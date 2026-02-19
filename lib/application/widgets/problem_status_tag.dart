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
        color: status.getStatusColor.withOpacity(0.1),
        border: Border.all(
          color: status.getStatusColor.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.labelTh,
        style: TextStyle(
          fontSize: 14,
          color: status.getStatusColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
