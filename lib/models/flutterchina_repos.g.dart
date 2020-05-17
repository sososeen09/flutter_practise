// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutterchina_repos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flutterchina_repos _$Flutterchina_reposFromJson(Map<String, dynamic> json) {
  return Flutterchina_repos()
    ..id = json['id'] as num
    ..node_id = json['node_id'] as String
    ..name = json['name'] as String
    ..full_name = json['full_name'] as String
    ..html_url = json['html_url'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$Flutterchina_reposToJson(Flutterchina_repos instance) =>
    <String, dynamic>{
      'id': instance.id,
      'node_id': instance.node_id,
      'name': instance.name,
      'full_name': instance.full_name,
      'html_url': instance.html_url,
      'description': instance.description
    };
