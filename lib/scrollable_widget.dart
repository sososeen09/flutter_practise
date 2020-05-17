import 'package:flutter/material.dart';

class ListViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("列表控件"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommonListView()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "普通ListView",
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
                            builder: (context) => HorizontalListViewPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "水平ListView",
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
                            builder: (context) => ListViewBuildPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "ListViewBuilder",
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
                            builder: (context) => CustomScrollViewPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "CustomScrollView",
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
                            builder: (context) => ScrollControllerPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0, top: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "ScrollControler",
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

class CommonListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("普通ListView"),
      ),
      body: Container(
        child: ListView(children: <Widget>[
          // 设置 ListTile 组件的标题与图标
          ListTile(leading: Icon(Icons.map), title: Text('Map')),
          ListTile(leading: Icon(Icons.mail), title: Text('Mail')),
          ListTile(leading: Icon(Icons.message), title: Text('Message')),
        ]),
      ),
    );
  }
}

class HorizontalListViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("水平 ListView"),
      ),
      body: Container(
        child: ListView(
            scrollDirection: Axis.horizontal,
            itemExtent: 140, //item 延展尺寸 (宽度)
            children: <Widget>[
              Container(color: Colors.black),
              Container(color: Colors.red),
              Container(color: Colors.blue),
              Container(color: Colors.green),
              Container(color: Colors.yellow),
              Container(color: Colors.orange),
            ]),
      ),
    );
  }
}

class ListViewBuildPage extends StatefulWidget {

  @override
  _ListViewBuildPageState createState() {
    return _ListViewBuildPageState();
  }
}

class _ListViewBuildPageState extends State<ListViewBuildPage>{
  List<int> list=[];
  @override
  void initState() {
    for (int i = 0; i < 50; i++) {
      list.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ListViewBuilder"),
        ),
        body: Container(
/*          child: ListView.builder(
              itemCount: 50,
              itemExtent: 50.0, // 列表项高度
              itemBuilder: (BuildContext context, int index) =>
                  _ListItem(index))),*/

            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) =>(GestureDetector(
                  child:  _ListItem(list[index]),
                  onLongPress: (){
                    print("onLongPress: $index");
                    list.removeAt(index);
                    setState(() {

                    });
                  },

                  onDoubleTap: (){
                    print("onDoubleTap: $index");
                    list.insert(0,index*10);
                    setState(() {

                    });
                  },
                )),

                separatorBuilder: (BuildContext context, int index) =>
                index % 2 == 0
                    ? Divider(color: Colors.green)
                    : Divider(color: Colors.red),
                itemCount: list.length)));
  }
}

class _ListItem extends StatelessWidget {
  final int _index;

  _ListItem(this._index) {
    print("create list item: $_index");
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("title: $_index"),
      subtitle: Text("body: $_index"),
    );
  }
}

class CustomScrollViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          //SliverAppBar 作为头图控件
          title: Text('CustomScrollView Demo'),
          // 标题
          floating: true,
          // 设置悬浮样式
          flexibleSpace: Image.network(
              "https://avatars0.githubusercontent.com/u/16533524?s=460&v=4",
              fit: BoxFit.cover),
          // 设置悬浮头图背景
          expandedHeight: 300, // 头图控件高度
        ),
        SliverList(
          //SliverList 作为列表控件
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(title: Text('Item #$index')),
            // 列表项创建方法
            childCount: 100, // 列表元素个数
          ),
        ),
      ]),
    );
  }
}

class ScrollControllerPage extends StatefulWidget {
  @override
  _ScrollControllerPageState createState() {
    return _ScrollControllerPageState();
  }
}

class _ScrollControllerPageState extends State<ScrollControllerPage> {
  ScrollController _controller;
  bool isToTop = false;

  List<int> list=[];
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset > 1000) {
        setState(() {
          isToTop = false;
        });
      } else {
        setState(() {
          isToTop = true;
        });
      }
    });
    for (int i = 0; i < 50; i++) {
      list.add(i);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ScrollControllerPage"),
        ),
        body: Column(
          children: <Widget>[
            // 顶部 Top 按钮，根据 isToTop 变量判断是否需要注册滚动到顶部的方法
            RaisedButton(
              onPressed: (isToTop
                  ? () {
                      if (isToTop) {
                        _controller.animateTo(.0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.ease); // 做一个滚动到顶部的动画
                      }
                    }
                  : null),
              child: Text("Top"),
            ),

            ListView.builder(
              controller: _controller, // 初始化传入控制器
              itemCount: list.length, // 列表元素总数
              itemExtent: 50, //item 延展尺寸 (宽度)
              itemBuilder: (BuildContext context, int index) =>GestureDetector(
                onLongPress: (){
                  print("onLongPress: $index");
                  list.removeAt(index);
                  setState(() {

                  });
                },
                child: _ListItem(index),
              ), // 列表项构造方法
            ),
          ],
        ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // 销毁控制器
    super.dispose();
  }
}
