import "package:meta/meta_meta.dart";

/// An annotation for a widget that should have a `show...` function generated.
@Target({TargetKind.classType})
/// The [ShowableDialog] annotation is used to mark a dialog widget
class ShowableDialog {
  /// Creates an instance of [ShowableDialog].
  const ShowableDialog();
}

/// A constant instance of the [ShowableDialog] annotation.
const showableDialog = ShowableDialog();
