//날씨 화면입니다

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'menu_bar_draw.dart';
import 'package:mapssi/network.dart';
import 'package:mapssi/main.dart';
import '../my_location.dart';
const apiKey = "122328b0a95baa0ce0c0a7697d3a30c7";

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  double? latitude3;
  double? longtitude3;

  int? currentTemperature;
  int? maxTemperature;
  int? minTemperature;
  String? cityName;

  var date = DateTime.now(); //오전오후/요일 표기


  //weatherScreen이 생성되는 순간 위치 정보 불러와서 날씨 정보 출력
  @override
  void initState() {
    // 최대 기온이 100도인 경우에만 initState실행 (처음 실행해서 위치 정보 불러온적 없을 때)
    if (Get.find<WeatherJasonData>().getData()[1]==100){
      super.initState();
      getLocation();
      updateData();
    }
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

    num currentTemperature2 = weatherData['main']['temp'];
    num maxTemperature2 = weatherData['main']['temp_max'];
    num minTemperature2 = weatherData['main']['temp_min'];

    setState(() { // 불러온 정보를 기반으로 화면 다시 빌드
      cityName = weatherData['name'];
      currentTemperature = currentTemperature2.round();
      maxTemperature = maxTemperature2.round();
      minTemperature = minTemperature2.round();
    });

    //생성된 위치 기반 날씨 정보를 character_page으로 넘김
    WeatherJasonData dataController = Get.find<WeatherJasonData>();
    dataController.updateData(currentTemperature, maxTemperature, minTemperature, cityName);
  }


  // 날씨 정보 업데이트
  void updateData() {
    print(currentTemperature);
    print(cityName);
    print(minTemperature);
    print(maxTemperature);
  }

  String getCurrentTime() {
    var now = DateTime.now();
    return DateFormat("h:m a").format(now);
  }



  @override
  Widget build(BuildContext context) {
    // 각 변수들 Get.find 써서 초기화
    currentTemperature = Get.find<WeatherJasonData>().getData()[0];
    maxTemperature = Get.find<WeatherJasonData>().getData()[1];
    minTemperature = Get.find<WeatherJasonData>().getData()[2];
    cityName = Get.find<WeatherJasonData>().getData()[3];
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
                                    Text('$currentTemperature°C', style: TextStyle(
                                        fontSize: 45.0, color: Colors.white),),
                                    SizedBox(height: 10.0,),
                                    Text('$minTemperature°C / $maxTemperature°C',
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


                      //중앙 부분
                      SizedBox(height: 20.0),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius
                                .circular(20), color: Colors.white),
                            padding: EdgeInsets.all(17.0),
                            height: 230.0,
                            width: 370.0,
                            child: Column(
                              children: [
                                Container(
                                  child: Text('시간대별 날씨', style: TextStyle(
                                      fontSize: 10.0, color: Colors.black)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    //현재
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(height: 10.0,),
                                          Container(
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceEvenly,
                                                children: [
                                                  //현재 아이콘
                                                  SvgPicture.asset(
                                                    'assets/weather_icon/humidity.svg',),
                                                  SizedBox(height: 10.0,),
                                                  Text('현재', style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black),),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/weather_icon/humidity.svg',
                                                        width: 30.0,
                                                        height: 30.0,),
                                                      Text('$currentTemperature°C',
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors
                                                                .black),),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10.0,),
                                                  Text('$currentTemperature°C',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black),),

                                                ]
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    //1시간 2시간 3시간 뒤(반복)
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(height: 10.0,),
                                          Container(
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  //다음날 아이콘
                                                  SvgPicture.asset(
                                                    'assets/weather_icon/humidity.svg',),
                                                  SizedBox(height: 10.0,),
                                                  Text('$currentTemperature°C',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.white),),
                                                  SizedBox(height: 10.0,),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/weather_icon/humidity.svg',
                                                        width: 30.0,
                                                        height: 30.0,),
                                                      Text('$currentTemperature°C',
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors
                                                                .white),),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10.0,),
                                                  Text('$currentTemperature°C',
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.white),),
                                                ]
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius
                                .circular(20), color: Colors.white,),
                            padding: EdgeInsets.all(17.0),
                            height: 230.0,
                            width: 370.0,
                            child: Column(
                              children: [
                                Container(
                                  child: Text('주간예보', style: TextStyle(
                                      fontSize: 15.0, color: Colors.white),),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}