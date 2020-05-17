import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * 状态管理演示，A 管理自己的状态
 */

class StateManage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("状态管理"),
        ),
        body: Column(
          children: <Widget>[
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TapboxA()));
                  },
                  child: Text("自己管理自己")),
            ),
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ParentWidget()));
                  },
                  child: Text("父管理子Widge")),
            ),
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProviderManagerPage()));
                  },
                  child: Text("Provider 状态管理")),
            ),
          ],
        ),
      ),
    );
  }
}

//------------------------- Widget管理自身状态 ----------------------------------

class TapboxA extends StatefulWidget {
  @override
  _TapboxAState createState() {
    return _TapboxAState();
  }
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? "Active" : "InActive",
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600]),
      ),
    );
  }
}

//------------------------- 父类管理子 widget 状态 ----------------------------------

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

//------------------------- TapboxB ----------------------------------

class TapboxB extends StatelessWidget {
  final bool active;
  final ValueChanged<bool> onChanged;

  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//------------------------- provider 状态管理 ----------------------------------

class ProviderManagerPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return ChangeNotifierProvider.value(
//      value: CounterModel(),
//      child: MaterialApp(
//        home: ProviderFirstPage(),
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider.value(value: 30.0), // 注入字体大小
          ChangeNotifierProvider.value(value: CounterModel()) // 注入计数器实例
        ],
        child: MaterialApp(
          home: ProviderFirstPage(),
        ));
  }
}

class ProviderFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context); // 获取计时器实例
    final textSize = Provider.of<double>(context); // 获取字体大小

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "provider first page",
        ),
      ),
      body: Text(
        "Counter: ${_counter._count}",
        style: TextStyle(fontSize: textSize),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProviderSecondPage())),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

//class ProviderSecondPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final _counter = Provider.of<CounterModel>(context);
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("provider second page"),
//      ),
//      body: Consumer<CounterModel>(
//        builder: (context, CounterModel counter, _) =>
//            Text("Counter: ${_counter._count}"),
//      ),
//      floatingActionButton: Consumer<CounterModel>(
//        builder: (context, CounterModel counter, child) => FloatingActionButton(
//          onPressed: _counter.increment,
//          child: child,
//        ),
//        child: TestIcon(),
//      ),
//    );
//  }
//}

class ProviderSecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("provider second page"),
      ),
      body: Consumer2<CounterModel, double>(
        builder: (context, CounterModel counter, double textSize, _) => Text(
          "Counter: ${counter._count}",
          style: TextStyle(fontSize: textSize),
        ),
      ),
      floatingActionButton: Consumer<CounterModel>(
        builder: (context, CounterModel counter, child) => FloatingActionButton(
          onPressed: counter.increment,
          child: child,
        ),
        child: TestIcon(),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用 Consumer 来封装 counter 的读取
      body: Consumer<CounterModel>(
          //builder 函数可以直接获取到 counter 参数
          builder: (context, CounterModel counter, _) =>
              Text('Value: ${counter.counter}')),
      // 使用 Consumer 来封装 increment 的读取
      floatingActionButton: Consumer<CounterModel>(
        //builder 函数可以直接获取到 increment 参数
        builder: (context, CounterModel counter, child) => FloatingActionButton(
          onPressed: counter.increment,
          child: child,
        ),
        child: TestIcon(),
      ),
    );
  }
}

class CounterModel with ChangeNotifier {
  int _count = 0;

  // 读方法
  int get counter => _count;

  // 写方法
  void increment() {
    _count++;
    // 通知听众刷新
    notifyListeners();
  }
}

// 用于打印 build 方法执行情况的自定义控件
class TestIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("TestIcon build");
    return Icon(Icons.add); // 返回 Icon 实例
  }
}
