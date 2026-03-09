/*
 * File: history_page.dart
 * Description: Specialized list viewer rendering purely previous logs natively sourced specifically back targeting uniquely reporting accounts.
 * Responsibilities: Partitions reports automatically mapping groups separating statuses into sections distinctly tracking historical milestones securely.
 * Dependencies: ProblemProvider, ProblemCard
 * Lifecycle: Created instantly whenever navigating toward index 2 exclusively, Disposed merely exiting parent tabs correctly.
 * Author: Chananchida, Komsan
 * Course: CMU Fondue
 */

import 'package:cmu_fondue/application/providers/problem_provider.dart';
import 'package:cmu_fondue/application/widgets/problem_card.dart';
import 'package:cmu_fondue/domain/entities/problem_entity.dart';
import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Aggregates exclusive lists strictly restricted toward identity-owned queries rendering dynamically sectioned interfaces directly.
class HistoryPage extends StatefulWidget {
  /// Initializes a new instance of [HistoryPage].
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProblemProvider>().fetchProblems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAE5F1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'ประวัติการแจ้งเรื่อง',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D3891),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () => context.read<ProblemProvider>().fetchProblems(),
          child: Consumer<ProblemProvider>(
            builder: (context, provider, child) {
              final historyList = provider.historyProblems;

              if (provider.isLoading && historyList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (historyList.isEmpty) {
                return _buildEmptyState();
              }

              final sections = _getSections(historyList);

              return ListView.builder(
                key: const PageStorageKey('historyList'),
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: sections.length,
                itemBuilder: (context, index) {
                  final item = sections[index];

                  if (item is String) {
                    return _buildSectionHeader(item);
                  } else if (item is ProblemEntity) {
                    return ProblemCard(
                      key: ValueKey(item.id),
                      problem: item,
                      onUpvote: (isUpvoted) => provider.toggleUpvote(
                        problemId: item.id,
                        isUpvoted: isUpvoted,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  /// Calculates visual dividers segmenting [problems] deeply segregating items spanning unique execution states statically.
  List<dynamic> _getSections(List<ProblemEntity> problems) {
    final pending = problems
        .where(
          (p) => [ProblemTag.pending, ProblemTag.received].contains(p.tagName),
        )
        .toList();
    final inProgress = problems
        .where((p) => p.tagName == ProblemTag.inProgress)
        .toList();
    final completed = problems
        .where((p) => p.tagName == ProblemTag.completed)
        .toList();

    List<dynamic> items = [];
    if (pending.isNotEmpty) {
      items.add('รอดำเนินการ (${pending.length})');
      items.addAll(pending);
    }
    if (inProgress.isNotEmpty) {
      items.add('กำลังดำเนินการ (${inProgress.length})');
      items.addAll(inProgress);
    }
    if (completed.isNotEmpty) {
      items.add('เสร็จสิ้น (${completed.length})');
      items.addAll(completed);
    }
    return items;
  }

  /// Projects simplistic blank placeholders natively covering entirely bare datasets visually stopping errors directly.
  Widget _buildEmptyState() {
    return ListView(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.3),
        const Center(
          child: Text(
            'ไม่มีประวัติการแจ้งเรื่อง',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  /// Constructs textual markers bridging gaps internally describing strictly identical status categories natively utilizing [title] text directly.
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: Color(0xFF5D3891),
        ),
      ),
    );
  }
}
