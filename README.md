# Fade Widget Kit

A lightweight Flutter package that provides elegant fade animations for widgets in various directions. Easily create modern UI transitions that trigger automatically based on widget visibility.

## Features

- **Direction-based animations**: Fade widgets in from any direction (up, down, left, right)
- **Customizable timing**: Control both animation duration and initial delay
- **Visibility-based triggering**: Animations automatically start when widgets become visible on screen
- **Simple API**: Apply animations with minimal code
- **Performance optimized**: Efficiently manages animations to avoid performance issues

## Getting started

Add `fade_widget_kit` to your `pubspec.yaml`:

```yaml
dependencies:
  fade_widget_kit: ^1.0.0
```

Then run:

```
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:fade_widget_kit/fade_widget_kit.dart';
```

### Basic usage

Wrap any widget with `FadeUpWidget` to add a smooth fade-in animation from the bottom:

```dart
FadeUpWidget(
  child: Text('This text will fade in from the bottom'),
)
```

### Customizing animations

You can customize the animation duration, delay, and direction:

```dart
FadeUpWidget(
  duration: const Duration(milliseconds: 1200),
  delay: const Duration(milliseconds: 300),
  direction: FadeDirection.left,
  child: Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('This card will fade in from the left after a delay'),
    ),
  ),
)
```

### Staggered animations

Create staggered animations by using different delay values:

```dart
Column(
  children: [
    FadeUpWidget(
      delay: const Duration(milliseconds: 0),
      child: Text('First item'),
    ),
    FadeUpWidget(
      delay: const Duration(milliseconds: 100),
      child: Text('Second item'),
    ),
    FadeUpWidget(
      delay: const Duration(milliseconds: 200),
      child: Text('Third item'),
    ),
  ],
)
```

### Available directions

The package supports four animation directions:

- `FadeDirection.up` (default): Widget fades in from bottom to its position
- `FadeDirection.down`: Widget fades in from top to its position
- `FadeDirection.left`: Widget fades in from right to its position
- `FadeDirection.right`: Widget fades in from left to its position

## Example

A complete example showcasing a staggered list animation:

```dart
import 'package:flutter/material.dart';
import 'package:fade_widget_kit/fade_widget_kit.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fade Widget Example')),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return FadeUpWidget(
            delay: Duration(milliseconds: index * 50),
            child: Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text('Item ${index + 1}'),
                subtitle: Text('This item fades in with a staggered effect'),
              ),
            ),
          );
        },
      ),
    );
  }
}
```

## Additional information

### Compatibility

This package is compatible with Flutter 1.17.0 and above.

### Dependencies

- [visibility_detector](https://pub.dev/packages/visibility_detector): Used to detect when widgets enter the viewport