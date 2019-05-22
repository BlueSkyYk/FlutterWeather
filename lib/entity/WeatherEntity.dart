class Weather {
  String date;
  WeatherData data;
  WeatherCity cityInfo;
  String time;
  String message;
  int status;

  Weather(
      {this.date,
      this.data,
      this.cityInfo,
      this.time,
      this.message,
      this.status});

  Weather.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    data = json['data'] != null ? new WeatherData.fromJson(json['data']) : null;
    cityInfo = json['cityInfo'] != null
        ? new WeatherCity.fromJson(json['cityInfo'])
        : null;
    time = json['time'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.cityInfo != null) {
      data['cityInfo'] = this.cityInfo.toJson();
    }
    data['time'] = this.time;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class WeatherData {
  String shidu;
  WeatherDataForecast yesterday;
  double pm25;
  double pm10;
  String ganmao;
  List<WeatherDataForecast> forecast;
  String wendu;
  String quality;

  WeatherData(
      {this.shidu,
      this.yesterday,
      this.pm25,
      this.pm10,
      this.ganmao,
      this.forecast,
      this.wendu,
      this.quality});

  WeatherData.fromJson(Map<String, dynamic> json) {
    shidu = json['shidu'];
    yesterday = json['yesterday'] != null
        ? new WeatherDataForecast.fromJson(json['yesterday'])
        : null;
    pm25 = json['pm25'];
    pm10 = json['pm10'];
    ganmao = json['ganmao'];
    if (json['forecast'] != null) {
      forecast = new List<WeatherDataForecast>();
      (json['forecast'] as List).forEach((v) {
        forecast.add(new WeatherDataForecast.fromJson(v));
      });
    }
    wendu = json['wendu'];
    quality = json['quality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shidu'] = this.shidu;
    if (this.yesterday != null) {
      data['yesterday'] = this.yesterday.toJson();
    }
    data['pm25'] = this.pm25;
    data['pm10'] = this.pm10;
    data['ganmao'] = this.ganmao;
    if (this.forecast != null) {
      data['forecast'] = this.forecast.map((v) => v.toJson()).toList();
    }
    data['wendu'] = this.wendu;
    data['quality'] = this.quality;
    return data;
  }
}

class WeatherDataForecast {
  String date;
  String ymd;
  String sunrise;
  String high;
  String fx;
  String week;
  String low;
  String fl;
  String sunset;
  double aqi;
  String type;
  String notice;

  WeatherDataForecast(
      {this.date,
      this.ymd,
      this.sunrise,
      this.high,
      this.fx,
      this.week,
      this.low,
      this.fl,
      this.sunset,
      this.aqi,
      this.type,
      this.notice});

  WeatherDataForecast.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    ymd = json['ymd'];
    sunrise = json['sunrise'];
    high = json['high'];
    fx = json['fx'];
    week = json['week'];
    low = json['low'];
    fl = json['fl'];
    sunset = json['sunset'];
    aqi = json['aqi'];
    type = json['type'];
    notice = json['notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['ymd'] = this.ymd;
    data['sunrise'] = this.sunrise;
    data['high'] = this.high;
    data['fx'] = this.fx;
    data['week'] = this.week;
    data['low'] = this.low;
    data['fl'] = this.fl;
    data['sunset'] = this.sunset;
    data['aqi'] = this.aqi;
    data['type'] = this.type;
    data['notice'] = this.notice;
    return data;
  }
}

class WeatherCity {
  String parent;
  String city;
  String updateTime;
  String cityId;

  WeatherCity({this.parent, this.city, this.updateTime, this.cityId});

  WeatherCity.fromJson(Map<String, dynamic> json) {
    parent = json['parent'];
    city = json['city'];
    updateTime = json['updateTime'];
    cityId = json['cityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent'] = this.parent;
    data['city'] = this.city;
    data['updateTime'] = this.updateTime;
    data['cityId'] = this.cityId;
    return data;
  }
}
