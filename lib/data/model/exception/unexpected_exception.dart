import 'package:linkmark_app/data/model/exception/app_exception.dart';

/// 予期していなかった例外
abstract class UnexpectedException implements AppException {
  String toString() {
    String message = this.message;
    if (message == null) return "UnexpectedException";
    return "UnexpectedException: $message";
  }
}
