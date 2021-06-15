import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:jira_matic/app/shared/theme/color_theme.dart';

import '../../components/custom_loading.dart';

abstract class ToastAdapter {
  void showLoading({String text});
  void closeLoading();

  void sucess({
    required String text,
    double positionToast = .8,
    Duration duration = const Duration(seconds: 2, milliseconds: 500),
  });
  void error({
    required String text,
    double positionToast = .75,
    Duration duration = const Duration(seconds: 3, milliseconds: 500),
  });
  void alert({
    required String text,
    double positionToast = .8,
    Duration duration = const Duration(seconds: 2, milliseconds: 500),
  });
  void info({
    required String text,
    double positionToast = .8,
    Duration duration = const Duration(seconds: 2, milliseconds: 500),
  });
  void message({
    required String text,
    double positionToast = .6,
  });
}

class ToastAdapterImpl implements ToastAdapter {
  @override
  void showLoading({String text = 'Aguarde...'}) {
    BotToast.showCustomLoading(
      backgroundColor: Colors.black45,
      toastBuilder: (cancelFunc) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        // constraints: BoxConstraints(maxHeight: 200, maxWidth: Get.width * .8),
        child: Row(
          children: [
            const SizedBox(height: 100, width: 100, child: CustomLoading()),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: AutoSizeText(
                text,
                // textAlign: TextAlign.center,
                minFontSize: 12,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  void closeLoading() {
    BotToast.closeAllLoading();
  }

  @override
  void sucess({
    required String text,
    double positionToast = .8,
    Duration duration = const Duration(seconds: 2, milliseconds: 500),
  }) =>
      BotToast.showCustomText(
        toastBuilder: (cancelFunc) => Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.greenLightColor,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 5,
                  spreadRadius: 3)
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle_outline,
                  color: AppColors.greenColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(color: AppColors.greenDarkColor),
                ),
              )
            ],
          ),
        ),
        align: Alignment(0, positionToast),
        clickClose: true,
        ignoreContentClick: true,
        duration: duration,
      );

  @override
  void error({
    required String text,
    double positionToast = .75,
    Duration duration = const Duration(seconds: 3, milliseconds: 500),
  }) =>
      BotToast.showCustomText(
        toastBuilder: (cancelFunc) => Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.redLightColor,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 5,
                  spreadRadius: 3)
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: AppColors.redColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(color: AppColors.redDarkColor),
                ),
              )
            ],
          ),
        ),
        align: Alignment(0, positionToast),
        clickClose: true,
        ignoreContentClick: true,
        duration: duration,
      );

  @override
  void alert({
    required String text,
    double positionToast = .8,
    Duration duration = const Duration(seconds: 2, milliseconds: 500),
  }) =>
      BotToast.showCustomText(
        toastBuilder: (cancelFunc) => Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.orangeLightColor,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 5,
                  spreadRadius: 3)
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: AppColors.orangeColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(color: AppColors.orangeDarkColor),
                ),
              )
            ],
          ),
        ),
        align: Alignment(0, positionToast),
        clickClose: true,
        ignoreContentClick: true,
        duration: duration,
      );

  @override
  void info({
    required String text,
    double positionToast = .8,
    Duration duration = const Duration(seconds: 2, milliseconds: 500),
  }) =>
      BotToast.showCustomText(
        toastBuilder: (cancelFunc) => Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.blueLightColor,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 5,
                  spreadRadius: 3)
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: AppColors.blueColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(color: AppColors.blueDarkColor),
                ),
              )
            ],
          ),
        ),
        align: Alignment(0, positionToast),
        clickClose: true,
        ignoreContentClick: true,
        duration: duration,
      );

  @override
  void message({required String text, double positionToast = .6}) =>
      BotToast.showCustomText(
        duration: const Duration(seconds: 5),
        toastBuilder: (void Function() cancelFunc) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Text(
              text,
              style: const TextStyle(
                  height: 1.3, fontSize: 16, color: Color(0xFF4CAF50)),
            ),
          );
        },
        clickClose: true,
        ignoreContentClick: true,
        align: Alignment(0, positionToast),
      );
}
