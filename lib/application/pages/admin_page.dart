import 'package:cmu_fondue/application/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AppAuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        centerTitle: true,
        backgroundColor: const Color(0xFF5D3891),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Admin Badge
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xFFF99305),
              child: const Icon(
                Icons.admin_panel_settings,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            // Admin Label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF99305),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'ADMIN',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Email
            const Text('Email', style: TextStyle(color: Colors.grey)),
            Text(
              user?.email ?? 'Not Available',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            // Admin Features
            Expanded(
              child: ListView(
                children: [
                  _buildAdminCard(
                    icon: Icons.people,
                    title: 'Manage Users',
                    subtitle: 'View and manage all users',
                    onTap: () {
                      // TODO: Navigate to user management
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildAdminCard(
                    icon: Icons.report_problem,
                    title: 'Manage Reports',
                    subtitle: 'Review and manage all reports',
                    onTap: () {
                      // TODO: Navigate to report management
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildAdminCard(
                    icon: Icons.analytics,
                    title: 'Analytics',
                    subtitle: 'View system statistics',
                    onTap: () {
                      // TODO: Navigate to analytics
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildAdminCard(
                    icon: Icons.settings,
                    title: 'System Settings',
                    subtitle: 'Configure system settings',
                    onTap: () {
                      // TODO: Navigate to settings
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Logout Button
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF5D3891),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
