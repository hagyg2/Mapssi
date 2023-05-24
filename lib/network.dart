//api 관련 클래스 입니다.

import 'package:http/http.dart' as http;
import 'dart:convert';


//loading.dart의 fetchData를 리팩토링하여 만든 dart 파일입니다.

class Network {
  final String currentWeatherUrl;
  Network(this.currentWeatherUrl);

  Future<dynamic> getCurrentWeatherData() async {
    http.Response response = await http.get(Uri.parse(currentWeatherUrl));
    if (response.statusCode ==200){
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      print(parsingData);
      return parsingData;
    }
  }
}
