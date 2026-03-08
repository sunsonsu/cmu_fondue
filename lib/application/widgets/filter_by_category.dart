/*
 * File: filter_by_category.dart
 * Description: Horizontal chip array segregating arbitrary problem pools matching strict localized metadata domains distinctly locally.
 * Responsibilities: Evaluates active semantic clusters, visualizes highlighted filter pills explicitly mapping internal enumerations correctly explicitly natively.
 * Dependencies: ProblemType
 * Lifecycle: Created merely while viewing lists exposing filtering tabs dynamically, Disposed automatically when abandoning history flows.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';

/// Wraps continuous categorical metadata exposing discrete interactive nodes narrowing data queries precisely dynamically globally.
class FilterByCategory extends StatelessWidget {
  /// The isolated single domain presently filtering list queries correctly transparently natively.
  final ProblemType? selectedCategory;
  
  /// Dispatches strict metadata shifts backwards rewriting upstream streams abruptly safely.
  final Function(ProblemType?) onCategorySelected;

  /// Initializes a new instance of [FilterByCategory].
  const FilterByCategory({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'ค้นหาตามหมวดหมู่',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: ProblemType.values.asMap().entries.map((entry) {
                final type = entry.value;
                final index = entry.key;
                final isSelected = selectedCategory == type;
                final isLast = index == ProblemType.values.length - 1;
                
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: isLast ? 0 : 8),
                    child: _buildChip(
                      label: type.labelTh,
                      isSelected: isSelected,
                      onTap: () => onCategorySelected(isSelected ? null : type),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /// Synthesizes distinct clickable pills marking active domains clearly leveraging contrast natively cleanly seamlessly.
  Widget _buildChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5D3891) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.grey[700],
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 4),
              const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
