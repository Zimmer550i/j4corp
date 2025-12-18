import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:j4corp/models/user.dart';
import 'package:j4corp/services/api_service.dart';

class UserController extends GetxController {
  Rxn<User> user = Rxn();
  RxBool isLoading = RxBool(false);

  final api = ApiService();

  User? get userData => user.value;
  // String? get userImage {
  //   if (user.value == null || user.value?.image == null) return null;

  //   return "${user.value?.image}";
  // }

  set userData(User? val) {
    user.value = val;
  }

  Future<String> getUserData() async {
    isLoading(true);
    try {
      final response = await api.get("v1/account/users/me/", authReq: true);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final data = body['data'];
        userData = User.fromJson(data);

        return "success";
      } else {
        return body['message'] ?? "Something went wrong!";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }
}
