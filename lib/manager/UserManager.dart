import 'dart:async';
import 'dart:convert';

import 'package:my_app/entity/UserEntity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/util/StaticClass.dart';
import 'package:quiver/strings.dart';

/**
 * UserManager
 * 单例
 */
class UserManager {
  static UserManager _instance;

  static UserManager get instance => _getInstance();

  factory UserManager() => _getInstance();

  static UserManager _getInstance() {
    if (_instance == null) {
      _instance = UserManager._internal();
    }
    return _instance;
  }

  UserManager._internal();

  //数据Key
  final String _KEY_USER = "user";

  /**
   * 保存User到本地
   */
  saveUser(User user) {
    var sharedPreferences = getSharedPreferences();
    sharedPreferences.then((instance) {
      String userJson = json.encode(user);
      instance.setString(_KEY_USER, userJson);
    });
  }

  /**
   * 从本地获取User
   */
  void getUser(FutureOr callback(User value)) {
    var sharedPreferences = getSharedPreferences();
    sharedPreferences.then((instance) {
      String userJson = instance.get(_KEY_USER);
      if (!isEmpty(userJson)) {
        callback(User.fromJson(jsonDecode(userJson)));
      } else {
        callback(null);
      }
    });
  }
}
