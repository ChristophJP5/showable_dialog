import "package:build/build.dart";
import "package:showable_dialog/src/showable_dialog_generator.dart";
import "package:source_gen/source_gen.dart";

// We dont need to check for the options, as we don't use them.
// ignore: require_parameter_assert
/// Returns a [Builder] that generates show functions for dialogs
/// annotated with `@ShowableDialog`.
Builder showableDialogBuilder(BuilderOptions options) {
  return LibraryBuilder(
    ShowableDialogGenerator(),
    generatedExtension: ".showable.g.dart",
  );
}
