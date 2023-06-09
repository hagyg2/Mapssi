import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';


import 'package:mapssi/personal_info.dart';
import 'package:mapssi/screens/character_screen.dart';
import 'package:mapssi/screens/splash_screen.dart';
import 'package:mapssi/screens/weather_screen.dart';

import 'screens/login_screen.dart';

void main() {
  KakaoSdk.init(nativeAppKey: 'b6a83e342196f95f61957acfbefd9974');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(UserDataFromServer());
    return MaterialApp(
      theme: ThemeData(
          sliderTheme: const SliderThemeData(
            valueIndicatorColor: Colors.black,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
            trackHeight: 12.0,
            thumbColor: Colors.white,
          )
      ),

      home: MyPageView(),
      routes: {
        '/index': (context) => MyPageView(),
        '/login': (context) => LoginScreen(),
        '/splash': (context) => SplashScreen(),
        '/perinfo': (context) => PersonalInfoState(),
      },
      initialRoute: '/splash',

    );
  }
}


// 모든 화면에서 유저 정보를 공유하기 위한 클래스 (GetxController 상속 받음)
class UserDataFromServer extends GetxController{
  // 각 변수들 초기화

  String? _id = "gildong22"; // 유저 고유 아이디
  String? _name = "홍길동"; // 이름
  int? _gender = 0; // 성별
  String? _perCol = ""; // 퍼스널컬러
  String? _prefType = ""; // 선호 타입

  setUserId(String? s){
    _id = s;
  }
  setUserName(String? s){
    _name = s;
  }
  setUserGender(int? n){
    _gender = n;
  }

  setUserPerCol(String? s){
    _perCol = s;
  }
  setUserPrefType(String? s){
    _prefType = s;
  }
  getUserId(){
    return _id;
  }
  getUserName(){
    return _name;
  }
  getUserGender(){
    return _gender;
  }
  getUserPerCol(){
    return _perCol;
  }
  getUserPrefType(){
    return _prefType;
  }
}


// 모든 화면에서 날씨 정보를 공유하기 위한 클래스 (GetxController 상속 받음)
class WeatherJasonData extends GetxController{
  // 각 변수들 초기화
  int? cT = 0; // 현재 기온
  int? mxT = 100; // 최고 기온
  int? mnT = -100; // 최저 기온
  String? ctDo = "서울특별시"; // 현재 도시
  String? ctSi = "강남구"; // 현재 도시
  int? cCondition = 0;
  double? ctRain = 0.0;
  double? ctDust = 0.0;
  String? ctDes = "비";
  List? forecastInfo = [];
  List? weeklyForecast =[];

  updateData(int? currentTemperature, int? maxTemperature, int? minTemperature,
      String? addresNameDo, String? addresNameSi, int? condition,
      double? currentRainFall, double? airDust, String? koreanDes, List? weatherList, List? dailyForecasts){
    cT = currentTemperature;
    mxT = maxTemperature;
    mnT = minTemperature;
    ctDo = addresNameDo;
    ctSi = addresNameSi;
    cCondition = condition;
    ctRain = currentRainFall;
    ctDust = airDust;
    ctDes = koreanDes;
    forecastInfo = weatherList;
    weeklyForecast = dailyForecasts;

  }

  getData(){
    return [cT, mxT, mnT, ctDo, ctSi, cCondition, ctRain, ctDust, ctDes, forecastInfo, weeklyForecast];
  }
}


// 페이지 좌우 슬라이드로 넘기는 기능
class MyPageView extends StatelessWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WeatherJasonData());
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index==0) { // 날씨 관련 페이지 출력
            return WeatherScreen();
          } else { //캐릭터 관련 페이지 출력
            return const CharacterPage();
          }
        },
        itemCount: 2,
      ),
    );
  }
}
