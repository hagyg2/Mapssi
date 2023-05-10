import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseShortWeatherData, this.parseCurrentWeatherData, this.parseLongWeatherData});

  final dynamic parseShortWeatherData;
  final dynamic parseCurrentWeatherData;
  final dynamic parseLongWeatherData;
  // final dynamic parseAirConditionData;


  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Image image = Image(image: null,);

  var now = DateTime.now();
  var timeHH; //현재 시간 HH00
  late DateFormat daysFormat; //요일 한글로

  var todayTMX2;//일 최고기온
  var todayTMN2;//일 최저기온
  var parsed_json;
  int? todayTMX;
  int? todayTMN;

  var currentT1H; //현재 기온
  String? currentREH; //현재 습도
  String? currentRN1; //1시간 강수량

  var skyCode; //하늘코드
  var ptyCode; //강수코드
  late Widget skyIcon;  //날씨 아이콘
  late Widget skyDesc; //날씨 설명


  var air10;  //미세먼지
  var air25; //초미세먼지
  late Widget airIcon; //미세먼지 아이콘
  late Widget airDesc;
  late Widget airIcon25; //미세먼지 아이콘
  late Widget airDesc25;

  String? si; //시
  String? addr; //동

  //시간대별 날씨 변수
  var next1, next2, next3, next4;
  var next1_TMP, next2_TMP, next3_TMP, next4_TMP; //다음 기온
  late String next1_REH, next2_REH, next3_REH, next4_REH;//다음 습도
  late String next1_time, next2_time, next3_time, next4_time;// 다음 시간
  late String next1_PTY, next2_PTY, next3_PTY, next4_PTY; //다음 pty 코드
  late String next1_SKY, next2_SKY, next3_SKY, next4_SKY; //다음 SKY 코드
  late Widget current_icon, next1_icon, next2_icon, next3_icon, next4_icon;// 다음 아이콘

  //3일간 날씨 변수
  String? today;
  String? tmr;
  String? df_tmr;
  String? tmr_REH; //내일 습도
  String? df_tmr_REH; //모레 습도
  int? tmr_tmn;
  int? tmr_tmx;
  int? df_tmr_tmn;
  int? df_tmr_tmx;
  var tmr_tmn2;
  var tmr_tmx2;
  var df_tmr_tmn2;
  var df_tmr_tmx2;
  late String td_sky_6, td_sky_18, tmr_sky_6, tmr_sky_18, df_tmr_sky_6, df_tmr_sky_18;
  late String td_pty_6, td_pty_18, tmr_pty_6, tmr_pty_18, df_tmr_pty_6, df_tmr_pty_18;
  late Widget td_icon_6, td_icon_18, tmr_icon_6, tmr_icon_18, df_tmr_icon_6, df_tmr_icon_18;


  String getSystemTime(){
    return DateFormat("h:mm a").format(now);
  }

  void initState(){
    super.initState();
    initializeDateFormatting();
    daysFormat = new DateFormat.EEEE('ko'); //요일 한글 표현
    updateData(widget.parse2amData, widget.parseShortTermWeatherData, widget.parseCurrentWeatherData,
        widget.parseSuperShortWeatherData, widget.parseAirConditionData, widget.parseAddrData
    );
  }

  void weatherTime(){
    if(now.hour < 3){
      next1 = '0300';
      next2 = '0600';
      next3 = '0900';
      next4 = '1200';
    } else if(now.hour < 6){
      next1 = '0600';
      next2 = '0900';
      next3 = '1200';
      next4 = '1500';
    } else if(now.hour < 9){
      next1 = '0900';
      next2 = '1200';
      next3 = '1500';
      next4 = '1800';
    } else if(now.hour < 12){
      next1 = '1200';
      next2 = '1500';
      next3 = '1800';
      next4 = '2100';
    } else if(now.hour < 15){
      next1 = '1500';
      next2 = '1800';
      next3 = '2100';
      next4 = '0000';
    } else if(now.hour < 18){
      next1 = '1800';
      next2 = '2100';
      next3 = '0000';
      next4 = '0300';
    } else if(now.hour < 21){
      next1 = '2100';
      next2 = '0000';
      next3 = '0300';
      next4 = '0600';
    } else {
      //if(now.hour < 23 || (now.hour < 23 && now.minute <= 59))
      next1 = '0000';
      next2 = '0300';
      next3 = '0600';
      next4 = '0900';
    }
    print('$next1 $next2 $next3 $next4');
  }

  String? timeDesc(next){
    if(next == '0000'){
      return '0시';
    } else if(next == '0300'){
      return '3시';
    } else if(next == '0600'){
      return '6시';
    } else if(next == '0900'){
      return '9시';
    } else if(next == '1200'){
      return '12시';
    } else if(next == '1500'){
      return '15시';
    } else if(next == '1800'){
      return '18시';
    } else if(next == '2100'){
      return '21시';
    }
  }

  void updateData(dynamic today2amData, dynamic shortTermWeatherData, dynamic currentWeatherData,
      dynamic superShortWeatherData, dynamic airConditionData, dynamic addrData){
    // print('addr: $addrData');
    // print('1: $todayTMNData');
    // print('2a: $todayTMXData');
    // print('3: $shortTermWeatherData');
    // print('4a: $currentWeatherData');
    // print('5: $superShortWeatherData');
    // print('6: $airConditionData');
    today = DateFormat('yyyyMMdd').format(now);
    tmr = DateFormat('yyyyMMdd').format(now.add(Duration(days:1)));
    df_tmr = DateFormat('yyyyMMdd').format(now.add(Duration(days:2)));
    timeHH = DateFormat('HH00').format(now.add(Duration(minutes:30)));

    print(today.toString());
    print(tmr.toString());
    print(df_tmr.toString());
    print(timeHH.toString());

    //2시 데이터
    int totalCount = today2amData['response']['body']['totalCount'];//데이터의 총 갯수
    for(int i = 0; i< totalCount; i++) { //데이터 전체를 돌면서 원하는 데이터 추출
      parsed_json = today2amData['response']['body']['items']['item'][i];
      if(now.hour < 2){ //2시 이전, 23시 데이터
        if (parsed_json['category'] == 'TMN') {
          todayTMN2 = parsed_json['fcstValue'];
        }
        //당일 최고 기온
        if (parsed_json['category'] == 'TMX') {
          todayTMX2 = parsed_json['fcstValue'];
          break;
        }
      } else { //2시 이후
        //당일 최저 기온
        if (parsed_json['category'] == 'TMN' &&
            parsed_json['baseDate'] == parsed_json['fcstDate']) {
          todayTMN2 = parsed_json['fcstValue'];
        }
        //당일 최고 기온
        if (parsed_json['category'] == 'TMX' &&
            parsed_json['baseDate'] == parsed_json['fcstDate']) {
          todayTMX2 = parsed_json['fcstValue'];
        }
      }

      //오늘 오전, 오후 sky, pty 코드
      if(parsed_json['fcstDate'] == today) {
        if(parsed_json['fcstTime'] == '0600'){
          if (parsed_json['category'] == 'SKY'){
            td_sky_6 = parsed_json['fcstValue'];
          }
          if (parsed_json['category'] == 'PTY'){
            td_pty_6 = parsed_json['fcstValue'];
          }
        }
        if(parsed_json['fcstTime'] == '1800'){
          if (parsed_json['category'] == 'SKY'){
            td_sky_18 = parsed_json['fcstValue'];
          }
          if (parsed_json['category'] == 'PTY'){
            td_pty_18 = parsed_json['fcstValue'];
          }
        }
      }
    }
    td_icon_6 = model.getSkyIcon(td_sky_6, td_pty_6, 50, 50, '0600')!;
    td_icon_18 = model.getSkyIcon(td_sky_18, td_pty_18, 50, 50, '1800')!;
    //td_sky_18과 td_pty_18은 0시 ~ 2시 사이에 에러 발생.
    todayTMN = double.parse('$todayTMN2').round(); //반올림
    todayTMX = double.parse('$todayTMX2').round();

    //단기예보
    //내일, 모레 최고 최저 온도
    String timeHHString = timeHH.toString();
    int totalCount2 = shortTermWeatherData['response']['body']['totalCount'];
    weatherTime();
    for(int i = 0; i< totalCount2; i++) { //데이터 전체를 돌면서 원하는 데이터 추출
      parsed_json = shortTermWeatherData['response']['body']['items']['item'][i];
      //기온 & 시간
      if (parsed_json['category'] == 'TMP' && ( parsed_json['fcstDate'] == today || parsed_json['fcstDate'] == tmr)) {
        if (parsed_json['fcstTime'] == next1) {
          next1_TMP = parsed_json['fcstValue'];
          next1_time = timeDesc(next1)!;
        }
        if (parsed_json['fcstTime'] == next2) {
          next2_TMP = parsed_json['fcstValue'];
          next2_time = timeDesc(next2)!;
        }
        if (parsed_json['fcstTime'] == next3) {
          next3_TMP = parsed_json['fcstValue'];
          next3_time = timeDesc(next3)!;
        }
        if (parsed_json['fcstTime'] == next4) {
          next4_TMP = parsed_json['fcstValue'];
          next4_time = timeDesc(next4)!;
        }
      }
      //습도
      if (parsed_json['category'] == 'REH' && ( parsed_json['fcstDate'] == today || parsed_json['fcstDate'] == tmr)) {
        if (parsed_json['fcstTime'] == next1) {
          next1_REH = parsed_json['fcstValue'];
        }
        if (parsed_json['fcstTime'] == next2) {
          next2_REH = parsed_json['fcstValue'];
        }
        if (parsed_json['fcstTime'] == next3) {
          next3_REH = parsed_json['fcstValue'];
        }
        if (parsed_json['fcstTime'] == next4) {
          next4_REH = parsed_json['fcstValue'];
        }
      }
      //SKY 코드값
      if (parsed_json['category'] == 'SKY') {
        //4일 sky 코드
        if(parsed_json['fcstDate'] == today || parsed_json['fcstDate'] == tmr){
          if (parsed_json['fcstTime'] == next1) {
            next1_SKY = parsed_json['fcstValue'];
          }
          if (parsed_json['fcstTime'] == next2) {
            next2_SKY = parsed_json['fcstValue'];
          }
          if (parsed_json['fcstTime'] == next3) {
            next3_SKY = parsed_json['fcstValue'];
          }
          if (parsed_json['fcstTime'] == next4) {
            next4_SKY = parsed_json['fcstValue'];
          }
        }

        //내일, 모레 sky 코드
        if(parsed_json['fcstDate'] == tmr){ //내일
          //6시
          if(parsed_json['fcstTime'] == '0600'){
            tmr_sky_6 = parsed_json['fcstValue'];
          }
          //18시
          if(parsed_json['fcstTime'] == '1800'){
            tmr_sky_18 = parsed_json['fcstValue'];
          }
        }
        //모레
        if(parsed_json['fcstDate'] == df_tmr){
          //6시
          if(parsed_json['fcstTime'] == '0600'){
            df_tmr_sky_6 = parsed_json['fcstValue'];
          }
          //18시
          if(parsed_json['fcstTime'] == '1800'){
            df_tmr_sky_18 = parsed_json['fcstValue'];
          }
        }
      }

      //PTY 코드값
      if (parsed_json['category'] == 'PTY') {
        //4일 PTY 코드
        if(parsed_json['fcstDate'] == today || parsed_json['fcstDate'] == tmr){
          if (parsed_json['fcstTime'] == next1) {
            next1_PTY = parsed_json['fcstValue'];
          }
          if (parsed_json['fcstTime'] == next2) {
            next2_PTY = parsed_json['fcstValue'];
          }
          if (parsed_json['fcstTime'] == next3) {
            next3_PTY = parsed_json['fcstValue'];
          }
          if (parsed_json['fcstTime'] == next4) {
            next4_PTY = parsed_json['fcstValue'];
          }
        }

        //내일, 모레 pty 코드
        if(parsed_json['fcstDate'] == tmr){ //내일
          //6시
          if(parsed_json['fcstTime'] == '0600'){
            tmr_pty_6 = parsed_json['fcstValue'];
          }
          //18시
          if(parsed_json['fcstTime'] == '1800'){
            tmr_pty_18 = parsed_json['fcstValue'];
          }
        }
        //모레
        if(parsed_json['fcstDate'] == df_tmr){
          //6시
          if(parsed_json['fcstTime'] == '0600'){
            df_tmr_pty_6 = parsed_json['fcstValue'];
          }
          //18시
          if(parsed_json['fcstTime'] == '1800'){
            df_tmr_pty_18 = parsed_json['fcstValue'];
          }
        }
      }

      if(parsed_json['category'] == 'TMN'){
        if (parsed_json['fcstDate'] == tmr) {
          tmr_tmn2 = parsed_json['fcstValue'];
        }
        if (parsed_json['fcstDate'] == df_tmr) {
          df_tmr_tmn2 = parsed_json['fcstValue'];
        }
      }

      if(parsed_json['category'] == 'TMX'){
        if (parsed_json['fcstDate'] == tmr) {
          tmr_tmx2 = parsed_json['fcstValue'];
        }
        if (parsed_json['fcstDate'] == df_tmr) {
          df_tmr_tmx2 = parsed_json['fcstValue'];
        }
      }
    }
    next1_icon = model.getSkyIcon(next1_SKY, next1_PTY, 60, 60, next1)!;
    next2_icon = model.getSkyIcon(next2_SKY, next2_PTY, 60, 60, next2)!;
    next3_icon = model.getSkyIcon(next3_SKY, next3_PTY, 60, 60, next3)!;
    next4_icon = model.getSkyIcon(next4_SKY, next4_PTY, 60, 60, next4)!;
    tmr_icon_6 = model.getSkyIcon(tmr_sky_6, tmr_pty_6, 50, 50, '0600')!;
    tmr_icon_18 = model.getSkyIcon(tmr_sky_18, tmr_pty_18, 50, 50, '1800')!;
    df_tmr_icon_6 = model.getSkyIcon(df_tmr_sky_6, df_tmr_pty_6, 50, 50, '0600')!;
    df_tmr_icon_18 = model.getSkyIcon(df_tmr_sky_18, df_tmr_pty_18, 50, 50, '1800')!;
    tmr_tmn = double.parse('$tmr_tmn2').round();
    tmr_tmx = double.parse('$tmr_tmx2').round();
    df_tmr_tmn = double.parse('$df_tmr_tmn2').round();
    df_tmr_tmx = double.parse('$df_tmr_tmx2').round();

    //초단기 실황
    //현재 온도
    currentT1H = currentWeatherData['response']['body']['items']['item'][3]['obsrValue'];
    //습도
    currentREH = currentWeatherData['response']['body']['items']['item'][1]['obsrValue'];
    //1시간 강수량
    currentRN1 = currentWeatherData['response']['body']['items']['item'][2]['obsrValue'];

    //초단기 예보
    int totalCount3 = superShortWeatherData['response']['body']['totalCount'];
    for(int i = 0; i< totalCount3; i++){
      parsed_json = superShortWeatherData['response']['body']['items']['item'][i];
      //PTY 코드값
      if(parsed_json['category']=='PTY' && parsed_json['fcstTime']==timeHH){
        ptyCode = parsed_json['fcstValue'];
      }
      //SKY 코드값
      if(parsed_json['category']=='SKY' && parsed_json['fcstTime']==timeHH){
        skyCode = parsed_json['fcstValue'];
      }
    }
    //pty, sky, 날씨 아이콘
    current_icon = model.getSkyIcon(skyCode, ptyCode, 60, 60, timeHHString)!;
    skyIcon = model.getSkyIcon(skyCode, ptyCode, 180, 180, timeHHString)!;
    skyDesc = model.getSkyDesc(skyCode, ptyCode)!;

    //미세먼지
    air10 = airConditionData['response']['body']['items'][0]['pm10Value'];
    air25 = airConditionData['response']['body']['items'][0]['pm25Value'];

    //관측소 에러처리
    if(air10 == '-'){
      air10 = '장비점검';
      airIcon = model.getAirIcon('0')!;
      airDesc = model.getAirDesc('-1')!;
    } else {
      airIcon = model.getAirIcon(air10)!;
      airDesc = model.getAirDesc(air10)!;
    }

    if(air25 == '-'){
      air25 = '장비점검';
      airIcon25 = model.getAirIcon('0')!;
      airDesc25 = model.getAirDesc('-1')!;
    } else {
      airIcon25 = model.getAirIcon25(air25)!;
      airDesc25 = model.getAirDesc25(air25)!;
    }

    //주소
    si = addrData['documents'][0]['address']['region_2depth_name'];
    addr = addrData['documents'][0]['address']['region_3depth_name'];
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
// TODO Implement this library.