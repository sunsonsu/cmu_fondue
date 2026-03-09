/*
 * File: profile_page.dart
 * Description: Identity inspection hub exposing active email credentials distinctly providing explicit exit pathways.
 * Responsibilities: Isolates user data strings distinctly, intercepts logout directions aggressively, and dumps active session tokens backward conclusively natively.
 * Dependencies: AppAuthProvider, CustomSnackBar
 * Lifecycle: Created instantly when accessing navigation index 3 exclusively, Disposed merely exiting parent tabs correctly.
 * Author: Rachata
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:cmu_fondue/application/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Renders basic visual abstractions surrounding internal active credentials allowing strict explicit token dropping dynamically natively.
class ProfilePage extends StatefulWidget {
  /// Initializes a new instance of [ProfilePage].
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AppAuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: const Color(0xFFEAE5F1),
      appBar: AppBar(
        leading: authProvider.isAdmin
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF5D3891)),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: const Text(
          'โปรไฟล์',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D3891),
          ),
        ),
        backgroundColor: const Color(0xFFEAE5F1),
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(41),
              topRight: Radius.circular(41),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF5D3891),
                              width: 3,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color(0xFF5D3891),
                            child: Text(
                              user?.email[0].toUpperCase() ?? 'U',
                              style: const TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user?.email.split('@')[0].toUpperCase() ?? 'User',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5D3891),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? 'No email',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                await authProvider.logout();
                                if (context.mounted) {
                                  CustomSnackBar.showSuccess(
                                    context: context,
                                    message: 'ออกจากระบบสำเร็จ',
                                  );

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/',
                                    (route) => false,
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  CustomSnackBar.showError(
                                    context: context,
                                    message:
                                        'ออกจากระบบไม่สำเร็จ กรุณาลองใหม่อีกครั้ง',
                                  );
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        disabledBackgroundColor: Colors.red.withAlpha(150),
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'ออกจากระบบ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
