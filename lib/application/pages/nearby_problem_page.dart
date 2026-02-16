import 'package:cmu_fondue/application/pages/reporting_page.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class NearbyProblemPage extends StatelessWidget {
  const NearbyProblemPage({super.key, this.location});

  final Placemark? location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ปัญหาที่เคยถูกแจ้งบริเวณนี้')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'กรุณาตรวจสอบว่าปัญหาที่คุณต้องการแจ้ง มีคนแจ้วแล้วหรือยัง ถ้ามีการแจ้งแล้วสามารถกด Upvote ได้ แต่ถ้ายังสามารถกดแจ้งปัญหาได้',
                  style: TextStyle(fontSize: 11, color: Color(0xFF696969)),
                ),
                SizedBox(height: 16),
                Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF9D9D9D),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${location?.name} ${location?.street}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF5D3891),
                  side: const BorderSide(color: Color(0xFF5D3891)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportingPage(location: location),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D3891),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'แจ้งปัญหา',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
