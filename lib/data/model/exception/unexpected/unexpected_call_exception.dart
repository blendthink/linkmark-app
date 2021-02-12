import '../unexpected_exception.dart';

class UnexpectedCallException implements UnexpectedException {
  const UnexpectedCallException();

  @override
  String get message => 'Unexpected call';

  @override
  String toString() => 'UnexpectedCallException: $message';
}
