//사용자 위치정보를 받아오는 화면인데
//로그인 화면에 위치정보를 같이 받아서
//바로 날씨 화면으로 넘길 예정입니당



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapssi/screens/weather_screen.dart';
import 'package:permission_handler/permission_handler.dart';


import '../my_location.dart';
import '../network.dart';
const apiKey = "122328b0a95baa0ce0c0a7697d3a30c7";


class Loading extends StatefulWidget{
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  MyLocation myLocation = MyLocation();

  double? latitude3;
  double? longtitude3;

  int? maxTemperature;
  int? minTemperature;

  late Position currentPosition;
  late String currentAddress;
  late String addressDo;
  late String addressSi;

  @override
  void initState() {
    super.initState();
    getCurrentLocationAsk();
  }

  //위치 권한 요청 메소드
  Future<void> getCurrentLocationAsk() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission(); // 위치 권한 확인

    // 위치 서비스가 활성화되어 있는지 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationAlertDialog('위치 서비스가 비활성화되어 있습니다.');
      return;
    }

    else {
      //1. 계속 거부
      if (permission == LocationPermission.deniedForever) {
        _showLocationAlertDialog('위치 권한이 영구적으로 거부되었습니다. 위치 설정으로 이동해주세요.');
        return;
      }

      //2. 거절
      else if (permission == LocationPermission.denied) {
        // 위치 권한 요청
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse) {
          currentAddress;
        }
        //2번 이상 거절
        else if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          _showLocationAlertDialog('위치 권한이 거부되었습니다.');
          permission = await Geolocator.requestPermission();

          return;
        }
      }
    }
  }


  // 현재 위치 가져오기
/*    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = position;
    });
*/

  /* 현재 위치 가져오기
    currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high
    );

    // 위경도를 주소로 변환
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude, currentPosition.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String address = '${placemark.administrativeArea}, ${placemark.locality}, ${placemark.name}';
      currentAddress = address;
    }
*/


  //위치 거부했을 때 메시지를 통해 위치 권한 요청
  void _showLocationAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(
          title: Text('위치 권한 요청'),
          content: Text('앱에서 위치 정보를 사용하기 위해 위치 권한이 필요합니다. 위치 권한을 허용하시겠습니까?'),
          actions: [
            TextButton(
              child: Text('허용'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings(); // 위치 설정창으로 이동
              },
            ),
            TextButton(
              child: Text('거부'),
              onPressed: () {
                Navigator.of(context).pop();
                _openLocationSettings();
              },
            ),
          ],
        );
      },
    );
  }

  //위치 설정 화면 관련 메소드(위치 설정 화면에서 돌아왔을 때 포함)
  void _openLocationSettings() async {
    bool result = await Geolocator.openLocationSettings();
    if (result) {
      // 위치 설정 화면에서 돌아왔을 때
      getCurrentLocationAsk();
    }
  }


  //사용자 위치 불러오기 -위경도 값f
  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLongilati();

    latitude3 = myLocation.latitude2;
    longtitude3 = myLocation.longtitude2;
    print(latitude3);
    print(longtitude3);

    // network.dart 에서 getJsonData()불러오기 위해 network인스턴스 생성
    String currentWeather = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longtitude3&appid=$apiKey&units=metric';
    String dailyWeather = 'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude3&lon=$longtitude3&appid=$apiKey&units=metric';
    String weeklyWeather = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longtitude3&appid=$apiKey&units=metric';
    //   String airCondition = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longtitude3&appid=$apiKey&units=metric';
    String airCondition = 'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longtitude3&appid=$apiKey';
    Network network = Network(
        currentWeather, dailyWeather, weeklyWeather, airCondition);

    // network.dart에서 파싱된 json data를 출력해주기 위해 weatherData 변수에 getJsonData()의 값을 할당
    var currentWeatherData = await network.getCurrentWeatherData();
    var dailyWeatherData = await network.getdailyWeatherData();
    var weeklyWeatherData = await network.getWeeklyeatherData();
    var airConditionData = await network.getAirConditionData();

    print(currentWeatherData);
    print(airConditionData);
    print(dailyWeatherData);


    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) =>
          WeatherScreen(),
    ),
    );

    /*
    // 날씨 화면으로 이동
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) =>
          WeatherScreen(
            latitude: myLocation.latitude2,
            longitude: myLocation.longtitude2,
            address: myLocation.currentAddress,
            addressDo: myLocation.addressDo,
            addressSi: myLocation.addressSi,
            parseCurrentWeatherData: currentWeatherData,
            parseDailyWeatherData: dailyWeatherData,
            parseWeeklyWeatherData: weeklyWeatherData,
            parseAirConditionData: airConditionData,
            weatherDescription: '', englishDayOfWeek: '',

          ),
    ),
*/

  }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             getLocation(); //사용자 위치 불러오기
//           },
//           child: Text(
//             '로그인 되면 날씨 페이지 ㄱㄱ',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//
//     );
//   }
//
// }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

}