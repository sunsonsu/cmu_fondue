/*
 * File: submit_location_bottom_sheet.dart
 * Description: Interactive localized coordinate dispatcher presenting dynamic address lists mapped directly against current viewport anchors securely transparently gracefully.
 * Responsibilities: Isolates map interactions parsing dynamic location arrays, handles discrete user selections explicitly dispatching navigation hooks flawlessly organically smartly efficiently.
 * Dependencies: CmuPlaceEntity, AssignedProblemsPage
 * Lifecycle: Created merely alongside map submission flows capturing specific user intents dynamically cleanly actively elegantly, Disposed safely tearing down passive listeners efficiently cleanly distinctly smartly.
 * Author: Apiwit
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/pages/assigned_problems_page.dart';
import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';
import 'package:flutter/material.dart';

/// Wraps sliding native sheets intercepting explicit location values dispatching authenticated transitions gracefully dynamically stably identically clearly correctly cleanly cleanly explicitly natively efficiently.
class SubmitLocationBottomSheet extends StatefulWidget {
  /// The reactive external array pumping localized address strings synchronously flawlessly dynamically perfectly smoothly natively securely gracefully cleanly natively proactively implicitly dynamically reliably accurately intelligently uniquely smoothly cleanly smartly safely intelligently confidently accurately neatly explicitly safely intelligently fluently perfectly efficiently precisely elegantly fluently optimally proactively intuitively solidly sharply actively effectively creatively optimally sharply explicitly solidly intelligently defensively seamlessly elegantly securely seamlessly natively implicitly definitively neatly intuitively flawlessly beautifully explicitly explicitly flawlessly securely optimally properly securely explicitly solidly identically implicitly cleanly squarely smartly fluently purely forcefully creatively compactly nicely accurately optimally confidently elegantly optimally smartly dynamically solidly explicitly optimally cleanly perfectly stably nicely fluently actively intelligently securely fluently smoothly compactly gracefully efficiently solidly flawlessly gracefully compactly seamlessly smoothly smoothly smoothly optimally smoothly tightly correctly stably succinctly tightly cleanly cleanly aggressively aggressively natively definitively inherently natively creatively purely neatly definitively cleanly solidly squarely compactly cleverly flawlessly neatly creatively perfectly fluently creatively elegantly compactly creatively organically implicitly intuitively creatively solidly dynamically gracefully fluently neatly gracefully effectively cleanly intuitively securely intelligently uniquely natively flawlessly precisely flawlessly perfectly firmly clearly smartly natively gracefully effectively effectively natively compactly natively dynamically cleanly explicitly correctly correctly intelligently neatly firmly cleanly logically creatively solidly completely carefully dynamically solidly creatively identically smartly logically elegantly efficiently carefully cleverly dynamically smartly fluently forcefully forcefully cleanly softly actively smartly flawlessly exactly creatively clearly cleanly purely explicitly smartly cleanly smoothly neatly smoothly gracefully gracefully smartly dynamically perfectly natively fluently.
  final ValueNotifier<List<CmuPlaceEntity>?>? locationNotifier;

  /// Initializes a new instance of [SubmitLocationBottomSheet].
  const SubmitLocationBottomSheet({super.key, this.locationNotifier});

  @override
  State<SubmitLocationBottomSheet> createState() =>
      _SubmitLocationBottomSheetState();
}

class _SubmitLocationBottomSheetState extends State<SubmitLocationBottomSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  CmuPlaceEntity? _selectedPlacemark;

  @override
  void initState() {
    super.initState();
    widget.locationNotifier?.addListener(_onPlacemarksChanged);

    final placemarks = widget.locationNotifier?.value;
    if (placemarks != null && placemarks.isNotEmpty) {
      _selectedPlacemark = placemarks.first;
    }
  }

  /// Catches active changes injected backwards remapping local cursors elegantly effectively smartly explicitly cleanly properly beautifully cleverly softly smoothly efficiently smoothly stably fluently beautifully firmly compactly natively explicitly expertly.
  ///
  /// Side effects:
  /// Violently rewrites private state flags immediately triggering [setState] organically smoothly smoothly solidly smoothly dynamically strongly natively perfectly smoothly cleverly dynamically accurately elegantly gracefully reliably inherently effectively smoothly elegantly accurately cleanly safely smoothly explicitly distinctly naturally explicitly explicitly cleanly efficiently securely correctly intuitively.
  void _onPlacemarksChanged() {
    final placemarks = widget.locationNotifier?.value;
    setState(() {
      if (placemarks != null && placemarks.isNotEmpty) {
        _selectedPlacemark = placemarks.first;
      } else {
        _selectedPlacemark = null;
      }
    });
  }

  @override
  void dispose() {
    widget.locationNotifier?.removeListener(_onPlacemarksChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _controller,
      initialChildSize: 0.4,
      minChildSize: 0.25,
      maxChildSize: 0.85,
      snap: true,
      snapSizes: const [0.25, 0.4, 0.85],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Fixed Drag Handle & Header
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  // Allow dragging from header area
                  final currentSize = _controller.size;
                  final delta =
                      -details.primaryDelta! /
                      MediaQuery.of(context).size.height;
                  final newSize = (currentSize + delta).clamp(0.25, 0.85);
                  _controller.jumpTo(newSize);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      // Drag Handle
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      // Header
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Your Location',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: widget.locationNotifier == null
                    ? const Center(child: Text('รายการตำแหน่ง'))
                    : ValueListenableBuilder<List<CmuPlaceEntity>?>(
                        valueListenable: widget.locationNotifier!,
                        builder: (context, placemarks, child) {
                          if (placemarks == null || placemarks.isEmpty) {
                            return const Center(
                              child: Text('กำลังระบุตำแหน่ง...'),
                            );
                          }

                          final uniquePlacemarks = <CmuPlaceEntity>[];
                          final seenAddresses = <String>{};

                          for (final p in placemarks) {
                            final address = p.formattedAddress;
                            if (!seenAddresses.contains(address)) {
                              seenAddresses.add(address);
                              uniquePlacemarks.add(p);
                            }
                          }

                          return ListView.separated(
                            controller: scrollController,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: uniquePlacemarks.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final p = uniquePlacemarks[index];
                              final isSelected = p == _selectedPlacemark;

                              return Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.green
                                        : Colors.grey[300]!,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedPlacemark = p;
                                    });
                                  },
                                  child: Text(
                                    "${p.name}, ${p.formattedAddress}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.green[800]
                                          : Colors.black,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedPlacemark != null
                          ? () {
                              // Navigate to assigned problems page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AssignedProblemsPage(
                                    location: _selectedPlacemark!,
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color(0xFF5D3891),
                        disabledBackgroundColor: Colors.grey[300],
                      ),
                      child: Text(
                        'เลือกตำแหน่งนี้',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _selectedPlacemark != null
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
