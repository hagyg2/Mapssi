//날씨 화면입니다

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'character_screen.dart';
import 'menu_bar_draw.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData});
  final dynamic parseWeatherData;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  String? cityName;
  int? currentTemp; //현재 온도
  int? tempTMN; //일 최저기온
  int? tempTMX; //일 최고기온

  var date = DateTime.now(); //오전오후/요일 표기


  //weatherScreen이 생성되는 순간, loading에서 추출한 정보를 바로 출력
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData);

    // updateData(widget.parseWeatherData);
  }


  void updateData(dynamic weatherData) {
    double currentTemp2 = weatherData['main']['temp'];
    currentTemp = currentTemp2.round();
    cityName = weatherData['name'];
    print(currentTemp);
    print(cityName);


    double tempMin2 = weatherData['main']['temp_min'];
    double tempMax2 = weatherData['main']['temp_max'];

    tempTMN = tempMin2.round();
    tempTMX = tempMax2.round();
    print(tempTMN);
    print(tempTMX);

  }

  String getCurrentTime() {
    var now = DateTime.now();
    return DateFormat("h:m a").format(now);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true, //appBar 꽉 차게
        appBar: AppBar(
          backgroundColor: Colors.pink,
          elevation: 0.0,
          //깊이감(그림자)
          title: Text('Mapssi-날씨 옷 코디'),
          centerTitle: true,
          // 앱바 가운데 정렬
          actions: [
            IconButton(icon: SvgPicture.asset("assets/icons/search.svg"),
              onPressed: () {print("search button is clicked");},
            ),
          ],
        ),

        drawer: const Drawer( //햄버거 바
          child: MenuBarDraw(),
        ),

        body: Container(
            child: Stack(
              children: [
              Image.asset('assets/image/background.jpg', fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,),
            SingleChildScrollView(
            child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100.0,),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center,
                          children: [
                            Text(
                              DateFormat(' d MMM (EEEE)').format(
                                  date), style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      TimerBuilder.periodic(Duration(minutes: 1),
                        builder: (context) {
                          print('${getCurrentTime()}');
                          return Text('${getCurrentTime()}',
                            style: TextStyle(fontSize: 16.0,
                                color: Colors.white),);
                        },
                      ),
                      SizedBox(height: 5,),
                      Text(('$cityName'), style: TextStyle(
                          fontSize: 35.9, color: Colors.white),),
                      SizedBox(height: 15.0,),
                      Text('$currentTemp°C', style: TextStyle(
                          fontSize: 45.0, color: Colors.white),),
                      SizedBox(height: 10.0,),
                      Text('$tempTMN°C / $tempTMX°C',
                        style: TextStyle(
                            fontSize: 20.0, color: Colors.white),)
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 80.0,),
                    SizedBox(height: 10.0,),
                    Text(('습도(%) $cityName'), style: TextStyle(
                        fontSize: 10.0, color: Colors.white),),
                    SizedBox(height: 5.0,),
                    Text(('1시간 강수량(mm) $cityName'),
                      style: TextStyle(
                          fontSize: 10.0, color: Colors.white),)
                  ],
                ),
              ),
            ]
        ),



