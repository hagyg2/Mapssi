import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mapssi/screens/character_screen.dart';
import 'package:mapssi/screens/slpash_screen.dart';
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
    return MaterialApp(
      theme: ThemeData(
          sliderTheme: const SliderThemeData(
            valueIndicatorColor: Colors.black,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
            trackHeight: 12.0,
            thumbColor: Colors.white,
          )
      ),
      routes: {
        '/index': (context) => MyPageView(),
        '/login': (context) => LoginScreen(),
        '/splash': (context) => SplashScreen(),
      },
      initialRoute: '/splash',
    );
  }
}

// 모든 화면에서 날씨 정보를 공유하기 위한 클래스 (GetxController 상속 받음)
class WeatherJasonData extends GetxController{
  // 각 변수들 초기화
  int? cT = 0; // 현재 기온
  int? mxT = 100; // 최고 기온
  int? mnT = -100; // 최저 기온
  String? ctName = "Seoul"; // 현재 도시

  updateData(int? currentTemperature, int? maxTemperature, int? minTemperature, String? cityName){
    cT = currentTemperature;
    mxT = maxTemperature;
    mnT = minTemperature;
    ctName = cityName;
  }

  getData(){
    return [cT, mxT, mnT, ctName];
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