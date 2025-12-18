import 'dart:convert';
import 'package:get/get.dart';
import 'package:j4corp/controllers/user_controller.dart';
import 'package:j4corp/models/user.dart';
import 'package:j4corp/services/api_service.dart';
import 'package:j4corp/views/screens/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  RxBool isLoading = RxBool(false);

  final api = ApiService();
  late SharedPreferences prefs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }

  Future<String> login(String email, String password, bool rememberMe) async {
    isLoading(true);
    try {
      final response = await api.post("v1/account/login/", {
        "email": email,
        "password": password,
      });
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        Get.find<UserController>().userData = User.fromJson(data);
        if (rememberMe) {
          api.setToken(data['tokens']['access']);
        }

        return "success";
      } else {
        return body['message'] ?? "Unexpected error occured!";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> register(
    String firstName,
    String lastName,
    String email,
    String phone,
    String address,
    String zipCode,
    DateTime dateOfBirth,
    String password,
    String confirmPassword,
  ) async {
    isLoading(true);
    try {
      final response = await api.post("v1/account/signup/", {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "address": address,
        "zip_code": zipCode,
        "dob": "${dateOfBirth.year}-${dateOfBirth.month}-${dateOfBirth.day}",
        "password": password,
        "confirm_password": confirmPassword,
      });
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "success";
      } else {
        return body['message'] ?? "Unexpected error occured!";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> resendOtp(String email) async {
    try {
      final response = await api.post("v1/account/resend-otp/", {
        "email": email,
      });
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return "success";
      } else {
        return body['message'] ?? "Unexpected error occured!";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> verifyOtp(String otp, {bool isResettingPass = false}) async {
    isLoading(true);
    try {
      final response = await api.post(
        "v1/account/${isResettingPass ? "verify-forget-password-otp" : "verify-email-otp"}/",
        {"otp": int.parse(otp)},
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        api.setToken(data['access_token']);
        await Get.find<UserController>().getUserData();

        return "success";
      } else {
        return body['message'] ?? "Unexpected error occured!";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> forgetPassword(String email) async {
    isLoading(true);
    try {
      final response = await api.post("v1/account/forget-password/", {
        "email": email,
      });
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return "success";
      } else {
        return body['message'] ?? "Unexpected error occured!";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> resetPassword(String pass, String conPass) async {
    isLoading(true);
    try {
      final response = await api.post("v1/account/reset-password/", {
        "new_password": pass,
        "confirm_password": conPass,
      }, authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return "success";
      } else {
        return body['message'] ?? "Unexpected error occured!";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  void logout() {
    Get.offAll(() => Login());
    prefs.clear();
  }

  Future<bool> previouslyLoggedIn() async {
    final token = prefs.getString("token");
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }
}
