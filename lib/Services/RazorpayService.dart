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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
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

    // Show verification loading loader
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: Colors.blue)),
      barrierDismissible: false,
    );

    // Call verify payment API
    bool isVerified = await verifyPayment(
      paymentId: response.paymentId!,
      orderId: response.orderId!,
      signature: response.signature!,
      bookingType: _currentBookingType,
      bookingId: _currentBookingId,
    );

    // Close loader
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (isVerified) {
      if (_onSuccessCallback != null) {
        _onSuccessCallback!(response);
      }
    } else {
      if (_onFailureCallback != null) {
        _onFailureCallback!(
          PaymentFailureResponse(
            Razorpay.PAYMENT_CANCELLED,
            "Payment verification failed on backend.",
            const {},
          ),
        );
      }
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
  Future<String?> createOrder(double amount, String bookingType, String bookingId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.createOrder}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      // Since backend expects FormData matching the rest of the application
      final Map<String, dynamic> data = {
        'amount': amount.toStringAsFixed(2),
        'booking_type': bookingType,
        'booking_id': bookingId,
      };

      print(
        "--- [RazorpayService] Requesting createOrder: POST $url with $data ---",
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
        if (response.data['success'] == true ||
            response.data['success'].toString() == "true") {
          return response.data['order_id']?.toString();
        }
      }
      return null;
    } catch (e) {
      print("--- [RazorpayService] createOrder API EXCEPTION: $e ---");
      return null;
    }
  }

  // Call Backend to Verify Payment
  Future<bool> verifyPayment({
    required String paymentId,
    required String orderId,
    required String signature,
    required String bookingType,
    required String bookingId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      String url = "${ApiConfigs.BASE_URL}${ApiEndPoints.verifyPayment}";

      final headers = {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final Map<String, dynamic> data = {
        'payment_id': paymentId,
        'order_id': orderId,
        'signature': signature,
        'booking_type': bookingType,
        'booking_id': bookingId,
      };

      print(
        "--- [RazorpayService] Requesting verifyPayment: POST $url with $data ---",
      );
      final FormData formData = FormData.fromMap(data);

      final response = await ApiConfigs.dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
      );

      print(
        "--- [RazorpayService] verifyPayment response: ${response.statusCode} ---",
      );
      print("--- [RazorpayService] Response data: ${response.data} ---");

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['success'] == true ||
            response.data['success'].toString() == "true") {
          return true;
        }
      }
      return false;
    } catch (e) {
      print("--- [RazorpayService] verifyPayment API EXCEPTION: $e ---");
      return false;
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
  }) async {
    _onSuccessCallback = onSuccess;
    _onFailureCallback = onFailure;
    _currentBookingType = bookingType;
    _currentBookingId = bookingId;

    // Show loading dialog
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: Colors.blue)),
      barrierDismissible: false,
    );

    // Call backend to create order
    final orderId = await createOrder(amount, bookingType, bookingId);

    // Close loading dialog
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (orderId == null) {
      Get.snackbar(
        "Order Creation Failed",
        "Unable to generate order ID from backend.",
        snackPosition: SnackPosition.BOTTOM,
      );
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
      'prefill': {
        'contact': contact.isNotEmpty ? contact : '9876543210',
        'email': email.isNotEmpty ? email : 'test@test.com',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("--- [RazorpayService] Error opening Razorpay checkout: $e ---");
      onFailure(
        PaymentFailureResponse(Razorpay.PAYMENT_CANCELLED, e.toString(), const {}),
      );
    }
  }
}
