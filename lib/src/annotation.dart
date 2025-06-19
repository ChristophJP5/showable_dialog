import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

/// An annotation for a widget that should have a `show...` function generated.
@Target({TargetKind.classType})
class ShowableDialog {
  const ShowableDialog();
}

/// A constant instance of the [ShowableDialog] annotation.
const showableDialog = ShowableDialog();