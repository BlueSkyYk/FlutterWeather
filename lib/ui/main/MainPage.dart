import 'package:flutter/material.dart';
import 'package:my_app/ui/find/FindPage.dart';
import 'package:my_app/ui/home/HomePage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const List<String> _tabTitle = ["主页", "发现"];
  static const List<IconData> _tabIconData = [Icons.home, Icons.find_in_page];
  static List<Widget> _tabPage = [HomePage(), FindPage()];

  //当前索引
  int _currIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主页"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: Text(_tabTitle[0]), icon: Icon(_tabIconData[1])),
          BottomNavigationBarItem(
              title: Text(_tabTitle[1]), icon: Icon(_tabIconData[1]))
        ],
        onTap: (index) {
          setState(() {
            _currIndex = index;
          });
        },
      ),
      body: _tabPage[_currIndex],
    );
  }
}
