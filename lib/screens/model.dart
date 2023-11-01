
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class Model {



  Widget? getWeatherIcon(int condition) {
    if (condition < 300) {
      return SvgPicture.asset(
        'assets/weather/icons8-클라우드-조명-50.png', color: Colors.black54,);
    }  else if (condition < 500) {
      return SvgPicture.asset(
        'svg/climacon-cloud_rain.svg',
        color: Colors.black54,
      );
    }else if (condition < 600) {
      return SvgPicture.asset(
        'assets/icons/climacon-cloud_snow_alt.svg', color: Colors.black54,);
    } else if (condition == 800) {
      return SvgPicture.asset(
        'assets/icons/climacon-sun.svg', color: Colors.black54,);
    } else if (condition <= 804) {
      return SvgPicture.asset(
        'assets/icons/climacon-cloud_sun.svg', color: Colors.black54,);
    } else {
      return null;
    }
  }


  Widget? getAirIcon(double airDust) {
    //int airDust = int.parse(code);
    if (0.00 <= airDust && airDust <= 30.99) {
      return Image.asset('assets/image/airconditionbest.png', width: 35.0, height: 35.0,);
    } else if (31.0 <= airDust && airDust <= 80.99) {
      return Image.asset('assets/image/airconditiongood.png', width: 35.0, height: 35.0,);
    } else if (81.0 <= airDust && airDust <= 150.99) {
      return Image.asset('assets/image/airconditionnormal.png', width: 35.0, height: 35.0,);
    } else if (151.0 <= airDust) {
      return Image.asset('assets/image/airconditionbad.png', width: 35.0, height: 35.0,);
    } else {
      return Text('모름', style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w700,),);

    }
  }

  Widget? getAirCondition(double airDust) {
    //int airDust = int.parse(code);
    if (0.0 <= airDust && airDust <= 30.99) {
      return Text("좋음", style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'SUITE', fontWeight: FontWeight.w700,),);
    } else if (31.0 <= airDust && airDust <= 80.99) {
      return Text("보통", style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'SUITE', fontWeight: FontWeight.w700,),);
    } else if (81.0 <= airDust && airDust <= 150.99) {
      return Text("나쁨", style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'SUITE', fontWeight: FontWeight.w700,),);
    } else if (151.0 <= airDust) {
      return Text('매우 나쁨', style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'SUITE', fontWeight: FontWeight.w700,),);
    } else {
      return Text('모름', style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'SUITE', fontWeight: FontWeight.w700,),);
    }
  }

/*
  static String getKoreanWeatherDescription(String englishDescription) {
    //String koreanDes = '';
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
    // return koreanDes;

  }
*/






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


class MappingDoSi {
  static Map<String, List<String>> collectionDoSi = {
    '서울특별시': [  '강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', '용산구', '은평구', '종로구', '중구', '중랑구'],
    '경기도': ['고양시', '과천시', '광명시', '광주시', '구리시', '군포시', '김포시', '남양주시', '동두천시', '부천시', '성남시', '수원시', '시흥시', '안산시', '안성시', '안양시', '양주시', '여주시', '오산시', '용인시', '의왕시', '의정부시', '이천시', '파주시', '평택시', '포천시', '하남시', '화성시', '가평군', '양평군', '연천군'],
    '인천광역시':[  '계양구', '남동구', '동구', '미추홀구', '부평구', '서구', '연수구', '중구', '강화군', '옹진군'],
    '충청남도':[ '공주시', '계룡시', '논산시', '당진시', '보령시', '서산시', '아산시', '천안시', '금산군', '부여군', '서천군', '예산군', '청양군', '태안군', '홍성군'],
    '충청북도':['괴산군', '단양군', '보은군', '영동군', '옥천군', '음성군', '증평군', '진천군', '제천시', '청주시', '충주시'],
    '세종특별자치시':
    [//조치원읍, 연기면, 연동면, 부강면, 금남면, 장군면, 연서면, 전의면, 전동면,
      //  소정면, 한솔동, 도담동, 아름동, 종촌동, 고운동, 보람동, 새롬동, 대평동,
      //  소담동, 다정동, 해밀동, 반곡동, 나성동, 어진동
      '조치원읍'
    ],
    '대전광역시':['대덕구', '동구', '서구', '유성구', '중구'],
    '전라북도':['군산시', '김제시', '남원시', '익산시', '전주시', '정읍시', '고창군', '무주군', '부안군', '순창군', '완주군', '임실군', '장수군', '진안군'],
    '전라남도':['광양시', '나주시', '목포시', '순천시', '여수시', '강진군', '고흥군', '곡성군', '구례군', '담양군', '무안군', '보성군', '신안군', '영광군', '영암군', '완도군', '장성군', '장흥군', '진도군', '함평군', '해남군', '화순군'],
    '광주광역시':['광산구', '남구', '동구', '북구', '서구'],
    '경상북도':[ '경산시', '경주시', '구미시', '김천시', '문경시', '상주시', '안동시', '영주시', '영천시', '포항시', '고령군', '군위군', '봉화군', '성주군', '영덕군', '영양군', '예천군', '울릉군', '울진군', '의성군', '청도군', '청송군', '칠곡군'],
    '경상남도':['거제시', '김해시', '밀양시', '사천시', '양산시', '진주시', '창원시', '통영시', '거창군', '고성군', '남해군', '산청군', '의령군', '창녕군', '하동군', '함안군', '함양군', '합천군'],
    '부산광역시':[ '강서구', '금정구', '남구', '동구', '동래구', '부산진구', '북구', '사상구', '사하구', '서구', '수영구', '연제구', '영도구', '중구', '해운대구', '기장군'],
    '대구광역시':['남구', '달서구', '동구', '북구', '서구', '수성구', '중구', '달성군', '군위군'],
    '울산광역시':[ '남구', '동구', '북구', '중구', '울주군'],
    '강원도':[ '강릉시', '동해시', '삼척시', '속초시', '원주시', '춘천시', '태백시', '고성군', '양구군', '양양군', '영월군', '인제군', '정선군', '철원군', '평창군', '홍천군', '화천군', '횡성군'],
    '제주특별자치시':[ '제주시', '서귀포시'],

  };


  static List<String> collectionDo = [
    '서울특별시',
    '경기도',
    '인천광역시',
    '충청남도',
    '충청북도',
    '세종특별자치시',
    '대전광역시',
    '전라북도',
    '전라남도',
    '광주광역시',
    '경상북도',
    '경상남도',
    '부산광역시',
    '대구광역시',
    '울산광역시',
    '강원도',
    '제주특별자치시'
    // 원하는 도시를 추가할 수 있습니다.
  ];

}
