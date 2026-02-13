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
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(color: const Color(0xFF5D3891), width: 2), // ขอบม่วง
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category.labelTh,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
