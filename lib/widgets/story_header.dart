import 'package:flutter/material.dart';

import '../models/story_page_data.dart';
import 'story_helpers.dart';

class StoryHeader extends StatelessWidget {
  const StoryHeader({
    super.key,
    required this.page,
    required this.onClose,
  });

  final StoryPageData page;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              ClipOval(
                child: StoryHelpers.safeAsset(
                  page.icon,
                  width: 46,
                  height: 46,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Round Recap',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF202020),
                    ),
                  ),
                  Text(
                    'See your results',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF4E4E4E),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: onClose,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: Color(0xFF111111),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '×',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
