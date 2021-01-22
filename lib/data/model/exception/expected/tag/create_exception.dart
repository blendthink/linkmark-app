import 'package:linkmark_app/data/model/exception/expected_exption.dart';

abstract class TagCreateException implements ExpectedException {
  const TagCreateException._();
  const factory TagCreateException.existsSameName() = _ExistsSameName;
  const factory TagCreateException.nameTooLong() = _NameTooLong;

  @override
  String toString() => 'TagCreateException: $message';
}

class _ExistsSameName extends TagCreateException {
  const _ExistsSameName() : super._();

  @override
  String get message => 'The same name already exists';

  @override
  String get solution => 'Please change the name';
}

class _NameTooLong extends TagCreateException {
  const _NameTooLong() : super._();

  @override
  String get message => 'The name too long';

  @override
  String get solution => 'Please be the name 20 characters or less';
}
