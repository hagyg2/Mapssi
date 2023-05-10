import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mapssi/weather_screen.dart';

import '../my_location.dart';
import '../network.dart';
import '../weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}



class _LoadingState extends State<LoadingScreen> {
  String? baseTime;
  String? baseDate;
  String? baseDate_2am;
  String? baseTime_2am;
  String? currentBaseTime; //초단기 실황
  String? currentBaseDate;
  String? sswBaseTime; //초단기 예보
  String? sswBaseDate;

  int? xCoordinate;
  int? yCoordinate;
  double? userLati;
  double? userLongi;

  var now = DateTime.now();

  void initState(){
    super.initState();
    getLocation();
  }

  //오늘 날짜 20201109 형태로 리턴
  String getSystemTime(){
    return DateFormat("yyyyMMdd").format(now);
  }

  //어제 날짜 20201109 형태로 리턴
  String getYesterdayDate(){
    return DateFormat("yyyyMMdd").format(DateTime.now().subtract(Duration(days:1)));
  }

  void getLocation() async{
    MyLocation userLocation = MyLocation();
    await userLocation.getMyCurrentLocation(); //사용자의 현재 위치 불러올 때까지 대기

    xCoordinate = userLocation.currentX;  //x좌표
    yCoordinate = userLocation.currentY;  //y좌표

    userLati = userLocation.latitude2;
    userLongi = userLocation.longitude2
    ;

    var tm_x;
    var tm_y;

    var obsJson;
    var obs;

    print(xCoordinate);
    print(yCoordinate);



    //단기 예보 데이터
    String shortWeather = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?'
        'serviceKey=$apiKey&numOfRows=1000&pageNo=1&'
        'base_date=$baseDate&base_time=$baseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';


    //현재 날씨
    String currentWeather = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?'
        'serviceKey=$apiKey&numOfRows=10&pageNo=1&'
        'base_date=$currentBaseDate&base_time=$currentBaseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';


    //장기 예보
    String longWeather = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst'
        '?serviceKey=$apiKey&numOfRows=60&pageNo=1'
        '&base_date=$sswBaseDate&base_time=$sswBaseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';

    Network network = Network(currentWeather, shortWeather, longWeather);


    // json 데이터
    var currentWeatherData = await network.getCurrentWeatherJson();
    var shortWeatherData = await network.getShortWeatherJson();
    var longWeatherData = await network. getLongWeatherJson();
    // var todayWeatherData = await network.getTodayWeatherJson();
    //  var airConditionData = await network.getAirConditionData();
    //  var addrData = jsonDecode(addr);

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(
        parseShortWeatherData: shortWeatherData,
        parseCurrentWeatherData: currentWeatherData,
        parseLongWeatherData: longWeatherData,
        //   parseAirConditionData: airConditionData,

      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
// TODO Implement this library.