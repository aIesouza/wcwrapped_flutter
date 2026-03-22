import 'package:flutter/material.dart';

import '../data/story_pages.dart';
import '../models/story_page_data.dart';
import '../widgets/progress_bars.dart';
import '../widgets/story_header.dart';
import '../widgets/story_helpers.dart';

class WrappedStoryScreen extends StatefulWidget {
  const WrappedStoryScreen({super.key});

  @override
  State<WrappedStoryScreen> createState() => _WrappedStoryScreenState();
}

class _WrappedStoryScreenState extends State<WrappedStoryScreen> {
  static const bool enableAppEntry = true;

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final maxWidth = size.width > 420 ? 420.0 : size.width;

    return Scaffold(
  backgroundColor: (!showEntryScreen && storyPages[currentPage].theme == StoryTheme.roundRecap)
      ? const Color(0xFFE33B3B)
      : Colors.black,
        body: Center(
        child: SizedBox(
          width: maxWidth,
          child: showEntryScreen ? _buildEntryScreen() : _buildStoryScreen(),
        ),
      ),
    );
  }

  Widget _buildEntryScreen() {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => setState(() => showEntryScreen = false),
            child: Container(
              color: const Color(0xFF111111),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: StoryHelpers.safeAsset(
                        'assets/images/entry-screen/apphome-mockup.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
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
          ),
        ),
      ],
    );
  }

  Widget _buildStoryScreen() {
    final page = storyPages[currentPage];

    return Stack(
      children: [
        Positioned.fill(child: _buildPageBackground(page)),
        Positioned.fill(child: _buildPageContent(page)),
        Positioned.fill(
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: goPrevious,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: goNext,
                ),
              ),
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
        color: page.backgroundColor ?? const Color(0xFF3385E3),
        image: DecorationImage(
          image: AssetImage(page.backgroundImage!),
          fit: BoxFit.cover,
          onError: (_, __) {},
        ),
      ),
      child: const SizedBox.expand(),
    );
  }

  return ColoredBox(color: page.backgroundColor ?? const Color(0xFF3385E3));
}

  Widget _buildPageContent(StoryPageData page) {
  return SafeArea(
    child: Stack(
      children: [
        Positioned.fill(
          child: _buildPageByTheme(page),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
          child: Column(
            children: [
              ProgressBars(total: storyPages.length, activeIndex: currentPage),
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
      case StoryTheme.shareRecap:
        return _shareRecapPage(page);
    }
  }

  Widget _userRow(UserData user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: StoryHelpers.safeAsset(
            user.avatar,
            width: 38,
            height: 38,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          user.name,
          style: const TextStyle(fontSize: 15, color: Color(0xFF202020)),
        ),
      ],
    );
  }

  Widget _countryRow(StoryPageData page, {double flagSize = 28}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StoryHelpers.safeAsset(
          page.flag ?? '',
          width: flagSize,
          height: flagSize,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 10),
        Text(
          page.country ?? '',
          style: const TextStyle(fontSize: 16, color: Color(0xFF202020)),
        ),
      ],
    );
  }

  Widget _roundRecapPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -60,
              left: 0,
              right: 0,
              child: StoryHelpers.safeAsset(
                'assets/images/page-1/element-1.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0,
              bottom: -36,
              child: SizedBox(
                width: constraints.maxWidth * 0.56,
                child: StoryHelpers.safeAsset(
                  'assets/images/page-1/element-2.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 18, 8, 20),
              child: Column(
                children: [
                  if (page.user != null) _userRow(page.user!),
                  const SizedBox(height: 22),
                  Text(
                    StoryHelpers.cleanText(page.intro),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.25,
                      color: Color(0xFF202020),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    StoryHelpers.cleanText(page.title),
                    textAlign: TextAlign.center,
                    style: StoryHelpers.titleStyle(context, size: 72),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    page.roundLabel ?? '',
                    style: const TextStyle(fontSize: 16, color: Color(0xFF202020)),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    StoryHelpers.cleanText(page.subtext),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.2,
                      color: Color(0xFF202020),
                    ),
                  ),
                  const Spacer(),
                  if (page.footerLogo != null)
                    SizedBox(
                      width: constraints.maxWidth * 0.44,
                      child: StoryHelpers.safeAsset(page.footerLogo!),
                    ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _defaultPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            if (page.decorImage != null)
            Positioned(
              left: 0,
              bottom: -constraints.maxHeight * 0.08,
              child: SizedBox(
                width: constraints.maxWidth * 0.82,
                child: StoryHelpers.safeAsset(
                  page.decorImage!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 18, 8, 20),
              child: Column(
                children: [
                  if (page.user != null) _userRow(page.user!) else _countryRow(page),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Text(
                    StoryHelpers.cleanText(page.title),
                    textAlign: TextAlign.center,
                    style: StoryHelpers.titleStyle(context, size: 60),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        page.score ?? '',
                        style: const TextStyle(
                          fontFamily: 'DrukBold',
                          fontSize: 112,
                          height: 0.88,
                          color: Color(0xFF202020),
                        ),
                      ),
                      if (page.showBadges) ...[
                        const SizedBox(width: 16),
                        Column(
                          children: [
                            _circleBadge(page.yellow ?? '', const Color(0xFFD7DF00)),
                            const SizedBox(height: 12),
                            _circleBadge(page.red ?? '', const Color(0xFFEF3D3D)),
                          ],
                        ),
                      ],
                    ],
                  ),
                  const Spacer(),
                  Text(
                    StoryHelpers.cleanText(page.players),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.25,
                      color: Color(0xFF202020),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _circleBadge(String value, Color color) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: Color(0xFF202020),
        ),
      ),
    );
  }

  Widget _roundMvpPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -constraints.maxWidth * 0.02,
              bottom: -20,
              width: constraints.maxWidth * 0.9,
              child: StoryHelpers.safeAsset(page.playerImage ?? ''),
            ),
            Positioned(
              left: 0,
              bottom: -constraints.maxHeight * 0.06,
              width: constraints.maxWidth * 1.1,
              child: StoryHelpers.safeAsset(
                page.bottomSpikes ?? '',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Column(
                children: [
                  _countryRow(page, flagSize: 34),
                  const SizedBox(height: 24),
                  Text(
                    StoryHelpers.cleanText(page.title),
                    textAlign: TextAlign.center,
                    style: StoryHelpers.titleStyle(context, size: 56),
                  ),
                ],
              ),
            ),
            Positioned(
              top: constraints.maxHeight * 0.36,
              right: 8,
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  page.verticalName ?? '',
                  style: const TextStyle(fontSize: 14, color: Color(0xFF202020)),
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
      final isSmallPhone = constraints.maxHeight < 700;

      final titleSize = isSmallPhone ? 48.0 : 58.0;
      final topGap = isSmallPhone ? 12.0 : 20.0;
      final bottomPadding = isSmallPhone ? 28.0 : 44.0;
      final bottomFontSize = isSmallPhone ? 12.0 : 13.0;

      final spikesWidth = isSmallPhone
          ? constraints.maxWidth * 0.82
          : constraints.maxWidth * 0.90;

      final characterWidth = isSmallPhone
          ? constraints.maxWidth * 0.46
          : constraints.maxWidth * 0.54;

      final badgeWidth = isSmallPhone
          ? constraints.maxWidth * 0.20
          : constraints.maxWidth * 0.26;

      return Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            width: spikesWidth,
            child: StoryHelpers.safeAsset(
              page.spikesImage ?? '',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: constraints.maxWidth * 0.06,
            top: isSmallPhone
                ? constraints.maxHeight * 0.28
                : constraints.maxHeight * 0.24,
            width: characterWidth,
            child: StoryHelpers.safeAsset(
              page.characterImage ?? '',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: constraints.maxWidth * 0.24,
            top: isSmallPhone
                ? constraints.maxHeight * 0.50
                : constraints.maxHeight * 0.52,
            width: badgeWidth,
            child: StoryHelpers.safeAsset(
              page.badgeImage ?? '',
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 12, 8, bottomPadding),
            child: Column(
              children: [
                if (page.user != null) _userRow(page.user!),
                SizedBox(height: topGap),
                Text(
                  StoryHelpers.cleanText(page.title),
                  textAlign: TextAlign.center,
                  style: StoryHelpers.titleStyle(context, size: titleSize),
                ),
                const Spacer(),
                Text(
                  StoryHelpers.cleanText(page.bottomText),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: bottomFontSize,
                    height: 1.2,
                    color: const Color(0xFF202020),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

  Widget _badgesEarnedPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              top: 42,
              left: -constraints.maxWidth * 0.09,
              width: constraints.maxWidth * 1.18,
              child: StoryHelpers.safeAsset(page.spikesImage ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 18, 8, 20),
              child: Column(
                children: [
                  if (page.user != null) _userRow(page.user!),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Text(
                    StoryHelpers.cleanText(page.title),
                    textAlign: TextAlign.center,
                    style: StoryHelpers.titleStyle(context, size: 56),
                  ),
                  const SizedBox(height: 80),
                  Expanded(
                    child: Stack(
                      children: [
                        _badgePositioned(
                          left: constraints.maxWidth * 0.06,
                          top: 0,
                          width: constraints.maxWidth * 0.32,
                          image: page.badgeLeftImage ?? '',
                          title: page.badgeLeftTitle ?? '',
                          text: page.badgeLeftText ?? '',
                        ),
                        _badgePositioned(
                          left: constraints.maxWidth * 0.62,
                          top: 0,
                          width: constraints.maxWidth * 0.32,
                          image: page.badgeRightImage ?? '',
                          title: page.badgeRightTitle ?? '',
                          text: page.badgeRightText ?? '',
                        ),
                        _badgePositioned(
                          left: constraints.maxWidth * 0.30,
                          top: 160,
                          width: constraints.maxWidth * 0.40,
                          image: page.badgeBottomImage ?? '',
                          title: page.badgeBottomTitle ?? '',
                          text: page.badgeBottomText ?? '',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _badgePositioned({
    required double left,
    required double top,
    required double width,
    required String image,
    required String title,
    required String text,
  }) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      child: Column(
        children: [
          StoryHelpers.safeAsset(image),
          const SizedBox(height: 14),
          Text(
            '$title\n$text',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              height: 1.2,
              color: Color(0xFF202020),
            ),
          ),
        ],
      ),
    );
  }

  Widget _predictionStatusPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              left: -constraints.maxWidth * 0.02,
              bottom: -20,
              width: constraints.maxWidth * 1.12,
              child: StoryHelpers.safeAsset(page.decorImage ?? ''),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 18, 8, 20),
              child: Column(
                children: [
                  if (page.user != null) _userRow(page.user!),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Text(
                    StoryHelpers.cleanText(page.title),
                    textAlign: TextAlign.center,
                    style: StoryHelpers.titleStyle(context, size: 56),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Text(
                    page.metricLabel ?? '',
                    style: const TextStyle(fontSize: 15, color: Color(0xFF202020)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        page.mainValue ?? '',
                        style: const TextStyle(
                          fontFamily: 'DrukBold',
                          fontSize: 132,
                          height: 0.88,
                          color: Color(0xFF202020),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Text(
                          page.mainSuffix ?? '',
                          style: const TextStyle(
                            fontFamily: 'DrukBold',
                            fontSize: 42,
                            color: Color(0xFF202020),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: constraints.maxHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _statBlock(page.stat1Label ?? '', page.stat1Value ?? ''),
                      _statBlock(page.stat2Label ?? '', page.stat2Value ?? ''),
                      _statBlock(page.stat3Label ?? '', page.stat3Value ?? ''),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _statBlock(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Color(0xFF202020)),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'DrukBold',
            fontSize: 52,
            height: 0.9,
            color: Color(0xFF202020),
          ),
        ),
      ],
    );
  }

  Widget _shareRecapPage(StoryPageData page) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isSmallPhone = constraints.maxHeight < 700;

      final introFontSize = isSmallPhone ? 11.0 : 12.0;
      final topGap = isSmallPhone ? 4.0 : 8.0;
      final gapAfterIntro = isSmallPhone ? 10.0 : 14.0;
      final gapBeforeButton = isSmallPhone ? 10.0 : 14.0;
      final buttonHeight = isSmallPhone ? 42.0 : 44.0;

      final decorWidth = constraints.maxWidth * 1.08;
      final cardWidth = isSmallPhone
            ? constraints.maxWidth * 0.54
            : constraints.maxWidth * 0.62;

      return Stack(
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
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 10),
            child: Column(
              children: [
                SizedBox(height: topGap),
                Text(
                  StoryHelpers.cleanText(page.intro),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: introFontSize,
                    height: 1.2,
                    color: const Color(0xFF202020),
                  ),
                ),
                SizedBox(height: gapAfterIntro),
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
                SizedBox(height: gapBeforeButton),
                SizedBox(
                  width: constraints.maxWidth * 0.78,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF272727),
                      foregroundColor: const Color(0xFFF4F4F4),
                      minimumSize: Size.fromHeight(buttonHeight),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Hook up your share logic here later.'),
                        ),
                      );
                    },
                    child: Text(page.buttonLabel ?? 'SHARE'),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
}
