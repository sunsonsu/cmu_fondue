/*
 * File: app_theme.dart
 * Description: Contains centralized theme definitions configuring the entire application blueprint.
 * Responsibilities: Provisions material designs, textual bindings matching the Kanit typography, and core coloring schemes.
 * Author: App Team
 * Course: CMU Fondue
 * Notes: No UI logic should appear in this file.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Unifies system presentation properties maintaining rigorous consistency cross platform.
class AppTheme {
  /// The global definition configuring raw widgets drawing the 'light' material aesthetic strictly mapped with Kanit fonts.
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFEAE5F1),
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.kanitTextTheme(),
    fontFamily: GoogleFonts.kanit().fontFamily,
  );
}
