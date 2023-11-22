//api 관련 클래스 입니다.

import 'package:http/http.dart' as http;
import 'dart:convert';

//loading.dart의 fetchData를 리팩토링하여 만든 dart 파일입니다.
class Network {

  final String currentWeatherUrl;
  final String dailyWeatherUrl;  //단기예보(1시간 단위)
  final String weeklyWeatherUrl; //주간 예보
  final String airConditionUrl; //대기오염 정보

  Network(this.currentWeatherUrl, this.dailyWeatherUrl, this.weeklyWeatherUrl, this.airConditionUrl); // Network 클래스의 생성자. API 요청을 보낼 url 주소를 입력받는다


  //현재 기온 Json
  Future<dynamic> getCurrentWeatherData() async {
    http.Response response = await http.get(Uri.parse(currentWeatherUrl)); //http GET 요청 (loading.dart에서 입력한 사용자 url이 여기로 연결됨)
    if (response.statusCode == 200) {// 200 응답코드는 정상적으로 동작했다는 응답임
      String jsonData = response.body;
      Map<String,dynamic> parsingData = jsonDecode(jsonData);

      return parsingData;
    }
  }


  //일일 예보 Json
  Future<dynamic> getdailyWeatherData() async {
    http.Response response = await http.get(Uri.parse(dailyWeatherUrl)); //http GET 요청 (loading.dart에서 입력한 사용자 url이 여기로 연결됨)
    if (response.statusCode == 200) {// 200 응답코드는 정상적으로 동작했다는 응답임
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }


  //주간 예보 Json
  Future<dynamic> getWeeklyeatherData() async {
    http.Response response = await http.get(Uri.parse(weeklyWeatherUrl)); //http GET 요청 (loading.dart에서 입력한 사용자 url이 여기로 연결됨)
    if (response.statusCode == 200) {// 200 응답코드는 정상적으로 동작했다는 응답임
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }


  //미세먼지 Json
  Future<dynamic> getAirConditionData() async {
    http.Response response = await http.get(Uri.parse(airConditionUrl)); //http GET 요청 (loading.dart에서 입력한 사용자 url이 여기로 연결됨)
    if (response.statusCode == 200) {// 200 응답코드는 정상적으로 동작했다는 응답임
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
    // else {
    //   throw Exception('미세먼지 정보를 가져오는 데 실패했습니다.');
    // }
  }
}
