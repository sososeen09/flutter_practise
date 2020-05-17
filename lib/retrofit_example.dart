import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'models/task.dart';
import 'net_manager.dart';

void main(List<String> args) {
  final logger = Logger();

  final dio = Dio();
  dio.options.headers["Demo-Header"] = "demo header";
  dio.options.headers["Content-Type"] = "application/json";
  final client = RestClient(dio);

//  client.getTasks().then((it) => logger.i(it));

  Future.wait([client.getTasks(), client.getTasks2()])
      .then((List response) => response.forEach((it) {
        if(it is DioError){
          final res = it.response;
          logger.e("Got error : ${res.statusCode} -> ${res.statusMessage}");
        }else if(it is List<Task>){
          logger.i(it);
        }

  }));

  var name=new List<String>();

  name.addAll(["a","b","c"]);
  print( name is List<String>);

  Future.wait([
    // 2秒后返回结果
    Future.delayed(new Duration(seconds: 2), () {
      return "hello";
    }),
    // 4秒后返回结果
    Future.delayed(new Duration(seconds: 4), () {
      return " world";
    })
  ]).then((results) {
    //执行成功会走到这里
    results.forEach((f) {
      print(f);
    });
//    print(results[0]+results[1]);
  }).catchError((e) {
    //执行失败会走到这里
    print(e);
  }).whenComplete(() {
    //无论成功或失败都会走到这里
  });
}
