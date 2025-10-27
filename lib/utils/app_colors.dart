import 'package:flutter/material.dart';

class AppColors {
  // Base color is a general category without specific shades listed in the provided data
  // It is included for structure but has no MaterialColor definition based on the input.
  // static const Color base = Color(0xFF<INSERT_BASE_HEX_HERE>); // No hex provided

  // Indigo
  static MaterialColor indigo = const MaterialColor(0xFF4F46E5, <int, Color>{
    25: Color(0xFFEEF2FF),
    50: Color(0xFFE0E7FF),
    100: Color(0xFFC7D2FE),
    200: Color(0xFFA5B4FC),
    300: Color(0xFF818CF8),
    400: Color(0xFF6366F1),
    500: Color(0xFF4F46E5), // Primary shade
    600: Color(0xFF4338CA),
    700: Color(0xFF3730A3),
    800: Color(0xFF312E81),
    900: Color(0xFF1E184B),
  });

  // Blue
  static MaterialColor blue = const MaterialColor(0xFF2563EB, <int, Color>{
    25: Color(0xFFEFF6FF),
    50: Color(0xFFDBEAFE),
    100: Color(0xFFBFDBFE),
    200: Color(0xFF93C5FD),
    300: Color(0xFF60A5FA),
    400: Color(0xFF3B82F6),
    500: Color(0xFF2563EB), // Primary shade
    600: Color(0xFF1D4ED8),
    700: Color(0xFF1E40AF),
    800: Color(0xFF1E3A8A),
    900: Color(0xFF172554),
  });

  // Green
  static MaterialColor green = const MaterialColor(0xFF16A34A, <int, Color>{
    25: Color(0xFFF0FDF4),
    50: Color(0xFFDCFCE7),
    100: Color(0xFFBBF7D0),
    200: Color(0xFF86EFAC),
    300: Color(0xFF4ADE80),
    400: Color(0xFF22C55E),
    500: Color(0xFF16A34A), // Primary shade
    600: Color(0xFF15803D),
    700: Color(0xFF166534),
    800: Color(0xFF145320),
    900: Color(0xFF052E16),
  });

  // Red
  static MaterialColor red = const MaterialColor(0xFFDC2626, <int, Color>{
    25: Color(0xFFFEF2F2),
    50: Color(0xFFFEE2E2),
    100: Color(0xFFFECACA),
    200: Color(0xFFFCA5A5),
    300: Color(0xFFF87171),
    400: Color(0XFFEF4444),
    500: Color(0xFFDC2626), // Primary shade
    600: Color(0xFFB91C1C),
    700: Color(0xFF991818),
    800: Color(0xFF7F1D1D),
    900: Color(0xFF450A0A),
  });

  // Gray (Note: Gray has fewer explicitly listed hex codes in the provided data)
  static MaterialColor gray = const MaterialColor(0xFF485563, <int, Color>{
    25: Color(0xFFF9FAFB),
    50: Color(0xFFF3F4F6),
    100: Color(0xFFE5E7EB),
    200: Color(0xFFD1D5DB),
    300: Color(0xFF9CA3AF),
    400: Color(0xFF687280),
    500: Color(0xFF485563), // Primary shade
    600: Color(0xFF374151),
    700: Color(0xFF1F2937),
    800: Color(0xFF111827),
    900: Color(0xFF030712),
  });

  // Individual Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}