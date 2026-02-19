import 'package:cmu_fondue/application/widgets/app_title_bar.dart';
import 'package:cmu_fondue/application/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/widgets/problems_bottom_sheet.dart';

class MapViewerPage extends StatelessWidget {
  const MapViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MapViewerWidget(),

        // Draggable Problems Bottom Sheet
        ProblemsBottomSheet(),

        // Title Bar at Top
        const AppTitleBar(),
      ],
    );
  }
}
