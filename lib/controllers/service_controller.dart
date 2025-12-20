import 'dart:convert';

import 'package:get/get.dart';
import 'package:j4corp/models/service.dart';
import 'package:j4corp/services/api_service.dart';

class ServiceController extends GetxController {
  final api = ApiService();

  RxBool isLoading = RxBool(false);
  RxList<Service> services = RxList.empty();

  Future<String> fetchServices() async {
    isLoading(true);
    try {
      final response = await api.get("v1/unit/services/", authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = body['data'];

        services.clear();
        for (var i in data) {
          services.add(Service.fromJson(i));
        }

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
