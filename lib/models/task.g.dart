// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task()
    ..id = json['id'] as String
    ..createdAt = json['createdAt'] as String
    ..name = json['name'] as String
    ..avatar = json['avatar'] as String;
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'name': instance.name,
      'avatar': instance.avatar
    };
