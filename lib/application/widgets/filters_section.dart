import 'package:cmu_fondue/application/widgets/filter_by_category.dart';
import 'package:cmu_fondue/application/widgets/filter_by_tag.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';

class FiltersSection extends StatelessWidget {
  final ProblemTag? selectedTag;
  final ProblemType? selectedCategory;
  final Function(ProblemTag?) onTagSelected;
  final Function(ProblemType?) onCategorySelected;

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
