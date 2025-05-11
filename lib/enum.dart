// Copyright (c) 2025, fade_widget_kit authors
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

/// Enumeration that defines possible directions for the fade animation.
///
/// These values determine the starting position of the widget before
/// animating to its final position.
enum FadeDirection {
  /// Animation starts from below the final position and moves upward.
  ///
  /// The widget will appear to slide up from the bottom while fading in.
  up,

  /// Animation starts from above the final position and moves downward.
  ///
  /// The widget will appear to slide down from the top while fading in.
  down,

  /// Animation starts from the right of the final position and moves left.
  ///
  /// The widget will appear to slide in from the right while fading in.
  left,

  /// Animation starts from the left of the final position and moves right.
  ///
  /// The widget will appear to slide in from the left while fading in.
  right,
}