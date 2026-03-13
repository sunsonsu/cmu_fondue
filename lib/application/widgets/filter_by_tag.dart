/*
 * File: filter_by_tag.dart
 * Description: Animated sliding horizontal tab array bounding dataset intersections strictly conforming underlying lifecycle lifespans seamlessly natively.
 * Responsibilities: Interpolates exact physical boundaries moving floating selection bars smoothly, intercepts active taps safely flushing data queries completely identically natively.
 * Dependencies: ProblemTag
 * Lifecycle: Created persistently anchoring list viewpoints completely dynamically, Disposed identically abandoning parent scopes.
 * Author: Chananchida 650510659
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';

/// Wraps sliding horizontal status arrays matching precise visual limits updating continuous data filters distinctly accurately natively.
class FilterByTag extends StatefulWidget {
  /// The single validated cloud status currently highlighting tabs identically natively.
  final ProblemTag? selectedTag;

  /// Invokes arbitrary parent reloads dumping disjoint data streams rapidly natively securely cleanly.
  final Function(ProblemTag?) onTagSelected;

  /// Initializes a new instance of [FilterByTag].
  const FilterByTag({
    super.key,
    required this.selectedTag,
    required this.onTagSelected,
  });

  @override
  State<FilterByTag> createState() => _FilterByTagState();
}

class _FilterByTagState extends State<FilterByTag> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.selectedTag == null) {
        widget.onTagSelected(ProblemTag.pending);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Row(
          children: [
            _buildTab(
              label: 'รอดำเนินการ',
              tag: ProblemTag.pending,
              isSelected: widget.selectedTag == ProblemTag.pending,
            ),
            const SizedBox(width: 16),
            _buildTab(
              label: 'รับเรื่องแล้ว',
              tag: ProblemTag.received,
              isSelected: widget.selectedTag == ProblemTag.received,
            ),
            const SizedBox(width: 16),
            _buildTab(
              label: 'กำลังดำเนินการ',
              tag: ProblemTag.inProgress,
              isSelected: widget.selectedTag == ProblemTag.inProgress,
            ),
            const SizedBox(width: 16),
            _buildTab(
              label: 'เสร็จสิ้น',
              tag: ProblemTag.completed,
              isSelected: widget.selectedTag == ProblemTag.completed,
            ),
          ],
        ),
      ),
    );
  }

  /// Composes simple textual labels registering strict logical node mappings intercepting taps explicitly neatly perfectly natively.
  Widget _buildTab({
    required String label,
    required ProblemTag tag,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => widget.onTagSelected(isSelected ? null : tag),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? const Color(0xFF5D3891)
                      : Colors.grey[700],
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              height: 3,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF5D3891)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
