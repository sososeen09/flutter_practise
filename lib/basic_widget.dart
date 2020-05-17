import 'package:flutter/material.dart';

/**
 * 经典控件
 * Text
 * TextSpan
 * Image
 * Button
 */
class ClassicWidgetPage extends StatelessWidget {
  TextStyle blackStyle = TextStyle(
      fontWeight: FontWeight.normal, fontSize: 20, color: Colors.black); // 黑色样式

  TextStyle redStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red); // 红色样式
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('经典控件'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                '文本是视图系统中的常见控件，用来显示一段特定样式的字符串，就比如 Android 里的 TextView，或是 iOS 中的 UILabel。',
                textAlign: TextAlign.center, // 居中显示
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.red), //20 号红色粗体展示
              ),
              Text.rich(
                  TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: '文本是视图系统中常见的控件，它用来显示一段特定样式的字符串，类似',
                        style: redStyle),
                    // 第 1 个片段，红色样式
                    TextSpan(text: 'Android', style: blackStyle),
                    // 第 1 个片段，黑色样式
                    TextSpan(text: '中的', style: redStyle),
                    // 第 1 个片段，红色样式
                    TextSpan(text: 'TextView', style: blackStyle)
                    // 第 1 个片段，黑色样式
                  ]),
                  textAlign: TextAlign.center),
              FadeInImage.assetNetwork(
                placeholder: 'images/loading.png',
                image:
                    'https://avatars0.githubusercontent.com/u/16533524?s=460&v=4',
                width: 200,
                height: 200,
              ),
              FloatingActionButton(
                onPressed: () => print('FloatingActionButton pressed'),
                child: Text('Btn'),
              ),
              FlatButton(
                onPressed: () => print('FlatButton pressed'),
                child: Text('Btn'),
              ),
              RaisedButton(
                onPressed: () => print('RaisedButton pressed'),
                child: Text('Btn'),
              ),
              Badges(),

              //1. 监听 onTap 事件不会被识别，因为按钮有默认的点击监听事件，监听到点击事件后，不会再向上冒泡。
              //2. 监听的是 onDoubleTap 事件会被识别，因为按钮没有默认的双击监听事件。
              GestureDetector(
                onTap: (){
                  print("container: onTap");
                },

                onDoubleTap: (){
                  print("container: onDoubleTap");
                },
                child: Container(width: 200, height: 200,
                  color: Colors.red,
                  child: FlatButton(
                    child: Text('子 widget'),
                    onPressed: (){
                      print("child: onPressed");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Badges extends StatefulWidget {
  final Color badgeColor;
  final Widget child;
  final bool showBadge;

  Badges({Key key, this.badgeColor, this.child, this.showBadge})
      : super(key: key);

  @override
  _BadgesState createState() {
    return _BadgesState();
  }
}

class _BadgesState extends State<Badges> {
  num counter = 200;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        new IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              setState(() {
                counter = 0;
              });
            }),
        counter != 0
            ? new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$counter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : new Container()
      ],
    );
  }
}

class TextFieldAndFormPage extends StatefulWidget {
  @override
  _TextFieldAndFormPageState createState() {
    return _TextFieldAndFormPageState();
  }
}

class _TextFieldAndFormPageState extends State<TextFieldAndFormPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _selectionController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _unameController.addListener(() {
      print("onChanged Controler: ${_unameController.text}");
    });

    _selectionController.text = "hello World";
    _selectionController.selection = TextSelection(
        baseOffset: 2, extentOffset: _selectionController.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TextField And Form"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                  hintText: "用户名或邮箱",
                  labelText: "用户名",
                  prefixIcon: Icon(Icons.person)),
              controller: _unameController,
              onChanged: (v) {
                print("onChanged: $v");
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)),
            ),
            TextField(
              controller: _selectionController,
              decoration:
                  InputDecoration(counterStyle: TextStyle(color: Colors.red)),
            ),
            Theme(
                data: Theme.of(context).copyWith(
                    hintColor: Colors.grey[200],
                    inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(color: Colors.grey),
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 14.0))),
                child: Column(
                  children: <Widget>[
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "用户名或邮箱",
                          labelText: "用户名",
                          prefixIcon: Icon(Icons.person)),
                      controller: _unameController,
                      onChanged: (v) {
                        print("onChanged: $v");
                      },
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "密码",
                          hintText: "您的登录密码",
                          prefixIcon: Icon(Icons.lock),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 13.0),
                          border: InputBorder.none), //隐藏下划线
                    )
                  ],
                )),
            RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TextFieldFocus()));
                },
                child: Text("焦点控制"))
          ],
        ),
      ),
    );
  }
}

class TextFieldFocus extends StatelessWidget {
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    focusNode1.addListener(() {
      print("input1 focus: ${focusNode1.hasFocus}");
    });
    focusNode2.addListener(() {
      print("input2 focus: ${focusNode2.hasFocus}");
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("TextField 焦点控制"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
                autofocus: true,
                focusNode: focusNode1,
                decoration: InputDecoration(labelText: "input1")),
            TextField(
                focusNode: focusNode2,
                decoration: InputDecoration(labelText: "input2")),
            Builder(builder: (context) {
              return Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      //将焦点从第一个TextField移到第二个TextField
                      // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                      // 这是第二种写法
                      if (null == focusScopeNode) {
                        focusScopeNode = FocusScope.of(context);
                      }

                      focusScopeNode.requestFocus(focusNode2);
                    },
                    child: Text("移动焦点"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                    child: Text("隐藏键盘"),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
