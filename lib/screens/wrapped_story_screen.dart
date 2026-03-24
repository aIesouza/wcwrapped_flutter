import 'package:flutter/material.dart';

import '../data/story_pages.dart';
import '../models/story_page_data.dart';
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
      case StoryTheme.shareRecap:
        return _shareRecapPage(page);
    }
  }

  // PAGE 1

  Widget _roundRecapPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 18, 8, 20),
          child: Column(
            children: [
              if (page.user != null) _userRow(page.user!),
              const SizedBox(height: 20),
              Text(
                page.intro ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF202020),
                ),
              ),
              const Spacer(),
              Text(
                page.title ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF202020),
                  height: 0.9,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                page.roundLabel ?? '',
                style: const TextStyle(
                  color: Color(0xFF202020),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                page.subtext ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF202020),
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

  // PAGE 2

  Widget _defaultPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 18, 8, 20),
          child: Column(
            children: [
              _countryRow(page),
              SizedBox(height: constraints.maxHeight * 0.04),
              Text(
                page.title ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF202020),
                  height: 0.9,
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.04),
              Text(
                page.score ?? '',
                style: const TextStyle(
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF202020),
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
              Text(
                page.players ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF202020),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // PAGE 3

  Widget _cardsFrenzyPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 18, 8, 20),
          child: Column(
            children: [
              _countryRow(page),
              SizedBox(height: constraints.maxHeight * 0.03),
              Text(
                page.title ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF202020),
                  height: 0.9,
                ),
              ),
              SizedBox(height: constraints.maxHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    page.score ?? '',
                    style: const TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202020),
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
              Text(
                page.players ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // PAGE 4

  Widget _roundMvpPage(StoryPageData page) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isSmall = constraints.maxHeight < 700;

      final titleSize = isSmall ? 42.0 : 48.0;
      final countryGap = isSmall ? 16.0 : 20.0;
      final playerWidth =
          isSmall ? constraints.maxWidth * 1.10 : constraints.maxWidth * 1.20;
      final playerLeft =
          isSmall ? -constraints.maxWidth * 0.06 : -constraints.maxWidth * 0.10;
      final playerBottom = -constraints.maxHeight * 0.08;

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
          Padding(
            padding: const EdgeInsets.only(top: 36),
            child: Column(
              children: [
                _countryRow(page),
                SizedBox(height: countryGap),
                Text(
                  page.title ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF202020),
                    height: 0.9,
                  ),
                ),
              ],
            ),
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

  // PAGE 5

  Widget _xpRoundPage(StoryPageData page) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxHeight < 700;
        final titleSize = isSmall ? 44.0 : 56.0;
        final characterWidth =
            isSmall ? constraints.maxWidth * 0.45 : constraints.maxWidth * 0.55;
        final badgeWidth =
            isSmall ? constraints.maxWidth * 0.18 : constraints.maxWidth * 0.25;

        return Stack(
          children: [
            Positioned(
              left: constraints.maxWidth * 0.08,
              top: constraints.maxHeight * 0.28,
              width: characterWidth,
              child: StoryHelpers.safeAsset(
                page.characterImage ?? '',
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: constraints.maxWidth * 0.28,
              top: constraints.maxHeight * 0.50,
              width: badgeWidth,
              child: StoryHelpers.safeAsset(
                page.badgeImage ?? '',
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 18, 8, 24),
              child: Column(
                children: [
                  if (page.user != null) _userRow(page.user!),
                  const SizedBox(height: 20),
                  Text(
                    page.title ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF202020),
                      height: 0.9,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    page.bottomText ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmall ? 12 : 13,
                      color: Color(0xFF202020),
                      fontWeight: FontWeight.w600,
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

  // PAGE 6

  Widget _badgesEarnedPage(StoryPageData page) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isSmall = constraints.maxHeight < 700;

      final titleSize = isSmall ? 42.0 : 48.0;
      final topGap = isSmall ? 24.0 : 32.0;
      final badgeTop = isSmall ? 6.0 : 12.0;
      final bottomBadgeTop = isSmall ? 150.0 : 170.0;

      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 18, 8, 20),
        child: Column(
          children: [
            if (page.user != null) _userRow(page.user!),
            SizedBox(height: topGap),
            Text(
              page.title ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF202020),
                height: 0.9,
              ),
            ),
            SizedBox(height: isSmall ? 28 : 40),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  _badgePositioned(
                    left: constraints.maxWidth * 0.05,
                    top: badgeTop,
                    width: constraints.maxWidth * 0.30,
                    image: page.badgeLeftImage ?? '',
                    title: page.badgeLeftTitle ?? '',
                    text: page.badgeLeftText ?? '',
                  ),
                  _badgePositioned(
                    left: constraints.maxWidth * 0.65,
                    top: badgeTop,
                    width: constraints.maxWidth * 0.30,
                    image: page.badgeRightImage ?? '',
                    title: page.badgeRightTitle ?? '',
                    text: page.badgeRightText ?? '',
                  ),
                  _badgePositioned(
                    left: constraints.maxWidth * 0.30,
                    top: bottomBadgeTop,
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
        StoryHelpers.safeAsset(
          image,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 12),
        Text(
          '$title\n$text',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF202020),
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
      ],
    ),
  );
}

  // PAGE 7

  Widget _predictionStatusPage(StoryPageData page) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isSmall = constraints.maxHeight < 700;

      final titleSize = isSmall ? 42.0 : 48.0;
      final mainValueSize = isSmall ? 104.0 : 120.0;
      final suffixSize = isSmall ? 30.0 : 36.0;
      final statValueSize = isSmall ? 40.0 : 46.0;

      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 18, 8, 20),
        child: Column(
          children: [
            if (page.user != null) _userRow(page.user!),
            SizedBox(height: isSmall ? 22 : 28),
            Text(
              page.title ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF202020),
                height: 0.9,
              ),
            ),
            SizedBox(height: isSmall ? 20 : 28),
            Text(
              page.metricLabel ?? '',
              style: const TextStyle(
                color: Color(0xFF202020),
                fontWeight: FontWeight.w600,
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
                    fontSize: mainValueSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF202020),
                    height: 0.85,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    page.mainSuffix ?? '',
                    style: TextStyle(
                      fontSize: suffixSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF202020),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isSmall ? 22 : 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statBlock(
                  page.stat1Label ?? '',
                  page.stat1Value ?? '',
                  valueSize: statValueSize,
                ),
                _statBlock(
                  page.stat2Label ?? '',
                  page.stat2Value ?? '',
                  valueSize: statValueSize,
                ),
                _statBlock(
                  page.stat3Label ?? '',
                  page.stat3Value ?? '',
                  valueSize: statValueSize,
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

  Widget _statBlock(
  String label,
  String value, {
  double valueSize = 46,
}) {
  return Column(
    children: [
      Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF202020),
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        value,
        style: TextStyle(
          fontSize: valueSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF202020),
          height: 0.9,
        ),
      ),
    ],
  );
}

  // PAGE 8

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
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: Color(0xFF202020),
        ),
      ),
    );
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
          style: const TextStyle(
            color: Color(0xFF202020),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _countryRow(StoryPageData page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StoryHelpers.safeAsset(page.flag ?? '', width: 28, height: 28),
        const SizedBox(width: 10),
        Text(
          page.country ?? '',
          style: const TextStyle(
            color: Color(0xFF202020),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}