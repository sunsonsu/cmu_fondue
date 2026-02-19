import 'package:cmu_fondue/domain/enum/problem_enums.dart';
import 'package:flutter/material.dart';

class FilterByTag extends StatefulWidget {
  final ProblemTag? selectedTag;
  final Function(ProblemTag?) onTagSelected;

  const FilterByTag({
    super.key,
    required this.selectedTag,
    required this.onTagSelected,
  });

  @override
  State<FilterByTag> createState() => _FilterByTagState();
}

class _FilterByTagState extends State<FilterByTag> {
  final GlobalKey _containerKey = GlobalKey();
  final Map<ProblemTag, GlobalKey> _tabKeys = {
    ProblemTag.pending: GlobalKey(),
    ProblemTag.received: GlobalKey(),
    ProblemTag.inProgress: GlobalKey(),
    ProblemTag.completed: GlobalKey(),
  };

  double _indicatorLeft = 0;
  bool _showIndicator = false;
  static const double _indicatorWidth = 60.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateIndicatorPosition();
    });
  }

  @override
  void didUpdateWidget(FilterByTag oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedTag != widget.selectedTag) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateIndicatorPosition();
      });
    }
  }

  void _updateIndicatorPosition() {
    if (widget.selectedTag == null) {
      setState(() {
        _showIndicator = false;
      });
      return;
    }

    final tabKey = _tabKeys[widget.selectedTag];
    final containerKey = _containerKey;

    if (tabKey?.currentContext != null && containerKey.currentContext != null) {
      final RenderBox tabBox = tabKey!.currentContext!.findRenderObject() as RenderBox;
      final RenderBox containerBox = containerKey.currentContext!.findRenderObject() as RenderBox;
      
      final tabPosition = tabBox.localToGlobal(Offset.zero);
      final containerPosition = containerBox.localToGlobal(Offset.zero);
      final tabWidth = tabBox.size.width;
      
      setState(() {
        // Center the indicator under the tab
        _indicatorLeft = (tabPosition.dx - containerPosition.dx) + (tabWidth - _indicatorWidth) / 2;
        _showIndicator = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _containerKey,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildTab(
                  label: 'รอดำเนินการ',
                  tag: ProblemTag.pending,
                  isSelected: widget.selectedTag == ProblemTag.pending,
                  tabKey: _tabKeys[ProblemTag.pending]!,
                ),
                const SizedBox(width: 16),
                _buildTab(
                  label: 'รับเรื่องแล้ว',
                  tag: ProblemTag.received,
                  isSelected: widget.selectedTag == ProblemTag.received,
                  tabKey: _tabKeys[ProblemTag.received]!,
                ),
                const SizedBox(width: 16),
                _buildTab(
                  label: 'กำลังดำเนินการ',
                  tag: ProblemTag.inProgress,
                  isSelected: widget.selectedTag == ProblemTag.inProgress,
                  tabKey: _tabKeys[ProblemTag.inProgress]!,
                ),
                const SizedBox(width: 16),
                _buildTab(
                  label: 'เสร็จสิ้น',
                  tag: ProblemTag.completed,
                  isSelected: widget.selectedTag == ProblemTag.completed,
                  tabKey: _tabKeys[ProblemTag.completed]!,
                ),
              ],
            ),
          ),
          // Animated indicator
          if (_showIndicator)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: 2,
              left: _indicatorLeft,
              child: Container(
                height: 3,
                width: _indicatorWidth,
                decoration: BoxDecoration(
                  color: const Color(0xFF5D3891),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required ProblemTag tag,
    required bool isSelected,
    required GlobalKey tabKey,
  }) {
    return GestureDetector(
      key: tabKey,
      onTap: () => widget.onTagSelected(isSelected ? null : tag),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 1),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? const Color(0xFF5D3891) : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}
