import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AppAuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // รูปโปรไฟล์ขนาดใหญ่
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xFF5D3891),
              child: Text(
                user?.email[0].toUpperCase() ?? 'U',
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            // แสดง Email
            const Text('Email', style: TextStyle(color: Colors.grey)),
            Text(
              user?.email ?? 'Not Available',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            // ปุ่ม Logout
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => authProvider.logout(),
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}