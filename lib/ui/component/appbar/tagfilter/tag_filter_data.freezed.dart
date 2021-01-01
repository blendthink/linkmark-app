// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'tag_filter_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
TagFilterData _$TagFilterDataFromJson(Map<String, dynamic> json) {
  return _TagFilterData.fromJson(json);
}

/// @nodoc
class _$TagFilterDataTearOff {
  const _$TagFilterDataTearOff();

// ignore: unused_element
  _TagFilterData call({@required bool selected, @required Tag tag}) {
    return _TagFilterData(
      selected: selected,
      tag: tag,
    );
  }

// ignore: unused_element
  TagFilterData fromJson(Map<String, Object> json) {
    return TagFilterData.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $TagFilterData = _$TagFilterDataTearOff();

/// @nodoc
mixin _$TagFilterData {
  bool get selected;
  Tag get tag;

  Map<String, dynamic> toJson();
  $TagFilterDataCopyWith<TagFilterData> get copyWith;
}

/// @nodoc
abstract class $TagFilterDataCopyWith<$Res> {
  factory $TagFilterDataCopyWith(
          TagFilterData value, $Res Function(TagFilterData) then) =
      _$TagFilterDataCopyWithImpl<$Res>;
  $Res call({bool selected, Tag tag});

  $TagCopyWith<$Res> get tag;
}

/// @nodoc
class _$TagFilterDataCopyWithImpl<$Res>
    implements $TagFilterDataCopyWith<$Res> {
  _$TagFilterDataCopyWithImpl(this._value, this._then);

  final TagFilterData _value;
  // ignore: unused_field
  final $Res Function(TagFilterData) _then;

  @override
  $Res call({
    Object selected = freezed,
    Object tag = freezed,
  }) {
    return _then(_value.copyWith(
      selected: selected == freezed ? _value.selected : selected as bool,
      tag: tag == freezed ? _value.tag : tag as Tag,
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
abstract class _$TagFilterDataCopyWith<$Res>
    implements $TagFilterDataCopyWith<$Res> {
  factory _$TagFilterDataCopyWith(
          _TagFilterData value, $Res Function(_TagFilterData) then) =
      __$TagFilterDataCopyWithImpl<$Res>;
  @override
  $Res call({bool selected, Tag tag});

  @override
  $TagCopyWith<$Res> get tag;
}

/// @nodoc
class __$TagFilterDataCopyWithImpl<$Res>
    extends _$TagFilterDataCopyWithImpl<$Res>
    implements _$TagFilterDataCopyWith<$Res> {
  __$TagFilterDataCopyWithImpl(
      _TagFilterData _value, $Res Function(_TagFilterData) _then)
      : super(_value, (v) => _then(v as _TagFilterData));

  @override
  _TagFilterData get _value => super._value as _TagFilterData;

  @override
  $Res call({
    Object selected = freezed,
    Object tag = freezed,
  }) {
    return _then(_TagFilterData(
      selected: selected == freezed ? _value.selected : selected as bool,
      tag: tag == freezed ? _value.tag : tag as Tag,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_TagFilterData with DiagnosticableTreeMixin implements _TagFilterData {
  const _$_TagFilterData({@required this.selected, @required this.tag})
      : assert(selected != null),
        assert(tag != null);

  factory _$_TagFilterData.fromJson(Map<String, dynamic> json) =>
      _$_$_TagFilterDataFromJson(json);

  @override
  final bool selected;
  @override
  final Tag tag;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TagFilterData(selected: $selected, tag: $tag)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TagFilterData'))
      ..add(DiagnosticsProperty('selected', selected))
      ..add(DiagnosticsProperty('tag', tag));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TagFilterData &&
            (identical(other.selected, selected) ||
                const DeepCollectionEquality()
                    .equals(other.selected, selected)) &&
            (identical(other.tag, tag) ||
                const DeepCollectionEquality().equals(other.tag, tag)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(selected) ^
      const DeepCollectionEquality().hash(tag);

  @override
  _$TagFilterDataCopyWith<_TagFilterData> get copyWith =>
      __$TagFilterDataCopyWithImpl<_TagFilterData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TagFilterDataToJson(this);
  }
}

abstract class _TagFilterData implements TagFilterData {
  const factory _TagFilterData({@required bool selected, @required Tag tag}) =
      _$_TagFilterData;

  factory _TagFilterData.fromJson(Map<String, dynamic> json) =
      _$_TagFilterData.fromJson;

  @override
  bool get selected;
  @override
  Tag get tag;
  @override
  _$TagFilterDataCopyWith<_TagFilterData> get copyWith;
}
