/*
 * File: map_viewer_page.dart
 * Description: The primary spatial data visualization layer aggregating ambient map components beneath interactive overlays.
 * Responsibilities: 
 * - Coordinates the rendering of the foundational [MapViewerWidget].
 * - Manages the stacking hierarchy of title bars and problem-status bottom sheets.
 * - Serves as the high-level dashboard for geographical incident inspection.
 * Author: Apiwit 650510648
 * Course: Mobile Application Development Framework
 * Lifecycle: Created via app router upon index 0 selection, Disposed when exiting parent navigation flow completely.
 */

import 'package:cmu_fondue/application/widgets/app_title_bar.dart';
import 'package:cmu_fondue/application/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/widgets/problems_bottom_sheet.dart';

/// Aggregates distinct spatial mapping abstractions layering dynamic overlays flawlessly natively.
/// 
/// Acts as the root container for the map screen, integrating [MapViewerWidget] for map display, 
/// [ProblemsBottomSheet] for incident lists, and [AppTitleBar] for navigation and search.
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
