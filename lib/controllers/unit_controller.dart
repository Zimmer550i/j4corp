import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:j4corp/services/api_service.dart';

class UnitController extends GetxController {
  final api = ApiService();
  RxBool isLoading = RxBool(false);
  Rx<File?> selectedImage = Rx<File?>(null);

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

      if (response.statusCode == 200) {
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
