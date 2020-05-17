import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';
@JsonSerializable()
class Task {
  Task();
  String id;
  String createdAt;
  String name;
  String avatar;
  
  factory Task.fromJson(Map<String,dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}