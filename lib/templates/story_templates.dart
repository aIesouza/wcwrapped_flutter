import 'package:flutter/material.dart';

import '../models/story_page_data.dart';
import '../widgets/echo_trail_asset.dart';
import '../widgets/story_helpers.dart';

class StoryTemplates {
  // COLOR PALETTES
  static const List<Color> _greenEffectColors = [
    Color(0xFF004C22),
    Color(0xFF00642D),
  ];

  static const List<Color> _redEffectColors = [
    Color(0xFFB92E2E),
    Color(0xFF7F1E1E),
  ];

  static const List<Color> _blueEffectColors = [
    Color(0xFF2A6CC5),
    Color(0xFF1C4E93),
  ];

  // GLOBAL ANIMATION MODE
  // Switch back to EchoAnimationStyle.echoTrail if you want the previous effect.
  static const EchoAnimationStyle _sharedAnimationStyle =
      EchoAnimationStyle.anchoredExpand;

  // GLOBAL ANCHORED EXPAND CONTROLS
  static const Duration _sharedExpandDuration = Duration(milliseconds: 1600);
  static const Curve _sharedExpandCurve = Curves.easeInOut;
  static const double _sharedExpandMinScale = 1.0;
  static const double _sharedExpandMaxScale = 1.08;

  // GLOBAL LEGACY ECHO TRAIL CONTROLS
  static const int _sharedCopyCount = 2;
  static const double _sharedAngleDistanceStep = 14;
  static const double _sharedCopyOpacity = 0.45;
  static const double _sharedMaxSpread = 1.0;
  static const bool _sharedShowOriginal = true;

  // COVER PAGE
  static const bool _enableCoverEffects = false;
  static const double _coverTopAngle = -18;
  static const double _coverRightAngle = 24;
  static const double _coverLeftAngle = -22;

  // PAGE 2
  static const double _page2Angle = 28;
  static const Alignment _page2ExpandAlignment = Alignment.bottomLeft;

  // PAGE 3
  static const double _page3Angle = 20;
  static const Alignment _page3ExpandAlignment = Alignment.bottomCenter;
  static const double _page3BottomFactor = -0.02;
  static const double _page3WidthFactor = 1.04;

  // PAGE 5
  static const double _page5Angle = 24;
  static const Alignment _page5ExpandAlignment = Alignment.bottomCenter;

  // PAGE 6
  static const double _page6Angle = 22;
  static const Alignment _page6ExpandAlignment = Alignment.topCenter;

  // PAGE 7
  static const double _page7Angle = -18;
  static const Alignment _page7ExpandAlignment = Alignment.bottomCenter;

  // PAGE 8
  static const double _page8Angle = 28;
  static const Alignment _page8ExpandAlignment = Alignment.bottomLeft;

  // FINAL PAGE
  static const bool _enableFinalCardEffects = false;

  static EchoTrailSpec _paletteSpec(
    List<Color> colors, {
    required double angleDegrees,
    required Alignment scaleAlignment,
  }) {
    return EchoTrailSpec(
      style: _sharedAnimationStyle,

      // Shared
      duration: _sharedExpandDuration,
      curve: _sharedExpandCurve,

      // Legacy effect
      copyCount: _sharedCopyCount,
      colors: colors,
      angleDegrees: angleDegrees,
      distanceStep: _sharedAngleDistanceStep,
      copyOpacity: _sharedCopyOpacity,
      maxSpread: _sharedMaxSpread,
      showOriginal: _sharedShowOriginal,

      // New effect
      minScale: _sharedExpandMinScale,
      maxScale: _sharedExpandMaxScale,
      scaleAlignment: scaleAlignment,
    );
  }

  static Widget _animatedAsset(
    String assetPath, {
    required List<Color> colors,
    required double angleDegrees,
    required Alignment scaleAlignment,
    BoxFit fit = BoxFit.contain,
    double? width,
    double? height,
  }) {
    return EchoTrailAsset(
      assetPath: assetPath,
      spec: _paletteSpec(
        colors,
        angleDegrees: angleDegrees,
        scaleAlignment: scaleAlignment,
      ),
      fit: fit,
      width: width,
      height: height,
    );
  }

  static Widget _buildGreenDecor(
    StoryPageData page,
    BoxConstraints constraints, {
    required double angleDegrees,
    required Alignment scaleAlignment,
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
              scaleAlignment: scaleAlignment,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildPage3Decor(
    StoryPageData page,
    BoxConstraints constraints,
  ) {
    if (page.decorImage == null) {
      return const SizedBox.shrink();
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -constraints.maxWidth * 0.02,
          bottom: -constraints.maxHeight * _page3BottomFactor,
          width: constraints.maxWidth * _page3WidthFactor,
          child: _animatedAsset(
            page.decorImage!,
            colors: _blueEffectColors,
            angleDegrees: _page3Angle,
            scaleAlignment: _page3ExpandAlignment,
            fit: BoxFit.cover,
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
                          scaleAlignment: Alignment.topCenter,
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
                            scaleAlignment: Alignment.bottomRight,
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
                            scaleAlignment: Alignment.bottomLeft,
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
            if (page.id == 'page-3') {
              return _buildPage3Decor(page, constraints);
            }

            return _buildGreenDecor(
              page,
              constraints,
              angleDegrees: _page2Angle,
              scaleAlignment: _page2ExpandAlignment,
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
                    scaleAlignment: _page5ExpandAlignment,
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
                    scaleAlignment: _page6ExpandAlignment,
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
                    scaleAlignment: _page7ExpandAlignment,
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
              scaleAlignment: _page8ExpandAlignment,
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
                          scaleAlignment: Alignment.topCenter,
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