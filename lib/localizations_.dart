import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/i18n.dart';

class LocalizationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,// 应用程序的翻译回调
        GlobalMaterialLocalizations.delegate,//Material 组件的翻译回调
        GlobalWidgetsLocalizations.delegate,// 普通 Widget 的翻译回调
      ],
      supportedLocales: S.delegate.supportedLocales,// 支持语系
      //title 的国际化回调
      onGenerateTitle: (context){
        return S.of(context).app_title;
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  _incrementCounter() {
    setState(() {
      _counter++;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(S.of(context).main_title),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Text(
                  S.of(context).message_tip(_counter.toString())
              )
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}