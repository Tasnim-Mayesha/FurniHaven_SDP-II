import 'package:flutter/material.dart';

import '../../global_colors.dart';

/* -- Light & Dark Elevated Button Themes -- */
class MyElevatedButtonTheme {
  MyElevatedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: GlobalColors.light,
      backgroundColor: GlobalColors.mainColorHex,
      disabledForegroundColor: GlobalColors.darkGrey,
      disabledBackgroundColor: GlobalColors.buttonDisabled,
      side: const BorderSide(color: GlobalColors.mainColorHex),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: GlobalColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: GlobalColors.light,
      backgroundColor: GlobalColors.mainColorHex,
      disabledForegroundColor: GlobalColors.darkGrey,
      disabledBackgroundColor: GlobalColors.darkerGrey,
      side: const BorderSide(color: GlobalColors.mainColorHex),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: GlobalColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
