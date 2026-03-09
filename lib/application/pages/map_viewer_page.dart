/*
 * File: map_viewer_page.dart
 * Description: High-level screen aggregating ambient mapping visualizers beneath floating interactive layers.
 * Responsibilities: Stacks native map widgets alongside custom title bars and drag-capable bottom sheets distinctly.
 * Dependencies: AppTitleBar, MapViewerWidget, ProblemsBottomSheet
 * Lifecycle: Created via app router upon index 0 selection, Disposed when exiting parent navigation flow completely.
 * Author: Apiwit, Chananchida
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/widgets/app_title_bar.dart';
import 'package:cmu_fondue/application/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/widgets/problems_bottom_sheet.dart';

/// Aggregates distinct spatial mapping abstractions layering dynamic overlays flawlessly native.
class MapViewerPage extends StatelessWidget {
  /// Initializes a new instance of [MapViewerPage].
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
