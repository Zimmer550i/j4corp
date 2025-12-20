import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:j4corp/models/user.dart';
import 'package:j4corp/services/api_service.dart';

class UserController extends GetxController {
  Rxn<User> user = Rxn();
  RxBool isLoading = RxBool(false);

  final api = ApiService();

  User? get userData => user.value;
  String? get userImage {
    if (user.value == null || user.value?.profilePic == null) return null;

    return "${ApiService.getImgUrl(user.value?.profilePic)}";
  }

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

  Future<String> updateUserProfile(Map<String, dynamic> data) async {
    isLoading(true);
    try {
      final response = await api.patch(
        "v1/account/users/${user.value!.userId}/update/",
        data,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          userData = User.fromJson(data);
        } catch (e) {
          await getUserData();
        }

        return "success";
      } else {
        return body['message'] ?? "Something went wrong";
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<Map?> getInfo(String endpoint) async {
    isLoading(true);
    try {
      final response = await api.get(endpoint, authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return body['data'];
      }
    } catch (e) {
      return null;
    } finally {
      isLoading(false);
    }
    return null;
  }
}
