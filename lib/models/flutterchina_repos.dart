import 'package:json_annotation/json_annotation.dart';

part 'flutterchina_repos.g.dart';
@JsonSerializable()
class Flutterchina_repos {
  Flutterchina_repos();
  num id;
  String node_id;
  String name;
  String full_name;
  String html_url;
  String description;
  
  factory Flutterchina_repos.fromJson(Map<String,dynamic> json) => _$Flutterchina_reposFromJson(json);
  Map<String, dynamic> toJson() => _$Flutterchina_reposToJson(this);
}