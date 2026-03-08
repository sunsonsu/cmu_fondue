/*
 * File: filters_section.dart
 * Description: Compact aggregator coupling distinct tag sliding arrays alongside categorized pills uniformly correctly implicitly natively.
 * Responsibilities: Mounts disjoint independent criteria layers cohesively simplifying parent history scaffolds greatly neatly.
 * Dependencies: FilterByCategory, FilterByTag, ProblemTag, ProblemType
 * Lifecycle: Created passively persisting along entire history list lifetimes safely completely seamlessly.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/widgets/filter_by_category.dart';
import 'package:cmu_fondue/application/widgets/filter_by_tag.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';

/// Aggregates completely decoupled filtering arrays cleanly masking component depth elegantly flawlessly safely natively.
class FiltersSection extends StatelessWidget {
  /// The isolated single status currently shaping query nodes exactly completely.
  final ProblemTag? selectedTag;
  
  /// The isolated categorical block narrowing target queries distinctly securely directly natively.
  final ProblemType? selectedCategory;
  
  /// Passes dynamic tag changes backwards routing intent implicitly completely quickly cleanly natively.
  final Function(ProblemTag?) onTagSelected;
  
  /// Rejects categorical changes throwing logic hooks recursively natively perfectly flawlessly dynamically natively.
  final Function(ProblemType?) onCategorySelected;

  /// Initializes a new instance of [FiltersSection].
  const FiltersSection({
    super.key,
    required this.selectedTag,
    required this.selectedCategory,
    required this.onTagSelected,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Filter by Tag
        FilterByTag(
          selectedTag: selectedTag,
          onTagSelected: onTagSelected,
        ),

        // Filter by Category
        FilterByCategory(
          selectedCategory: selectedCategory,
          onCategorySelected: onCategorySelected,
        ),
      ],
    );
  }
}
