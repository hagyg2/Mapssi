import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class Image {
  Widget? getSkyIcon(String sky, String pty, double wSize, double hSize,
      String now) {
    int time = int.parse(now);
    print(sky + " " + pty);
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
}
