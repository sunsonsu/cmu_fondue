import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:cmu_fondue/application/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AppAuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: const Color(0xFFEAE5F1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5D3891)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'โปรไฟล์',
          style: TextStyle(
            fontSize: 24,
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
              
              // Profile Header Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  // decoration: const BoxDecoration(
                  //   color: Color(0xFFEAE5F1),
                  //   borderRadius: BorderRadius.all(Radius.circular(30)),
                  // ),
                  child: Column(
                    children: [
                      // Profile Avatar
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF5D3891), width: 3),
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
                      // User Name/Email
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

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await authProvider.logout();
                      if (context.mounted) {
                        CustomSnackBar.showSuccess(
                          context: context,
                          message: 'ออกจากระบบสำเร็จ',
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        CustomSnackBar.showError(
                          context: context,
                          message: 'ออกจากระบบไม่สำเร็จ กรุณาลองใหม่อีกครั้ง',
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Row(
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