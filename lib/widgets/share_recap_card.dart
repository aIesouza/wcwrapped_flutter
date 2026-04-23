import 'package:flutter/material.dart';

import '../models/share_recap_data.dart';
import '../models/story_page_data.dart';
import 'story_helpers.dart';

class ShareRecapCard extends StatelessWidget {
  const ShareRecapCard({
    super.key,
    required this.data,
  });

  final ShareRecapData data;

  String? _tierFallbackBase(ShareCardTier tier) {
    switch (tier) {
      case ShareCardTier.regular:
        return null;
      case ShareCardTier.gold:
        return null;
      case ShareCardTier.legend:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseImage = data.baseImagePath ?? _tierFallbackBase(data.tier);

    return AspectRatio(
      aspectRatio: 0.68,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          final borderRadius = width * 0.09;
          final borderWidth = width * 0.028;

          final horizontalPadding = width * 0.06;
          final topPadding = height * 0.028;
          final bottomPadding = height * 0.03;

          final topLabelFontSize = width * 0.021;
          final usernameFontSize = width * 0.03;
          final headlineFontSize = width * 0.115;
          final metricLabelFontSize = width * 0.020;
          final metricValueFontSize = width * 0.075;
          final bottomLabelFontSize = width * 0.034;

          final topLogoWidth = width * 0.16;
          final avatarSize = width * 0.30;
          final usernameHorizontalPadding = width * 0.03;
          final usernameVerticalPadding = height * 0.010;
          final flagSize = width * 0.11;
          final footerLogoSize = width * 0.10;

          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: const Color(0xFF2B2B2B),
                width: borderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x22000000),
                  blurRadius: width * 0.04,
                  offset: Offset(0, height * 0.015),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                const Positioned.fill(
                  child: ColoredBox(
                    color: Color(0xFFD9D9D9),
                  ),
                ),
                if (baseImage != null)
                  Positioned.fill(
                    child: StoryHelpers.safeAsset(
                      baseImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    topPadding,
                    horizontalPadding,
                    bottomPadding,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              'WC WRAPPED WEEK BY',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: topLabelFontSize,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF202020),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.012),
                          SizedBox(
                            width: topLogoWidth,
                            child: StoryHelpers.safeAsset(
                              'assets/images/shared/of_wordmark.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.024),
                      Container(
                        width: avatarSize,
                        height: avatarSize,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF1F1F1),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: StoryHelpers.safeAsset(
                          data.avatarPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: height * 0.014),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: usernameHorizontalPadding,
                          vertical: usernameVerticalPadding,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F4F4),
                          borderRadius: BorderRadius.circular(width * 0.02),
                        ),
                        child: Text(
                          data.userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: usernameFontSize,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF202020),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.022),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: flagSize,
                                height: flagSize,
                                child: StoryHelpers.safeAsset(
                                  data.flagPath,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.008),
                            Text(
                              data.headline,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Druk',
                                fontSize: headlineFontSize,
                                height: 0.88,
                                color: const Color(0xFF202020),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _metric(
                                  label: 'PREDICTION ACCURACY',
                                  value: data.predictionAccuracy,
                                  labelFontSize: metricLabelFontSize,
                                  valueFontSize: metricValueFontSize,
                                ),
                                SizedBox(width: width * 0.02),
                                _metric(
                                  label: 'SESSIONS',
                                  value: data.sessions,
                                  labelFontSize: metricLabelFontSize,
                                  valueFontSize: metricValueFontSize,
                                ),
                                SizedBox(width: width * 0.02),
                                _metric(
                                  label: 'READING TIME',
                                  value: data.readingTime,
                                  labelFontSize: metricLabelFontSize,
                                  valueFontSize: metricValueFontSize,
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.024),
                            Row(
                              children: [
                                SizedBox(
                                  width: footerLogoSize,
                                  height: footerLogoSize,
                                  child: StoryHelpers.safeAsset(
                                    'assets/images/shared/1F_icon.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(width: width * 0.024),
                                SizedBox(
                                  width: footerLogoSize,
                                  height: footerLogoSize,
                                  child: const SizedBox.shrink(),
                                ),
                                const Spacer(),
                                Flexible(
                                  child: Text(
                                    data.weekLabel,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: bottomLabelFontSize,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF202020),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _metric({
    required String label,
    required String value,
    required double labelFontSize,
    required double valueFontSize,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: labelFontSize,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF202020),
              height: 1.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Druk',
              fontSize: valueFontSize,
              height: 0.9,
              color: const Color(0xFF202020),
            ),
          ),
        ],
      ),
    );
  }
}