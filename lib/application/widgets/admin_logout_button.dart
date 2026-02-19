import 'package:cmu_fondue/application/pages/profile_page.dart';
import 'package:flutter/material.dart';

class AdminLogoutButton extends StatelessWidget {
  const AdminLogoutButton({super.key});

  void _navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _navigateToProfile(context),
      icon: const Icon(
        Icons.person,
        color: Color(0xFF5D3891),
      ),
      iconSize: 32,
      tooltip: 'Profile',
    );
  }
}
