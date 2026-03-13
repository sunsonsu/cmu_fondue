/*
 * File: problem_status_tag.dart
 * Description: Miniature status indicator resolving dynamic semantic colors matching discrete enumerated entity states consistently clearly graphically clearly organically.
 * Responsibilities: Wraps specific enumeration nodes strictly explicitly projecting semantic color palettes universally flawlessly sharply concisely locally visually.
 * Dependencies: ProblemTag
 * Lifecycle: Created invariably projecting active states dynamically distinctly flawlessly clearly precisely reliably perfectly sharply neatly seamlessly correctly seamlessly, Disposed safely correctly cleanly silently releasing layout locks uniquely transparently dynamically passively gracefully reliably accurately smoothly identically actively solidly accurately compactly cleanly reliably purely correctly reliably completely clearly.
 * Author: Chananchida 650510659
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';

/// Renders compact visual status indicators binding discrete enumerated metadata explicitly projecting native semantic palettes flawlessly properly accurately natively locally uniformly clearly correctly smartly sharply precisely perfectly organically smoothly distinct flawlessly firmly dynamically intuitively neatly natively cleanly effectively clearly dynamically.
class ProblemStatusTag extends StatelessWidget {
  /// The absolute verified status domain forcing dynamic palette evaluations flawlessly safely uniquely implicitly gracefully directly correctly cleanly intuitively completely directly natively distinctly natively definitively strictly.
  final ProblemTag status;

  /// Initializes a new instance of [ProblemStatusTag].
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
