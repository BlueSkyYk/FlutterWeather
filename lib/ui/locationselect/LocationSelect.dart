import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_app/entity/CityEntity.dart';
import 'package:my_app/manager/WeatherManager.dart';

class LocationSelectPage extends StatefulWidget {
  @override
  _LocationSelectPageState createState() => _LocationSelectPageState();
}

class _LocationSelectPageState extends State<LocationSelectPage> {
  TextEditingController _controller = TextEditingController();
  List<CityEntity> _allCityList = List();
  List<CityEntity> _currCityList = List();
  bool _showBack = false;
  int _lastPId = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("城市选择"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0, 2, 8, 2),
                  hintText: "城市名称",
                  border: OutlineInputBorder(gapPadding: 0),
                  prefixIcon: Icon(Icons.search),
                ),
                style: TextStyle(fontSize: 16),
                onChanged: (text) {},
              ),
            ),
            Expanded(
              child: _createCityListView(_currCityList),
            )
          ],
        ));
  }

  void _loadData() async {
    String json = await DefaultAssetBundle.of(context)
        .loadString("assets/json/_city.json");
    List list = jsonDecode(json);
    list = list.map((map) => CityEntity.fromJson(map)).toList();
    setState(() {
      _allCityList = list;
      _lastPId = 0;
      _updateCityList(null);
    });
  }

  //更新城市列表信息
  void _updateCityList(CityEntity city) {
    int pId = city == null ? 0 : city.id;
    List<CityEntity> cityList = List();
    for (var value in _allCityList) {
      if (value.pid == pId) {
        cityList.add(value);
      }
    }
    if (cityList.isNotEmpty) {
      setState(() {
        _showBack = (pId == 0);
        _currCityList = cityList;
        _lastPId = city == null ? 0 : city.pid;
      });
    } else {
      if (city != null) {
        WeatherManager.instance.saveCityInfo(city.cityName, city.cityCode);
        Navigator.pop(context, city);
      }
    }
  }

  //返回上一级城市
  void _onBack() {
    if (_lastPId == 0) {
      _updateCityList(null);
    } else {
      for (var value in _allCityList) {
        if (value.id == _lastPId) {
          _updateCityList(value);
          break;
        }
      }
    }
  }

  //创建城市列表
  SingleChildScrollView _createCityListView(List<CityEntity> cityList) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Offstage(
            offstage: _showBack,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Row(
                  children: <Widget>[Icon(Icons.arrow_back_ios), Text("返回")],
                ),
              ),
              onTap: _onBack, //返回上一级
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cityList.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: 1,
                    color: Colors.black12);
              },
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      cityList[index].cityName,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  onTap: () {
                    _updateCityList(cityList[index]);
                  },
                  onLongPress: () {},
                );
              })
        ],
      ),
    );
  }
}
