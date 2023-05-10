import 'dart:convert';
import 'package:http/http.dart' as http;
// network클래스에 날씨 데이터를 구하는 getCurrentWeatherJson()메소드
//url 속성에 api 대입, http.get-데이터를 가져오는 메소드,
//response.body-날씨 정보가 저장된 부분(JSON 형식)
//jsonDecode-특정 날씨정보만 사용할 수 있도록 parsing이 가능하게 해줌



class Network{
  final String currentWeatherUrl; //현재날씨정보
  final String shortWeatherUrl; //단기예보
  final String longWeatherUrl; //장기예보
//  final String todayWeatherUrl; //최저,최고기온

  Network(this.currentWeatherUrl, this.shortWeatherUrl, this.longWeatherUrl);

  //1. 현재 날씨 정보
  Future<dynamic> getCurrentWeatherJson() async {
    http.Response response = await http.get(Uri.parse(currentWeatherUrl));
    if (response.statusCode == 200) { //response가 정상인 경우 200반환
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      print(parsingData);
      return parsingData;
    }
  }

  //2. 단기 날씨 예보
  Future<dynamic> getShortWeatherJson() async {
    http.Response response = await http.get(Uri.parse(shortWeatherUrl));
    if(response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      print(parsingData);
      return parsingData;
    }
  }

  //3. 장기(주간) 날씨 예보
  Future<dynamic> getLongWeatherJson() async {
    http.Response response = await http.get(Uri.parse(longWeatherUrl));
    if(response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      print(parsingData);
      return parsingData;
    }
  }

/*
  //4. 최저-최고 기온 정보
  Future<dynamic> getTodayWeatherJson() async {
    http.Response response = await http.get(Uri.parse(todayWeatherUrl));
    if(response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      print(parsingData);
      return parsingData;
    }
  }
*/
}