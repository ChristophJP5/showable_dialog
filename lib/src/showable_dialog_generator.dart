import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

// Import the annotation from our own package's lib folder.
import 'package:showable_dialog/showable_dialog.dart';

class ShowableDialogGenerator extends GeneratorForAnnotation<ShowableDialog> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '`@ShowableDialog` can only be used on classes.',
        element: element,
      );
    }

    final className = element.name;
    final constructor = element.unnamedConstructor;

    if (constructor == null) {
      throw InvalidGenerationSourceError(
        'The class `$className` must have an unnamed constructor.',
        element: element,
      );
    }

    final ctorParams =
        constructor.parameters.where((param) => param.name != 'key').toList();

    final functionSignatureParams = ctorParams.map((p) {
      return '${p.isRequired?'required':''} ${p.type.toString()} ${p.name}';
    }).join(',\n');

    final widgetConstructorArgs = ctorParams.map((p) {
      return '${p.name}: ${p.name}';
    }).join(',\n');

    final buffer = StringBuffer();
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln('// ignore_for_file: prefer_const_constructors');
    buffer.writeln('\n');
    buffer.writeln('part of \'${element.librarySource.uri.pathSegments.last}\';');
    buffer.writeln('\n');
    buffer.writeln('/// Generated show function for [$className] dialog.');
    buffer.writeln('extension ${className}Utils on $className {');
    buffer.writeln('  static Future<T?> show<T>({');
    buffer.writeln('    required BuildContext context,');
    if (functionSignatureParams.isNotEmpty) {
      buffer.writeln('  $functionSignatureParams,');
    }
    buffer.writeln('  }) {');
    buffer.writeln('    return showDialog<T>(');
    buffer.writeln('      context: context,');
    buffer.writeln('      builder: (context) => $className(');
    if (widgetConstructorArgs.isNotEmpty) {
      buffer.writeln('      $widgetConstructorArgs,');
    }
    buffer.writeln('      ),');
    buffer.writeln('    );');
    buffer.writeln('  }');
    buffer.writeln('}');
    buffer.writeln('\n');
    return buffer.toString();
  }
}
