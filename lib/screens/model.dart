
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class Model {



  Widget? getWeatherIcon(int condition) {
    if (condition < 300) {
      return SvgPicture.asset(
        'assets/icons/climacon-cloud_lightning.svg', color: Colors.white,);
    } else if (condition < 600) {
      return SvgPicture.asset(
        'assets/icons/climacon-cloud_snow_alt.svg', color: Colors.white,);
    } else if (condition == 800) {
      return SvgPicture.asset(
        'assets/icons/climacon-sun.svg', color: Colors.white,);
    } else if (condition <= 804) {
      return SvgPicture.asset(
        'assets/icons/climacon-cloud_sun.svg', color: Colors.white,);
    }
  }


  Widget? getAirIcon(double airDust) {
    //int airDust = int.parse(code);
    if (0.0 <= airDust && airDust <= 30.0) {
      return Image.asset('assets/image/airconditiongood.png', width: 70.0, height: 70.0,);
    } else if (31.0 <= airDust && airDust <= 80.0) {
      return Image.asset('assets/image/airconditionnormal.png', width: 70.0, height: 70.0,);
    } else if (81.0 <= airDust && airDust <= 150.0) {
      return Image.asset('assets/image/airconditionbad.png', width: 70.0, height: 70.0,);
    } else if (151.0 <= airDust) {
      return Image.asset('assets/image/airconditionworst.png', width: 70.0, height: 70.0,);
    } else {
      return Text('정보없음', style: TextStyle(fontSize: 18.0, color: Colors.white,),);

    }
  }

  Widget? getAirCondition(double airDust) {
    //int airDust = int.parse(code);
    if (0.0 <= airDust && airDust <= 30.0) {
      return Text("좋음", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold,),);
    } else if (31.0 <= airDust && airDust <= 80.0) {
      return Text("보통", style: TextStyle(
        color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold,),);
    } else if (81.0 <= airDust && airDust <= 150.0) {
      return Text("나쁨", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold,),);
    } else if (151.0 <= airDust) {
      return Text('매우 나쁨', style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold,),);
    } else {
      return Text('정보없음', style: TextStyle(fontSize: 18.0, color: Colors.white,),);
    }
  }



  static String getKoreanWeatherDescription(String englishDescription) {
    switch (englishDescription) {
      case 'clear sky':
        return '맑음';
      case 'few clouds':
      case 'scattered clouds':
      case 'broken clouds':
        return '구름';
      case 'shower rain':
      case 'light intensity shower rain':
      case 'heavy intensity shower rain':
      case 'ragged shower rain':
        return '소나기';
      case 'rain':
      case 'light rain':
      case 'moderate rain':
      case 'heavy intensity rain':
      case 'very heavy rain':
      case 'extreme rain':
      case 'freezing rain':
        return '많은 비';
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
        return '천둥번개';
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
        return '눈';
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'sand/dust whirls':
      case 'fog':
      case 'sand':
      case 'dust':
        return '안개';
      case 'volcanic ash':
        return '화산재';
      case 'squalls':
        return '돌풍';
      case 'tornado':
        return '토네이도(회오리 바람)';
      case 'drizzle':
      case 'light intensity drizzle':
      case 'heavy intensity drizzle':
      case 'light intensity drizzle rain':
      case 'drizzle rain':
      case 'heavy intensity drizzle rain':
      case 'shower rain and drizzle':
      case 'heavy shower rain and drizzle':
      case 'shower drizzle' :
        return '이슬비';
      case 'overcast clouds':
        return '흐림';
      default:
        return englishDescription;
    }
  }

  static String getKoreanWeekDay(String englishWeekDay) {
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



