import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:my_app/entity/CityEntity.dart';
import 'package:my_app/entity/WeatherEntity.dart';
import 'package:my_app/http/api/WeatherApi.dart';
import 'package:my_app/manager/WeatherManager.dart';
import 'package:my_app/ui/locationselect/LocationSelect.dart';
import 'package:my_app/util/DateTimeUtil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _cityName = "成都";
  String _cityCode = "101270101";

  //天气信息
  Weather _weather;

  //当前温度
  String _currWenDu = "20";

  //当前湿度
  String _currShiDu = "20%";

  //空气质量
  String _quality = "优";

  //建议
  String _suggest = "";

  //最近几日的天气
  List<WeatherDataForecast> _weatherDataList;

  //昨天天气
  WeatherDataForecast _yesterdayData;

  //数据数量
  int _dataSize = 0;

  _HomePageState() : super() {}

  @override
  void initState() {
    super.initState();
    WeatherManager.instance.getCityInfo((String cityName, String cityCode) {
      setState(() {
        _cityName = cityName;
        _cityCode = cityCode;
        //更新天气信息
        _updateWeatherInfo();
      });
    });
  }

  //更新天气信息
  void _updateWeatherInfo() {
    //获取天气情况
    WeatherManager.instance.getWeather(_cityCode, (result) {
      _weather = result;
      if (_weather != null) {
        setState(() {
          _currWenDu = _weather.data.wendu;
          _currShiDu = _weather.data.shidu;
          _quality = _weather.data.quality;
          _suggest = _weather.data.ganmao;
          _weatherDataList = _weather.data.forecast;
          _yesterdayData = _weather.data.yesterday;
          _dataSize = _weather.data.forecast.length;
        });
      }
    }, (errCode, errMsg) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text(
                      _currWenDu,
                      style: TextStyle(fontSize: 100),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Column(
                      // 垂直方向排列方式
                      mainAxisAlignment: MainAxisAlignment.start,
                      // 水平方向排列方式
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[
                        Container(
                          height: 46,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                child: Text(
                                  "°",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 60),
                                ),
                              ),
                              Container(
                                width: 178,
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.my_location),
                                        Container(
                                          child: Text(
                                            _cityName,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: _selectCity),
                              ),
                            ],
                          ),
                        ),
                        Text("空气质量：${_quality}"),
                        Text("湿度：${_currShiDu}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                "提示：$_suggest",
                style: TextStyle(fontSize: 12),
              ),
            ),
            Container(
              height: 1,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              color: Colors.black12,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "昨天",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 12, color: Colors.cyan),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  ),
                  _getWeatherItem(_yesterdayData),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _dataSize,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _getWeatherItem(_weatherDataList[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  //选择城市
  void _selectCity() async {
    CityEntity city = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => LocationSelectPage()));
    if (city != null) {
      setState(() {
        _cityName = city.cityName;
        _cityCode = city.cityCode;
        _updateWeatherInfo();
      });
    }
  }

  String getDate(String ymd) {
    String date = DateTimeUtil.getMDDate(ymd);
    String now = DateTimeUtil.getMDDate(DateTime.now().toIso8601String());
    if (now == date) {
      return "今天";
    } else {
      return date;
    }
  }

  //呼气天气Item
  Widget _getWeatherItem(WeatherDataForecast weatherData) {
    DateTime yes = DateTimeUtil.getYesterday();
    String date = DateTimeUtil.getMDDate(yes.toIso8601String());
    String week = DateTimeUtil.getWeekString(DateTime.now().weekday);
    bool isToday = false;
    String wendu = "低温 - 高温";
    String type = "";
    if (weatherData != null) {
      date = getDate(weatherData.ymd);
      isToday = "今天" == date ? true : false;
      wendu = "${weatherData.low} - ${weatherData.high}";
      wendu = wendu.replaceAll("低温", "").replaceAll("高温", "");
      week = isToday ? "今天    " : weatherData.week;
      type = weatherData.type;
    }
    return Container(
      padding: EdgeInsets.fromLTRB(20, 6, 20, 6),
      child: Row(
        children: <Widget>[
          Text(
            week,
            style: TextStyle(
                fontSize: 16, color: isToday ? Colors.red : Colors.black),
          ),
          Container(
            height: 19,
            width: 38,
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
            child: Text(
              date,
              style: TextStyle(
                  fontSize: 12, color: isToday ? Colors.red : Colors.black),
            ),
          ),
          Expanded(
            child: Container(
                height: 18,
                child: Text(
                  type,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: isToday ? Colors.red : Colors.black),
                )),
          ),
          Text(
            wendu,
            style: TextStyle(
                color: isToday ? Colors.red : Colors.black, fontSize: 12),
          )
        ],
      ),
    );
  }
}
