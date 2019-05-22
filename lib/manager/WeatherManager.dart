import 'dart:convert';
import 'dart:math';

import 'package:my_app/entity/WeatherEntity.dart';
import 'package:my_app/http/api/WeatherApi.dart';
import 'package:my_app/util/HttpUtil.dart';
import 'package:my_app/util/StaticClass.dart';
import 'package:quiver/strings.dart';

class WeatherManager {
  static WeatherManager _instance;

  static WeatherManager get instance => _getInstance();

  factory WeatherManager() => _getInstance();

  static WeatherManager _getInstance() {
    if (_instance == null) {
      _instance = WeatherManager._internal();
    }
    return _instance;
  }

  WeatherManager._internal();

  //天气信息
  static String _KEY_WEATHER = "weather";

  static String _CITY_NAME = "city_name";
  static String _CITY_CODE = "city_code";

  //更新时间间隔，单位：秒
  static const int _UPDATE_TIME = 120;

  /**
   * 获取天气信息
   */
  void getWeather(
      String cityCode, HttpSuccess<Weather> success, HttpFail fail) {
    var sp = getSharedPreferences();
    sp.then((instance) {
      String json = instance.get(_KEY_WEATHER);
      if (!isEmpty(json)) {
        Map map = jsonDecode(json);
        Weather weather = Weather.fromJson(map["weather"]);
        var lastTime = map["time"];
        var nowTime = DateTime.now().millisecondsSinceEpoch;
        //超时，需要重新请求数据
        if ((nowTime - lastTime) / 1000 > _UPDATE_TIME ||
            cityCode != weather.cityInfo.cityId) {
          //从网络获取天气信息
          _getWeatherByNet(cityCode, (weather) {
            Map<String, dynamic> map = {
              "time": DateTime.now().millisecondsSinceEpoch,
              "weather": weather
            };
            //保存Json到本地
            instance.setString(_KEY_WEATHER, jsonEncode(map));
            //回调
            success(weather);
          }, fail);
        } else {
          //回调
          success(weather);
        }
      } else {
        //从网络获取天气信息
        _getWeatherByNet(cityCode, (weather) {
          Map<String, dynamic> map = {
            "time": DateTime.now().millisecondsSinceEpoch,
            "weather": weather
          };
          //保存Json到本地
          instance.setString(_KEY_WEATHER, jsonEncode(map));
          //回调
          success(weather);
        }, fail);
      }
    });
  }

  void _getWeatherByNet(
      String cityCode, HttpSuccess<Weather> success, HttpFail fail) {
    //从网络获取天气信息
    WeatherApi.getWeather(cityCode, (weather) {
      success(weather);
    }, fail);
  }

  //获取城市信息
  void getCityInfo(CallbackCityInfo callback) {
    getSharedPreferences().then((instance) {
      String cityName = instance.getString(_CITY_NAME);
      String cityCode = instance.getString(_CITY_CODE);
      if (isEmpty(cityName) || isEmpty(cityCode)) {
        callback("成都", "101270101");
      } else {
        callback(cityName, cityCode);
      }
    });
  }

  //保存城市信息
  void saveCityInfo(String cityName, String cityCode) {
    getSharedPreferences().then((instance) {
      instance.setString(_CITY_NAME, cityName);
      instance.setString(_CITY_CODE, cityCode);
    });
  }
}

typedef CallbackCityInfo = Function(String cityName, String cityCode);
