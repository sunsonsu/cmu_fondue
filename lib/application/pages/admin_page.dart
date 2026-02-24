import 'package:cmu_fondue/application/widgets/profile_button.dart';
import 'package:cmu_fondue/application/widgets/staff_dashboard.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAE5F1),
      appBar: AppBar(
        title: const Text(
          'ภาพรวมระบบ',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D3891),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: const [
          Padding(padding: EdgeInsets.only(right: 12), child: ProfileButton()),
        ],
      ),
      body: const StaffDashboard(),
    );
  }
}
