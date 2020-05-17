import 'package:flutter/material.dart';

class CounterInheritedPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CounterInheritedPageState();
  }
}

class _CounterInheritedPageState extends State<CounterInheritedPage> {
  int count = 0;
  void _incrementCounter() => setState(() {count++;});//修改计数器

  @override
  Widget build(BuildContext context) {
    return CounterContainer2(
        model: this,//将自身作为model交给CountContainer
        increment: _incrementCounter,//提供修改数据的方法
        child:CounterWidget2()
    );
  }
}

class CounterContainer2 extends InheritedWidget {
  _CounterInheritedPageState model;
  Function increment;
  static CounterContainer2 of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterContainer2>();
  }

  CounterContainer2({this.model,this.increment, Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(CounterContainer2 oldWidget) {
    return oldWidget.model.count != this.model.count;
  }
}

class CounterWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterContainer2 value = CounterContainer2.of(context);
    int  count2 = value.model.count;
    return Scaffold(
      body: Container(
        width: 200,
        height: 200,
        child: Text('parent value:$count2'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: value.increment,
      ),
    );
  }
}


class CounterContainer extends InheritedWidget {
  int count = 0;

  static CounterContainer of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterContainer>();
  }

  CounterContainer(this.count, {Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(CounterContainer oldWidget) {
    return oldWidget.count != this.count;
  }
}

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var count2 = CounterContainer.of(context).count;
    return Container(
      width: 200,
      height: 200,
      child: Text('parent value:$count2'),
    );
  }
}
