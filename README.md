
# Fade Widget Kit
*by **Khaled Ghaly** — Flutter Developer*

A lightweight Flutter package that provides elegant fade animations for widgets in various directions. Easily create modern UI transitions that trigger automatically based on widget visibility.

[![pub package](https://img.shields.io/badge/pub-v1.1.4-blue)](https://pub.dev/packages/fade_widget_kit)
[![flutter](https://img.shields.io/badge/flutter-website-blue)](https://flutter.dev)
[![license: MIT](https://img.shields.io/badge/license-MIT-purple)](https://opensource.org/licenses/MIT)

## Demo

### Mobile Demo

https://github.com/user-attachments/assets/f4a3f5cf-950a-4566-8f15-d537eea32482

### Web/Desktop Demo

https://github.com/user-attachments/assets/39a919f6-4800-4b42-8450-d48d140c6f8f

## Installation

Add `fade_widget_kit` to your `pubspec.yaml`:

```yaml
dependencies:
  fade_widget_kit: ^1.1.4
```

Then run:

```bash
flutter pub get
```

## Features

- **Direction-based animations**: Fade widgets in from any direction (up, down, left, right)
- **Customizable timing**: Control both animation duration and initial delay
- **Visibility-based triggering**: Animations automatically start when widgets become visible on screen
- **Simple API**: Apply animations with minimal code
- **Performance optimized**: Efficiently manages animations to avoid performance issues

## Usage

Import the package:

```dart
import 'package:fade_widget_kit/fade_widget_kit.dart';
```

### Basic usage

Wrap any widget with `FadeWidgetKit` to add a smooth fade-in animation:

```dart
const FadeWidgetKit(
  child: Text('This text will fade in from the bottom'),
)
```

### Customizing animations

Customize the animation duration, delay, and direction:

```dart
FadeWidgetKit(
  duration: const Duration(milliseconds: 1200),
  delay: const Duration(milliseconds: 300),
  direction: FadeDirection.left,
  child: Card(
    child: const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('This card will fade in from the left after a delay'),
    ),
  ),
)
```

### Available directions

The package supports four animation directions:

- `FadeDirection.up` (default): Widget fades in from bottom to its position
- `FadeDirection.down`: Widget fades in from top to its position
- `FadeDirection.left`: Widget fades in from right to its position
- `FadeDirection.right`: Widget fades in from left to its position

### Staggered animations

Create staggered animations by using different delay values:

```dart
const Column(
  children: [
    FadeWidgetKit(
      delay: Duration(milliseconds: 0),
      child: Text('First item'),
    ),
    FadeWidgetKit(
      delay: Duration(milliseconds: 100),
      child: Text('Second item'),
    ),
    FadeWidgetKit(
      delay: Duration(milliseconds: 200),
      child: Text('Third item'),
    ),
  ],
)
```

## Complete Example

Here's a full example showcasing a staggered list animation with alternating directions:

```dart
import 'package:fade_widget_kit/fade_widget_kit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

@immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FadeWidgetKit Example',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

@immutable
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FadeWidgetKit Example')),
      body: const FadeList(),
    );
  }
}

@immutable
class FadeList extends StatelessWidget {
  const FadeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        final delay = Duration(milliseconds: index * 150);
        final direction =
            index.isEven ? FadeDirection.left : FadeDirection.right;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: FadeWidgetKit(
            delay: delay,
            duration: const Duration(milliseconds: 500),
            direction: direction,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade300,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text('Item ${index + 1}'),
                subtitle: const Text('This item fades and slides into view.'),
              ),
            ),
          ),
        );
      },
    );
  }
}
```

## Compatibility

This package is compatible with:
- Dart 3 compatible
- Flutter 1.17.0 and above
- Works on all platforms: Android, iOS, Web, macOS, Windows, and Linux

## Dependencies

- [visibility_detector](https://pub.dev/packages/visibility_detector): Used to detect when widgets enter the viewport

## License

This package is released under the MIT License.