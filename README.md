# showable_dialog

A Dart package that automatically generates convenient static `show` methods for your dialog widgets using code generation.

# Why i made this
I love Locality of reference. As a college showed me where and how she implements `showDialog` function to show a dialog, i  yoinked the approach. But cause i don't like boilerplate and tidious code, i made this package to generate the static `show` methods for me. 
What approach am i talkin about? This: 
```dart
class MyDialog extends StatelessWidget {
    const MyDialog({super.key, required this.title});

    final String title;

    /// this is what i'm talking about baby
    /// this is just the perfect place to put the showDialog
    static Future<T?> show<T>({
        required BuildContext context,
        required String title,
    }) {
        return showDialog<T>(
            context: context,
            builder: (context) => MyDialog(title: title),
        );
    }

    @override
    Widget build(BuildContext context) {
        return AlertDialog(
        // ...
        );
    }
}
```


> [!WARNING]  
> I vibe code part the build runner generation, and only wrote the extension method stuff my self, so `use with caution`. But i'm still responsible, so if you find bugs or issues, please report them.


## Features

- 🎯 **Static Method Generation**: Automatically generates static `show` methods for annotated dialog classes
- 🔧 **Type-Safe**: Maintains full type safety with proper generic support
- ✨ **Simple API**: Just add `@showableDialog` annotation to your widget
- 🚀 **Built-Value Style**: Uses the familiar `MyDialog.show()` pattern
- 📦 **Zero Runtime Dependencies**: Only generates code, no runtime overhead

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  showable_dialog: ^1.0.0

dev_dependencies:
  build_runner: ^2.4.0
```

## Usage

### 1. Annotate Your Dialog Widget

Create a dialog widget and annotate it with `@showableDialog`:

```dart
import 'package:flutter/material.dart';
import 'package:showable_dialog/showable_dialog.dart';

part 'demo_dialog.showable.g.dart';

@showableDialog
class DemoDialog extends StatelessWidget {
  const DemoDialog({
    super.key,
    required this.title,
    this.content,
  });

  final String title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content ?? 'This is a demo dialog.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
```

### 2. Run Code Generation

Execute the build runner to generate the helper methods:

```bash
dart run build_runner build
```
OR 
```bash
dart run build_runner watch
```

### 3. Use the Generated Static Method

The package generates a static `show` method through an extension:

```dart
import 'package:flutter/material.dart';
import 'demo_dialog.dart'; // Your dialog file

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                // Use the generated static method
                DemoDialog.show(
                  context: context,
                  title: "Hello World",
                  content: "This is easy to use!",
                );
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      ),
    );
  }
}
```

## Generated Code

For the example above, the package generates:

```dart
// demo_dialog.showable.g.dart
part of 'demo_dialog.dart';

extension DemoDialogUtils on DemoDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? content,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => DemoDialog(
        title: title,
        content: content,
      ),
    );
  }
}
```

## API Reference

### `@showableDialog`

Annotation that marks a widget class for show method generation.

**Requirements:**
- The annotated class must be a Widget
- The class must have an unnamed constructor
- Constructor parameters (except `key`) become parameters of the generated `show` method

### Generated Method Signature

```dart
static Future<T?> show<T>({
  required BuildContext context,
  // ... your widget's constructor parameters
}) 
```

## Examples

### Basic Dialog

```dart
@showableDialog
class SimpleDialog extends StatelessWidget {
  const SimpleDialog({super.key});
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Simple'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

// Usage:
SimpleDialog.show(context: context);
```

### Dialog with Parameters

```dart
@showableDialog
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
  });

  final String title;
  final String message;
  final String confirmText;
  final String cancelText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmText),
        ),
      ],
    );
  }
}

// Usage:
final result = await ConfirmDialog.show(
  context: context,
  title: 'Delete Item',
  message: 'Are you sure you want to delete this item?',
  confirmText: 'Delete',
);
```

## Development

### Running the Example

```bash
cd showable_dialog_example
flutter pub get
dart run build_runner build
flutter run
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Inspiration

By my college Ouafae.