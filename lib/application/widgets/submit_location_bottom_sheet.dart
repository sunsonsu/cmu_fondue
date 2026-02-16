import 'package:cmu_fondue/application/pages/nearby_problem_page.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class SubmitLocationBottomSheet extends StatefulWidget {
  const SubmitLocationBottomSheet({super.key, this.locationNotifier});

  final ValueNotifier<List<Placemark>?>? locationNotifier;

  @override
  State<SubmitLocationBottomSheet> createState() =>
      _SubmitLocationBottomSheetState();
}

class _SubmitLocationBottomSheetState extends State<SubmitLocationBottomSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  Placemark? _selectedPlacemark;

  @override
  void initState() {
    super.initState();
    widget.locationNotifier?.addListener(_resetSelection);
  }

  void _resetSelection() {
    if (_selectedPlacemark != null) {
      setState(() {
        _selectedPlacemark = null;
      });
    }
  }

  @override
  void dispose() {
    widget.locationNotifier?.removeListener(_resetSelection);
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
                            'เลือกตำแหน่ง',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
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
                    : ValueListenableBuilder<List<Placemark>?>(
                        valueListenable: widget.locationNotifier!,
                        builder: (context, placemarks, child) {
                          if (placemarks == null || placemarks.isEmpty) {
                            return const Center(
                              child: Text('กำลังระบุตำแหน่ง...'),
                            );
                          }

                          if (_selectedPlacemark != null) {
                            return ListView(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  child: Text(
                                    [
                                          _selectedPlacemark!.name,
                                          _selectedPlacemark!.street,
                                          _selectedPlacemark!.subLocality,
                                          _selectedPlacemark!.locality,
                                          _selectedPlacemark!.postalCode,
                                        ]
                                        .where((e) => e != null && e.isNotEmpty)
                                        .toSet()
                                        .join(' '),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => NearbyProblemPage(
                                          location: _selectedPlacemark,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(
                                      double.infinity,
                                      48,
                                    ),
                                    backgroundColor: const Color(0xFF5D3891),
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('เลือกตำแหน่ง'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedPlacemark = null;
                                    });
                                  },
                                  child: const Text('เลือกตำแหน่งใหม่'),
                                ),
                              ],
                            );
                          }

                          return ListView.separated(
                            controller: scrollController,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: placemarks.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final p = placemarks[index];
                              return Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedPlacemark = p;
                                    });
                                  },
                                  child: Text(
                                    [
                                          p.name,
                                          p.street,
                                          p.subLocality,
                                          p.locality,
                                          p.postalCode,
                                        ]
                                        .where((e) => e != null && e.isNotEmpty)
                                        .toSet()
                                        .join(' '),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
