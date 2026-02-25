import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/widgets/problem_card.dart';
import 'package:provider/provider.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cmu_fondue/application/widgets/map_widget.dart';

class ProblemsBottomSheet extends StatefulWidget {
  const ProblemsBottomSheet({super.key});

  @override
  State<ProblemsBottomSheet> createState() => _ProblemsBottomSheetState();
}

class _ProblemsBottomSheetState extends State<ProblemsBottomSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  Position? _currentPosition;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try {
      final position = await getUserCurrentLocation();
      if (mounted) {
        setState(() {
          _currentPosition = position;
          _isLoadingLocation = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoadingLocation = false);
    }
  }

  @override
  void dispose() {
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
                            'ปัญหาที่เคยถูกแจ้งบริเวณนี้',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5D3891),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Scrollable Problems List
              Expanded(
                child: Consumer<ProblemProvider>(
                  builder: (context, provider, child) {
                    if (provider.isLoading || _isLoadingLocation) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    List<ProblemEntity> displayProblems =
                        provider.notCompletedProblems;

                    print(
                      '-----------------UI bottom sheet: ${displayProblems.length}-------------------',
                    );

                    if (displayProblems.isEmpty) {
                      return const Center(
                        child: Text('ไม่พบข้อมูลในบริเวณนี้'),
                      );
                    }

                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: displayProblems.length,
                      itemBuilder: (context, index) {
                        return ProblemCard(problem: displayProblems[index]);
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
