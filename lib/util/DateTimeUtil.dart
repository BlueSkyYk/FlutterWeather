class DateTimeUtil {
  /**
   * 获取月和日（MM/dd）
   */
  static String getMDDate(String yymmdd) {
    yymmdd = yymmdd.replaceAll("/", "-");
    var dateTime = DateTime.parse(yymmdd);
    int month = dateTime.month;
    int day = dateTime.day;
    String strMonth = month < 10 ? "0${month}" : "${month}";
    String strDay = day < 10 ? "0${day}" : "${day}";
    return "${strMonth}/${strDay}";
  }

  /**
   * 获取昨天DateTime
   */
  static DateTime getYesterday() {
    DateTime today = DateTime.now();
    int yesMill = today.millisecondsSinceEpoch - (24 * 60 * 60 * 1000);
    DateTime yes = DateTime.fromMillisecondsSinceEpoch(yesMill);
    return yes;
  }

  /**
   * 通过weekDay获取中文星期几
   */
  static String getWeekString(int weekDay) {
    switch (weekDay) {
      case DateTime.monday:
        return "星期一";
        break;
      case DateTime.tuesday:
        return "星期二";
        break;
      case DateTime.wednesday:
        return "星期三";
        break;
      case DateTime.thursday:
        return "星期四";
        break;
      case DateTime.friday:
        return "星期五";
        break;
      case DateTime.saturday:
        return "星期六";
        break;
      case DateTime.sunday:
        return "星期日";
        break;
      default:
        return "错误";
        break;
    }
  }
}
