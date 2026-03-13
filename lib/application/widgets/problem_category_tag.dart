/*
 * File: problem_category_tag.dart
 * Description: Miniature semantic visual chip encoding absolute categorical definitions statically visually cleanly distinct.
 * Responsibilities: Translates domain enum constants into colored textual badges seamlessly dynamically reliably correctly natively effortlessly passively smoothly transparently independently intelligently visually.
 * Dependencies: ProblemType
 * Lifecycle: Created merely to project categorical states inside dense layouts quickly, Disposed naturally yielding layout bounds back silently cleanly transparently efficiently swiftly safely flawlessly perfectly.
 * Author: Chananchida 650510659
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';

/// Wraps discrete categorical metadata explicitly projecting stylized borders wrapping Thai labels perfectly seamlessly tightly directly inherently organically cleanly distinctly purely completely natively cleanly solidly smartly.
class ProblemCategoryTag extends StatelessWidget {
  /// The specific domain value injecting localized labels dynamically strictly visually distinct passively consistently implicitly gracefully.
  final ProblemType category;

  /// Initializes a new instance of [ProblemCategoryTag].
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
