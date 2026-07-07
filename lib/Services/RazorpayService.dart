import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Configs/ApiConfigs.dart';

class RazorpayService {
  static final RazorpayService _instance = RazorpayService._internal();
  factory RazorpayService() => _instance;

  late Razorpay _razorpay;
  bool _isInitialized = false;

  Function(PaymentSuccessResponse)? _onSuccessCallback;
  Function(PaymentFailureResponse)? _onFailureCallback;
  String _currentBookingType = '';
  String _currentBookingId = '';

  RazorpayService._internal() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _isInitialized = true;
  }

  void dispose() {
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("--- [RazorpayService] Payment Success Callback ---");
    print("Payment ID: ${response.paymentId}");
    print("Order ID: ${response.orderId}");
    print("Signature: ${response.signature}");

    if (response.paymentId == null ||
        response.orderId == null ||
        response.signature == null) {
      if (_onFailureCallback != null) {
        _onFailureCallback!(
          PaymentFailureResponse(
            Razorpay.PAYMENT_CANCELLED,
            "Invalid payment response parameters.",
            const {},
          ),
        );
      }
      return;
    }

    if (_onSuccessCallback != null) {
      _onSuccessCallback!(response);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("--- [RazorpayService] Payment Error Callback ---");
    print("Code: ${response.code}");
    print("Message: ${response.message}");
    if (_onFailureCallback != null) {
      _onFailureCallback!(response);
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("--- [RazorpayService] External Wallet Callback ---");
    print("Wallet Name: ${response.walletName}");
  }

  // Call Backend to Create Order
  Future<String?> createOrder(
    double amount,
    String bookingType,
    String bookingId,
  ) async {
    print(
      "--- [RazorpayService] createOrder called: amount=$amount, bookingType='$bookingType', bookingId='$bookingId' ---",
    );
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      // Normalize booking type
      String normalizedBookingType = bookingType;
      if (bookingType == "1") {
        normalizedBookingType = "nurse_booking";
      } else if (bookingType == "2") {
        normalizedBookingType = "doctor_booking";
      } else if (bookingType == "3") {
        normalizedBookingType = "other_service_booking";
      }
      print(
        "--- [RazorpayService] createOrder normalized bookingType to: '$normalizedBookingType' ---",
      );

      String url;
      Map<String, dynamic> data;

      if (normalizedBookingType == "nurse_booking") {
        url = "${ApiConfigs.BASE_URL}${ApiEndPoints.createOrder}";
        data = {
          'booking_id': bookingId,
          'type': normalizedBookingType,
          'amount': amount.toStringAsFixed(2),
        };
      } else {
        url = "${ApiConfigs.BASE_URL}${ApiEndPoints.createOrder}";
        data = {
          'amount': amount.toStringAsFixed(2),
          'type': normalizedBookingType,
          'booking_id': bookingId,
        };
      }

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      print(
        "--- [RazorpayService] Requesting createOrder: POST $url with payload Map: $data ---",
      );
      final FormData formData = FormData.fromMap(data);

      final response = await ApiConfigs.dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      print(
        "--- [RazorpayService] createOrder response: ${response.statusCode} ---",
      );
      print("--- [RazorpayService] Response data: ${response.data} ---");

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data;
        if (responseData is Map) {
          // If order_id or id is directly present, return it immediately
          var orderId = responseData['order_id'] ?? responseData['id'];
          if (orderId == null && responseData['data'] is Map) {
            orderId =
                responseData['data']['order_id'] ?? responseData['data']['id'];
          }
          if (orderId != null) {
            return orderId.toString();
          }

          // Fallback check for success/status indicators
          if (responseData['success'] == true ||
              responseData['success'].toString() == "true" ||
              responseData['status'] == true ||
              responseData['status'].toString() == "true") {
            var nestedId = responseData['order_id'] ?? responseData['id'];
            if (nestedId == null && responseData['data'] is Map) {
              nestedId =
                  responseData['data']['order_id'] ??
                  responseData['data']['id'];
            }
            if (nestedId != null) {
              return nestedId.toString();
            }
          }
        }
      }
      return null;
    } catch (e) {
      print("--- [RazorpayService] createOrder API EXCEPTION: $e ---");
      return null;
    }
  }

  // Start checkout flow
  Future<void> startPayment({
    required double amount, // in Rupees (e.g. 500)
    required String bookingType, // '1' = nurse, '2' = doctor, '3' = other
    required String bookingId,
    required String description,
    required String contact,
    required String email,
    required String key, // Test Key: rzp_test_T8uZQ7cP2kcNGN
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
    String? id, // nurse_id or doctor_id
    String? paymentType,
  }) async {
    print(
      "--- [RazorpayService] startPayment called: amount=$amount, bookingType='$bookingType', bookingId='$bookingId' ---",
    );
    _onSuccessCallback = onSuccess;
    _onFailureCallback = onFailure;

    // Map the booking type to string representation
    String mappedBookingType = bookingType;
    if (bookingType == "1") {
      mappedBookingType = "nurse_booking";
    } else if (bookingType == "2") {
      mappedBookingType = "doctor_booking";
    } else if (bookingType == "3") {
      mappedBookingType = "other_service_booking";
    }
    print(
      "--- [RazorpayService] startPayment mappedBookingType to: '$mappedBookingType' ---",
    );

    _currentBookingType = mappedBookingType;
    _currentBookingId = bookingId;

    // Show loading dialog
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: Colors.blue)),
      barrierDismissible: false,
    );

    // Call backend to create order
    final orderId = await createOrder(amount, mappedBookingType, bookingId);

    // Close loading dialog
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (orderId == null) {
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text("Unable to generate order ID from backend."),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      onFailure(
        PaymentFailureResponse(
          Razorpay.PAYMENT_CANCELLED,
          "Failed to create order on backend.",
          const {},
        ),
      );
      return;
    }

    var options = {
      'key': key,
      'amount': (amount * 100).toInt(), // in paise
      'currency': 'INR',
      'name': 'Wada App',
      'description': description,
      'order_id': orderId,
      'payment_capture':
          1, // Auto capture payment immediately after authorization
      'prefill': {
        'contact': contact.isNotEmpty ? contact : '9876543210',
        'email': email.isNotEmpty ? email : 'test@test.com',
      },
      'notes': {
        'payment_type': paymentType ?? 'Online',
        'total_amount': amount.toString(),
        'type': mappedBookingType,
        'id': bookingId,
      },
      'config': {
        'display': {
          'hide': [
            {'method': 'emi'},
            {'method': 'paylater'},
          ],
          'preferences': {'show_default_blocks': true},
        },
      },
    };

    try {
      print(
        "--- [RazorpayService] opening Razorpay checkout with options Map: $options ---",
      );
      _razorpay.open(options);
    } catch (e) {
      print("--- [RazorpayService] Error opening Razorpay checkout: $e ---");
      onFailure(
        PaymentFailureResponse(
          Razorpay.PAYMENT_CANCELLED,
          e.toString(),
          const {},
        ),
      );
    }
  }

  // Call Backend to Create Premium Order
  Future<CreateOrderResult> createPremiumOrder(
    double amount, {
    bool? autoSubscription,
  }) async {
    print(
      "--- [RazorpayService] createPremiumOrder called: amount=$amount, autoSubscription=$autoSubscription ---",
    );
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      String url = "${ApiConfigs.BASE_URL}premium/razor-order";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final data = {
        'amount': amount.toStringAsFixed(2),
        if (autoSubscription != null)
          'auto_subscription': autoSubscription ? '1' : '0',
      };

      print(
        "--- [RazorpayService] Requesting createPremiumOrder: POST $url with payload Map: $data ---",
      );
      final FormData formData = FormData.fromMap(data);

      final response = await ApiConfigs.dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      print(
        "--- [RazorpayService] createPremiumOrder response: ${response.statusCode} ---",
      );
      print("--- [RazorpayService] Response data: ${response.data} ---");

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data;
        if (responseData is Map) {
          var orderId = responseData['order_id'] ?? responseData['id'];
          if (orderId == null && responseData['data'] is Map) {
            orderId =
                responseData['data']['order_id'] ?? responseData['data']['id'];
          }
          if (orderId != null) {
            return CreateOrderResult(orderId: orderId.toString());
          }
        }
      }
      return CreateOrderResult(errorMessage: "Failed to generate order ID from backend.");
    } on DioException catch (e) {
      print("--- [RazorpayService] createPremiumOrder DioException: $e ---");
      String? apiErrorMessage;
      if (e.response != null && e.response?.data != null) {
        final resData = e.response?.data;
        print("--- [RazorpayService] Exception response data: $resData (type: ${resData.runtimeType}) ---");
        if (resData is Map) {
          if (resData['message'] != null) {
            apiErrorMessage = resData['message'].toString();
          }
        } else if (resData is String) {
          try {
            final decoded = jsonDecode(resData);
            if (decoded is Map && decoded['message'] != null) {
              apiErrorMessage = decoded['message'].toString();
            }
          } catch (jsonError) {
            print("--- [RazorpayService] JSON decode error: $jsonError ---");
          }
        }
      }
      return CreateOrderResult(
        errorMessage: apiErrorMessage ?? "Failed to create order on backend.",
      );
    } catch (e) {
      print("--- [RazorpayService] createPremiumOrder General Exception: $e ---");
      return CreateOrderResult(errorMessage: e.toString());
    }
  }

  // Start checkout flow for Premium Membership
  Future<void> startMembershipPayment({
    required double amount, // in Rupees (e.g. 1499)
    required String description,
    required String contact,
    required String email,
    required String key, // Test Key
    bool? autoSubscription,
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
  }) async {
    print(
      "--- [RazorpayService] startMembershipPayment called: amount=$amount, autoSubscription=$autoSubscription ---",
    );
    _onSuccessCallback = onSuccess;
    _onFailureCallback = onFailure;
    _currentBookingType = "premium_membership";
    _currentBookingId = "";

    // Show loading dialog
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: Colors.blue)),
      barrierDismissible: false,
    );

    // Call backend to create order
    final result = await createPremiumOrder(
      amount,
      autoSubscription: autoSubscription,
    );

    // Close loading dialog
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (result.orderId == null) {
      onFailure(
        PaymentFailureResponse(
          0,
          result.errorMessage ?? "Failed to create order on backend.",
          const {},
        ),
      );
      return;
    }

    final orderId = result.orderId!;

    var options = {
      'key': key,
      'amount': (amount * 100).toInt(), // in paise
      'currency': 'INR',
      'name': 'Wada App',
      'description': description,
      'order_id': orderId,
      'payment_capture':
          1, // Auto capture payment immediately after authorization
      'prefill': {
        'contact': contact.isNotEmpty ? contact : '9876543210',
        'email': email.isNotEmpty ? email : 'test@test.com',
      },
      'notes': {
        'payment_type': 'Online',
        'total_amount': amount.toString(),
        'type': 'premium_membership',
      },
      'config': {
        'display': {
          'hide': [
            {'method': 'emi'},
            {'method': 'paylater'},
          ],
          'preferences': {'show_default_blocks': true},
        },
      },
    };

    try {
      print(
        "--- [RazorpayService] opening Razorpay checkout with options Map: $options ---",
      );
      _razorpay.open(options);
    } catch (e) {
      print("--- [RazorpayService] Error opening Razorpay checkout: $e ---");
      onFailure(
        PaymentFailureResponse(
          Razorpay.PAYMENT_CANCELLED,
          e.toString(),
          const {},
        ),
      );
    }
  }
}

class CreateOrderResult {
  final String? orderId;
  final String? errorMessage;
  CreateOrderResult({this.orderId, this.errorMessage});
}
