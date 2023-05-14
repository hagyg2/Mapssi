//사용자 위치정보를 받아오는 화면인데
//로그인 화면에 위치정보를 같이 받아서
//바로 날씨 화면으로 넘길 예정입니당

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapssi/network.dart';
import 'package:mapssi/screens/weather_screen.dart';
import '../my_location.dart';
const apiKey = "122328b0a95baa0ce0c0a7697d3a30c7";

class Loading extends StatefulWidget{
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>{

  double? latitude3;
  double? longtitude3;

  @override
  void initStae() {
    super.initState();
    getLocation();
  }

  //사용자 위치 불러오기 -위경도 값
  void getLocation() async{
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longtitude3 = myLocation.longtitude2;
    print(latitude3);
    print(longtitude3);

    // network.dart 에서 getJsonData()불러오기 위해 network인스턴스 생성
    Network network = Network('https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longtitude3&appid=$apiKey&units=metric');

    // network.dart에서 파싱된 json data를 출력해주기 위해 weatherData 변수에 getJsonData()의 값을 할당
    var weatherData = await network.getJsonData();
    print(weatherData);

    //생성된 위치 기반 날씨 정보를 weatehr_page으로 넘김
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}