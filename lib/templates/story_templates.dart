import 'package:flutter/material.dart';
import '../models/story_page_data.dart';
import '../widgets/story_helpers.dart';

class StoryTemplates {
  static Widget buildDecor(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (page.theme) {

          // ---------------- PAGE 1 ----------------
          case StoryTheme.roundRecap:
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -40,
                  left: 0,
                  right: 0,
                  child: StoryHelpers.safeAsset(
                    'assets/images/page-1/element-1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: -constraints.maxHeight * 0.04,
                  child: SizedBox(
                    width: constraints.maxWidth * 0.32,
                    child: StoryHelpers.safeAsset(
                      'assets/images/page-1/element-3.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: -constraints.maxHeight * 0.04,
                  child: SizedBox(
                    width: constraints.maxWidth * 0.56,
                    child: StoryHelpers.safeAsset(
                      'assets/images/page-1/element-2.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            );

          // ---------------- PAGE 2 / DEFAULT ----------------
          case StoryTheme.defaultPage:
            if (page.decorImage == null) {
              return const SizedBox.shrink();
            }

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  bottom: -constraints.maxHeight * 0.05,
                  child: SizedBox(
                    width: constraints.maxWidth * 0.82,
                    child: StoryHelpers.safeAsset(
                      page.decorImage!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            );

          // ---------------- PAGE 4 ----------------
          case StoryTheme.roundMvp:
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: constraints.maxWidth * 0.02,
                  bottom: -constraints.maxHeight * 0.05,
                  width: constraints.maxWidth * 1.1,
                  child: StoryHelpers.safeAsset(
                    page.bottomSpikes ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );

          // ---------------- PAGE 5 ----------------
          case StoryTheme.xpRound:
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 45,
                  bottom: -constraints.maxHeight * 0.025,
                  width: constraints.maxWidth * 0.9,
                  child: StoryHelpers.safeAsset(
                    page.spikesImage ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );

          // ---------------- PAGE 6 ----------------
          case StoryTheme.badgesEarned:
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 42,
                  left: -constraints.maxWidth * 0.09,
                  width: constraints.maxWidth * 1.18,
                  child: StoryHelpers.safeAsset(
                    page.spikesImage ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );

          // ---------------- PAGE 7 ----------------
          case StoryTheme.predictionStatus:
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: -constraints.maxWidth * 0.02,
                  bottom: -constraints.maxHeight * 0.04,
                  width: constraints.maxWidth * 1.12,
                  child: StoryHelpers.safeAsset(
                    page.decorImage ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );

          // ---------------- PAGE 8 ----------------
          case StoryTheme.shareRecap:
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -16,
                  left: -8,
                  right: -8,
                  child: StoryHelpers.safeAsset(
                    page.backgroundDecor ?? '',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}