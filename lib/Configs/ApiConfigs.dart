import 'package:dio/dio.dart';
import '../Utils/LoggingInterceptor.dart';

class ApiConfigs {
  static String BASE_URL =
      "https://thewada.com/wada-backend/public/api/customer/";
  static String IMAGE_URL = "https://thewada.com/wada-backend/public/storage/";

  static Dio get dio {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    dio.interceptors.add(LoggingInterceptor());
    return dio;
  }
}

class ApiEndPoints {
  static String login = "login";
  static String getCountryCodes = "getCountryCodes";
  static String sendLoginOtp = "send_login_otp";
  static String logout = "logout";
  static String sendRegOtp = "send_reg_otp";
  static String register = "nurseRegistration";
  static String home = "home";
  static String specializations = "specializations";
  static String otherServiceNames = "otherServiceNames";
  static String doctorsList = "doctorsList";
  static String nursesList = "nurses";
  static String donorsList = "donors/list";
  static String aboutUs = "about";
  static String terms = "terms";
  static String privacyPolicy = "privacy_policy";
  static String faqs = "faqs";
  static String contactUs = "contact_us";
  static String referralCode = "referral_code";
  static String members = "members";
  static String addMember = "members/add";
  static String removeMember = "members/remove";
  static String updateMember = "members/update";
  static String wallet = "wallet";
  static String profile = "profile";
  static String updateProfile = "profile/update";
  static String healthcareCategories = "healthcare_categories";
  static String nurseDetails = "nurseDetails";
  static String bookNurse = "bookNurse";
  static String listBookings = "listBookings";
  static String bookingDetails = "bookingDetails";
  static String getHours = "getHours";
  static String shareLocation = "shareLocation";
  static String cancelBooking = "cancelBooking";
  static String doctorDetails = "doctorDetails";
  static String updateNursePaymentStatus = "updateNursePaymentStatus";
  static String bookHomeVisit = "bookHomeVisit";
  static String createOrder = "nurse/razor-order";
}
