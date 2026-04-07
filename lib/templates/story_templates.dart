import 'package:flutter/material.dart';

import '../models/story_page_data.dart';
import '../widgets/echo_trail_asset.dart';
import '../widgets/story_helpers.dart';

class StoryTemplates {
  // COLOR PALETTES
  // Green palette = current page-2 effect colors. This is the default for all green pages.
  static const List<Color> _greenEffectColors = [
    Color(0xFF004C22),
    Color(0xFF00642D),
  ];

  // Red palette = shared by all red pages.
  static const List<Color> _redEffectColors = [
    Color(0xFFB92E2E),
    Color(0xFF7F1E1E),
  ];

  // Blue palette = shared by all blue pages.
  static const List<Color> _blueEffectColors = [
    Color(0xFF2A6CC5),
    Color(0xFF1C4E93),
  ];

  // COVER PAGE
  // Effect kept available but turned off.
  static const bool _enableCoverEffects = false;
  static const double _coverTopAngle = -18;
  static const double _coverRightAngle = 24;
  static const double _coverLeftAngle = -22;

  // PAGE 2 / GREEN DEFAULT PAGE
  static const double _page2Angle = 28;

  // PAGE 5 / GREEN XP PAGE
  static const double _page5Angle = 24;

  // PAGE 6 / BLUE PAGE
  static const double _page6Angle = 22;

  // PAGE 7 / RED PAGE
  static const double _page7Angle = -18;

  // PAGE 8 / GREEN APP ACTIVITY PAGE
  static const double _page8Angle = 28;

  // FINAL CARD PAGE
  // No effect implemented.
  static const bool _enableFinalCardEffects = false;

  static EchoTrailSpec _paletteSpec(
    List<Color> colors, {
    required double angleDegrees,
  }) {
    return EchoTrailSpec(
      copyCount: 2,
      colors: colors,
      angleDegrees: angleDegrees,
      distanceStep: 14,
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeInOut,
      copyOpacity: 0.45,
      maxSpread: 1.0,
      showOriginal: true,
    );
  }

  static Widget _animatedAsset(
    String assetPath, {
    required List<Color> colors,
    required double angleDegrees,
    BoxFit fit = BoxFit.contain,
    double? width,
    double? height,
  }) {
    return EchoTrailAsset(
      assetPath: assetPath,
      spec: _paletteSpec(colors, angleDegrees: angleDegrees),
      fit: fit,
      width: width,
      height: height,
    );
  }

  static Widget _buildGreenDecor(
    StoryPageData page,
    BoxConstraints constraints, {
    required double angleDegrees,
  }) {
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
            child: _animatedAsset(
              page.decorImage!,
              colors: _greenEffectColors,
              angleDegrees: angleDegrees,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildDecor(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (page.theme) {
          case StoryTheme.roundRecap:
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -40,
                  left: 0,
                  right: 0,
                  child: _enableCoverEffects
                      ? _animatedAsset(
                          'assets/images/page-1/element-1.png',
                          colors: _greenEffectColors,
                          angleDegrees: _coverTopAngle,
                          fit: BoxFit.cover,
                        )
                      : StoryHelpers.safeAsset(
                          'assets/images/page-1/element-1.png',
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  right: 0,
                  bottom: -constraints.maxHeight * 0.04,
                  child: SizedBox(
                    width: constraints.maxWidth * 0.32,
                    child: _enableCoverEffects
                        ? _animatedAsset(
                            'assets/images/page-1/element-3.png',
                            colors: _redEffectColors,
                            angleDegrees: _coverRightAngle,
                            fit: BoxFit.contain,
                          )
                        : StoryHelpers.safeAsset(
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
                    child: _enableCoverEffects
                        ? _animatedAsset(
                            'assets/images/page-1/element-2.png',
                            colors: _blueEffectColors,
                            angleDegrees: _coverLeftAngle,
                            fit: BoxFit.contain,
                          )
                        : StoryHelpers.safeAsset(
                            'assets/images/page-1/element-2.png',
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
              ],
            );

          case StoryTheme.defaultPage:
            return _buildGreenDecor(
              page,
              constraints,
              angleDegrees: _page2Angle,
            );

          case StoryTheme.roundMvp:
            return const SizedBox.shrink();

          case StoryTheme.xpRound:
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 45,
                  bottom: -constraints.maxHeight * 0.025,
                  width: constraints.maxWidth * 0.9,
                  child: _animatedAsset(
                    page.spikesImage ?? '',
                    colors: _greenEffectColors,
                    angleDegrees: _page5Angle,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );

          case StoryTheme.badgesEarned:
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 42,
                  left: -constraints.maxWidth * 0.09,
                  width: constraints.maxWidth * 1.18,
                  child: _animatedAsset(
                    page.spikesImage ?? '',
                    colors: _blueEffectColors,
                    angleDegrees: _page6Angle,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );

          case StoryTheme.predictionStatus:
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: -constraints.maxWidth * 0.02,
                  bottom: -constraints.maxHeight * 0.04,
                  width: constraints.maxWidth * 1.12,
                  child: _animatedAsset(
                    page.decorImage ?? '',
                    colors: _redEffectColors,
                    angleDegrees: _page7Angle,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            );

          case StoryTheme.appActivity:
            return _buildGreenDecor(
              page,
              constraints,
              angleDegrees: _page8Angle,
            );

          case StoryTheme.shareRecap:
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -16,
                  left: -8,
                  right: -8,
                  child: _enableFinalCardEffects
                      ? _animatedAsset(
                          page.backgroundDecor ?? '',
                          colors: _blueEffectColors,
                          angleDegrees: 18,
                          fit: BoxFit.fitWidth,
                        )
                      : StoryHelpers.safeAsset(
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