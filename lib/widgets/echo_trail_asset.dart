import 'dart:math' as math;
import 'package:flutter/material.dart';

class EchoTrailSpec {
  const EchoTrailSpec({
    this.copyCount = 2,
    required this.colors,
    this.angleDegrees = 28,
    this.distanceStep = 14,
    this.duration = const Duration(milliseconds: 1400),
    this.curve = Curves.easeInOut,
    this.copyOpacity = 0.45,
    this.maxSpread = 1.0,
    this.showOriginal = true,
  });

  final int copyCount;
  final List<Color> colors;
  final double angleDegrees;
  final double distanceStep;
  final Duration duration;
  final Curve curve;
  final double copyOpacity;
  final double maxSpread;
  final bool showOriginal;
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
  late final Animation<double> _spread;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.spec.duration,
    )..repeat(reverse: true);

    _spread = CurvedAnimation(
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildImage({Color? tint}) {
    Widget img = Image.asset(
      widget.assetPath,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
    );

    if (tint != null) {
      img = ColorFiltered(
        colorFilter: ColorFilter.mode(tint, BlendMode.srcIn),
        child: img,
      );
    }

    return img;
  }

  @override
  Widget build(BuildContext context) {
    final angle = widget.spec.angleDegrees * math.pi / 180;

    return AnimatedBuilder(
      animation: _spread,
      builder: (context, _) {
        final spread = _spread.value * widget.spec.maxSpread;

        return Stack(
          alignment: Alignment.center,
          children: [
            ...List.generate(widget.spec.copyCount, (i) {
              final distance = widget.spec.distanceStep * (i + 1) * spread;
              final dx = math.cos(angle) * distance;
              final dy = math.sin(angle) * distance;
              final color = widget.spec.colors[i % widget.spec.colors.length];

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
}