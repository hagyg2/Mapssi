import 'package:flutter/material.dart';
import 'package:mapssi/screens/character_screen.dart';

void main() {
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
      home: const MyPageView(),
    );
  }
}

// 날씨 페이지 - 지원
class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("1"),
      ),
    );
  }
}

// 페이지 좌우 슬라이드로 넘기는 기능
class MyPageView extends StatelessWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index==0) { // 날씨 관련 페이지 출력
            return const WeatherPage();
          }
          else { //캐릭터 관련 페이지 출력
            return const CharacterPage();
          }
        },
        itemCount: 2,
      ),
    );
  }
}