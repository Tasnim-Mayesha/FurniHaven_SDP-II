import 'package:flutter/material.dart';
import '../../global_colors.dart';

class MyChipTheme {
  MyChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: GlobalColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: GlobalColors.black),
    selectedColor: GlobalColors.mainColor,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: GlobalColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: GlobalColors.darkerGrey,
    labelStyle: TextStyle(color: GlobalColors.white),
    selectedColor: GlobalColors.mainColorHex,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: GlobalColors.white,
  );
}
