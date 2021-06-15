import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:jira_matic/app/shared/theme/color_theme.dart';

class CustomDialog {
  static Future alert(
          {required String title,
          required String text,
          String buttonText = 'Fechar',
          Function()? onPressed}) =>
      Get.dialog(ZoomIn(
        preferences: const AnimationPreferences(
          duration: Duration(milliseconds: 400),
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          content: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
                if (onPressed != null) {
                  onPressed();
                }
              },
              child: Text(
                buttonText.toUpperCase(),
                style: const TextStyle(
                    color: AppColors.primaryColor, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ));

  static Future doubleButton({
    required String title,
    required String text,
    String buttonTextCancel = 'CANCELAR',
    String buttonTextOk = 'OK',
    required Function()? onPressed,
  }) async {
    return await Get.dialog(ZoomIn(
      preferences: const AnimationPreferences(
        duration: Duration(milliseconds: 400),
      ),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        content: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back(result: false);
            },
            child: Text(
              buttonTextCancel.toUpperCase(),
              style: const TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w600),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);
              if (onPressed != null) {
                onPressed();
              }
            },
            child: Text(
              buttonTextOk.toUpperCase(),
              style: const TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    ));
  }
}
