import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkmark_app/data/model/exception/expected_exption.dart';

class TagCreateException implements ExpectedException {
  final TagCreateExceptionType _type;

  const TagCreateException({
    @required TagCreateExceptionType type,
  }) : _type = type;

  @override
  String get message => _type.message;

  @override
  String get solution => _type.solution;

  @override
  String toString() => 'TagCreateException: $message';
}

abstract class TagCreateExceptionType {
  const TagCreateExceptionType._();
  const factory TagCreateExceptionType.existsSameName() = _ExistsSameName;
  String get message;
  String get solution;
}

class _ExistsSameName extends TagCreateExceptionType {
  const _ExistsSameName() : super._();

  @override
  String get message => 'The same name already exists';

  @override
  String get solution => 'Please change the name';
}
