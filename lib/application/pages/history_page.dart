import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Report History',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),

        // History List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            itemBuilder: (context, index) => _buildHistoryCard(index),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryCard(int index) {
    final reports = [
      {
        'title': 'Broken Road',
        'date': '2026-02-08',
        'status': 'pending',
        'type': 'road',
      },
      {
        'title': 'ถนนแตกหน้าหอสมุด',
        'date': '2026-02-07',
        'status': 'in_progress',
        'type': 'ถนน',
      },
      {
        'title': 'Street Light Out',
        'date': '2026-02-05',
        'status': 'resolved',
        'type': 'light',
      },
      {
        'title': 'Water Leak',
        'date': '2026-02-03',
        'status': 'resolved',
        'type': 'water',
      },
      {
        'title': 'ป้ายจราจรชำรุด',
        'date': '2026-02-01',
        'status': 'pending',
        'type': 'sign',
      },
    ];

    final report = reports[index];
    final status = report['status'] as String;

    Color statusColor;
    String statusText;

    switch (status) {
      case 'pending':
        statusColor = Colors.orange;
        statusText = 'Pending';
        break;
      case 'in_progress':
        statusColor = Colors.blue;
        statusText = 'In Progress';
        break;
      case 'resolved':
        statusColor = Colors.green;
        statusText = 'Resolved';
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Unknown';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    report['title'] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.category, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  report['type'] as String,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                const SizedBox(width: 16),
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  report['date'] as String,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
