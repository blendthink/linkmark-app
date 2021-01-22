import 'package:linkmark_app/data/model/exception/app_exception.dart';

/// 予期していた例外
abstract class ExpectedException implements AppException {
  String get solution;
  String toString() {
    String message = this.message;
    if (message == null) return "ExpectedException";
    return "ExpectedException: $message";
  }
}
