import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';

import '../theme/color_theme.dart';
import '../utils/enums.dart';

class CustomDatePicker {
  // *
  // * Seleciona a data no formato dd/MM/yyyy
  static Future<void> selectDate({
    DateTime? initialDate,
    bool disablePastDate = false,
    bool disableFutureDate = false,
    required TextEditingController controller,
  }) async {
    FocusScope.of(Get.overlayContext!).requestFocus(FocusNode());
    initialDate ??= DateTime.now();

    // ? Exibe somente na versão ios
    if (GetPlatform.isIOS) {
      DatePicker.showDatePicker(
        Get.context!,
        minDateTime: disablePastDate ? DateTime.now() : DateTime(1900),
        maxDateTime: disableFutureDate ? DateTime.now() : DateTime(2100),
        initialDateTime: initialDate,
        dateFormat: 'dd/MM/yyyy',
        locale: DateTimePickerLocale.pt_br,
        onConfirm: (dateTime, List<int> index) {
          controller.text = dateTime.onlyDate;
        },
      );

      return;
    }

    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      helpText: 'Selecione uma data',
      firstDate: disablePastDate ? DateTime.now() : DateTime(1900),
      lastDate: disableFutureDate ? DateTime.now() : DateTime(2100),
      cancelText: 'CANCELAR',
      confirmText: 'CONFIRMAR',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primaryColor,
            accentColor: AppColors.accentColor,
            colorScheme:
                const ColorScheme.light(primary: AppColors.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = picked.onlyDate;
    }
  }

  // *
  // * Seleciona o horário no formato HH:mm
  static Future<void> selectHour({
    DateTime? initialDateTime,
    required TextEditingController controller,
  }) async {
    FocusScope.of(Get.overlayContext!).requestFocus(FocusNode());
    initialDateTime ??= DateTime(0, 0, 0, DateTime.now().hour + 1);
    final initialTime =
        TimeOfDay(hour: initialDateTime.hour, minute: initialDateTime.minute);

    // ? Exibe somente na versão ios
    if (GetPlatform.isIOS) {
      DatePicker.showDatePicker(
        Get.context!,
        pickerMode: DateTimePickerMode.time,
        initialDateTime: initialDateTime,
        dateFormat: 'HH:mm',
        locale: DateTimePickerLocale.pt_br,
        onConfirm: (dateTime, List<int> index) {
          controller.text = dateTime.onlyTime;
        },
      );

      return;
    }

    final picked = await showTimePicker(
      context: Get.context!,
      initialTime: initialTime,
      helpText: 'Selecione um horário',
      cancelText: 'CANCELAR',
      confirmText: 'CONFIRMAR',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primaryColor,
            accentColor: AppColors.accentColor,
            colorScheme:
                const ColorScheme.light(primary: AppColors.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = DateTime(0, 0, 0, picked.hour, picked.minute).onlyTime;
    }
  }
}
