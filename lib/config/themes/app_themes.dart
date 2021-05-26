import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservaai/config/themes/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ThemeData.light().copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      // appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: GoogleFonts.montserratTextTheme(theme.textTheme)
          .copyWith(
            headline1: theme.textTheme.headline1?.copyWith(
                fontSize: 48, color: Colors.white, fontWeight: FontWeight.w900),
            headline2: theme.textTheme.headline1?.copyWith(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.w900),
            headline3: theme.textTheme.headline1?.copyWith(
                fontSize: 38, color: Colors.white, fontWeight: FontWeight.w900),
            headline4: theme.textTheme.headline1?.copyWith(
                fontSize: 32, color: Colors.white, fontWeight: FontWeight.w700),
            headline5: theme.textTheme.headline1?.copyWith(
                fontSize: 26, color: Colors.white, fontWeight: FontWeight.w700),
            headline6: theme.textTheme.headline1?.copyWith(
                fontSize: 20,
                color: theme.primaryColor,
                fontWeight: FontWeight.w700),
            bodyText1: theme.textTheme.headline1
                ?.copyWith(fontSize: 14, color: AppColors.primaryColor),
            bodyText2: theme.textTheme.headline1
                ?.copyWith(fontSize: 12, color: AppColors.primaryColorLighter),
            button: theme.textTheme.button?.copyWith(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          )
          .apply(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            bodyColor: AppColors.contentColorLightTheme,
          ),

      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.acentColor,
        error: AppColors.errorColor,
      ),

      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Colors.black12,
              primary: AppColors.contentColorLightTheme)),

      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primaryColor,
          selectionColor: Colors.grey,
          selectionHandleColor: AppColors.acentColor),

      //Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            primary: AppColors.acentColor,
            elevation: 30),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ThemeData.dark().copyWith(
      primaryColor: AppColors.primaryColor,
      accentColor: AppColors.acentColor,
      scaffoldBackgroundColor: Colors.black54,
      // appBarTheme: appBarTheme,
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: GoogleFonts.montserratTextTheme(theme.textTheme)
          .copyWith(
            headline1: theme.textTheme.headline1?.copyWith(
                fontSize: 48, color: Colors.white, fontWeight: FontWeight.w900),
            headline2: theme.textTheme.headline1?.copyWith(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.w900),
            headline3: theme.textTheme.headline1?.copyWith(
                fontSize: 38, color: Colors.white, fontWeight: FontWeight.w900),
            headline4: theme.textTheme.headline1?.copyWith(
                fontSize: 32, color: Colors.white, fontWeight: FontWeight.w700),
            headline5: theme.textTheme.headline1?.copyWith(
                fontSize: 26, color: Colors.white, fontWeight: FontWeight.w700),
            headline6: theme.textTheme.headline1?.copyWith(
                fontSize: 20,
                color: theme.primaryColor,
                fontWeight: FontWeight.w700),
            bodyText1: theme.textTheme.headline1
                ?.copyWith(fontSize: 14, color: AppColors.primaryColor),
            bodyText2: theme.textTheme.headline1
                ?.copyWith(fontSize: 12, color: AppColors.primaryColorLighter),
            button: theme.textTheme.button?.copyWith(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          )
          .apply(
              bodyColor: AppColors.contentColorDarkTheme,
              fontFamily: GoogleFonts.montserrat().fontFamily),

      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryColor,
        secondary: AppColors.acentColor,
        error: AppColors.errorColor,
      ),

      textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primaryColor,
          selectionColor: Colors.grey,
          selectionHandleColor: AppColors.acentColor),

      //Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            primary: AppColors.acentColor,
            elevation: 30),
      ),

      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: Colors.white12,
              primary: AppColors.contentColorDarkTheme)),
    );
  }
}
