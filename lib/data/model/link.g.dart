// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Link _$_$_LinkFromJson(Map<String, dynamic> json) {
  return _$_Link(
    id: json['id'] as String,
    url: json['url'] as String,
    title: json['title'] as String ?? '',
    description: json['description'] as String ?? '',
    imageUrl: json['imageUrl'] as String,
    tagIds: (json['tagIds'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$_$_LinkToJson(_$_Link instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'tagIds': instance.tagIds,
    };
