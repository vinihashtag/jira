import 'package:flutter/material.dart';

import '../theme/color_theme.dart';
import '../theme/text_theme.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final String hint;
  final Set<String> items;
  final bool enabled;
  final String? initialValue;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final TextAlign textAlign;

  const CustomDropdown({
    Key? key,
    this.title = '',
    this.hint = '',
    this.enabled = true,
    this.initialValue,
    this.validator,
    this.textAlign = TextAlign.start,
    this.items = const {},
    this.onChanged,
    this.onSaved,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: titleTextfieldStyle),
        const SizedBox(height: 5),
        Stack(
          children: [
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 1),
                      blurRadius: 5,
                      spreadRadius: -3)
                ],
              ),
            ),
            DropdownButtonFormField<String>(
              value: initialValue,
              items: items
                  .map<DropdownMenuItem<String>>(
                      (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: textFieldStyle),
                          ))
                  .toList(),
              onChanged: onChanged,
              onSaved: onSaved,
              isDense: true,
              style: textFieldStyle,
              validator: validator,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: textGrey,
                contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
                  borderSide: BorderSide(color: AppColors.primaryColor),
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
            ),
          ],
        ),
      ],
    );
  }
}
