import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/showable_dialog_generator.dart';

/// The builder entry point, referenced in build.yaml
Builder showableDialogBuilder(BuilderOptions options) {
  return LibraryBuilder(
    ShowableDialogGenerator(),
    generatedExtension: '.showable.g.dart',
  );
}
