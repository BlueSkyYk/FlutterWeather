import 'package:flutter/material.dart';
import 'package:my_app/ui/login/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static BuildContext context;

  @override
  Widget build(BuildContext context) {
    MyApp.context = context;
    return MaterialApp(
      title: '我的APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
