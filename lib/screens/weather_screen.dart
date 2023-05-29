import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mapssi/screens/search_area_screen.dart';
import 'menu_bar_draw.dart';
import 'model.dart';

class WeatherScreen extends StatefulWidget {

  final double latitude;
  final double longitude;
  final String address;
  final String addressDo;
  final String addressSi;
  final String englishDayOfWeek;

  final dynamic parseCurrentWeatherData;
  final dynamic parseDailyWeatherData;
  final dynamic parseWeeklyWeatherData;
  final dynamic parseAirConditionData;
  final String weatherDescription;

  WeatherScreen({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.addressDo,
    required this.addressSi,
    required this.parseCurrentWeatherData,
    required this.parseDailyWeatherData,
    required this.parseWeeklyWeatherData,
    required this.parseAirConditionData,
    required this.weatherDescription,
    required this.englishDayOfWeek,
  });


  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}



class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  late String addresName;
  late String addresNameDo;
  late String addresNameSi;
  var currentTemp;
  late double dailyTemp;

  late Widget icon;

  late Widget airIcon;
  late Widget airState;
  var airDust;


  DateTime now = DateTime.now();
  late String des; //description
  late String dailyDes;

  late String koreanDes;
  late String englishDayOfWeek = DateFormat.EEEE().format(now);
  late String koreanDayOfWeek;

  late double currentRainfall;
  late double dailyRainfall;

  late int maxTemperature;
  late int minTemperature;

  @override
  void initState() {
    super.initState();
    updateData(widget.parseCurrentWeatherData, widget.parseAirConditionData,
      widget.parseDailyWeatherData,);
  }

  void updateTemperatures() {
    List<dynamic> weatherList = widget.parseDailyWeatherData['list'];

    double maxTemp = double.negativeInfinity;
    double minTemp = double.infinity;

    for (dynamic weatherData in weatherList) {
      double temperature = weatherData['main']['temp'].toDouble();
      if (temperature > maxTemp) {
        maxTemp = temperature.toDouble();
      }
      if (temperature < minTemp) {
        minTemp = temperature.toDouble();
      }
    }

    setState(() {
      maxTemperature = maxTemp.round();
      minTemperature = minTemp.round();
    });
  }


  void updateData(dynamic currentWeatherData, dynamic airConditionData,
      dynamic dailyWeatherData) {
    currentTemp = currentWeatherData['main']['temp'].round();
    //int index = airConditionData['list'][0]['main']['aqi'];
    int condition = currentWeatherData['weather'][0]['id'];
    airDust = airConditionData['list'][0]['components']['pm10'];
    icon = model.getWeatherIcon(condition)!;
    airIcon = model.getAirIcon(airDust)!;
    airState = model.getAirCondition(airDust)!;


    addresName = widget.address;
    addresNameDo = widget.addressDo;
    addresNameSi = widget.addressSi;
    des = currentWeatherData['weather'][0]['description'];
    koreanDes = Model.getKoreanWeatherDescription(des!);
    koreanDayOfWeek = Model.getKoreanWeekDay(englishDayOfWeek);

    currentRainfall =
    currentWeatherData['rain'] != null ? currentWeatherData['rain']['1h'] : 0.0;

  }

  final List<String> weatherTexts = [
    'Sunny',
    'Cloudy',
    'Rainy',
    'Windy',
    'Snowy',
    'Foggy',
    'Stormy',
    'Partly Cloudy',
    'Hazy',
    'Thunderstorm',
    'Misty',
    'Clear Night',
  ];



  @override
  Widget build(BuildContext context) {
    // double currentTemperature = parseCurrentWeatherData['main']['temp'];
    // double airConditionState = parseAirConditionData['list'][0]['components']['pm10'];
    List<dynamic> weatherList = widget.parseDailyWeatherData['list'];
    List<String> daysOfWeek = ['월요일', '화요일', '수요일', '목요일', '금요일'];
    List<IconData> icons = [Icons.wb_sunny, Icons.cloud, Icons.wb_sunny, Icons.cloud, Icons.wb_sunny];
    List<double> maxTemperatures = [28.0, 26.0, 30.0, 24.0, 27.0];
    List<double> minTemperatures = [19.0, 18.0, 20.0, 16.0, 18.0];


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0.0,
        //깊이감(그림자)
        title: Text('Mapssi-날씨 옷 코디'),
        centerTitle: true,
        // 앱바 가운데 정렬
        actions: [
          IconButton(icon: SvgPicture.asset("assets/icons/search.svg"),
            onPressed: () {
              //print("search button is clicked");
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => LocationSearchPage(),),
              );
            },
          ),
        ],
      ),

      drawer: const Drawer( //햄버거 바
        child: MenuBarDraw(),
      ),


      body: SingleChildScrollView( //전체적인 화면을 위아래로 스크롤
        child: Column(

          children: [
            //상단
            //SizedBox(height: 20.0),

            Container(
              height: 200.0,
              color: Colors.orange, //#투명 = transparent

              child: Row(
                children: [
                  //아이콘이랑 날씨상태, 강수량
                  Expanded(
                    //width: 100.0, //height: 80.0,
                    // margin: EdgeInsets.all(25.0),
                    // padding: EdgeInsets.all(5.0),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.0,),
                        icon,
                        SizedBox(height: 20),
                        Text('$koreanDes', style: TextStyle(
                            color: Colors.white, fontSize: 18.0),),
                        SizedBox(height: 10,),
                        Text('${currentRainfall.toStringAsFixed(1)}mm',
                          style: TextStyle(color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),

                  //지역명, 기온, 최고최저 기온
                  Expanded(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 25,),
                        Text('$addresNameSi',
                          style: TextStyle(fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),),
                        SizedBox(height: 8,),
                        Text('($addresNameDo)',
                          style: TextStyle(fontSize: 15, color: Colors.white),),

                        SizedBox(height: 28.0),
                        Text('$currentTemp°C', style: TextStyle(color: Colors
                            .white, fontSize: 35.0, fontWeight: FontWeight
                            .bold),),

                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('$maxTemperature°C', style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),),
                            Text(' / ', style: TextStyle(color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),),
                            Text('$minTemperature°C', style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),),
                          ],
                        )
                      ],
                    ),
                  ),

                  //요일, 미세먼지 실황
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40.0),
                        Text(
                          DateFormat('M월 d일 $koreanDayOfWeek').format(now),
                          style: TextStyle(
                            color: Colors.white, fontSize: 13.0,),
                        ),

                        SizedBox(height: 38.0),
                        Text(
                          '미세먼지',
                          style: TextStyle(
                            color: Colors.white, fontSize: 16.0,),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              airState,
                              airIcon,
                            ]

                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),


            //예보 칸
            Container(
              color: Colors.orange,
              padding: EdgeInsets.all(20.0),

              //일일 예보 글자칸
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('일일 예보', style: TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold,),),
                  SizedBox(height: 18.0),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // 일일 예보 칸
                        Container(
                          padding: EdgeInsets.all(20.0),

                          height: 190.0, color: Colors.orangeAccent,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: weatherList.length,
                              itemBuilder: (context, index) {
                                dynamic weatherData = weatherList[index];
                                int hourlyTemp = weatherData['main']['temp']
                                    .round();
                                double rainfall = weatherData.containsKey(
                                    'rain') ? weatherData['rain']['3h'] : 0.0;
                                String weatherDescription = weatherData['weather'][0]['description'];
                                int timestamp = weatherData['dt'];
                                DateTime time = DateTime
                                    .fromMillisecondsSinceEpoch(
                                    timestamp * 1000);
                                String formattedTime = DateFormat('HH:mm')
                                    .format(time); // 시간을 HH:mm 형식으로 변환

                                return Container(
                                  width: 150, // 각 항목의 너비 조정
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [

                                      Text('$formattedTime', style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,),),
                                      // 시간 표시
                                      Text('$hourlyTemp°C', style: TextStyle(
                                        fontSize: 15, color: Colors.black,),),
                                      Text('$koreanDes($weatherDescription)',
                                        style: TextStyle(
                                          fontSize: 10, color: Colors.black,),),
                                      icon,
                                      Text('$rainfall mm', style: TextStyle(
                                        fontSize: 12, color: Colors.black,),),

                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.0),

                  //주간 예보 글자 찬
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('주간 예보', style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold,),),
                        SizedBox(height: 18.0),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              //주간 예보 칸
                              Container(
                                padding: EdgeInsets.all(40.0),

                                height: 500, color: Colors.orangeAccent,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: daysOfWeek.length,
                                  itemBuilder: (context, index) {
                                    String day = daysOfWeek[index];
                                    IconData icon = icons[index];
                                    double maxTemp = maxTemperatures[index];
                                    double minTemp = minTemperatures[index];

                                    return Row(

                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [


                                        Text(day, style: TextStyle(fontSize: 18.0,
                                          fontWeight: FontWeight.bold, color: Colors.white,),),
                                        SizedBox(height: 77.0,),

                                        Row(
                                          children: [
                                            Icon(icon,color: Colors.white,size: 30.0,),

                                            SizedBox(width: 15.0),
                                            Text('${maxTemp.toStringAsFixed(1)}°C',
                                              style: TextStyle(fontSize: 14.0,color: Colors.white,),),

                                            SizedBox(width: 5.0),
                                            Text(' / ',
                                              style: TextStyle(fontSize: 28.0,color: Colors.white, fontWeight: FontWeight.bold,),),

                                            SizedBox(width: 5.0),
                                            Text('${minTemp.toStringAsFixed(1)}°C',
                                              style: TextStyle(fontSize: 14.0,color: Colors.white,),),
                                          ],
                                        )
                                      ],
                                    );

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),


            ),
          ],
        ),
      ),
    );
  }
}

