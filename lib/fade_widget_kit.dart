// Copyright (c) 2025, fade_widget_kit authors
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

/// A Flutter package that provides customizable fade animations for widgets
/// when they become visible in the viewport.
///
/// This file contains the main [FadeWidgetKit] implementation which handles
/// animations from various directions with customizable duration and delay.
library;

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import './enum.dart';

/// A widget that animates its child with a fade and position animation when
/// it becomes visible in the viewport.
///
/// The animation direction, duration, and delay can be customized.
///
/// Example usage:
///
/// ```dart
/// FadeWidgetKit(
///   duration: const Duration(milliseconds: 800),
///   delay: const Duration(milliseconds: 200),
///   direction: FadeDirection.up,
///   child: const Text('This text will fade up when visible'),
/// )
/// ```
@immutable
class FadeWidgetKit extends StatefulWidget {
  /// The widget to animate when it becomes visible.
  final Widget child;

  /// The duration of the animation.
  ///
  /// Defaults to 800 milliseconds.
  final Duration duration;

  /// The delay before starting the animation after the widget becomes visible.
  ///
  /// Defaults to zero (no delay).
  final Duration delay;

  /// The direction from which the child widget will animate.
  ///
  /// Defaults to [FadeDirection.up] (animating from bottom to current position).
  final FadeDirection direction;

  /// Creates a [FadeWidgetKit].
  ///
  /// The [child] parameter is required. The [duration], [delay], and [direction]
  /// parameters are optional and have default values.
  const FadeWidgetKit({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.delay = Duration.zero,
    this.direction = FadeDirection.up,
  });

  @override
  State<FadeWidgetKit> createState() => _FadeWidgetKitState();
}

class _FadeWidgetKitState extends State<FadeWidgetKit>
    with SingleTickerProviderStateMixin {
  /// Controller for managing the animation.
  late AnimationController _controller;

  /// Animation for the opacity effect (fade in).
  late Animation<double> _opacityAnimation;

  /// Animation for the position effect (sliding).
  late Animation<Offset> _positionAnimation;

  /// Tracks whether the widget has become visible to avoid retriggering the animation.
  bool _isVisible = false;

  /// Determines the starting offset based on the specified direction.
  ///
  /// Returns an [Offset] representing the starting position for the animation
  /// relative to the final position.
  Offset getOffsetByDirection() {
    switch (widget.direction) {
      case FadeDirection.up:
        return const Offset(0, 0.2); // From bottom to current position
      case FadeDirection.down:
        return const Offset(0, -0.2); // From top to current position
      case FadeDirection.left:
        return const Offset(0.2, 0); // From right to current position
      case FadeDirection.right:
        return const Offset(-0.2, 0); // From left to current position
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller with the specified duration
    _controller = AnimationController(vsync: this, duration: widget.duration);

    // Configure the opacity animation from 0 (transparent) to 1 (fully visible)
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Configure the position animation from the starting offset to zero (final position)
    // When using SlideTransition, we don't need to scale by screen height in build()
    // because SlideTransition handles the scaling internally
    _positionAnimation = Tween<Offset>(
      begin: getOffsetByDirection(),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  /// Callback that's triggered when the widget's visibility changes.
  ///
  /// Starts the animation when the widget becomes sufficiently visible
  /// (more than 10% visible) and hasn't already been animated.
  void _onVisibilityChanged(VisibilityInfo info) async {
    if (info.visibleFraction > 0.1 && !_isVisible) {
      _isVisible = true;
      // Wait for the specified delay before starting the animation
      await Future.delayed(widget.delay);
      // Check if the widget is still mounted before updating the UI
      if (mounted) {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    // Clean up the animation controller when the widget is removed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      // Use the provided key or create a unique one to track visibility
      key: widget.key ?? UniqueKey(),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        // Use FadeTransition which is optimized for opacity animations
        opacity: _opacityAnimation,
        child: SlideTransition(
          // Replace Transform.translate with SlideTransition for better integration
          // with the animation framework and improved performance
          position: _positionAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}
