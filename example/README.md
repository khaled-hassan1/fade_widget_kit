
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