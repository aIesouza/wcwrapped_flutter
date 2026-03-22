import 'package:flutter/material.dart';

class StoryHelpers {
  static TextStyle titleStyle(BuildContext context, {double size = 54}) {
    return TextStyle(
      fontFamily: 'DrukBold',
      fontSize: size,
      height: 0.9,
      color: const Color(0xFF202020),
    );
  }

  static Widget safeAsset(
    String path, {
    BoxFit fit = BoxFit.contain,
    double? width,
    double? height,
  }) {
    return Image.asset(
      path,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (_, __, ___) => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Missing asset',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ),
      ),
    );
  }

  static String cleanText(String? value) => (value ?? '').replaceAll('<br>', '\n');
}
