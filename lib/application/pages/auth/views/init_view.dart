/*
 * File: init_view.dart
 * Description: The initial splash interface greeting unauthenticated guests establishing primary intent.
 * Responsibilities: Provides large distinct navigation buttons routing newcomers towards either registration or login pathways.
 * Dependencies: <None>
 * Lifecycle: Created instantly when AuthPage initializes, Disposed immediately upon selecting either routing option.
 * Author: Rachata
 * Course: CMU Fondue
 */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Renders the foundational welcome menu distinctly offering identity options natively.
class InitView extends StatelessWidget {
  /// The reactive closure triggered explicitly when requesting the sign-in pathway.
  final VoidCallback onLoginTap;

  /// The reactive closure triggered explicitly when requesting the sign-up pathway.
  final VoidCallback onRegisterTap;

  /// Initializes a new instance of [InitView].
  const InitView({
    super.key,
    required this.onLoginTap,
    required this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Column(
        children: [
          const SizedBox(height: 100),
          Image.asset('assets/images/cmu_logo.png', width: 160),
          const SizedBox(height: 36),

          ElevatedButton(
            onPressed: onLoginTap,
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(200, 40)),
              backgroundColor: MaterialStateProperty.all(
                const Color(0xFF5D3891),
              ),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            child: Text(
              'เข้าสู่ระบบ',
              style: GoogleFonts.kanit(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 30),
          RichText(
            text: TextSpan(
              text: 'ยังไม่มีบัญชี? ',
              style: GoogleFonts.kanit(color: Colors.black, fontSize: 18),
              children: [
                TextSpan(
                  text: 'ลงทะเบียน',
                  style: GoogleFonts.kanit(
                    color: const Color(0xFF5D3891),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onRegisterTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
