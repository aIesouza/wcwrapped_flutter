import 'package:flutter/material.dart';

enum StoryTheme {
  roundRecap,
  defaultPage,
  roundMvp,
  xpRound,
  badgesEarned,
  predictionStatus,
  appActivity,
  shareRecap,
}

class UserData {
  const UserData({required this.name, required this.avatar});

  final String name;
  final String avatar;
}

class BadgeItemData {
  const BadgeItemData({
    required this.image,
    required this.title,
    required this.text,
  });

  final String image;
  final String title;
  final String text;
}

class StoryPageData {
  const StoryPageData({
    required this.id,
    required this.theme,
    required this.icon,
    this.backgroundColor,
    this.backgroundImage,
    this.user,
    this.country,
    this.flag,
    this.title,
    this.intro,
    this.roundLabel,
    this.subtext,
    this.crowdAvatars = const [],
    this.footerLogo,
    this.showBadges = true,
    this.score,
    this.yellow,
    this.red,
    this.players,
    this.decorImage,
    this.playerImage,
    this.bottomSpikes,
    this.verticalName,
    this.spikesImage,
    this.characterImage,
    this.badgeImage,
    this.bottomText,
    this.badgeLeftImage,
    this.badgeRightImage,
    this.badgeBottomImage,
    this.badgeLeftTitle,
    this.badgeLeftText,
    this.badgeRightTitle,
    this.badgeRightText,
    this.badgeBottomTitle,
    this.badgeBottomText,
    this.badges,
    this.metricLabel,
    this.mainValue,
    this.mainSuffix,
    this.stat1Label,
    this.stat1Value,
    this.stat2Label,
    this.stat2Value,
    this.stat3Label,
    this.stat3Value,
    this.backgroundDecor,
    this.cardImage,
    this.buttonLabel,
  });

  final String id;
  final StoryTheme theme;
  final String icon;
  final Color? backgroundColor;
  final String? backgroundImage;
  final UserData? user;
  final String? country;
  final String? flag;
  final String? title;
  final String? intro;
  final String? roundLabel;
  final String? subtext;
  final List<String> crowdAvatars;
  final String? footerLogo;
  final bool showBadges;
  final String? score;
  final String? yellow;
  final String? red;
  final String? players;
  final String? decorImage;
  final String? playerImage;
  final String? bottomSpikes;
  final String? verticalName;
  final String? spikesImage;
  final String? characterImage;
  final String? badgeImage;
  final String? bottomText;
  final String? badgeLeftImage;
  final String? badgeRightImage;
  final String? badgeBottomImage;
  final String? badgeLeftTitle;
  final String? badgeLeftText;
  final String? badgeRightTitle;
  final String? badgeRightText;
  final String? badgeBottomTitle;
  final String? badgeBottomText;
  final List<BadgeItemData>? badges;
  final String? metricLabel;
  final String? mainValue;
  final String? mainSuffix;
  final String? stat1Label;
  final String? stat1Value;
  final String? stat2Label;
  final String? stat2Value;
  final String? stat3Label;
  final String? stat3Value;
  final String? backgroundDecor;
  final String? cardImage;
  final String? buttonLabel;
}