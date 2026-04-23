import 'dart:math' as math;
import 'package:flutter/material.dart';

class InteractiveTiltCard extends StatefulWidget {
  const InteractiveTiltCard({
    super.key,
    required this.child,
    this.maxTiltRadians = 0.12,
    this.perspective = 0.0018,
    this.resetDuration = const Duration(milliseconds: 220),
  });

  final Widget child;
  final double maxTiltRadians;
  final double perspective;
  final Duration resetDuration;

  @override
  State<InteractiveTiltCard> createState() => _InteractiveTiltCardState();
}

class _InteractiveTiltCardState extends State<InteractiveTiltCard>
    with SingleTickerProviderStateMixin {
  double _rotateX = 0;
  double _rotateY = 0;

  late final AnimationController _resetController;
  Animation<double>? _resetX;
  Animation<double>? _resetY;

  @override
  void initState() {
    super.initState();

    _resetController = AnimationController(
      vsync: this,
      duration: widget.resetDuration,
    )
      ..addListener(() {
        setState(() {
          _rotateX = _resetX?.value ?? 0;
          _rotateY = _resetY?.value ?? 0;
        });
      });
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _handlePanUpdate(DragUpdateDetails details, BoxConstraints constraints) {
    final local = details.localPosition;
    final width = constraints.maxWidth;
    final height = constraints.maxHeight;

    final normalizedX = ((local.dx / width) * 2) - 1;
    final normalizedY = ((local.dy / height) * 2) - 1;

    setState(() {
      _rotateY = normalizedX * widget.maxTiltRadians;
      _rotateX = -normalizedY * widget.maxTiltRadians;
    });
  }

  void _resetTilt() {
    _resetX = Tween<double>(
      begin: _rotateX,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _resetController,
      curve: Curves.easeOut,
    ));

    _resetY = Tween<double>(
      begin: _rotateY,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _resetController,
      curve: Curves.easeOut,
    ));

    _resetController
      ..stop()
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) => _resetController.stop(),
          onPanUpdate: (details) => _handlePanUpdate(details, constraints),
          onPanEnd: (_) => _resetTilt(),
          onPanCancel: _resetTilt,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, widget.perspective)
              ..rotateX(_rotateX)
              ..rotateY(_rotateY),
            child: widget.child,
          ),
        );
      },
    );
  }
}