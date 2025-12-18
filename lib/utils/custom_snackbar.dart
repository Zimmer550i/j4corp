import 'package:get/get.dart';

customSnackbar(String message, {bool isError = true}) async {
  Get.snackbar(isError ? "Error" : "Success", message);
}
