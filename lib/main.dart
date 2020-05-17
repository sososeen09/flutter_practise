import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_practise/data_pass.dart';
import 'package:flutter_practise/scrollable_widget.dart';

import 'basic_widget.dart';
import 'localizations_.dart';
import 'method_channel.dart';
import 'net_sample.dart';
import 'state_manage.dart';

doSth(msg) => print(msg);
void main(){

  Isolate.spawn(doSth, "Hi");
  runApp(CustomPage(null));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('text'),
        ),
        body: new ListView.builder(
          itemBuilder: (context, index) {
            return Text('text');
          },
          itemCount: 20,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(window.defaultRouteName),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              child: FlatButton(
                  onPressed: () {
//                  print("点击了按钮");
//                Future future = Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => NewRoute()));
                    Navigator.pushNamed(context, "new_page", arguments: "hi");
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            child: Text(
                              "这是描述",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14.0),
                              maxLines: 3,
                              textDirection: TextDirection.ltr,
                              overflow: TextOverflow.ellipsis,
                            ),
                            margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
                            alignment: Alignment.topLeft),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _getBottomItem(Icons.star, "1000"),
                            _getBottomItem(Icons.link, "1000"),
                            _getBottomItem(Icons.subject, "1000"),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LifecyclePage(tag: "first",)));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "State 生命周期",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => StateManage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "状态管理",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TextFieldAndFormPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "输入框及表单",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClassicWidgetPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "经典控件",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListViewPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "列表控件",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MethodChannelTestPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "跨平台方法",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CounterInheritedPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "数据跨组件传递",
                            style:
                            TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocalizationPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Flutter 国际化",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FutureBuilderRoute()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "网络请求",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  )),
            ),

          ],
        ),
      ),
    );
  }
}

// 返回一个居中带图标和文本的Item
_getBottomItem(IconData icon, String text) {
  // 充满row横向布局
  return Expanded(
    flex: 1,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 16.0,
            color: Colors.grey,
          ),
          Padding(padding: EdgeInsets.only(left: 5.0)),
          Text(
            text,
            style: TextStyle(color: Colors.grey, fontSize: 14.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    ),
  );
}

class CustomPage extends StatelessWidget {
  final String text;

  CustomPage(this.text) {
    print("defaultRouteName: ${window.defaultRouteName}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        "new_page": (context) {
          return NewRoute();
        }
      },
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;

    print("new route arges: " + args);

    return Scaffold(
      appBar: AppBar(
        title: Text("new route page"),
      ),
      body: Center(
        child: Text("this is new route page"),
      ),
    );
  }
}

class LifecyclePage extends StatefulWidget {
  const LifecyclePage({Key key, this.initValue: 0,this.tag});

  final int initValue;
  final String tag;

  @override
  _LifecyclePageState createState() {
    return _LifecyclePageState();
  }
}

class _LifecyclePageState extends State<LifecyclePage>
    with WidgetsBindingObserver {
  int _counter;

  @override
  void initState() {
    super.initState();
    //初始化状态
    _counter = widget.initValue;
    print("initState:${widget.tag}");
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(" 单次 Frame 绘制回调 "); //只回调一次
    });

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      print(" 实时 Frame 绘制回调 "); //没帧都回调
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build:${widget.tag}");
    return Scaffold(
      appBar: AppBar(
        title: Text("State 生命周期"),
      ),
      body: Center(
        child: FlatButton(
            color: Colors.grey,
            onPressed: () {
//              setState(() {
//                ++_counter;
//              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LifecyclePage(tag: "second",)));
            },
            child: Text("$_counter")),
      ),
    );
  }

  @override
  void didUpdateWidget(LifecyclePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget:${widget.tag}");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate:${widget.tag}");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose:${widget.tag}");
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble:${widget.tag}");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies:${widget.tag}");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("state: $state");
    if (state == AppLifecycleState.resumed) {
      // do something
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
