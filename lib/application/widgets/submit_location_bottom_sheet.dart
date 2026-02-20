import 'package:cmu_fondue/application/pages/assigned_problems_page.dart';
import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';
// import 'package:cmu_fondue/application/pages/nearby_problem_page.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class SubmitLocationBottomSheet extends StatefulWidget {
  const SubmitLocationBottomSheet({super.key, this.locationNotifier});

  final ValueNotifier<List<CmuPlaceEntity>?>? locationNotifier;

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
