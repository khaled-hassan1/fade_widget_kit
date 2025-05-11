import 'package:flutter/material.dart';

import 'enum.dart';
import 'package:visibility_detector/visibility_detector.dart';


@immutable
class FadeUpWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final FadeDirection direction;

  const FadeUpWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.direction = FadeDirection.up,
  });

  @override
  State<FadeUpWidget> createState() => _FadeUpWidgetState();
}

class _FadeUpWidgetState extends State<FadeUpWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _positionAnimation;
  bool _isVisible = false;

  Offset getOffsetByDirection() {
    switch (widget.direction) {
      case FadeDirection.up:
        return const Offset(0, 0.2); // from bottom
      case FadeDirection.down:
        return const Offset(0, -0.2); // from top
      case FadeDirection.left:
        return const Offset(0.2, 0); // from right
      case FadeDirection.right:
        return const Offset(-0.2, 0); // from left
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _positionAnimation = Tween<Offset>(
      begin: getOffsetByDirection(),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _onVisibilityChanged(VisibilityInfo info) async {
    if (info.visibleFraction > 0.1 && !_isVisible) {
      _isVisible = true;
      await Future.delayed(widget.delay); // هنا بنستنى ال delay قبل بدء الحركة
      if (mounted) {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: widget.key ?? UniqueKey(),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _controller,
        builder:
            (context, child) => Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.translate(
                offset:
                    _positionAnimation.value *
                    MediaQuery.of(context).size.height,
                child: widget.child,
              ),
            ),
      ),
    );
  }
}
