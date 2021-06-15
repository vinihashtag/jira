import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/color_theme.dart';
import '../theme/text_theme.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final bool titleColorWhite;
  final String hint;
  final bool autocorrect;
  final bool autofocus;
  final bool enabled;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final int? maxLines;
  final bool obscureText;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  const CustomTextField({
    Key? key,
    this.title = '',
    this.hint = '',
    this.titleColorWhite = false,
    this.autocorrect = true,
    this.autofocus = false,
    this.enabled = true,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.inputFormatters = const [],
    this.keyboardType = TextInputType.text,
    this.maxLines,
    this.obscureText = false,
    this.onEditingComplete,
    this.onTap,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.textAlign = TextAlign.start,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: title.isNotEmpty,
          child: Text(title,
              style: titleColorWhite
                  ? titleTextFieldWhiteStyle
                  : titleTextfieldStyle),
        ),
        const SizedBox(height: 5),
        Stack(
          children: [
            Visibility(
              visible: enabled,
              child: Container(
                height: 47,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: -2)
                  ],
                ),
              ),
            ),
            TextFormField(
              autocorrect: autocorrect,
              autofocus: autofocus,
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                prefix: prefix,
                prefixIcon: prefixIcon,
                suffix: suffix,
                suffixIcon: suffixIcon,
                contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                errorMaxLines: 2,
                isDense: true,
                filled: true,
                fillColor: !enabled ? AppColors.disableColor : Colors.white,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: AppColors.disableColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: AppColors.errorColor),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: AppColors.errorColor),
                ),
              ),
              enabled: enabled,
              initialValue: initialValue,
              focusNode: focusNode,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              maxLines: maxLines,
              obscureText: obscureText,
              obscuringCharacter: '*',
              onTap: onTap,
              onEditingComplete: onEditingComplete,
              onChanged: onChanged,
              onSaved: onSaved,
              validator: validator,
              readOnly: readOnly,
              style: enabled ? textFieldStyle : textfieldDisabledStyle,
              textCapitalization: textCapitalization,
              textInputAction: textInputAction,
              textAlign: textAlign,
            ),
          ],
        ),
      ],
    );
  }
}
