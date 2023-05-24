//사용자 위치정보를 받아오는 화면인데
//로그인 화면에 위치정보를 같이 받아서
//바로 날씨 화면으로 넘길 예정입니당

//import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:get/get.dart';
import 'package:mapssi/network.dart';
import 'package:mapssi/screens/weather_screen.dart';
//import 'package:mapssi/main.dart';
import 'login_screen.dart';
import '../my_location.dart';
// const apiKey = "122328b0a95baa0ce0c0a7697d3a30c7";
//   const apiKey = "TKPlhIHeHlFWyt%2B%2F1ghOEDHuZF3F8WxzyLC7rgIQeFfH6w1IBpgssS9%2B7ft16xHXJFCM5CbCWhaYsgrqtbpGUA%3D%3D";
//     Network network = Network('http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0 /weather?lat=$latitude3&lon=$longtitude3&appid=$apiKey&units=metric');

const apiKey = "TKPlhIHeHlFWyt%2B%2F1ghOEDHuZF3F8WxzyLC7rgIQeFfH6w1IBpgssS9%2B7ft16xHXJFCM5CbCWhaYsgrqtbpGUA%3D%3D";


class Loading extends StatefulWidget{
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>{
  var now = DateTime.now(); //시간,날짜,요일 가져오기

  double? latitude3;
  double? longtitude3;

  int? currentTemperature;
  int? maxTemperature;
  int? minTemperature;

  String? baseDate; //발표일자
  String? baseTime; //발표시각

  //최고최저 기온 가져올 변수
  String? baseDate_2am;
  String? baseTime_2am;

  String? currentBaseTime; //초단기 실황
  String? currentBaseDate;
  String? sWeatherBaseTime; //초단기 예보
  String? sWeatherBaseDate;

  int? xCoordinate;
  int? yCoordinate; //좌표(기상청 api)
  double? userLati2;
  double? userLongi2; //사용자 위경도(geolocator)

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  //오늘 날짜 20000406 형태로 리턴
  String getSystemTime() {
    return DateFormat("yyyy-MM-dd").format(now);
  }

  //어제 날짜 20000405 형태로 리턴
  String getYesterdayDate() {
    return DateFormat("yyyy-MM-dd").format(
        DateTime.now().subtract(Duration(days: 1)));
  }

  //사용자 위치 불러오기 -위경도 값
  void getLocation() async{
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();

    xCoordinate = myLocation.currentX;
    yCoordinate = myLocation.currentY;
    userLati2 = myLocation.userlati;
    userLongi2 = myLocation.userlongi;
    //if (!Platform.isAndroid && !Platform.isIOS) //나중에 개발환경 확인
        {
      xCoordinate = 55;
      yCoordinate = 127;
    }

    print("x좌표 값$xCoordinate");
    print("y좌표 값$yCoordinate");

    currentWeatherDate();
    String currentWeather = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=$apiKey&numOfRows=10&pageNo=1&base_date=$currentBaseDate&base_time=$currentBaseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';

    // network.dart 에서 getJsonData()불러오기 위해 network인스턴스 생성
    Network network = Network(currentWeather);
    var currentWeatherData = network.getCurrentWeatherData();
    print(currentWeatherData);

    //weatherScreen으로 출력
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(
          parseCurrentWeatherData: currentWeatherData
      );
    }));
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          SignInWithGoogle.signOut();
          Navigator.pop(context);
        }, icon: Icon(Icons.login))],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getLocation(); //사용자 위치 불러오기
          },
          child: Text(
            '로그인 되면 날씨 페이지 ㄱㄱ',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),

    );
  }


  void currentWeatherDate() {
    //40분 이전이면 현재 시보다 1시간 전 `base_time`을 요청한다.
    if (now.minute <= 40){

      // 단. 00:40분 이전이라면 `base_date`는 전날이고 `base_time`은 2300이다.
      if (now.hour == 0) {
        currentBaseDate = DateFormat('yyyyMMdd').format(now.subtract(Duration(days:1)));
        currentBaseTime = '2300';
      } else {
        currentBaseDate = DateFormat('yyyyMMdd').format(now);
        currentBaseTime = DateFormat('HH00').format(now.subtract(Duration(hours:1)));
      }
    }
    //40분 이후면 현재 시와 같은 `base_time`을 요청한다.
    else{
      currentBaseDate = DateFormat('yyyyMMdd').format(now);
      currentBaseTime = DateFormat('HH00').format(now);
    }
  }




}
