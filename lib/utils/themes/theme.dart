import 'package:flutter/material.dart';
import 'package:sdp2/utils/themes/widget_themes/appbar_theme.dart';
import 'package:sdp2/utils/themes/widget_themes/bottom_sheet_theme.dart';
import 'package:sdp2/utils/themes/widget_themes/checkbox_theme.dart';
import 'package:sdp2/utils/themes/widget_themes/chip_theme.dart';
import 'package:sdp2/utils/themes/widget_themes/elevated_button_theme.dart';
import 'package:sdp2/utils/themes/widget_themes/outlined_button_theme.dart';
import 'package:sdp2/utils/themes/widget_themes/text_field_theme.dart';
import 'package:sdp2/utils/themes/widget_themes/text_theme.dart';
import '../global_colors.dart';

class MyAppTheme {
  MyAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    disabledColor: GlobalColors.grey,
    brightness: Brightness.light,
    primaryColor: GlobalColors.mainColor,
    textTheme: MyTextTheme.lightTextTheme,
    chipTheme: MyChipTheme.lightChipTheme,
    scaffoldBackgroundColor: GlobalColors.white,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    checkboxTheme: MyCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: MyBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MyTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    disabledColor: GlobalColors.grey,
    brightness: Brightness.dark,
    primaryColor: GlobalColors.mainColor,
    textTheme: MyTextTheme.darkTextTheme,
    chipTheme: MyChipTheme.darkChipTheme,
    scaffoldBackgroundColor: GlobalColors.black,
    appBarTheme: MyAppBarTheme.darkAppBarTheme,
    checkboxTheme: MyCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: MyBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: MyTextFormFieldTheme.darkInputDecorationTheme,
  );
}
