// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'chosen_tag_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ChosenTagDataTearOff {
  const _$ChosenTagDataTearOff();

// ignore: unused_element
  _ChosenTagData call({@required Tag tag, @required bool isChosen}) {
    return _ChosenTagData(
      tag: tag,
      isChosen: isChosen,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ChosenTagData = _$ChosenTagDataTearOff();

/// @nodoc
mixin _$ChosenTagData {
  Tag get tag;
  bool get isChosen;

  @JsonKey(ignore: true)
  $ChosenTagDataCopyWith<ChosenTagData> get copyWith;
}

/// @nodoc
abstract class $ChosenTagDataCopyWith<$Res> {
  factory $ChosenTagDataCopyWith(
          ChosenTagData value, $Res Function(ChosenTagData) then) =
      _$ChosenTagDataCopyWithImpl<$Res>;
  $Res call({Tag tag, bool isChosen});

  $TagCopyWith<$Res> get tag;
}

/// @nodoc
class _$ChosenTagDataCopyWithImpl<$Res>
    implements $ChosenTagDataCopyWith<$Res> {
  _$ChosenTagDataCopyWithImpl(this._value, this._then);

  final ChosenTagData _value;
  // ignore: unused_field
  final $Res Function(ChosenTagData) _then;

  @override
  $Res call({
    Object tag = freezed,
    Object isChosen = freezed,
  }) {
    return _then(_value.copyWith(
      tag: tag == freezed ? _value.tag : tag as Tag,
      isChosen: isChosen == freezed ? _value.isChosen : isChosen as bool,
    ));
  }

  @override
  $TagCopyWith<$Res> get tag {
    if (_value.tag == null) {
      return null;
    }
    return $TagCopyWith<$Res>(_value.tag, (value) {
      return _then(_value.copyWith(tag: value));
    });
  }
}

/// @nodoc
abstract class _$ChosenTagDataCopyWith<$Res>
    implements $ChosenTagDataCopyWith<$Res> {
  factory _$ChosenTagDataCopyWith(
          _ChosenTagData value, $Res Function(_ChosenTagData) then) =
      __$ChosenTagDataCopyWithImpl<$Res>;
  @override
  $Res call({Tag tag, bool isChosen});

  @override
  $TagCopyWith<$Res> get tag;
}

/// @nodoc
class __$ChosenTagDataCopyWithImpl<$Res>
    extends _$ChosenTagDataCopyWithImpl<$Res>
    implements _$ChosenTagDataCopyWith<$Res> {
  __$ChosenTagDataCopyWithImpl(
      _ChosenTagData _value, $Res Function(_ChosenTagData) _then)
      : super(_value, (v) => _then(v as _ChosenTagData));

  @override
  _ChosenTagData get _value => super._value as _ChosenTagData;

  @override
  $Res call({
    Object tag = freezed,
    Object isChosen = freezed,
  }) {
    return _then(_ChosenTagData(
      tag: tag == freezed ? _value.tag : tag as Tag,
      isChosen: isChosen == freezed ? _value.isChosen : isChosen as bool,
    ));
  }
}

/// @nodoc
class _$_ChosenTagData implements _ChosenTagData {
  const _$_ChosenTagData({@required this.tag, @required this.isChosen})
      : assert(tag != null),
        assert(isChosen != null);

  @override
  final Tag tag;
  @override
  final bool isChosen;

  @override
  String toString() {
    return 'ChosenTagData(tag: $tag, isChosen: $isChosen)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChosenTagData &&
            (identical(other.tag, tag) ||
                const DeepCollectionEquality().equals(other.tag, tag)) &&
            (identical(other.isChosen, isChosen) ||
                const DeepCollectionEquality()
                    .equals(other.isChosen, isChosen)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(tag) ^
      const DeepCollectionEquality().hash(isChosen);

  @JsonKey(ignore: true)
  @override
  _$ChosenTagDataCopyWith<_ChosenTagData> get copyWith =>
      __$ChosenTagDataCopyWithImpl<_ChosenTagData>(this, _$identity);
}

abstract class _ChosenTagData implements ChosenTagData {
  const factory _ChosenTagData({@required Tag tag, @required bool isChosen}) =
      _$_ChosenTagData;

  @override
  Tag get tag;
  @override
  bool get isChosen;
  @override
  @JsonKey(ignore: true)
  _$ChosenTagDataCopyWith<_ChosenTagData> get copyWith;
}
