import 'dart:math' as math;
import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';

enum EchoAnimationStyle {
  echoTrail,
  anchoredExpand,
}

class EchoTrailSpec {
  const EchoTrailSpec({
    this.style = EchoAnimationStyle.echoTrail,

    // Shared animation controls
    this.duration = const Duration(milliseconds: 1400),
    this.curve = Curves.easeInOut,

    // Legacy echo trail controls
    this.copyCount = 2,
    required this.colors,
    this.angleDegrees = 28,
    this.distanceStep = 14,
    this.copyOpacity = 0.45,
    this.maxSpread = 1.0,
    this.showOriginal = true,

    // New anchored expand controls
    this.minScale = 1.0,
    this.maxScale = 1.08,
    this.scaleAlignment = Alignment.bottomCenter,
  });

  final EchoAnimationStyle style;

  // Shared
  final Duration duration;
  final Curve curve;

  // Legacy echo trail
  final int copyCount;
  final List<Color> colors;
  final double angleDegrees;
  final double distanceStep;
  final double copyOpacity;
  final double maxSpread;
  final bool showOriginal;

  // New anchored expand
  final double minScale;
  final double maxScale;
  final Alignment scaleAlignment;
}

class EchoTrailAsset extends StatefulWidget {
  const EchoTrailAsset({
    super.key,
    required this.assetPath,
    required this.spec,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
  });

  final String assetPath;
  final EchoTrailSpec spec;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  State<EchoTrailAsset> createState() => _EchoTrailAssetState();
}

class _EchoTrailAssetState extends State<EchoTrailAsset>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.spec.duration,
    )..repeat(reverse: true);

    _progress = CurvedAnimation(
      parent: _controller,
      curve: widget.spec.curve,
    );
  }

  @override
  void didUpdateWidget(covariant EchoTrailAsset oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.spec.duration != widget.spec.duration) {
      _controller.duration = widget.spec.duration;
      _controller
        ..stop()
        ..repeat(reverse: true);
    }

    if (oldWidget.spec.curve != widget.spec.curve) {
      _progress = CurvedAnimation(
        parent: _controller,
        curve: widget.spec.curve,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildImage({Color? tint}) {
    Widget image = Image.asset(
      widget.assetPath,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
    );

    if (tint != null) {
      image = ColorFiltered(
        colorFilter: ColorFilter.mode(tint, BlendMode.srcIn),
        child: image,
      );
    }

    return image;
  }

  Widget _buildEchoTrail() {
    final angle = widget.spec.angleDegrees * math.pi / 180;

    return AnimatedBuilder(
      animation: _progress,
      builder: (context, _) {
        final spread = _progress.value * widget.spec.maxSpread;

        return Stack(
          alignment: Alignment.center,
          children: [
            ...List.generate(widget.spec.copyCount, (i) {
              final distance = widget.spec.distanceStep * (i + 1) * spread;
              final dx = math.cos(angle) * distance;
              final dy = math.sin(angle) * distance;
              final color =
                  widget.spec.colors[i % widget.spec.colors.length];

              return Transform.translate(
                offset: Offset(dx, dy),
                child: Opacity(
                  opacity: widget.spec.copyOpacity,
                  child: _buildImage(tint: color),
                ),
              );
            }),
            if (widget.spec.showOriginal) _buildImage(),
          ],
        );
      },
    );
  }

  Widget _buildAnchoredExpand() {
    return AnimatedBuilder(
      animation: _progress,
      builder: (context, _) {
        final scale = lerpDouble(
          widget.spec.minScale,
          widget.spec.maxScale,
          _progress.value,
        )!;

        return Transform.scale(
          scale: scale,
          alignment: widget.spec.scaleAlignment,
          child: _buildImage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.spec.style) {
      case EchoAnimationStyle.echoTrail:
        return _buildEchoTrail();
      case EchoAnimationStyle.anchoredExpand:
        return _buildAnchoredExpand();
    }
  }
}