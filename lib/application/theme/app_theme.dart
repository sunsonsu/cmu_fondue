import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
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
