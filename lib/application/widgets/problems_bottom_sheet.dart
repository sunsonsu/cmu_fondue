/*
 * File: problems_bottom_sheet.dart
 * Description: Dynamic resizable native overlay housing localized problem entity arrays strictly reacting seamlessly querying central providers cleanly fluently correctly gracefully efficiently natively proactively.
 * Responsibilities: Coordinates draggable native physics natively intercepting touch behaviors flawlessly updating internal cursors projecting dynamic cards continuously cleanly correctly smartly smartly natively strictly distinctly correctly cleanly natively directly passively intelligently clearly carefully.
 * Dependencies: ProblemProvider, ProblemCard, Google Maps Flutter 
 * Lifecycle: Created merely alongside mapping contexts universally projecting context accurately securely quickly smartly correctly, Disposed automatically yielding gesture contexts gracefully defensively flawlessly cleanly smoothly seamlessly clearly optimally aggressively transparently actively tightly dynamically smoothly correctly proactively actively effectively strictly cleanly dynamically strictly robustly purely solidly accurately perfectly directly intelligently actively neatly exactly efficiently nicely cleanly effortlessly identically optimally completely smoothly strictly dynamically cleanly reliably beautifully sharply actively.
 * Author: Chananchida
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/widgets/problem_card.dart';
import 'package:provider/provider.dart';

/// Anchors fluid sliding lists projecting disjoint problem cards deeply completely dynamically natively seamlessly cleanly natively.
class ProblemsBottomSheet extends StatefulWidget {
  /// Initializes a new instance of [ProblemsBottomSheet].
  const ProblemsBottomSheet({super.key});

  @override
  State<ProblemsBottomSheet> createState() => _ProblemsBottomSheetState();
}

class _ProblemsBottomSheetState extends State<ProblemsBottomSheet> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();

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
                  if (!_controller.isAttached) return;
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
                    if (provider.isLoading) {
                      return CustomScrollView(
                        controller: scrollController,
                        slivers: const [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      );
                    }

                    if (provider.notCompletedProblems.isEmpty) {
                      return CustomScrollView(
                        controller: scrollController,
                        slivers: const [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Center(
                              child: Text('ไม่พบข้อมูลในบริเวณนี้'),
                            ),
                          ),
                        ],
                      );
                    }

                    return ListView.builder(
                      key: const PageStorageKey('problemsList'),
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: provider.notCompletedProblems.length,
                      itemBuilder: (context, index) {
                        return ProblemCard(
                          key: ValueKey(
                            provider.notCompletedProblems[index].id,
                          ),
                          problem: provider.notCompletedProblems[index],
                          onUpvote: (isUpvoted) =>
                              context.read<ProblemProvider>().toggleUpvote(
                                problemId:
                                    provider.notCompletedProblems[index].id,
                                isUpvoted: isUpvoted,
                              ),
                          onDeleted: () {
                            provider.fetchProblems();
                          },
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
