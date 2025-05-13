// test/fade_up_widget_test.dart

import 'package:fade_widget_kit/fade_widget_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  // Make sure VisibilityDetector can register its IDs in a test environment.
  setUpAll(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets('First FadeUpWidget fades in', (tester) async {
    await tester.pumpWidget(_wrapped(Text('Hello'), key: const Key('first')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('Second FadeUpWidget fades in', (tester) async {
    await tester.pumpWidget(_wrapped(Text('Hello0'), key: const Key('second')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.text('Hello0'), findsOneWidget);
  });
}

// helper to avoid duplication
Widget _wrapped(Widget child, {required Key key}) {
  return MaterialApp(
    home: Scaffold(
      body: FadeWidgetKit(
        key: key,
        duration: const Duration(milliseconds: 800),
        delay: const Duration(milliseconds: 200),
        direction: FadeDirection.up,
        child: child,
      ),
    ),
  );
}
