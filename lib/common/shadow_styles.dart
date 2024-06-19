
import 'package:flutter/material.dart';



class ShadowStyle {
  static const verticalProductShadow = BoxShadow(
    //color: Color(0xFF939393).withOpacity(0.1),
    color: Colors.red,
    blurRadius: 5,
    spreadRadius: 7,
    offset: Offset(0, 2),
  );

  static final horizontalProductShadow = BoxShadow(
    color: const Color(0xFF939393).withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}