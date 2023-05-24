import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class Model {
  Widget? getSkyIcon(String sky, String pty, double wSize, double hSize, String now) {
    int time = int.parse(now);
    print(sky +" "+ pty);
    if (pty == '0') {
      if (sky == '1') { //맑음
        if (time < 500 || time > 1900) { //오후 7시~새벽 5시까지 night 아이콘
          return SvgPicture.asset(
            'assets/weather_icon/clear-night.svg',
            width: wSize,
            height: hSize,
          );
        } else {
          return SvgPicture.asset(
            'assets/weather_icon/clear-day.svg',
            width: wSize,
            height: hSize,
          );
        }
      } else if (sky == '3') { //구름 많음
        if (time < 500 || time > 1900) { //오후 7시~새벽 5시까지 night 아이콘
          return SvgPicture.asset(
            'assets/weather_icon/partly-cloudy-night.svg',
            width: wSize,
            height: hSize,
          );
        } else {
          return SvgPicture.asset(
            'assets/weather_icon/partly-cloudy-day.svg',
            width: wSize,
            height: hSize,
          );
        }
      } else if (sky == '4') { //흐림
        return SvgPicture.asset(
          'assets/weather_icon/cloudy.svg',
          width: wSize,
          height: hSize,
        );
      }
    } else if (pty == '1') { //비
      return SvgPicture.asset(
        'assets/weather_icon/rain.svg',
        width: wSize,
        height: hSize,
      );
    } else if (pty == '2') { //비/눈
      if (time < 500 || time > 1900) { //오후 7시~새벽 5시까지 night 아이콘
        return SvgPicture.asset(
          'assets/weather_icon/partly-cloudy-night-sleet.svg',
          width: wSize,
          height: hSize,
        );
      } else {
        return SvgPicture.asset(
          'assets/weather_icon/partly-cloudy-day-sleet.svg',
          width: wSize,
          height: hSize,
        );
      }
    } else if (pty == '3') { //눈
      return SvgPicture.asset(
        'assets/weather_icon/snow.svg',
        width: wSize,
        height: hSize,
      );
    } else if (pty == '5') { //빗방울
      return SvgPicture.asset(
        'assets/weather_icon/drizzle.svg',
        width: wSize,
        height: hSize,
      );
    } else if (pty == '6') { //빗방울눈날림
      return SvgPicture.asset(
        'assets/weather_icon/sleet.svg',
        width: wSize,
        height: hSize,
      );
    } else if (pty == '7') { //눈날림
      return SvgPicture.asset(
        'assets/weather_icon/snow.svg',
        width: wSize,
        height: hSize,
      );
    }
  }

  Widget? getSkyDesc(String sky, String pty) {
    if (pty == '0') {
      if (sky == '1') { //맑음
        return Text('맑음',
            style: TextStyle(
                fontFamily: 'tmon',
                fontSize: 20.0,
                color: Colors.white
            )
        );
      } else if (sky == '3') { //구름 많음
        return Text('구름 많음',
            style: TextStyle(
                fontFamily: 'tmon',
                fontSize: 20.0,
                color: Colors.white
            )
        );
      } else if (sky == '4') { //흐림
        return Text('흐림',
            style: TextStyle(
                fontFamily: 'tmon',
                fontSize: 20.0,
                color: Colors.white
            )
        );
      }
    } else if (pty == '1') { //비
      return Text('비',
          style: TextStyle(
              fontFamily: 'tmon',
              fontSize: 20.0,
              color: Colors.white
          )
      );
    } else if (pty == '2') { //비/눈
      return Text('진눈개비',
          style: TextStyle(
              fontFamily: 'tmon',
              fontSize: 20.0,
              color: Colors.white
          )
      );
    } else if (pty == '3') { //눈
      return Text('눈',
          style: TextStyle(
              fontFamily: 'tmon',
              fontSize: 20.0,
              color: Colors.white
          )
      );
    } else if (pty == '5') { //빗방울
      return Text('빗방울',
          style: TextStyle(
              fontFamily: 'tmon',
              fontSize: 20.0,
              color: Colors.white
          )
      );
    } else if (pty == '6') { //빗방울눈날림
      return Text('빗방울눈날림',
          style: TextStyle(
              fontFamily: 'tmon',
              fontSize: 20.0,
              color: Colors.white
          )
      );
    } else if (pty == '7') { //눈날림
      return Text('눈날림',
          style: TextStyle(
              fontFamily: 'tmon',
              fontSize: 20.0,
              color: Colors.white
          )
      );
    }
  }
  Widget? getAirIcon(String code) {
    int dens = int.parse(code);
    if (0 <= dens && dens <= 30) {
      return SvgPicture.asset(
        'assets/expression/good.svg',
        width: 50.0,
        height: 50.0,
      );
    } else if (31 <= dens && dens <= 80) {
      return SvgPicture.asset(
        'assets/expression/soso.svg',
        width: 50.0,
        height: 50.0,
      );
    }
    else if (81 <= dens && dens <= 150) {
      return SvgPicture.asset(
        'assets/expression/bad.svg',
        width: 50.0,
        height: 50.0,
      );
    }
    else if (151 <= dens) {
      return SvgPicture.asset(
        'assets/expression/so-bad.svg',
        width: 50.0,
        height: 50.0,
      );
    }
  }

  Widget? getAirDesc(String code) {
    int dens = int.parse(code);
    if (0 <= dens && dens <= 30) {
      return Text('좋음',
        style: TextStyle(
          fontFamily: 'tmon',
          fontSize: 18.0,
          color: Color(0xff1a0dab),
        ),
      );
    } else if (31 <= dens && dens <= 80) {
      return Text('보통',
        style: TextStyle(
          fontFamily: 'tmon',
          fontSize: 18.0,
          color: Color(0xff004b00),
        ),
      );
    }
    else if (81 <= dens && dens <= 150) {
      return Text('나쁨',
        style: TextStyle(
          fontFamily: 'tmon',
          fontSize: 18.0,
          color: Color(0xfff7781d),
        ),
      );
    }
    else if (151 <= dens) {
      return Text('매우 나쁨',
        style: TextStyle(
          fontFamily: 'tmon',
          fontSize: 18.0,
          color: Color(0xfff60000),
        ),
      );
    } else {
      return Text('정보없음',
        style: TextStyle(
          fontFamily: 'tmon',
          fontSize: 15.0,
          color: Color(0xffF7138E),
        ),
      );
    }
  }

  Widget? getAirIcon25(String code) {
    int dens = int.parse(code);
    if (0 <= dens && dens <= 15) {
      return SvgPicture.asset(
        'assets/expression/good.svg',
        width: 50.0,
        height: 50.0,
      );
    } else if (16 <= dens && dens <= 35) {
      return SvgPicture.asset(
        'assets/expression/soso.svg',
        width: 50.0,
        height: 50.0,
      );
    }
    else if (36 <= dens && dens <= 75) {
      return SvgPicture.asset(
        'assets/expression/bad.svg',
        width: 50.0,
        height: 50.0,
      );
    }
    else if (76 <= dens) {
      return SvgPicture.asset(
        'assets/expression/so-bad.svg',
        width: 50.0,
        height: 50.0,
      );
    }
  }

  Widget? getAirDesc25(String code) {
    int dens = int.parse(code);
    if (0 <= dens && dens <= 15) {
      return Text('좋음',
        style: TextStyle(
          fontFamily: 'tmon',
          fontSize: 18.0,
          color: Color(0xff1a0dab),
        ),
      );
    } else if (16 <= dens && dens <= 35) {
      return Text('보통',
        style: TextStyle(
          fontFamily: 'tmon',
          fontSize: 18.0,
          color: Color(0xff004b00),
        ),
      );
    }
    else if (36 <= dens && dens <= 75) {
      return Text('나쁨',
        style: TextStyle(
          fontFamily: 'tmon',
          fontSize: 18.0,
          color: Color(0xfff7781d),
        ),
      );
    }
    else if (76 <= dens) {
      return Text('매우 나쁨',
        style: TextStyle(
          fontFamily: 'tmon',
          fontSize: 18.0,
          color: Color(0xfff60000),
        ),
      );
    } else {
      return Text('정보없음',
        style: TextStyle(
          fontFamily: 'tmon',
          fontSize: 15.0,
          color: Color(0xffF7138E),
        ),
      );
    }
  }
}



