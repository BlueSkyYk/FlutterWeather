import 'package:my_app/entity/WeatherEntity.dart';
import 'package:my_app/http/HttpConstant.dart';
import 'package:my_app/util/HttpUtil.dart';

/**
 * 获取天气预报信息
 */
class WeatherApi {
  WeatherApi._();

  /**
   * 获取天气信息
   */
  static void getWeather(
      String cityCode, HttpSuccess<Weather> success, HttpFail fail) {
    HttpUtil.getInstance().get(getWeatherUrl + cityCode, (Map map) {
      var result = Weather.fromJson(map);
      if (result.status == 200) {
        //获取数据成功
        success(result);
      } else {
        fail(result.status, result.message);
      }
    }, (errCode, errMsg) {
      fail(errCode, errMsg);
    });
  }
}
