import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:mapssi/screens/search_area_screen.dart';
//import 'package:mapssi/screens/search_area_screen2.dart';
import '../main.dart';
import '../my_location.dart';
import '../network.dart';
import '../weather.dart';
import 'menu_bar_draw.dart';
import 'model.dart';
const apiKey = "122328b0a95baa0ce0c0a7697d3a30c7";

// 현재 페이지 에서 쓰일 TextStyle (글씨체,색상 고정 / 크기,굵기 조절)
TextStyle myTextStyle(double fs, {FontWeight fontWeight = FontWeight.w600}) {
  return TextStyle(
    fontSize: fs,
    color: Colors.black,
    fontFamily: 'SUITE',
    fontWeight: fontWeight,
  );
}


class WeatherScreen extends StatefulWidget {

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();

  //1. condition -> icon과 현재 상태 알아내기
  late int condition = 500; //500 = 비

  late String des = 'glgl'; //description
  late String dailyDes = 'glgl';

  late String koreanDes = '날씨상태'; // 날씨 상태 -> 한국어로

  late Widget icon;

  //2. 강수량
  late double currentRainFall = 10.0;

  //3.지역(동/시 단위로)
  late String addresNameDo;
  late String addresNameSi;


  //4. 현재 기온
  var currentTemperature;

  // late double dailyTemp;


  //5. 최저,최고 온도 -> maxTemp, minTemp로 알아냄
  late int maxTemperature;
  late int minTemperature;


  //6. 날짜 요일
  final now = DateTime.now();
  late String englishDayOfWeek = DateFormat.EEEE().format(now); //요일
  late String koreanDayOfWeek; //요일 > 한글로
  late String addresName;


  //7. 미세먼지
  late double airDust = 0.00;
  late Widget airIcon;
  late Widget airState;



  double? latitude3;
  double? longitude3;

  //8. 일일예보
  var dailyWeatherData;

  bool isLoading = false;

  List<dynamic> weatherList = [];
  //List<WeatherData> weatherDataList = [];
  //List<dynamic>? dailyForecasts;
  WeatherModel weather = WeatherModel();

  void initState() {
    super.initState();
    if (Get.find<WeatherJasonData>().getData()[1] == 100) {
      super.initState();
      getMyLocation();
      //getLocation();
      //getLocation();
    }
  }





  Future<void> loadWeatherData(var currentWeatherData) async {
    setState(() {
      isLoading = true; // 데이터를 불러오는 중으로 상태 변경
    });
    // network.dart에서 파싱된 json data를 출력해주기 위해 weatherData 변수에 getJsonData()의 값을 할당
    String currentWeather = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric';
    String dailyWeather = 'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric';
    String weeklyWeather = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric';
    String airCondition = 'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apiKey';
    Network network = Network(currentWeather, dailyWeather, weeklyWeather, airCondition);

    var currentWeatherData = await network.getCurrentWeatherData();
    var dailyWeatherData = await network.getdailyWeatherData();
    var weeklyWeatherData = await network.getWeeklyeatherData();
    var airConditionData = await network.getAirConditionData();
    // print(currentWeatherData);
    // print(dailyWeatherData);
    // print(weeklyWeatherData);
    // print(airConditionData);


    //위경도 => 지역 변환
    List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude3!, longitude3!);
    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String address = '${placemark.administrativeArea}, ${placemark
          .locality}';
      addresNameDo = '${placemark.administrativeArea}';
      addresNameSi = '${placemark.locality}';
    }




    //데이터 파싱하기

    currentTemperature = currentWeatherData['main']['temp'].ceil();  //현재기온
    //int index = airConditionData['list'][0]['main']['aqi'];
    condition = currentWeatherData['weather'][0]['id'];  //날씨 아이콘에 사용
    airDust = airConditionData['list'][0]['components']['pm10']; //미세먼지
    // icon = model.getWeatherIcon(condition)!;

    des = currentWeatherData['weather'][0]['description']; //날씨 상태
    koreanDes =getKoreanWeatherDescription(des);

    currentRainFall =
    currentWeatherData['rain'] != null ? currentWeatherData['rain']['1h'] : 0.0;  //현재 강수량

    weatherList = dailyWeatherData['list'];    // 5일간 3시간 단위 예보
    //print('weatherList? $weatherList');






    // 실시간 기온
    void updateTemperatures() {
      List<dynamic> weatherList = dailyWeatherData['list'];

      double maxTemp = double.negativeInfinity;
      double minTemp = double.infinity;

      DateTime midnight = DateTime.now().subtract(Duration(hours: DateTime.now().hour));
      DateTime nextMidnight = midnight.add(Duration(days: 1));

      for (dynamic weatherData in weatherList) {
        int timestamp = weatherData['dt'];
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

        if (dateTime.isAfter(midnight) && dateTime.isBefore(nextMidnight)) {
          double temperature = weatherData['main']['temp'].toDouble();
          minTemp = temperature < minTemp ? temperature : minTemp;
          maxTemp = temperature > maxTemp ? temperature : maxTemp;
        }
      }
      setState(() {
        maxTemperature = maxTemp.ceil(); //오늘의 최고 - 올림
        minTemperature = minTemp.floor();  //오늘의 최저 - 내림
      });

    }
    updateTemperatures();


    // print("최고 $maxTemperature");
    // print("최저 $minTemperature");


    List<dynamic> _filterDailyForecasts(List<dynamic> weatherList) {
      final dailyForecasts = <dynamic>[];

      // 현재 날짜와 비교하기 위한 변수 초기화
      DateTime currentDate = DateTime.now();

      for (final forecast in weatherList) {
        final dt = forecast['dt'] * 1000;
        final forecastDate = DateTime.fromMillisecondsSinceEpoch(dt);

        // 날짜가 변경되었을 때, 하루 기준의 데이터로 판단하고 추가
        if (forecastDate.day != currentDate.day&& forecastDate.hour == 12 )  {
          dailyForecasts.add(forecast);
          currentDate = forecastDate;
        }
      }

      return dailyForecasts;

    }
    final dailyForecasts = _filterDailyForecasts(weatherList);

    //print('주간예보? $dailyForecasts');


    for (final forecast in dailyForecasts) {
      final dt = forecast['dt'] * 1000;
      final forecastDate = DateTime.fromMillisecondsSinceEpoch(dt);
      final temperature = forecast['main']['temp'];
      final weatherDescription = forecast['weather'][0]['description'];

      // 하루 기준의 데이터를 출력하거나 처리
      // print('Date: $forecastDate');
      // print('Weather Description: $weatherDescription');
    }

    //생성된 위치 기반 날씨 정보를 character_page으로 넘김
    WeatherJasonData dataController = Get.find<WeatherJasonData>();
    dataController.updateData(
        currentTemperature, maxTemperature, minTemperature, addresNameDo,
        addresNameSi, condition, currentRainFall, airDust, koreanDes, weatherList,dailyForecasts);

    //koreanDes = getKoreanWeatherDescription(des!);
    //koreanDayOfWeek = getKoreanWeekDay(englishDayOfWeek);

    setState(() {
      isLoading = false; // 데이터를 불러오는 중으로 상태 변경
    });
  }



  //사용자 위치 불러오기 -위경도 값f
  void getMyLocation() async {
    setState(() {
      isLoading = true; // 데이터를 불러오는 중으로 상태 변경
    });
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLongilati();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longtitude2;
    // print(latitude3);
    // print(longitude3);

    addresNameDo = myLocation.addressDo;
    addresNameSi = myLocation.addressSi;
    // print(addresNameDo);
    // print(addresNameSi);


    // network.dart 에서 getJsonData()불러오기 위해 network인스턴스 생성
    String currentWeather = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric';
    String dailyWeather = 'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric';
    String weeklyWeather = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric';
    String airCondition = 'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apiKey';
    Network network = Network(
        currentWeather, dailyWeather, weeklyWeather, airCondition);
    // network.dart에서 파싱된 json data를 출력해주기 위해 weatherData 변수에 getJsonData()의 값을 할당
    var currentWeatherData = await network.getCurrentWeatherData();
    var dailyWeatherData = await network.getdailyWeatherData();
    var weeklyWeatherData = await network.getWeeklyeatherData();
    var airConditionData = await network.getAirConditionData();
    // print(currentWeatherData);
    // print(dailyWeatherData);
    // print(weeklyWeatherData);
    // print(airConditionData);




    //데이터 파싱하기

    currentTemperature = currentWeatherData['main']['temp'].ceil();  //현재기온
    //int index = airConditionData['list'][0]['main']['aqi'];
    condition = currentWeatherData['weather'][0]['id'];  //날씨 아이콘에 사용
    airDust = airConditionData['list'][0]['components']['pm10']; //미세먼지
    // icon = model.getWeatherIcon(condition)!;

    des = currentWeatherData['weather'][0]['description']; //날씨 상태
    koreanDes =getKoreanWeatherDescription(des);

    currentRainFall =
    currentWeatherData['rain'] != null ? currentWeatherData['rain']['1h'] : 0.0;  //현재 강수량

    weatherList = dailyWeatherData['list'];    // 5일간 3시간 단위 예보
    // print('weatherList? $weatherList');




    // 실시간 기온
    void updateTemperatures() {
      List<dynamic> weatherList = dailyWeatherData['list'];

      double maxTemp = double.negativeInfinity;
      double minTemp = double.infinity;

      DateTime midnight = DateTime.now().subtract(Duration(hours: DateTime.now().hour));
      DateTime nextMidnight = midnight.add(Duration(days: 1));

      for (dynamic weatherData in weatherList) {
        int timestamp = weatherData['dt'];
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

        if (dateTime.isAfter(midnight) && dateTime.isBefore(nextMidnight)) {
          double temperature = weatherData['main']['temp'].toDouble();
          minTemp = temperature < minTemp ? temperature : minTemp;
          maxTemp = temperature > maxTemp ? temperature : maxTemp;
        }
      }
      setState(() {
        maxTemperature = maxTemp.ceil(); //오늘의 최고 - 올림
        minTemperature = minTemp.floor();  //오늘의 최저 - 내림
      });

    }
    updateTemperatures();


    // print("최고 $maxTemperature");
    // print("최저 $minTemperature");


    List<dynamic> _filterDailyForecasts(List<dynamic> weatherList) {
      final dailyForecasts = <dynamic>[];

      // 현재 날짜와 비교하기 위한 변수 초기화
      DateTime currentDate = DateTime.now();

      for (final forecast in weatherList) {
        final dt = forecast['dt'] * 1000;
        final forecastDate = DateTime.fromMillisecondsSinceEpoch(dt);

        // 날짜가 변경되었을 때, 하루 기준의 데이터로 판단하고 추가
        if (forecastDate.day != currentDate.day&& forecastDate.hour == 12 )  {
          dailyForecasts.add(forecast);
          currentDate = forecastDate;
        }
      }

      return dailyForecasts;

    }
    final dailyForecasts = _filterDailyForecasts(weatherList);

    //print('주간예보? $dailyForecasts');


    for (final forecast in dailyForecasts) {
      final dt = forecast['dt'] * 1000;
      final forecastDate = DateTime.fromMillisecondsSinceEpoch(dt);
      final temperature = forecast['main']['temp'];
      final weatherDescription = forecast['weather'][0]['description'];

      // 하루 기준의 데이터를 출력하거나 처리
      // print('Date: $forecastDate');
      // print('Weather Description: $weatherDescription');
    }

    //생성된 위치 기반 날씨 정보를 character_page으로 넘김
    WeatherJasonData dataController = Get.find<WeatherJasonData>();
    dataController.updateData(
        currentTemperature, maxTemperature, minTemperature, addresNameDo,
        addresNameSi, condition, currentRainFall, airDust, koreanDes, weatherList,dailyForecasts);

    //koreanDes = getKoreanWeatherDescription(des!);
    //koreanDayOfWeek = getKoreanWeekDay(englishDayOfWeek);

    setState(() {
      isLoading = false; // 데이터를 불러오는 중으로 상태 변경
    });
  }


  @override
  Widget build(BuildContext context) {
    late double latitude;
    late double longitude;


    List<dynamic> _filterDailyForecasts(List<dynamic> weatherList) {
      final dailyForecasts = <dynamic>[];

      // 현재 날짜와 비교하기 위한 변수 초기화
      DateTime currentDate = DateTime.now();

      for (final forecast in weatherList) {
        final dt = forecast['dt'] * 1000;
        final forecastDate = DateTime.fromMillisecondsSinceEpoch(dt);

        // 날짜가 변경되었을 때, 하루 기준의 데이터로 판단하고 추가
        if  (forecastDate.day != currentDate.day && forecastDate.hour == 12)
        {
          // dailyForecasts.add(currentData);
          dailyForecasts.add(forecast);
          currentDate = forecastDate;
        }
      }
      return dailyForecasts;
    }

    var dailyForecasts = _filterDailyForecasts(weatherList);
    // print('주간예보????????????? $dailyForecasts');



    for (final forecast in dailyForecasts) {
      final dt = forecast['dt'] * 1000;
      final forecastDate = DateTime.fromMillisecondsSinceEpoch(dt);
      final temperature = forecast['main']['temp'];
      final weatherDescription = forecast['weather'][0]['description'];


      // 하루 기준의 데이터를 출력하거나 처리
      // print('Date: $forecastDate');
      // print('Weather Description: $weatherDescription');
    }

    currentTemperature = Get.find<WeatherJasonData>().getData()[0];
    maxTemperature = Get.find<WeatherJasonData>().getData()[1];
    minTemperature = Get.find<WeatherJasonData>().getData()[2];
    addresNameDo = Get.find<WeatherJasonData>().getData()[3];
    addresNameSi = Get.find<WeatherJasonData>().getData()[4];
    condition = Get.find<WeatherJasonData>().getData()[5];
    currentRainFall = Get.find<WeatherJasonData>().getData()[6];
    airDust = Get.find<WeatherJasonData>().getData()[7];
    koreanDes = Get.find<WeatherJasonData>().getData()[8];
    weatherList = Get.find<WeatherJasonData>().getData()[9];
    dailyForecasts = Get.find<WeatherJasonData>().getData()[10];


    //최고 최저 날씨 구하는 코드(5일간)
    //DateTime now = DateTime.now();
    DateTime midnight = DateTime(now.year, now.month, now.day, 0, 0, 0);
    // DateTime nextMidnight = midnight.add(Duration(days: 1));

    List<double> maxTemperatures = [];
    List<double> minTemperatures = [];

    for (int i = 0; i < 6; i++) {

      DateTime currentMidnight = midnight.add(Duration(days: i));
      DateTime nextMidnight = midnight.add(Duration(days: i + 1));

      double maxTemp = double.negativeInfinity;
      double minTemp = double.infinity;

      for (dynamic weatherData in weatherList) {
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
            weatherData['dt'] * 1000);

        // 현재 시간이 현재 날짜의 자정 이후이고 다음 날짜의 자정 전인 경우
        if (dateTime.isAfter(currentMidnight) &&
            dateTime.isBefore(nextMidnight)) {
          double temperature = weatherData['main']['temp'].toDouble();
          minTemp = temperature < minTemp ? temperature : minTemp;
          maxTemp = temperature > maxTemp ? temperature : maxTemp;
        }
      }


      maxTemperatures.add(maxTemp);
      minTemperatures.add(minTemp);

      // print('날짜: ${currentMidnight.toString().substring(0, 10)}');
      // print('최고 온도: ${maxTemp.toStringAsFixed(1)}');
      // print('최저 온도: ${minTemp.toStringAsFixed(1)}');
      // print('===================!!!!!!!!!!=');
    }



    // int condition = getWeatherCondition() as int;
    icon = model.getWeatherIcon(condition)!;
    //필요없음  koreanDes = Model.getKoreanWeatherDescription(des!);
    koreanDayOfWeek = Model.getKoreanWeekDay(englishDayOfWeek);
    airState = model.getAirCondition(airDust)!;
    airIcon = model.getAirIcon(airDust)!;


    String text1= "$addresNameSi";
    String text2 ="$addresNameDo";


    //더미
    // String text1= "용인시";
    //  String text2= "경기로";



    return Scaffold(

      appBar: AppBar(
        //  backgroundColor: Colors.white,
        backgroundColor: Colors.transparent,

        flexibleSpace: Image(
          image: AssetImage('assets/background_image.png'),
          fit: BoxFit.cover, // 이미지가 AppBar에 맞게 확장됨
        ),


        title: Center(
          child: GestureDetector(
            onTap: () async {
              var locationData = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return CityDropdown();
                }),
              );
              if (locationData != null) {
                latitude3 = locationData[0];
                longitude3 = locationData[1];
                setState(() {
                  isLoading = true; // 데이터를 불러오는 중으로 상태 변경
                });
                var weatherData = await weather.getCityWeather(
                    latitude3!, longitude3!);
                await loadWeatherData(weatherData);
              }
              // else(){
              //   latitude3 = locationData[0];
              //   longitude3 = locationData[1];
              //   var weatherData = weather.getLocationWeather();
              //   print("현재 지역ㅇㄴㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍㅍ");
              //   loadWeatherData(weatherData);
              // };
            },


            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child:
                  RichText(
                    textAlign: TextAlign.center, // 가운데 정렬
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: text1,
                          style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'SUITE', fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: "\n",
                        ),
                        TextSpan(
                          text: text2,
                          style: TextStyle(fontSize: 13, color: Colors.black, fontFamily: 'SUITE', fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),),

                Image.asset(
                  'assets/icons/down_arrow_black.png',
                  width: 15,
                  height: 15,
                ),
              ],
            ),
          ),
        ),


        actions: [

          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,20,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 15,
                  height: 7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 10), // 회색 동그라미와 검정색 동그라미 사이 간격
                Container(
                  width: 15,
                  height: 7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),


        ],
        iconTheme: IconThemeData(color: Colors.black),

      ),



      //Text('$addresNameSi ($addresNameDo)'),



      drawer: Drawer( //햄버거 바
        child: MenuBarDraw(),
      ),


      body: Container(
        // 배경 이미지 고정(배경 이미지도 스크롤하려면 SingleChild를 body에 두고 Container를 child에
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_image.png'),
              fit: BoxFit.cover,
            )
        ),
        child:  isLoading == false
            ?  SingleChildScrollView(
          child: Column(
            children: [
              //상단
              SizedBox(height: 20.0),
              Container(
                // height: 300.0,
                height: MediaQuery.of(context).size.height*0.3,

                // color: Colors.red, // 없애도 됨. 공간 확인용.

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 가로 방향으로 중앙 배치
                  children: [
                    //Expanded1. 아이콘이랑 날씨상태, 강수량
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 25.0,),

                          WeatherIconWidget(
                              image: model.getWeatherIcon(condition), // condition 값에 따른 이미지 가져오기
                              size: 100,
                              color: Colors.black54),

                          SizedBox(height: 20),
                          Text('$koreanDes', style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontFamily: 'SUITE',
                            fontWeight: FontWeight.w800,),),

                          SizedBox(height: 10,),
                          Text('${currentRainFall.toStringAsFixed(1)}mm',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontFamily: 'SUITE',
                              fontWeight: FontWeight.w700,),),
                        ],
                      ),
                    ),


                    //Expanded2. 요일, 미세먼지 실황
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.0),
                          Text(
                            DateFormat('M월 d일 $koreanDayOfWeek').format(now),
                            style: myTextStyle(13.0, fontWeight: FontWeight.w700),),


                          SizedBox(height:10.0),
                          Text('$currentTemperature°C',
                            style: myTextStyle(45.0, fontWeight: FontWeight.w800),),


                          SizedBox(height: 4.0),
                          Row(
                            children: [
                              Text(' $maxTemperature°C', style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.red,
                                fontFamily: 'SUITE',
                                fontWeight: FontWeight.w700,),),


                              Text('  /  ',
                                style: myTextStyle(15.0, fontWeight: FontWeight.w700),),

                              Text('$minTemperature°C', style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blue,
                                fontFamily: 'SUITE',
                                fontWeight: FontWeight.w700,),),
                            ],
                          ),

                          SizedBox(height: 20.0),
                          Row(
                              children: [
                                Text('미세\n먼지',
                                  style: myTextStyle(13.0, fontWeight: FontWeight.w700),),
                                SizedBox(width: 18.0),
                                airState,
                                SizedBox(width: 10.0),
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
                //color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 27.0, vertical: 8.0),

                //일일 예보 글자칸
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('일일 예보',
                      style: myTextStyle(28.0, fontWeight: FontWeight.w700),),
                    SizedBox(height: 18.0),


                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 일일 예보 박스+내용
                          Container(

                            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                            height: MediaQuery.of(context).size.height*0.25,
                            decoration: BoxDecoration(
                                color: Color(0xFFFFFDF9),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 1), // 그림자의 위치 조정
                                  )
                                ]
                            ),

                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: weatherList.length,
                                itemBuilder: (context, index) {
                                  dynamic weatherData = weatherList[index];

                                  int hourlyTemp = weatherData['main']['temp']
                                      .round();
                                  double rainfall = weatherData.containsKey(
                                      'rain') ? weatherData['rain']['3h'] : 0.0;
                                  //int rainPercent = weatherData['pop'];

                                  String englishDescription = weatherData['weather'][0]['description'];
                                  koreanDes = getKoreanWeatherDescription(englishDescription);

                                  int condition = weatherData['weather'][0]['id'];
                                  //icon = model.getWeatherIcon(condition)!;

                                  int timestamp = weatherData['dt'];


                                  DateTime time = DateTime
                                      .fromMillisecondsSinceEpoch(
                                      timestamp * 1000);
                                  String formattedTime = DateFormat('HH:mm')
                                      .format(time); // 시간을 HH:mm 형식으로 변환

                                  return Container(
                                    width: 120, // 각 항목의 너비 조정
                                    //color: Colors.blue,
                                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        SizedBox(height: 3.0,),
                                        Text('$formattedTime',
                                          style: myTextStyle(15.0, fontWeight: FontWeight.w500),),
                                        // 시간 표시
                                        SizedBox(height: 8.0,),
                                        Text('$hourlyTemp°C',
                                          style: myTextStyle(22.0, fontWeight: FontWeight.w800),),

                                        SizedBox(height: 8.0,),
                                        /*  Text('$koreanDes($englishDescription)',
                                        style: TextStyle(
                                          fontSize: 10, color: Colors.black,),),
                                      //icon,
                                      Icon(
                                        Icons.cloud,
                                        size: 50.0,
                                        color: Colors.black,
                                      ),
                                     */

                                        WeatherIconWidget(
                                            image: model.getWeatherIcon(condition), // condition 값에 따른 이미지 가져오기
                                            size: 50,
                                            color: Colors.black54),

                                        SizedBox(height: 5.0,),
                                        Text(koreanDes, style:
                                        myTextStyle(15.0, fontWeight: FontWeight.w600),),

                                        SizedBox(height: 5.0,),
                                        Text('$rainfall(mm)',
                                          style: myTextStyle(12.0, fontWeight: FontWeight.w300),),

                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),


                    SizedBox(height: 40.0),

                    //주간 예보 글자 칸
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('주간 예보',
                          style: myTextStyle(28.0, fontWeight: FontWeight.w700),),

                        SizedBox(height: 18.0), // 주간예보 글씨와 박스 사이 간격
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            //주간 예보 칸
                            Container(
                              padding: EdgeInsets.all(40.0),
                              height: MediaQuery.of(context).size.height*0.7,

                              decoration: BoxDecoration(
                                  color: Color(0xFFFFFDF9),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(0, 1), // 그림자의 위치 조정
                                    )
                                  ]
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: dailyForecasts.map((forecast) {
                                  String weatherDescription = forecast['weather'][0]['description'];
                                  koreanDes = getKoreanWeatherDescription(weatherDescription);

                                  int condition = forecast['weather'][0]['id'];
                                  //icon = model.getWeatherIcon(condition)!;

                                  int timestamp = forecast['dt'];
                                  DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
                                  String formattedTime = DateFormat('HH:mm').format(time); // 시간을 HH:mm 형식으로 변환
                                  String weekday = DateFormat.EEEE().format(time);
                                  String koreanWeekDay = getKoreanWeekDay(weekday);
                                  int dailyMaxTemp = maxTemperatures[dailyForecasts.indexOf(forecast) + 1].ceil();
                                  int dailyMinTemp = minTemperatures[dailyForecasts.indexOf(forecast) + 1].floor();

                                  //가로로 하루의 날씨 정보를 나타냄
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween, //요일과 날씨 정보 간격
                                    children: [
                                      //날짜+요일 세로로 배치
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat('M월 d일').format(time),
                                            style: myTextStyle(13.0, fontWeight: FontWeight.w400),),
                                          SizedBox(height: 5,), // 날짜와 요일 사이 간격
                                          Text(
                                            '$koreanWeekDay',
                                            style: myTextStyle(18.0, fontWeight: FontWeight.w800),),
                                        ],
                                      ),

                                      //세로로 아이콘, 최고 최저 기온
                                      Row(
                                        children: [
                                          //날씨 글씨로 + 아이콘
                                          Container(
                                            margin: EdgeInsets.symmetric(vertical: 30.0),
                                            child:
                                            Text(koreanDes,
                                              style: myTextStyle(15.0, fontWeight: FontWeight.w800),),
                                          ),
                                          Container(
                                            child: WeatherIconWidget(
                                                image: model.getWeatherIcon(condition), // condition 값에 따른 이미지 가져오기
                                                size: 30,
                                                color: Colors.black54),
                                          ),


                                          SizedBox(width: 18.0,),

                                          //최고,최저 기온
                                          Container(
                                            margin: EdgeInsets.symmetric(vertical: 30.0),
                                            child: Text('${dailyMaxTemp}°C',
                                              style: TextStyle(fontSize: 13.0, color: Colors.redAccent, fontFamily: 'SUITE', fontWeight: FontWeight.w500,),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(vertical: 30.0),
                                            child: Text(' / ',
                                              style: myTextStyle(25.0, fontWeight: FontWeight.w100),),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(vertical: 30.0),
                                            child: Text(
                                              '${dailyMinTemp}°C',
                                              style: TextStyle(fontSize: 13.0, color: Colors.blueAccent, fontFamily: 'SUITE', fontWeight: FontWeight.w500,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    ],
                  ),
                ),
              ],
            ),
          )
          // maxTemperature ==100 (로딩 표시 보여주기)
              : Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                          'assets/loading_new.gif', // 로딩 이미지 파일 경로
                          width: 200, // 이미지의 너비 설정
                          height: 200,
                        ),
                      Text(
                        'Loading...',
                        style:  myTextStyle(25.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                        height: 80,
                      )
                    ],

                ),
              ),
      ),
    );
  }



  String getKoreanWeatherDescription(String englishDescription) {
    String koreanDes =' ';
    switch (englishDescription) {
      case 'clear sky':
        koreanDes = '맑음';
        break;
      case 'few clouds':
      case 'scattered clouds':
      case 'broken clouds':
        koreanDes = '구름';
        break;
      case 'shower rain':
      case 'light intensity shower rain':
      case 'heavy intensity shower rain':
      case 'ragged shower rain':
        koreanDes = '소나기';
        break;
      case 'rain':
      case 'light rain':
      case 'moderate rain':
      case 'heavy intensity rain':
      case 'very heavy rain':
      case 'extreme rain':
      case 'freezing rain':
        koreanDes = '많은 비';
        break;
      case 'thunderstorm':
      case 'thunderstorm with light rain':
      case 'thunderstorm with rain':
      case 'thunderstorm with heavy rain':
      case 'light thunderstorm':
      case 'heavy thunderstorm':
      case 'ragged thunderstorm':
      case 'thunderstorm with light drizzle':
      case 'thunderstorm with drizzle':
      case 'thunderstorm with heavy drizzle':
        koreanDes = '천둥번개';
        break;
      case 'snow':
      case 'light snow':
      case 'heavy snow':
      case 'sleet':
      case 'light shower sleet':
      case 'shower sleet':
      case 'light rain and snow':
      case 'rain and snow':
      case 'light shower snow':
      case 'shower snow':
      case 'heavy shower snow':
        koreanDes = '눈';
        break;
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'sand/dust whirls':
      case 'fog':
      case 'sand':
      case 'dust':
        koreanDes = '안개';
        break;
      case 'volcanic ash':
        koreanDes = '화산재';
        break;
      case 'squalls':
        koreanDes =  '돌풍';
        break;
      case 'tornado':
        koreanDes = '토네이도(회오리 바람)';
        break;
      case 'drizzle':
      case 'light intensity drizzle':
      case 'heavy intensity drizzle':
      case 'light intensity drizzle rain':
      case 'drizzle rain':
      case 'heavy intensity drizzle rain':
      case 'shower rain and drizzle':
      case 'heavy shower rain and drizzle':
      case 'shower drizzle' :
        koreanDes = '이슬비';
        break;
      case 'overcast clouds':
        koreanDes = '흐림';
        break;
      default:
        koreanDes = '정보 없음' ;
    }
    return koreanDes;

  }

  String getKoreanWeekDay(String englishWeekDay) {
    String koreanWeekDay = '';

    switch (englishWeekDay) {
      case 'Monday':
        koreanWeekDay = '월요일';
        break;
      case 'Tuesday':
        koreanWeekDay = '화요일';
        break;
      case 'Wednesday':
        koreanWeekDay = '수요일';
        break;
      case 'Thursday':
        koreanWeekDay = '목요일';
        break;
      case 'Friday':
        koreanWeekDay = '금요일';
        break;
      case 'Saturday':
        koreanWeekDay = '토요일';
        break;
      case 'Sunday':
        koreanWeekDay = '일요일';
        break;
      default:
        koreanWeekDay = '알 수 없음';
    }
    return koreanWeekDay;
  }

}
class WeatherIconWidget extends StatelessWidget {
  final Widget? image;
  final double size;

  WeatherIconWidget({required this.image, required this.size, required Color color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: image, // 이미지 위젯을 화면에 출력
    );
  }
}