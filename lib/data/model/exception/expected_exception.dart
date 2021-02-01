import 'app_exception.dart';

/// 予期していた例外
abstract class ExpectedException implements AppException {
  String get solution;
  String toString() {
    final message = this.message;
    if (message == null) return "ExpectedException";
    return "ExpectedException: $message";
  }
}
