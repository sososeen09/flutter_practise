import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'models/task.dart';

part 'net_manager.g.dart';
@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/tasks")
  Future<List<Task>> getTasks();

  @GET("/tasks")
  Future<List<Task>> getTasks2();
}
