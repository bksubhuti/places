import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart' as intl;
import 'package:solar_calculator/solar_calculator.dart';


class WorldTime {
  late String location;
  late String time; // time in that location
  late String flag; // url to flag asset
  late String shorturl; // url to call location for api endpoint
  late bool isDayTime;
  late double latitude = 41.387048;
  late double longitude = 2.17413425;
  late Instant instant;
  late SolarCalculator calc;
  late String solarNoon = 'not set';
  late bool initialized = false;

  WorldTime(
      {required this.location, required this.flag, required this.shorturl}) {
    location = location;
    flag = flag;
    shorturl = shorturl;
    time = 'yo';

    instant =
        Instant(year: 2021, month: 7, day: 23, hour: 14, timeZoneOffset: 2.0);
    calc = SolarCalculator(instant, latitude, longitude);
    // solarNoon = calc.sunTransitTime as String;
    print('Solar Noon: ${calc.sunTransitTime}');
  }

  Future<void> getCities() async {
    try {
      var url = Uri.parse('http://worldtimeapi.org/api/timezone/$shorturl');
      http.Response response = await http.get(url);
      Map data = jsonDecode(response.body);

      // get the data properties
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = (now.hour > 6 && now.hour < 20) ? true : false;
      // set the time property
      time = 'test'; //      intl.DateFormat.jm().format(now);
    }
    //try
    catch (e) {
      print('error $e');
      //time = "could not set time";
    }
  }
}
