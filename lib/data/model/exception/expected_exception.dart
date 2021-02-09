import 'app_exception.dart';

/// 予期していた例外
abstract class ExpectedException implements AppException {
  String get solution;
}
