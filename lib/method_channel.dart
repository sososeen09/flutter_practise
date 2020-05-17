import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelTestPage extends StatelessWidget {
  //Add this line
  static const platformMethodChannel =
      const MethodChannel('sample.method/utils');

  NativeViewController controller;

  @override
  Widget build(BuildContext context) {
    controller = NativeViewController(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('method channel'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
                child: Text("打开应用"),
                onPressed: () {
                  platformMethodChannel.invokeMethod(
                      'openApp', "com.hongxiu.app");
                }),
            RaisedButton(
                child: Text("跳转原生登录界面"),
                onPressed: () {
                  platformMethodChannel.invokeMethod('openAppLogin');
                }),
            RaisedButton(
                child: Text("修改内嵌原生View背景"),
                onPressed: () {
                  controller.changeBackgroundColor();
                }),
            Container(
              width: 200,
              height: 200,
              child: SampleView(controller: controller),
            ),
          ],
        ));
  }
}

class SampleView extends StatefulWidget {
  const SampleView({
    Key key,
    this.controller,
  }) : super(key: key);

  final NativeViewController controller;

  @override
  State<StatefulWidget> createState() => _SampleViewState();
}

class _SampleViewState extends State<SampleView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'sampleView',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      return UiKitView(
          viewType: 'sampleView',
          onPlatformViewCreated: _onPlatformViewCreated);
    }
  }

  _onPlatformViewCreated(int id) => widget.controller?.onCreate(id);
}

class NativeViewController {
  MethodChannel _channel;
  MethodChannel _channel2;

  BuildContext mContext;

  NativeViewController(BuildContext context) {
    this.mContext = context;
  }

  onCreate(int id) {
    _channel = MethodChannel('sample.view/native_views_$id');
    _channel2 = MethodChannel('sample.view/native_views');
    _channel2.setMethodCallHandler((handler) {
      switch (handler.method) {
        case "closePage":
          print("closePage");
          Navigator.of(mContext).pop();
          break;
        default:
          break;
      }
    });
  }

  changeBackgroundColor() async {
    _channel.invokeMethod('changeBackgroundColor');
  }
}
