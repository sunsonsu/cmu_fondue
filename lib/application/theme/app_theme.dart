/*
 * File: app_theme.dart
 * Description: Contains centralized theme definitions configuring the entire application blueprint.
 * Responsibilities: 
 * - Provisions material design 3 aesthetic properties globally.
 * - Configures primary color schemes derived from the branding seed.
 * - Manages centralized typography utilizing the Kanit Google Font theme.
 * Author: Rachata 650510638 & Chananchida 650510659
 * Course: Mobile Application Development Framework
 * Notes: No UI logic should appear in this file.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Unifies system presentation properties maintaining rigorous consistency cross platform.
/// 
/// Defines [lightTheme] as the authoritative source for visual tokens including 
/// color schemes, typography, and Material 3 behavioral flags.
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
