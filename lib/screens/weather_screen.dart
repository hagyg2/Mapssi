import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:mapssi/screens/search_area_screen.dart';
import '../main.dart';
import '../my_location.dart';
import '../network.dart';
import 'menu_bar_draw.dart';
import 'model.dart';
const apiKey = "122328b0a95baa0ce0c0a7697d3a30c7";


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
  late double airDust = 0.0;
  late Widget airIcon;
  late Widget airState;



  double? latitude3;
  double? longitude3;

  //8. 일일예보
  var dailyWeatherData;


  List<dynamic> weatherList = [];
  //List<WeatherData> weatherDataList = [];
  //List<dynamic>? dailyForecasts;


  @override
  void initState() {
    super.initState();
    if (Get.find<WeatherJasonData>().getData()[1] == 100) {
      super.initState();
      getLocation();
    }
  }

  //사용자 위치 불러오기 -위경도 값f
  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLongilati();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longtitude2;
    print(latitude3);
    print(longitude3);

    addresNameDo = myLocation.addressDo;
    addresNameSi = myLocation.addressSi;
    print(addresNameDo);
    print(addresNameSi);
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
    print(currentWeatherData);
    print(dailyWeatherData);
    print(weeklyWeatherData);
    print(airConditionData);




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
    print('weatherList? $weatherList');




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


    print("최고ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ $maxTemperature");
    print("최저ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ $minTemperature");


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

    print('주간예보? $dailyForecasts');


    for (final forecast in dailyForecasts) {
      final dt = forecast['dt'] * 1000;
      final forecastDate = DateTime.fromMillisecondsSinceEpoch(dt);
      final temperature = forecast['main']['temp'];
      final weatherDescription = forecast['weather'][0]['description'];

      // 하루 기준의 데이터를 출력하거나 처리
      print('Date: $forecastDate');
      print('Weather Description: $weatherDescription');
    }

    //생성된 위치 기반 날씨 정보를 character_page으로 넘김
    WeatherJasonData dataController = Get.find<WeatherJasonData>();
    dataController.updateData(
      currentTemperature, maxTemperature, minTemperature, addresNameDo,
      addresNameSi, condition, currentRainFall, airDust, koreanDes, weatherList,dailyForecasts);

    //koreanDes = getKoreanWeatherDescription(des!);
    //koreanDayOfWeek = getKoreanWeekDay(englishDayOfWeek);

  }




  @override
  Widget build(BuildContext context) {

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
    print('주간예보????????????? $dailyForecasts');



    for (final forecast in dailyForecasts) {
      final dt = forecast['dt'] * 1000;
      final forecastDate = DateTime.fromMillisecondsSinceEpoch(dt);
      final temperature = forecast['main']['temp'];
      final weatherDescription = forecast['weather'][0]['description'];


      // 하루 기준의 데이터를 출력하거나 처리
      print('Date: $forecastDate');
      print('Weather Description: $weatherDescription');
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

      print('날짜: ${currentMidnight.toString().substring(0, 10)}');
      print('최고 온도: ${maxTemp.toStringAsFixed(1)}');
      print('최저 온도: ${minTemp.toStringAsFixed(1)}');
      print('===================!!!!!!!!!!=');
    }



    // int condition = getWeatherCondition() as int;
    icon = model.getWeatherIcon(condition)!;
    //필요없음  koreanDes = Model.getKoreanWeatherDescription(des!);
    koreanDayOfWeek = Model.getKoreanWeekDay(englishDayOfWeek);
    airState = model.getAirCondition(airDust)!;
    airIcon = model.getAirIcon(airDust)!;


    return Scaffold(
      backgroundColor: Colors.orange,

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
                context,
                MaterialPageRoute(builder: (context) => CityDropdown(),),
              );
            },
          ),
        ],
      ),

      drawer: const Drawer( //햄버거 바
        child: MenuBarDraw(),
      ),


      body: SingleChildScrollView(

        // child: GestureDetector(
        // onHorizontalDragEnd: (DragEndDetails details) {
        // if (details.primaryVelocity! < 0) {
        // Navigator.pushReplacement(
        // context,
        // MaterialPageRoute(builder: (context) =>
        // CharacterPage(),),);}},//전체적인 화면을 위아래로 스크롤
        child: maxTemperature != 100
            ? Column(

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
                        Text('${currentRainFall.toStringAsFixed(1)}mm',
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
                        Text('$currentTemperature°C',
                          style: TextStyle(color: Colors
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

                        SizedBox(height: 28.0),
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
                  Text(' (좌우로 스크롤 !)', style: TextStyle(fontSize: 11.0),),
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
                                //int rainPercent = weatherData['pop'];

                                String englishDescription = weatherData['weather'][0]['description'];
                                koreanDes = getKoreanWeatherDescription(englishDescription);

                                int condition = weatherData['weather'][0]['id'];
                                icon = model.getWeatherIcon(condition)!;

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
                                      Text('$koreanDes($englishDescription)',
                                        style: TextStyle(
                                          fontSize: 10, color: Colors.black,),),
                                      icon,

                                      Text('$rainfall(mm)', style: TextStyle(
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
                        Text(' (위아래로 스크롤 !)', style: TextStyle(fontSize: 11.0),),

                        SizedBox(height: 18.0),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              //주간 예보 칸
                              Container(
                                padding: EdgeInsets.all(40.0),
                                height: 500, color: Colors.orangeAccent,

                                child:   ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  // 여기부터 시작

                                  itemCount: dailyForecasts.length,
                                  itemBuilder: (context, index) {

                                    dynamic forecast = dailyForecasts[index];
                                    String weatherDescription = forecast['weather'][0]['description'];
                                    koreanDes = getKoreanWeatherDescription(weatherDescription);

                                    int condition = forecast['weather'][0]['id'];
                                    icon = model.getWeatherIcon(condition)!;

                                    int timestamp = forecast['dt'];
                                    DateTime time = DateTime
                                        .fromMillisecondsSinceEpoch(
                                        timestamp * 1000);
                                    String formattedTime = DateFormat('HH:mm')
                                        .format(time); // 시간을 HH:mm 형식으로 변환
                                    String weekday = DateFormat.EEEE().format(
                                        time);
                                    String koreanWeekDay = getKoreanWeekDay(weekday);

                                    int dailyMaxTemp = maxTemperatures[index+1].ceil();
                                    int dailyMinTemp = minTemperatures[index+1].floor();


                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [

                                        Column(
                                          children: [
                                            Text(
                                              DateFormat('M월 d일').format(time),

                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,),),
                                            SizedBox(height: 15,),
                                            Text('$koreanWeekDay',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,),),
                                          ] ,
                                        ),



                                        Row( //세로로 아이콘, 최고 최저 기온
                                            children: [

                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 30.0),
                                                child: icon,
                                                // Text('$weatherDescription\n $koreanDes', style: TextStyle(
                                                //   fontSize: 8, color: Colors.black,),),
                                              ),

                                              SizedBox(width: 18.0,),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 30.0),
                                                child:  Text('${dailyMaxTemp}°C',
                                                  style: TextStyle(fontSize: 14.0,color: Colors.white,),),

                                              ),

                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 30.0),
                                                child: Text(' / ',
                                                  style: TextStyle(fontSize: 28.0,color: Colors.white, fontWeight: FontWeight.bold,),),

                                              ),

                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 30.0),
                                                child:  Text('${dailyMinTemp}°C',
                                                  style: TextStyle(fontSize: 14.0,color: Colors.white,),),
                                              ),
                                            ]
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
        ) : Container(

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 222.2),
                Image.asset(
                  'assets/0010.gif', // 로딩 이미지 파일 경로
                  width: 200, // 이미지의 너비 설정
                  height: 200,
                ),
                SizedBox(height: 16),
                Text(
                  'Loading...',
                  style: TextStyle(fontSize: 20),
                ),
              ],

            ),
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
