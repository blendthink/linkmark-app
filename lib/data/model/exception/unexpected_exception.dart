import 'app_exception.dart';

/// 予期していなかった例外
abstract class UnexpectedException implements AppException {
  String toString() {
    final message = this.message;
    if (message == null) return "UnexpectedException";
    return "UnexpectedException: $message";
  }
}
