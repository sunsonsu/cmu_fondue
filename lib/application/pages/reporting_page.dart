import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ReportingPage extends StatefulWidget {
  const ReportingPage({super.key, this.location});

  final Placemark? location;

  @override
  State<ReportingPage> createState() => _ReportingPageState();
}

class _ReportingPageState extends State<ReportingPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedType;
  String? _selectedTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แจ้งปัญหา'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Your location',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.location?.name} ${widget.location?.street}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),

                // Photo Upload
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        size: 60,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to add photo',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Title TextField
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Problem Title',
                    hintText: 'Enter problem title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Type Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: _selectedType,
                  items: const [
                    DropdownMenuItem(value: 'road', child: Text('Road (ถนน)')),
                    DropdownMenuItem(value: 'light', child: Text('Light (ไฟ)')),
                    DropdownMenuItem(
                      value: 'water',
                      child: Text('Water (น้ำ)'),
                    ),
                    DropdownMenuItem(
                      value: 'other',
                      child: Text('Other (อื่นๆ)'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Tag Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: _selectedTag,
                  items: const [
                    DropdownMenuItem(
                      value: 'urgent',
                      child: Text('Urgent (รบเร่อง)'),
                    ),
                    DropdownMenuItem(
                      value: 'normal',
                      child: Text('Normal (ปกติ)'),
                    ),
                    DropdownMenuItem(value: 'low', child: Text('Low (ต่ำ)')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedTag = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a priority';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Description TextField
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Describe the problem',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 24),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Submit form
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Problem reported!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5D3891),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit Report',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
