import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';

class ProblemCategoryTag extends StatelessWidget {
  final ProblemType category;

  const ProblemCategoryTag({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF5D3891).withOpacity(0.1),
        border: Border.all(
          color: const Color(0xFF5D3891).withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category.labelTh,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF5D3891),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
