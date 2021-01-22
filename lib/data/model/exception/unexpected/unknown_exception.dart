import 'package:linkmark_app/data/model/exception/unexpected_exception.dart';

class UnknownException implements UnexpectedException {
  const UnknownException();

  @override
  String get message => 'This exception is not defined in the app';

  @override
  String toString() => 'UnknownException: $message';
}
