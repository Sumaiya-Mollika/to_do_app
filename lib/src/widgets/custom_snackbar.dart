import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController customSnackbar({String? title, String? message, Color? color, Color? textColor}) {
  return Get.snackbar(title!, message!, snackPosition: SnackPosition.BOTTOM, backgroundColor: color, colorText: textColor);
}
