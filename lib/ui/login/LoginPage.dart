import 'package:flutter/material.dart';
import 'package:my_app/entity/UserEntity.dart';
import 'package:my_app/manager/UserManager.dart';
import 'package:my_app/ui/main/MainPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controlAccount = TextEditingController();
  final TextEditingController controlPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("登录"),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Image.network(
                "http://p5.so.qhimgs1.com/sdr/400__/t015343baf551aaedab.png",
                width: 80,
                height: 80,
                fit: BoxFit.fill,
              ),
            ),
            getAccountInput(),
            getPasswordInput(),
            getLoginButton(),
          ],
        ),
      ),
    );
  }

  /**
   * 获取用户名输入框
   */
  Widget getAccountInput() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.account_circle),
          ),
          Expanded(
            child: TextField(
                maxLength: 15,
                maxLines: 1,
                controller: controlAccount,
                decoration: InputDecoration(hintText: "请输入用户名")),
          )
        ],
      ),
    );
  }

  /**
   * 获取密码输入框
   */
  Widget getPasswordInput() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.lock),
          ),
          Expanded(
            child: TextField(
              maxLength: 15,
              maxLines: 1,
              obscureText: true,
              controller: controlPassword,
              decoration: InputDecoration(hintText: "请输入密码"),
            ),
          )
        ],
      ),
    );
  }

  /**
   * 创建登录按钮
   */
  Widget getLoginButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
      child: RaisedButton(
        onPressed: doLogin,
        child: Text("登录"),
      ),
    );
  }

  /**
   * 登录
   */
  doLogin() {
    String account = controlAccount.text;
    String password = controlPassword.text;
    User user = User(account: account, password: password);
    user.name = "张三";
    UserManager.instance.saveUser(user);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
        (route) => route == null);
  }
}
