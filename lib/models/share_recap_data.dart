import 'story_page_data.dart';

class ShareRecapData {
  const ShareRecapData({
    required this.userName,
    required this.avatarPath,
    required this.flagPath,
    required this.countryName,
    required this.headline,
    required this.predictionAccuracy,
    required this.sessions,
    required this.readingTime,
    required this.weekLabel,
    required this.tier,
    this.baseImagePath,
  });

  final String userName;
  final String avatarPath;
  final String flagPath;
  final String countryName;
  final String headline;
  final String predictionAccuracy;
  final String sessions;
  final String readingTime;
  final String weekLabel;
  final ShareCardTier tier;
  final String? baseImagePath;

  ShareRecapData copyWith({
    String? userName,
    String? avatarPath,
    String? flagPath,
    String? countryName,
    String? headline,
    String? predictionAccuracy,
    String? sessions,
    String? readingTime,
    String? weekLabel,
    ShareCardTier? tier,
    String? baseImagePath,
  }) {
    return ShareRecapData(
      userName: userName ?? this.userName,
      avatarPath: avatarPath ?? this.avatarPath,
      flagPath: flagPath ?? this.flagPath,
      countryName: countryName ?? this.countryName,
      headline: headline ?? this.headline,
      predictionAccuracy: predictionAccuracy ?? this.predictionAccuracy,
      sessions: sessions ?? this.sessions,
      readingTime: readingTime ?? this.readingTime,
      weekLabel: weekLabel ?? this.weekLabel,
      tier: tier ?? this.tier,
      baseImagePath: baseImagePath ?? this.baseImagePath,
    );
  }
}