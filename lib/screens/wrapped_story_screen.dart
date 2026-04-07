import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../data/story_pages.dart';
import '../models/story_page_data.dart';
import '../widgets/echo_trail_asset.dart';
import '../widgets/progress_bars.dart';
import '../widgets/story_header.dart';
import '../widgets/story_helpers.dart';
import '../templates/story_templates.dart';

class WrappedStoryScreen extends StatefulWidget {
  const WrappedStoryScreen({super.key});

  @override
  State<WrappedStoryScreen> createState() => _WrappedStoryScreenState();
}

class _WrappedStoryScreenState extends State<WrappedStoryScreen> {
  static const bool enableAppEntry = true;

  // GLOBAL CONTROLS
  static const double identityRowOffset = 80;
  static const double sharedPageTitleFontSize = 72;
  static const double sharedPageTitleLineHeight = 0.85;
  static const double sharedPageTitleLetterSpacing = -0.2;
  static const double sharedPageTitleGap = 28;
  static const double sharedPageContentGap = 28;

  // SHARED BIG NUMBER CONTROLS
  static const double mainBigNumberSize = 180;

  // SHARED METRIC LABEL CONTROLS (PAGE 7 + PAGE 8)
  static const double sharedMetricLabelFontSize = 14;
  static const double sharedMetricLabelLineHeight = 1.0;
  static const FontWeight sharedMetricLabelFontWeight = FontWeight.w600;

  // COVER PAGE — INDEPENDENT TEXT BLOCK CONTROLS
  static const double coverIntroOffsetY = -8;
  static const double coverRoundLabelOffsetY = 0;
  static const double coverSubtextOffsetY = 8;

  static const double coverIntroFontSize = 13;
  static const double coverRoundLabelFontSize = 13;
  static const double coverSubtextFontSize = 13;

  static const double coverTextLineHeight = 1.15;
  static const double coverTextLetterSpacing = 0.0;

  // MIDDLE PAGES — SHARED BOTTOM TEXT CONTROLS
  static const double middleBottomTextFontSize = 12;
  static const double middleBottomTextLineHeight = 1.25;
  static const double middleBottomTextLetterSpacing = 0.0;
  static const double middleBottomTextWidthFactor = 0.86;
  static const double middleBottomTextOffsetY = 0;
  static const double middleBottomTextBottomGap = 0;
  static const FontWeight middleBottomTextFontWeight = FontWeight.w700;

  // PAGE 4 — PLAYER CONTROLS
  static const double mvpPlayerWidthFactorSmall = 1.08;
  static const double mvpPlayerWidthFactor = 1.18;
  static const double mvpPlayerLeftFactorSmall = -0.05;
  static const double mvpPlayerLeftFactor = -0.08;
  static const double mvpPlayerBottomFactorSmall = -0.14;
  static const double mvpPlayerBottomFactor = -0.16;

  // PAGE 4 — SPIKES CONTROLS
  static const double mvpSpikesLeftFactor = 0.02;
  static const double mvpSpikesBottomFactor = -0.16;
  static const double mvpSpikesWidthFactor = 1.10;

  // PAGE 4 — RED EFFECT ANGLE
  static const double mvpSpikesEffectAngle = -20;

  // PAGE 4 — RED EFFECT COLORS
  static const List<Color> _redEffectColors = [
    Color(0xFFB92E2E),
    Color(0xFF7F1E1E),
  ];

  // PAGE 5 — CHARACTER / BADGE CONTROLS
  static const double xpCharacterWidthFactor = 0.55;
  static const double xpCharacterOffsetX = 0;
  static const double xpCharacterOffsetY = 310;

  static const double xpBadgeWidthFactor = 0.25;
  static const double xpBadgeOffsetX = 0;
  static const double xpBadgeOffsetY = 490;

  // PAGE 6 — BADGES GRID CONTROLS
  static const double badgesGridTopGap = 18;
  static const double badgesGridHorizontalPadding = 18;
  static const double badgesGridSpacing = 22;
  static const double badgesGridRunSpacing = 26;
  static const double badgesGridBottomPadding = 28;

  static const double badgesCardMaxWidth = 150;
  static const double badgesCardMinWidth = 118;
  static const double badgesImageWidthFactor = 0.82;
  static const double badgesImageBottomGap = 12;

  static const double badgesTextFontSize = 11;
  static const double badgesTextLineHeight = 1.15;
  static const double badgesTextLetterSpacing = 0.0;
  static const FontWeight badgesTextFontWeight = FontWeight.w700;

  // PAGE 7 — METRIC SIZE CONTROLS
  static const double predictionSuffixSize = 48;
  static const double predictionSuffixTopPadding = 38;

  // PAGE 7 — STATS CONTROLS
  static const double predictionStatValueSize = 78;
  static const double predictionStatLabelSize = 11;
  static const double predictionStatSpacing = 6;
  static const double predictionStatsTopGap = 28;
  static const double predictionStatsBaselineHeight = 82;
  static const double predictionStatsRowWidthFactor = 0.68;

  // PAGE 8 — APP ACTIVITY CONTROLS
  static const double activityMetricLabelGap = 8;
  static const double activityMainValueLineHeight = 0.85;

  static const double activityBottomStatsTopGap = 28;
  static const double activityBottomStatsRowWidthFactor = 0.78;
  static const double activityBottomStatsBottomGap = 12;
  static const double activityBottomStatLabelSize = 11;
  static const double activityBottomStatLabelLineHeight = 1.05;
  static const double activityBottomStatValueSize = 84;
  static const double activityBottomStatSpacing = 6;
  static const double activityBottomStatsBaselineHeight = 92;

  int currentPage = 0;
  bool showEntryScreen = enableAppEntry;

  void goNext() {
    if (currentPage < storyPages.length - 1) {
      setState(() => currentPage += 1);
    }
  }

  void goPrevious() {
    if (currentPage > 0) {
      setState(() => currentPage -= 1);
    }
  }

  void handleClose() {
    if (enableAppEntry) {
      setState(() => showEntryScreen = true);
      return;
    }
    Navigator.of(context).maybePop();
  }

  EchoTrailSpec _redEffectSpec(double angleDegrees) {
    return EchoTrailSpec(
      copyCount: 2,
      colors: _redEffectColors,
      angleDegrees: angleDegrees,
      distanceStep: 14,
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeInOut,
      copyOpacity: 0.45,
      maxSpread: 1.0,
      showOriginal: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final maxWidth = size.width > 420 ? 420.0 : size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: maxWidth,
          child: showEntryScreen ? _buildEntryScreen() : _buildStoryScreen(),
        ),
      ),
    );
  }

  Widget _buildEntryScreen() {
    return GestureDetector(
      onTap: () => setState(() => showEntryScreen = false),
      child: Container(
        color: const Color(0xFF111111),
        child: Column(
          children: [
            Expanded(
              child: StoryHelpers.safeAsset(
                'assets/images/entry-screen/apphome-mockup.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 78,
              width: double.infinity,
              child: StoryHelpers.safeAsset(
                'assets/images/entry-screen/navi-bar.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryScreen() {
    final page = storyPages[currentPage];

    return Stack(
      children: [
        Positioned.fill(child: _buildPageBackground(page)),
        Positioned.fill(child: StoryTemplates.buildDecor(page)),
        Positioned.fill(child: _buildPageContent(page)),
        Positioned.fill(
          child: Row(
            children: [
              Expanded(child: GestureDetector(onTap: goPrevious)),
              Expanded(child: GestureDetector(onTap: goNext)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageBackground(StoryPageData page) {
    if (page.backgroundImage != null) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: page.backgroundColor,
          image: DecorationImage(
            image: AssetImage(page.backgroundImage!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return ColoredBox(
      color: page.backgroundColor ?? const Color(0xFF3385E3),
    );
  }

  Widget _buildPageContent(StoryPageData page) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(child: _buildPageByTheme(page)),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
            child: Column(
              children: [
                ProgressBars(
                  total: storyPages.length,
                  activeIndex: currentPage,
                ),
                const SizedBox(height: 16),
                StoryHeader(page: page, onClose: handleClose),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageByTheme(StoryPageData page) {
    if (page.id == 'page-3') {
      return _cardsFrenzyPage(page);
    }

    switch (page.theme) {
      case StoryTheme.roundRecap:
        return _roundRecapPage(page);
      case StoryTheme.defaultPage:
        return _defaultPage(page);
      case StoryTheme.roundMvp:
        return _roundMvpPage(page);
      case StoryTheme.xpRound:
        return _xpRoundPage(page);
      case StoryTheme.badgesEarned:
        return _badgesEarnedPage(page);
      case StoryTheme.predictionStatus:
        return _predictionStatusPage(page);
      case StoryTheme.appActivity:
        return _appActivityPage(page);
      case StoryTheme.shareRecap:
        return _shareRecapPage(page);
    }
  }

  Widget _roundRecapPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 18, 8, 20),
          child: Column(
            children: [
              SizedBox(height: _identityRowTopGap(constraints)),
              if (page.user != null) _userRow(page.user!),
              const SizedBox(height: 20),
              Transform.translate(
                offset: const Offset(0, coverIntroOffsetY),
                child: Text(
                  page.intro ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: coverIntroFontSize,
                    color: Color(0xFF202020),
                    fontWeight: FontWeight.w700,
                    height: coverTextLineHeight,
                    letterSpacing: coverTextLetterSpacing,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                page.title ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Druk',
                  fontSize: 104,
                  color: Color(0xFF202020),
                  height: 0.84,
                ),
              ),
              const SizedBox(height: 20),
              Transform.translate(
                offset: const Offset(0, coverRoundLabelOffsetY),
                child: Text(
                  page.roundLabel ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: coverRoundLabelFontSize,
                    color: Color(0xFF202020),
                    fontWeight: FontWeight.w700,
                    height: coverTextLineHeight,
                    letterSpacing: coverTextLetterSpacing,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Transform.translate(
                offset: const Offset(0, coverSubtextOffsetY),
                child: Text(
                  page.subtext ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: coverSubtextFontSize,
                    color: Color(0xFF202020),
                    fontWeight: FontWeight.w700,
                    height: coverTextLineHeight,
                    letterSpacing: coverTextLetterSpacing,
                  ),
                ),
              ),
              const Spacer(),
              if (page.footerLogo != null)
                SizedBox(
                  width: constraints.maxWidth * 0.4,
                  child: StoryHelpers.safeAsset(page.footerLogo!),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _defaultPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildStandardPage(
          constraints: constraints,
          page: page,
          useUserRow: false,
          content: [
            SizedBox(height: _sharedPageContentGapValue(constraints)),
            Text(
              page.score ?? '',
              style: TextStyle(
                fontFamily: 'Druk',
                fontSize: _mainBigNumberSize(constraints),
                color: const Color(0xFF202020),
                height: 0.85,
              ),
            ),
            if (page.showBadges) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _circleBadge(page.yellow ?? '', const Color(0xFFD7DF00)),
                  const SizedBox(width: 12),
                  _circleBadge(page.red ?? '', const Color(0xFFEF3D3D)),
                ],
              ),
            ],
            const Spacer(),
            _sharedMiddleBottomText(
              page.players ?? '',
              constraints,
              color: const Color(0xFF202020),
            ),
          ],
        );
      },
    );
  }

  Widget _cardsFrenzyPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildStandardPage(
          constraints: constraints,
          page: page,
          useUserRow: false,
          content: [
            SizedBox(height: _sharedPageContentGapValue(constraints)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  page.score ?? '',
                  style: TextStyle(
                    fontFamily: 'Druk',
                    fontSize: _mainBigNumberSize(constraints),
                    color: const Color(0xFF202020),
                    height: 0.85,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    _circleBadge(page.yellow ?? '', const Color(0xFFD7DF00)),
                    const SizedBox(height: 12),
                    _circleBadge(page.red ?? '', const Color(0xFFEF3D3D)),
                  ],
                ),
              ],
            ),
            const Spacer(),
            _sharedMiddleBottomText(
              page.players ?? '',
              constraints,
              color: const Color(0xFF202020),
            ),
          ],
        );
      },
    );
  }

  Widget _roundMvpPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxHeight < 700;

        final playerWidth = isSmall
            ? constraints.maxWidth * mvpPlayerWidthFactorSmall
            : constraints.maxWidth * mvpPlayerWidthFactor;

        final playerLeft = isSmall
            ? constraints.maxWidth * mvpPlayerLeftFactorSmall
            : constraints.maxWidth * mvpPlayerLeftFactor;

        final playerBottom = isSmall
            ? constraints.maxHeight * mvpPlayerBottomFactorSmall
            : constraints.maxHeight * mvpPlayerBottomFactor;

        final spikesLeft = constraints.maxWidth * mvpSpikesLeftFactor;
        final spikesBottom = constraints.maxHeight * mvpSpikesBottomFactor;
        final spikesWidth = constraints.maxWidth * mvpSpikesWidthFactor;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: playerLeft,
              bottom: playerBottom,
              width: playerWidth,
              child: StoryHelpers.safeAsset(
                page.playerImage ?? '',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: spikesLeft,
              bottom: spikesBottom,
              width: spikesWidth,
              child: EchoTrailAsset(
                assetPath: page.bottomSpikes ?? '',
                fit: BoxFit.contain,
                spec: _redEffectSpec(mvpSpikesEffectAngle),
              ),
            ),
            _buildStandardPage(
              constraints: constraints,
              page: page,
              useUserRow: false,
              content: const [],
            ),
            if ((page.verticalName ?? '').isNotEmpty)
              Positioned(
                right: 6,
                top: constraints.maxHeight * 0.40,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    page.verticalName ?? '',
                    style: const TextStyle(
                      color: Color(0xFF202020),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _xpRoundPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxHeight < 700;

        final characterWidth = isSmall
            ? constraints.maxWidth * (xpCharacterWidthFactor - 0.10)
            : constraints.maxWidth * xpCharacterWidthFactor;

        final badgeWidth = isSmall
            ? constraints.maxWidth * (xpBadgeWidthFactor - 0.07)
            : constraints.maxWidth * xpBadgeWidthFactor;

        final characterOffsetY =
            isSmall ? xpCharacterOffsetY - 10 : xpCharacterOffsetY;

        final badgeOffsetY = isSmall ? xpBadgeOffsetY - 10 : xpBadgeOffsetY;

        return Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                offset: Offset(xpCharacterOffsetX, characterOffsetY),
                child: SizedBox(
                  width: characterWidth,
                  child: StoryHelpers.safeAsset(
                    page.characterImage ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                offset: Offset(xpBadgeOffsetX, badgeOffsetY),
                child: SizedBox(
                  width: badgeWidth,
                  child: StoryHelpers.safeAsset(
                    page.badgeImage ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            _buildStandardPage(
              constraints: constraints,
              page: page,
              useUserRow: true,
              content: [
                const Spacer(),
                _sharedMiddleBottomText(
                  page.bottomText ?? '',
                  constraints,
                  color: const Color(0xFF202020),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _badgesEarnedPage(StoryPageData page) {
    final badges = page.badges ?? const <BadgeItemData>[];

    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildStandardPage(
          constraints: constraints,
          page: page,
          useUserRow: true,
          content: [
            SizedBox(height: badgesGridTopGap),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: badgesGridBottomPadding),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: badgesGridHorizontalPadding,
                  ),
                  child: LayoutBuilder(
                    builder: (context, gridConstraints) {
                      final availableWidth = gridConstraints.maxWidth;
                      final rawCardWidth =
                          (availableWidth - badgesGridSpacing) / 2;
                      final badgeCardWidth = math.max(
                        badgesCardMinWidth,
                        math.min(badgesCardMaxWidth, rawCardWidth),
                      );

                      return Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.start,
                        spacing: badgesGridSpacing,
                        runSpacing: badgesGridRunSpacing,
                        children: badges
                            .map(
                              (badge) => _badgeGridCard(
                                width: badgeCardWidth,
                                badge: badge,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _badgeGridCard({
    required double width,
    required BadgeItemData badge,
  }) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: width * badgesImageWidthFactor,
            child: StoryHelpers.safeAsset(
              badge.image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: badgesImageBottomGap),
          Text(
            '${badge.title}\n${badge.text}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: badgesTextFontSize,
              color: Color(0xFF202020),
              fontWeight: badgesTextFontWeight,
              height: badgesTextLineHeight,
              letterSpacing: badgesTextLetterSpacing,
            ),
          ),
        ],
      ),
    );
  }

  Widget _predictionStatusPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxHeight < 700;

        final mainValueSize = _mainBigNumberSize(constraints);

        final suffixSize =
            isSmall ? predictionSuffixSize - 8 : predictionSuffixSize;

        final suffixTopPadding = isSmall
            ? predictionSuffixTopPadding - 2
            : predictionSuffixTopPadding;

        final statValueSize =
            isSmall ? predictionStatValueSize - 6 : predictionStatValueSize;

        final statLabelSize =
            isSmall ? predictionStatLabelSize - 1 : predictionStatLabelSize;

        final statsTopGap =
            isSmall ? predictionStatsTopGap - 8 : predictionStatsTopGap;

        final statsBaselineHeight = isSmall
            ? predictionStatsBaselineHeight - 6
            : predictionStatsBaselineHeight;

        return _buildStandardPage(
          constraints: constraints,
          page: page,
          useUserRow: true,
          content: [
            SizedBox(height: _sharedPageContentGapValue(constraints)),
            Text(
              page.metricLabel ?? '',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: sharedMetricLabelFontSize,
                height: sharedMetricLabelLineHeight,
                color: Color(0xFF202020),
                fontWeight: sharedMetricLabelFontWeight,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  page.mainValue ?? '',
                  style: TextStyle(
                    fontFamily: 'Druk',
                    fontSize: mainValueSize,
                    color: const Color(0xFF202020),
                    height: 0.85,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: suffixTopPadding),
                  child: Text(
                    page.mainSuffix ?? '',
                    style: TextStyle(
                      fontFamily: 'Druk',
                      fontSize: suffixSize,
                      color: const Color(0xFF202020),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: statsTopGap),
            SizedBox(
              width: constraints.maxWidth * predictionStatsRowWidthFactor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statBlock(
                    page.stat1Label ?? '',
                    page.stat1Value ?? '',
                    valueSize: statValueSize,
                    labelSize: statLabelSize,
                    baselineHeight: statsBaselineHeight,
                  ),
                  _statBlock(
                    page.stat2Label ?? '',
                    page.stat2Value ?? '',
                    valueSize: statValueSize,
                    labelSize: statLabelSize,
                    baselineHeight: statsBaselineHeight,
                  ),
                  _statBlock(
                    page.stat3Label ?? '',
                    page.stat3Value ?? '',
                    valueSize: statValueSize,
                    labelSize: statLabelSize,
                    baselineHeight: statsBaselineHeight,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _statBlock(
    String label,
    String value, {
    required double valueSize,
    required double labelSize,
    required double baselineHeight,
  }) {
    return SizedBox(
      width: 74,
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: labelSize,
              color: const Color(0xFF202020),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: predictionStatSpacing),
          SizedBox(
            height: baselineHeight,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Druk',
                  fontSize: valueSize,
                  color: const Color(0xFF202020),
                  height: 0.9,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appActivityPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxHeight < 700;

        final metricLabelSize = isSmall
            ? sharedMetricLabelFontSize - 1
            : sharedMetricLabelFontSize;

        final mainValueSize = _mainBigNumberSize(constraints);

        final bottomStatValueSize =
            isSmall ? activityBottomStatValueSize - 8 : activityBottomStatValueSize;

        final bottomBaselineHeight = isSmall
            ? activityBottomStatsBaselineHeight - 8
            : activityBottomStatsBaselineHeight;

        final bottomStatsTopGap = isSmall
            ? activityBottomStatsTopGap - 6
            : activityBottomStatsTopGap;

        return _buildStandardPage(
          constraints: constraints,
          page: page,
          useUserRow: true,
          content: [
            SizedBox(height: _sharedPageContentGapValue(constraints)),
            Text(
              page.metricLabel ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: metricLabelSize,
                color: const Color(0xFF202020),
                fontWeight: sharedMetricLabelFontWeight,
                height: sharedMetricLabelLineHeight,
              ),
            ),
            SizedBox(height: activityMetricLabelGap),
            Text(
              page.mainValue ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Druk',
                fontSize: mainValueSize,
                color: const Color(0xFF202020),
                height: activityMainValueLineHeight,
              ),
            ),
            SizedBox(height: bottomStatsTopGap),
            SizedBox(
              width: constraints.maxWidth * activityBottomStatsRowWidthFactor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _activityStatBlock(
                    label: page.stat1Label ?? '',
                    value: page.stat1Value ?? '',
                    labelSize: activityBottomStatLabelSize,
                    valueSize: bottomStatValueSize,
                    baselineHeight: bottomBaselineHeight,
                  ),
                  _activityStatBlock(
                    label: page.stat2Label ?? '',
                    value: page.stat2Value ?? '',
                    labelSize: activityBottomStatLabelSize,
                    valueSize: bottomStatValueSize,
                    baselineHeight: bottomBaselineHeight,
                  ),
                ],
              ),
            ),
            SizedBox(height: activityBottomStatsBottomGap),
          ],
        );
      },
    );
  }

  Widget _activityStatBlock({
    required String label,
    required String value,
    required double labelSize,
    required double valueSize,
    required double baselineHeight,
  }) {
    return SizedBox(
      width: 118,
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: labelSize,
              color: const Color(0xFF202020),
              fontWeight: FontWeight.w700,
              height: activityBottomStatLabelLineHeight,
            ),
          ),
          SizedBox(height: activityBottomStatSpacing),
          SizedBox(
            height: baselineHeight,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Druk',
                  fontSize: valueSize,
                  color: const Color(0xFF202020),
                  height: 0.9,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shareRecapPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxHeight < 700;
        final cardWidth =
            isSmall ? constraints.maxWidth * 0.58 : constraints.maxWidth * 0.66;

        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 16),
          child: Column(
            children: [
              Text(
                page.intro ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF202020),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: isSmall ? 14 : 20),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: cardWidth,
                    child: StoryHelpers.safeAsset(
                      page.cardImage ?? '',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: constraints.maxWidth * 0.78,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF272727),
                    foregroundColor: const Color(0xFFF4F4F4),
                    minimumSize: Size.fromHeight(isSmall ? 42 : 44),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {},
                  child: Text(page.buttonLabel ?? 'SHARE'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sharedMiddleBottomText(
    String text,
    BoxConstraints constraints, {
    Color color = const Color(0xFF202020),
  }) {
    if (text.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: middleBottomTextBottomGap),
      child: Transform.translate(
        offset: const Offset(0, middleBottomTextOffsetY),
        child: SizedBox(
          width: constraints.maxWidth * middleBottomTextWidthFactor,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: middleBottomTextFontSize,
              color: Color(0xFF202020),
              fontWeight: middleBottomTextFontWeight,
              height: middleBottomTextLineHeight,
              letterSpacing: middleBottomTextLetterSpacing,
            ).copyWith(color: color),
          ),
        ),
      ),
    );
  }

  Widget _circleBadge(String value, Color color) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        value,
        style: const TextStyle(
          fontFamily: 'Druk',
          fontSize: 22,
          color: Color(0xFF202020),
        ),
      ),
    );
  }

  Widget _buildStandardPage({
    required BoxConstraints constraints,
    required StoryPageData page,
    required bool useUserRow,
    required List<Widget> content,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 18, 8, 20),
      child: Column(
        children: [
          _sharedTopSection(
            constraints: constraints,
            page: page,
            useUserRow: useUserRow,
          ),
          ...content,
        ],
      ),
    );
  }

  Widget _sharedTopSection({
    required BoxConstraints constraints,
    required StoryPageData page,
    required bool useUserRow,
  }) {
    return Column(
      children: [
        SizedBox(height: _identityRowTopGap(constraints)),
        useUserRow && page.user != null ? _userRow(page.user!) : _countryRow(page),
        SizedBox(height: _sharedPageTitleGapValue(constraints)),
        _sharedPageTitle(page.title ?? '', constraints),
      ],
    );
  }

  double _identityRowTopGap(BoxConstraints constraints) {
    final isSmall = constraints.maxHeight < 700;
    return isSmall ? identityRowOffset - 6 : identityRowOffset;
  }

  double _sharedPageTitleSize(BoxConstraints constraints) {
    final isSmall = constraints.maxHeight < 700;
    return isSmall ? sharedPageTitleFontSize - 6 : sharedPageTitleFontSize;
  }

  double _sharedPageTitleGapValue(BoxConstraints constraints) {
    final isSmall = constraints.maxHeight < 700;
    return isSmall ? sharedPageTitleGap - 4 : sharedPageTitleGap;
  }

  double _sharedPageContentGapValue(BoxConstraints constraints) {
    final isSmall = constraints.maxHeight < 700;
    return isSmall ? sharedPageContentGap - 4 : sharedPageContentGap;
  }

  double _mainBigNumberSize(BoxConstraints constraints) {
    final isSmall = constraints.maxHeight < 700;
    return isSmall ? mainBigNumberSize - 20 : mainBigNumberSize;
  }

  Widget _sharedPageTitle(String text, BoxConstraints constraints) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Druk',
        fontSize: _sharedPageTitleSize(constraints),
        color: const Color(0xFF202020),
        height: sharedPageTitleLineHeight,
        letterSpacing: sharedPageTitleLetterSpacing,
      ),
    );
  }

  Widget _userRow(UserData user) {
    const double thumbSize = 38;
    const double textSize = 15;
    const double gap = 10;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: StoryHelpers.safeAsset(
            user.avatar,
            width: thumbSize,
            height: thumbSize,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: gap),
        Text(
          user.name,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: textSize,
            color: Color(0xFF202020),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _countryRow(StoryPageData page) {
    const double thumbSize = 38;
    const double textSize = 15;
    const double gap = 10;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StoryHelpers.safeAsset(
          page.flag ?? '',
          width: thumbSize,
          height: thumbSize,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: gap),
        Text(
          page.country ?? '',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: textSize,
            color: Color(0xFF202020),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}