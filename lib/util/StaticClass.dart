import 'package:shared_preferences/shared_preferences.dart';

/**
 * 获取SharedPreferences
 */
Future<SharedPreferences> getSharedPreferences() =>
    SharedPreferences.getInstance();
