// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_filter_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TagFilterData _$_$_TagFilterDataFromJson(Map<String, dynamic> json) {
  return _$_TagFilterData(
    selected: json['selected'] as bool,
    tag: json['tag'] == null
        ? null
        : Tag.fromJson(json['tag'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_TagFilterDataToJson(_$_TagFilterData instance) =>
    <String, dynamic>{
      'selected': instance.selected,
      'tag': instance.tag,
    };
