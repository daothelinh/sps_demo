import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackbarType { informative, success, error, warning }
const textColor = Colors.white;

class Snackbar {
  static show(
      {required SnackbarType type, required String message, String? title}) {
    if (title == null || title.isEmpty) {
      title = _chooseTitle(type);
    }
    Get.snackbar(
      title,
      message,
      backgroundColor: _chooseColor(type),
      icon: Icon(_chooseIcon(type), color: textColor),
      colorText: textColor,
    );
  }

  static String _chooseTitle(SnackbarType type) {
    if (type == SnackbarType.success) {
      return "Success!!!";
    } else if (type == SnackbarType.error) {
      return "Error!!!";
    } else if (type == SnackbarType.informative) {
      return 'Informative !!!';
    } else {
      return "Warning!!!";
    }
  }

  static Color _chooseColor(SnackbarType type) {
    if (type == SnackbarType.success) {
      return Colors.green[500]!;
    } else if (type == SnackbarType.error) {
      return Colors.red[500]!;
    } else if (type == SnackbarType.informative) {
      return Colors.blue[500]!;
    } else {
      return Colors.orange[500]!;
    }
  }

  static IconData _chooseIcon(SnackbarType type) {
    if (type == SnackbarType.success) {
      return Icons.check_circle_outline;
    } else if (type == SnackbarType.error) {
      return Icons.error_outline;
    } else if (type == SnackbarType.informative) {
      return Icons.info_outline_rounded;
    } else {
      return Icons.warning_amber_outlined;
    }
  }
}
