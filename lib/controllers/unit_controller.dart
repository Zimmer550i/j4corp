import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:j4corp/models/unit.dart';
import 'package:j4corp/services/api_service.dart';

class UnitController extends GetxController {
  final api = ApiService();
  RxBool isLoading = RxBool(false);

  RxList<Unit> units = RxList.empty();

  Future<String> getUnits() async {
    isLoading(true);
    try {
      final res = await api.get("v1/unit/register-units/", authReq: true);
      final body = jsonDecode(res.body);

      if (res.statusCode == 200 || res.statusCode == 201) {
        final data = body['data'];
        
        units.clear();
        for (var i in data['results']) {
          units.add(Unit.fromJson(i));
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

  Future<String> createUnit({
    required String vin,
    required String brand,
    required String model,
    required String year,
    required String purchaseDate,
    required String storeLocation,
    required String additionalNotes,
    required File? image,
  }) async {
    isLoading(true);
    try {
      final Map<String, dynamic> data = {
        'vin': vin,
        'brand': brand,
        'model': model,
        'year': int.parse(year),
        'purchase_date': purchaseDate,
        'store_location': storeLocation,
        'additional_notes': additionalNotes,
      };

      if (image != null) {
        data['image'] = image;
      }

      final response = await api.post(
        'v1/unit/register-units/create/',
        data,
        isMultiPart: true,
        authReq: true,
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
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
}
