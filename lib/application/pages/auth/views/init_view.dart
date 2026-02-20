import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitView extends StatelessWidget {
  final VoidCallback onLoginTap;
  final VoidCallback onRegisterTap;

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
              backgroundColor: MaterialStateProperty.all(const Color(0xFF5D3891)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            child: Text(
              'Login',
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
              text: 'Don\'t have an account? ',
              style: GoogleFonts.kanit(
                color: Colors.black,
                fontSize: 18,
              ),
              children: [
                TextSpan(
                  text: 'Sign up',
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
