//날씨 화면입니다
// weather_icons: ^3.0.0 yaml dependencies:에 추가하기
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'menu_bar_draw.dart';

import 'model.dart';


class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseCurrentWeatherData});
  final dynamic parseCurrentWeatherData;



  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();

  var now = DateTime.now(); //오전오후/요일 표기
  var timeHH; //현재 시간 표기
  late DateFormat daysFormat; //요일을 한글로 표기

  var parsed_json;

  var currentTemp; //현재 온도
  var currentREH; //현재 습도
  var currentRAIN1; //1시간 강수량

  var skyCode; //하늘 코드
  var ptyCode; //강수 코드
  late Widget skyIcon; //날씨 아이콘
  late Widget skyDesc; //날씨 설명

  var todayTMN2; //일 최저기온
  var todayTMX2; //일 최고기온
  //반올림하여 int형으로 저장할 예정...
  int? todayTMN;
  int? todayTMX;

  var air10;  //미세먼지
  var air25; //초미세먼지
  late Widget airIcon; //미세먼지 아이콘
  late Widget airDesc;
  late Widget airIcon25; //미세먼지 아이콘
  late Widget airDesc25;

  // String? si ; //시(지역)
  // String? addr ; //동



  //시간대별 날씨 변수(일일 예보)
  var next1, next2, next3, next4, next5, next6, next7, next8, next9, next10,
      next11, next12;

  var next1_TMP, next2_TMP, next3_TMP, next4_TMP, next5_TMP, next6_TMP,
      next7_TMP, next8_TMP,
      next9_TMP, next10_TMP, next11_TMP, next12_TMP; //다음 기온
  late String next1_REH, next2_REH, next3_REH, next4_REH, next5_REH, next6_REH,
      next7_REH, next8_REH,
      next9_REH, next10_REH, next11_REH, next12_REH; //다음 습도
  late String next1_time, next2_time, next3_time, next4_time, next5time,
      next6_time,
      next7_time, next8_time, next9_time, next10_time, next11_time,
      next12_time; // 다음 시간
  late String next1_PTY, next2_PTY, next3_PTY, next4_PTY, next5_PTY, next6_PTY,
      next7_PTY, next8_PTY,
      next9_PTY, next10_PTY, next11_PTY, next12_PTY; //다음 pty 코드
  late String next1_SKY, next2_SKY, next3_SKY, next4_SKY, next5_SKY, next6_SKY,
      next7_SKY, next8_SKY,
      next9_SKY, next10_SKY, next11_SKY, next12_SKY; //다음 SKY 코드
  late Widget current_icon, next1_icon, next2_icon, next3_icon, next4_icon,
      next5_icon, next6_icon,
      next7_icon, next8_icon, next9_icon, next10_icon, next11_icon, next12_icon;


  String? today;



  //일주일간 날씨 변수(주간 예보)
//    월
//     화
//     수
//      목
//       금
//       토
//       일


  String getSystemTime() {
    return DateFormat("h:mm a").format(now);
  }

  //weatherScreen이 생성되는 순간, loading에서 추출한 정보를 바로 출력
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    daysFormat = new DateFormat.EEEE('ko'); //요일을 한글로 표현
    updateData(widget.parseCurrentWeatherData);
  }

  //시간대별 날씨
  void weatherTime() {
    if (now.hour < 2) {
      next1 = '0200';
      next2 = '0400';
      next3 = '0600';
      next4 = '0800';
      next5 = '1000';
      next6 = '1200';
      next7 = '1400';
      next8 = '1600';
      next9 = '1800';
      next10 = '2000';
      next11 = '2200';
      next12 = '0000';
    } else if (now.hour < 4) {
      next1 = '0400';
      next2 = '0600';
      next3 = '0800';
      next4 = '1000';
      next5 = '1200';
      next6 = '1400';
      next7 = '1600';
      next8 = '1800';
      next9 = '2000';
      next10 = '2200';
      next11 = '0000';
      next12 = '2200';
    } else if (now.hour < 6) {
      next1 = '0600';
      next2 = '0800';
      next3 = '1000';
      next4 = '1200';
      next5 = '1400';
      next6 = '1600';
      next7 = '1800';
      next8 = '2000';
      next9 = '2200';
      next10 = '0000';
      next11 = '0200';
      next12 = '0400';
    } else if (now.hour < 8) {
      next1 = '0800';
      next2 = '1000';
      next3 = '1200';
      next4 = '1400';
      next5 = '1600';
      next6 = '1800';
      next7 = '2000';
      next8 = '2200';
      next9 = '0000';
      next10 = '0200';
      next11 = '0400';
      next12 = '0600';
    } else if (now.hour < 10) {
      next1 = '1000';
      next2 = '1200';
      next3 = '1400';
      next4 = '1600';
      next5 = '1800';
      next6 = '2000';
      next7 = '2200';
      next8 = '0000';
      next9 = '0200';
      next10 = '0400';
      next11 = '0600';
      next12 = '0800';
    } else if (now.hour < 12) {
      next1 = '1200';
      next2 = '1400';
      next3 = '1600';
      next4 = '1800';
      next5 = '2000';
      next6 = '2200';
      next7 = '0000';
      next8 = '0200';
      next9 = '0400';
      next10 = '0600';
      next11 = '0800';
      next12 = '1000';
    } else if (now.hour < 14) {
      next1 = '1400';
      next2 = '1600';
      next3 = '1800';
      next4 = '2000';
      next5 = '2200';
      next6 = '0000';
      next7 = '0200';
      next8 = '0400';
      next9 = '0600';
      next10 = '0800';
      next11 = '1000';
      next12 = '1200';
    } else if (now.hour < 16) {
      next1 = '1600';
      next2 = '1800';
      next3 = '2000';
      next4 = '2200';
      next5 = '0000';
      next6 = '0200';
      next7 = '0400';
      next8 = '0600';
      next9 = '0800';
      next10 = '1000';
      next11 = '1200';
      next12 = '1400';
    } else if (now.hour < 18) {
      next1 = '1800';
      next2 = '2000';
      next3 = '2200';
      next4 = '0000';
      next5 = '0200';
      next6 = '0400';
      next7 = '0600';
      next8 = '0800';
      next9 = '1000';
      next10 = '1200';
      next11 = '1400';
      next12 = '1600';
    } else if (now.hour < 20) {
      next1 = '2000';
      next2 = '2200';
      next3 = '0000';
      next4 = '0200';
      next5 = '0400';
      next6 = '0600';
      next7 = '0800';
      next8 = '1000';
      next9 = '1200';
      next10 = '1400';
      next11 = '1600';
      next12 = '1800';
    } else if (now.hour < 22) {
      next1 = '2200';
      next2 = '0000';
      next3 = '0200';
      next4 = '0400';
      next5 = '0600';
      next6 = '0800';
      next7 = '1000';
      next8 = '1200';
      next9 = '1400';
      next10 = '1600';
      next11 = '1800';
      next12 = '2000';
    } else {
      //if(now.hour < 01 || (now.hour > 00 && now.minute <= 59))
      next1 = '0000';
      next2 = '0200';
      next3 = '0400';
      next4 = '0600';
      next5 = '0800';
      next6 = '1000';
      next7 = '1200';
      next8 = '1400';
      next9 = '1600';
      next10 = '1800';
      next11 = '2000';
      next12 = '2200';
    }
    print(
        '$next1 $next2 $next3 $next4 $next5 $next6 $next7 $next8 $next9 $next10 $next11 $next12');
  }

  String? timeDesc(next) {
    if (next == '0000') {
      return '0시';
    } else if (next == '0200') {
      return '2시';
    } else if (next == '0400') {
      return '4시';
    } else if (next == '0600') {
      return '6시';
    } else if (next == '0800') {
      return '8시';
    } else if (next == '1000') {
      return '10시';
    } else if (next == '1200') {
      return '12시';
    } else if (next == '1400') {
      return '14시';
    } else if (next == '1600') {
      return '16시';
    } else if (next == '1800') {
      return '18시';
    } else if (next == '2000') {
      return '20시';
    } else if (next == '2200') {
      return '22시';
    }
  }


  void updateData(dynamic currentWeatherData) {
    today = DateFormat('yyyyMMdd').format(now);


    //일주일간 날씨
    // tmr = DateFormat('yyyyMMdd').format(now.add(Duration(days:1)));
    // df_tmr = DateFormat('yyyyMMdd').format(now.add(Duration(days:2)));
    timeHH = DateFormat('HH00').format(now.add(Duration(minutes: 30)));

    print(today.toString());
    // print(tmr.toString());
    // print(df_tmr.toString());
    print(timeHH.toString());

    // //2시 데이터
    // int totalCount = today2amData['response']['body']['totalCount']; //데이터의 총 갯수
    // for (int i = 0; i < totalCount; i++) { //데이터 전체를 돌면서 원하는 데이터 추출
    //   var parsedJson = today2amData['response']['body']['items']['item'][i];
    //   if (now.hour < 2) { //2시 이전, 23시 데이터
    //     if (parsedJson['category'] == 'TMN') {
    //       todayTMN2 = parsedJson['fcstValue'];
    //     }
    //     //당일 최고 기온
    //     if (parsedJson['category'] == 'TMX') {
    //       todayTMX2 = parsedJson['fcstValue'];
    //       break;
    //     }
    //   } else { //2시 이후
    //     //당일 최저 기온
    //     if (parsedJson['category'] == 'TMN' &&
    //         parsedJson['baseDate'] == parsedJson['fcstDate']) {
    //       todayTMN2 = parsedJson['fcstValue'];
    //     }
    //     //당일 최고 기온
    //     if (parsedJson['category'] == 'TMX' &&
    //         parsedJson['baseDate'] == parsedJson['fcstDate']) {
    //       todayTMX2 = parsedJson['fcstValue'];
    //     }
    //   }
    // }


    //   //오늘 오전, 오후 sky, pty 코드
    //   if(parsed_json['fcstDate'] == today) {
    //     if(parsed_json['fcstTime'] == '0600'){
    //       if (parsed_json['category'] == 'SKY'){
    //         td_sky_6 = parsed_json['fcstValue'];
    //       }
    //       if (parsed_json['category'] == 'PTY'){
    //         td_pty_6 = parsed_json['fcstValue'];
    //       }
    //     }
    //     if(parsed_json['fcstTime'] == '1800'){
    //       if (parsed_json['category'] == 'SKY'){
    //         td_sky_18 = parsed_json['fcstValue'];
    //       }
    //       if (parsed_json['category'] == 'PTY'){
    //         td_pty_18 = parsed_json['fcstValue'];
    //       }
    //     }
    //   }
    // }
    //
    // td_icon_6 = model.getSkyIcon(td_sky_6, td_pty_6, 50, 50, '0600')!;
    // td_icon_18 = model.getSkyIcon(td_sky_18, td_pty_18, 50, 50, '1800')!;

    // todayTMN = double.parse('$todayTMN2').round(); //반올림
    // todayTMX = double.parse('$todayTMX2').round();

    //초단기 실황
    //현재 온도
    currentTemp = currentWeatherData['response']['body']['items']['item'][3]['obsrValue'];
    //습도
    currentREH = currentWeatherData['response']['body']['items']['item'][1]['obsrValue'];
    //1시간 강수량
    currentRAIN1 = currentWeatherData['response']['body']['items']['item'][2]['obsrValue'];

    // //초단기 예보
    // int totalCount3 = superShortWeatherData['response']['body']['totalCount'];
    // for (int i = 0; i < totalCount3; i++) {
    //   var parsed_json = superShortWeatherData['response']['body']['items']['item'][i];
    //   //PTY 코드값
    //   if (parsed_json['category'] == 'PTY' &&
    //       parsed_json['fcstTime'] == timeHH) {
    //     ptyCode = parsed_json['fcstValue'];
    //   }
    //   //SKY 코드값
    //   if (parsed_json['category'] == 'SKY' &&
    //       parsed_json['fcstTime'] == timeHH) {
    //     skyCode = parsed_json['fcstValue'];
    //   }
    // }
    // //pty, sky, 날씨 아이콘
    // current_icon = model.getSkyIcon(skyCode, ptyCode, 60, 60, timeHH)!;
    // skyIcon = model.getSkyIcon(skyCode, ptyCode, 180, 180, timeHH)!;
    // skyDesc = model.getSkyDesc(skyCode, ptyCode)!;
    //
    // //미세먼지
    // air10 = airConditionData['response']['body']['items'][0]['pm10Value'];
    // air25 = airConditionData['response']['body']['items'][0]['pm25Value'];
    //
    // //관측소 에러처리
    // if(air10 == '-'){
    //   air10 = '장비점검';
    //   airIcon = model.getAirIcon('0')!;
    //   airDesc = model.getAirDesc('-1')!;
    // } else {
    //   airIcon = model.getAirIcon(air10)!;
    //   airDesc = model.getAirDesc(air10)!;
    // }
    //
    // if(air25 == '-'){
    //   air25 = '장비점검';
    //   airIcon25 = model.getAirIcon('0')!;
    //   airDesc25 = model.getAirDesc('-1')!;
    // } else {
    //   airIcon25 = model.getAirIcon25(air25)!;
    //   airDesc25 = model.getAirDesc25(air25)!;
    // }

    //주소
    // si = addrData['documents'][0]['address']['region_2depth_name'];
    // addr = addrData['documents'][0]['address']['region_3depth_name'];
  }


  //단기예보
  //   주간날씨
  // 월
  // 화
  // 수
  // 목
  // 금
  // 토
  // 일

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
              print("search button is clicked");
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
            Container(
              height: 200.0,
              color: Colors.blue, //#투명 = transparent
              child: Row(
                children: [
                  Container(
                    width: 100.0,
                    height: 80.0,
                    margin: EdgeInsets.all(40.0),
                    padding: EdgeInsets.all(3.0),

                    child: Image.asset('assets/image/bad.png'),
                  ),


                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 40.0),
                        // Text('Seoul', style: TextStyle(color: Colors.white,
                        //   fontSize: 28.0,
                        //   fontWeight: FontWeight.bold,),),
                        SizedBox(height: 15,),
                        Text('죽전동',
                          style: TextStyle(fontSize: 25, color: Colors.white),),

                        SizedBox(height: 5.0,),
                        Text('(용인시)',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),),

                        SizedBox(height: 20.0),
                        Text('$currentTemp°C', style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),),

                        SizedBox(height: 10.0),
                        Text('  "맑음"', style: TextStyle(
                            color: Colors.white, fontSize: 18.0),),
                      ],
                    ),
                  ),

                  SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),
                        Text(
                          DateFormat('M월 d일 ').format(now) + daysFormat.format(now),
                          style: TextStyle(
                            color: Colors.white, fontSize: 12.0,),
                        ),

                        SizedBox(height: 10.0),
                        Text(
                          '최고: 15C',
                          style: TextStyle(
                            color: Colors.white, fontSize: 16.0,),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '최저: 15C', style: TextStyle(
                          color: Colors.white, fontSize: 16.0,),
                        ),
                        SizedBox(height: 18.0),
                        Text(
                          '미세먼지',
                          style: TextStyle(
                            color: Colors.white, fontSize: 16.0,),
                        ),
                        SizedBox(height: 10.0),
                        Image.asset(
                          'assets/image/bad.png', height: 50.0, width: 50.0,),
                      ],
                    ),
                  ),
                ],
              ),
            ),


            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('일일예보', style: TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold,),),

                  SizedBox(height: 20.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        weatherTexts.length,
                            (index) =>
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              child: Column(
                                children: [
                                  Text('${index + 1}시',
                                    style: TextStyle(fontSize: 16.0,),
                                  ),

                                  Icon(Icons.cloud),

                                  Text('${index + 1}°C',
                                    style: TextStyle(fontSize: 16.0,),),

                                  Text('${index + 1}mm',
                                    style: TextStyle(fontSize: 16.0,),),
                                ],
                              ),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            SizedBox(height: 20.0),
            Container(
              height: 700.0,
              color: Colors.orange,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('주간 예보', style: TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold,),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

