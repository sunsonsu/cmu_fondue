/*
 * File: assigned_problems_page.dart
 * Description: Transitional gate-checking screen verifying prior bug reports before drafting duplicates.
 * Responsibilities: Checks existing submissions surrounding a chosen locale preventing extraneous entries globally.
 * Dependencies: ProblemProvider, ProblemCard, CreateReportPage
 * Lifecycle: Pushed via Navigator following explicit search selections, Disposed when drafting begins or cancelled outwardly.
 * Author: App Team
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:flutter/material.dart';
import 'package:cmu_fondue/application/widgets/problem_card.dart';
import 'package:cmu_fondue/application/pages/create_report_page.dart';
import 'package:provider/provider.dart';
import 'package:cmu_fondue/domain/entities/cmu_place_entity.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';

/// Demands citizens explicitly review ongoing vicinity issues preventing unnecessary duplicate logs internally.
class AssignedProblemsPage extends StatefulWidget {
  /// The isolated coordinate framework pinning the user intent physically.
  final CmuPlaceEntity location;

  /// Initializes a new instance of [AssignedProblemsPage].
  const AssignedProblemsPage({super.key, required this.location});

  @override
  State<AssignedProblemsPage> createState() => _AssignedProblemsPageState();
}

class _AssignedProblemsPageState extends State<AssignedProblemsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProblemProvider>(context, listen: false).fetchProblems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAE5F1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF5D3891)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ปัญหาที่เคยถูกแจ้งบริเวณนี้',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D3891),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Text(
                'ตรวจสอบว่าปัญหาที่คุณต้องการแจ้ง มีคนแจ้งแล้วหรือยัง ถ้ามีการแจ้งแล้วสามารถกด Upvote ได้ แต่ถ้ายังสามารถกดแจ้งปัญหาได้',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.location.formattedAddress,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: Consumer<ProblemProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<ProblemEntity> displayProblems = provider
                      .getNearbyProblems(
                        widget.location.lat,
                        widget.location.lng,
                        onlyNotCompleted: true,
                      );

                  if (displayProblems.isEmpty) {
                    return const Center(child: Text('ไม่พบข้อมูลในบริเวณนี้'));
                  }

                  return ListView.builder(
                    key: const PageStorageKey('problemsList'),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: displayProblems.length,
                    itemBuilder: (context, index) {
                      return ProblemCard(
                        key: ValueKey(displayProblems[index].id),
                        problem: displayProblems[index],
                        onUpvote: (isUpvoted) =>
                            context.read<ProblemProvider>().toggleUpvote(
                              problemId: displayProblems[index].id,
                              isUpvoted: isUpvoted,
                            ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateReportPage(location: widget.location),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: const Color(0xFF5D3891),
                        ),
                        child: const Text(
                          'แจ้งปัญหา',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: const BorderSide(
                            color: Color(0xFF5D3891),
                            width: 2,
                          ),
                        ),
                        child: const Text(
                          'ยกเลิก',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF5D3891),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
