import 'dart:convert';
import 'package:flutter/rendering.dart';
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
        final data = body['data']['results'];

        services.clear();
        for (var i in data) {
          try {
            services.add(Service.fromJson(i));
          } catch (e) {
            debugPrint("Error: ${e.toString()}");
            debugPrint("Data: $i");
          }
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

  Future<String> createService(
    int id,
    String details,
    String location,
    DateTime date,
    bool hasServicedBefore,
  ) async {
    isLoading(true);
    try {
      final response = await api.post("v1/unit/services/", {
        "unit": id,
        "details": details,
        "location": location,
        "appointment_date": "${date.year}-${date.month}-${date.day}",
        "has_serviced_before": hasServicedBefore,
      }, authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<String> updateService(
    int id,
    String details,
    String location,
    DateTime date,
    bool hasServicedBefore,
  ) async {
    isLoading(true);
    try {
      final response = await api.patch("v1/unit/services/$id/", {
        "details": details,
        "location": location,
        "appointment_date": "${date.year}-${date.month}-${date.day}",
        "has_serviced_before": hasServicedBefore,
      }, authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = body['data'];

        int index = services.indexWhere((val) => val.id == id);
        services.removeAt(index);
        services.insert(index, Service.fromJson(data));

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
