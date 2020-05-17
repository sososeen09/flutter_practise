import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'http.dart';
import 'net_manager.dart';
class RequestRoute extends StatefulWidget {
  @override
  _RequestRouteState createState() => _RequestRouteState();
}

class _RequestRouteState extends State<RequestRoute> {
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Page"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          RaisedButton(
            child: Text("Request"),
            onPressed: () {
              dio.get<String>("http://httpbin.org/get").then((r) {
                setState(() {
                  _text = r.data;
                });
              });
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(_text),
            ),
          )
        ]),
      ),
    );
  }
}

class FutureBuilderRoute extends StatefulWidget {
  @override
  _FutureBuilderRouteState createState() => _FutureBuilderRouteState();
}

class _FutureBuilderRouteState extends State<FutureBuilderRoute> {
  Dio _dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
            future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //请求完成
              if (snapshot.connectionState == ConnectionState.done) {
                Response response = snapshot.data;
                //发生错误
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                //请求成功，通过项目信息构建用于显示项目名称的ListView
                return ListView(
                  children: response.data
                      .map<Widget>((e) => ListTile(title: Text(e["full_name"])))
                      .toList(),
                );
              }
              //请求未完成时弹出loading
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
