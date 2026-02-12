import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';

class ProblemStatusTag extends StatelessWidget {
  final ProblemTag status;

  const ProblemStatusTag({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: status.getStatusColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.labelTh,
        style: TextStyle(
          fontSize: 13,
          color: status.getStatusColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
