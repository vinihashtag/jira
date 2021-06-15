import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_theme.dart';

class AppTheme {
  static ThemeData defaultTheme(BuildContext context) => ThemeData(
        primaryColor: AppColors.primaryColor,
        accentColor: AppColors.accentColor,
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: AppColors.accentColor),
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        fontFamily: GoogleFonts.heebo().fontFamily,
        primaryTextTheme: GoogleFonts.poppinsTextTheme(),
        accentTextTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            color: AppColors.backgroundColor,
            iconTheme: IconThemeData(
              color: AppColors.accentColor,
            )),
        buttonTheme: ButtonThemeData(
          height: 40,
          buttonColor: AppColors.buttonColor,
          disabledColor: AppColors.disableColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        disabledColor: AppColors.disableColor,
        errorColor: AppColors.errorColor,
        hintColor: AppColors.disableColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}
