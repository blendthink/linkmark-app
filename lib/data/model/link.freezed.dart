// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Link _$LinkFromJson(Map<String, dynamic> json) {
  return _Link.fromJson(json);
}

/// @nodoc
class _$LinkTearOff {
  const _$LinkTearOff();

// ignore: unused_element
  _Link call(
      {@required String url,
      String title = '',
      String description = '',
      String imageUrl}) {
    return _Link(
      url: url,
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }

// ignore: unused_element
  Link fromJson(Map<String, Object> json) {
    return Link.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Link = _$LinkTearOff();

/// @nodoc
mixin _$Link {
  String get url;
  String get title;
  String get description;
  String get imageUrl;

  Map<String, dynamic> toJson();
  $LinkCopyWith<Link> get copyWith;
}

/// @nodoc
abstract class $LinkCopyWith<$Res> {
  factory $LinkCopyWith(Link value, $Res Function(Link) then) =
      _$LinkCopyWithImpl<$Res>;
  $Res call({String url, String title, String description, String imageUrl});
}

/// @nodoc
class _$LinkCopyWithImpl<$Res> implements $LinkCopyWith<$Res> {
  _$LinkCopyWithImpl(this._value, this._then);

  final Link _value;
  // ignore: unused_field
  final $Res Function(Link) _then;

  @override
  $Res call({
    Object url = freezed,
    Object title = freezed,
    Object description = freezed,
    Object imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      url: url == freezed ? _value.url : url as String,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
    ));
  }
}

/// @nodoc
abstract class _$LinkCopyWith<$Res> implements $LinkCopyWith<$Res> {
  factory _$LinkCopyWith(_Link value, $Res Function(_Link) then) =
      __$LinkCopyWithImpl<$Res>;
  @override
  $Res call({String url, String title, String description, String imageUrl});
}

/// @nodoc
class __$LinkCopyWithImpl<$Res> extends _$LinkCopyWithImpl<$Res>
    implements _$LinkCopyWith<$Res> {
  __$LinkCopyWithImpl(_Link _value, $Res Function(_Link) _then)
      : super(_value, (v) => _then(v as _Link));

  @override
  _Link get _value => super._value as _Link;

  @override
  $Res call({
    Object url = freezed,
    Object title = freezed,
    Object description = freezed,
    Object imageUrl = freezed,
  }) {
    return _then(_Link(
      url: url == freezed ? _value.url : url as String,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Link implements _Link {
  _$_Link(
      {@required this.url,
      this.title = '',
      this.description = '',
      this.imageUrl})
      : assert(url != null),
        assert(title != null),
        assert(description != null);

  factory _$_Link.fromJson(Map<String, dynamic> json) =>
      _$_$_LinkFromJson(json);

  @override
  final String url;
  @JsonKey(defaultValue: '')
  @override
  final String title;
  @JsonKey(defaultValue: '')
  @override
  final String description;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'Link(url: $url, title: $title, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Link &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(imageUrl);

  @override
  _$LinkCopyWith<_Link> get copyWith =>
      __$LinkCopyWithImpl<_Link>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LinkToJson(this);
  }
}

abstract class _Link implements Link {
  factory _Link(
      {@required String url,
      String title,
      String description,
      String imageUrl}) = _$_Link;

  factory _Link.fromJson(Map<String, dynamic> json) = _$_Link.fromJson;

  @override
  String get url;
  @override
  String get title;
  @override
  String get description;
  @override
  String get imageUrl;
  @override
  _$LinkCopyWith<_Link> get copyWith;
}
