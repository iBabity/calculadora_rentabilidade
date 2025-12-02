import 'package:flutter/material.dart';
import '../constants/text_sizes.dart';

class AppTypography {
  static TextTheme textTheme = TextTheme(
    bodyMedium: TextStyle(
      fontSize: TextSizes.normal,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      fontSize: TextSizes.title,
      fontWeight: FontWeight.bold,
    ),
  );
}
