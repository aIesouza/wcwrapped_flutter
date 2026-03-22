import 'package:flutter/material.dart';

class ProgressBars extends StatelessWidget {
  const ProgressBars({
    super.key,
    required this.total,
    required this.activeIndex,
  });

  final int total;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        final isDone = index < activeIndex;
        final isActive = index == activeIndex;

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index == total - 1 ? 0 : 6),
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              borderRadius: BorderRadius.circular(999),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: isDone || isActive ? 1 : 0,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF272727),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
