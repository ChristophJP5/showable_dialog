import "package:analyzer/dart/element/element.dart";
import "package:build/build.dart";
// Import the annotation from our own package's lib folder.
import "package:showable_dialog/showable_dialog.dart";
import "package:source_gen/source_gen.dart";

/// A [GeneratorForAnnotation] that generates a show function for dialogs
/// annotated with `@ShowableDialog`.
class ShowableDialogGenerator extends GeneratorForAnnotation<ShowableDialog> {
  // It is okay to have a long function here, as this is the main
  // ignore: avoid_long_and_complex_functions, require_parameter_assert
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        "`@ShowableDialog` can only be used on classes.",
        element: element,
      );
    }

    final className = element.name;
    final constructor = element.unnamedConstructor;

    if (constructor == null) {
      throw InvalidGenerationSourceError(
        "The class `$className` must have an unnamed constructor.",
        element: element,
      );
    }

    // No need to check for empty or stuff like this
    // ignore: check_return_value
    final ctorParams = constructor.parameters.where((param) {
      return param.name != "key";
    }).toList();

    final functionSignatureParams = ctorParams.map((p) {
      return '${p.isRequired ? 'required' : ''} ${p.type} ${p.name}';
    }).join(",\n");

    final widgetConstructorArgs = ctorParams.map((p) {
      return "${p.name}: ${p.name}";
    }).join(",\n");

    final buffer = StringBuffer()
      ..writeln("// GENERATED CODE - DO NOT MODIFY BY HAND")
      ..writeln("// ignore_for_file: prefer_const_constructors")
      ..writeln("\n")
      ..writeln("part of '${element.librarySource.uri.pathSegments.last}';")
      ..writeln("\n")
      ..writeln("/// Generated show function for [$className] dialog.")
      ..writeln("extension ${className}Utils on $className {")
      ..writeln("  static Future<T?> show<T>({")
      ..writeln("    required BuildContext context,");
    if (functionSignatureParams.isNotEmpty) {
      buffer.writeln("  $functionSignatureParams,");
    }
    buffer
      ..writeln("  }) {")
      ..writeln("    return showDialog<T>(")
      ..writeln("      context: context,")
      ..writeln("      builder: (context) => $className(");
    if (widgetConstructorArgs.isNotEmpty) {
      buffer.writeln("      $widgetConstructorArgs,");
    }
    buffer
      ..writeln("      ),")
      ..writeln("    );")
      ..writeln("  }")
      ..writeln("}")
      ..writeln("\n");
    return buffer.toString();
  }
}
