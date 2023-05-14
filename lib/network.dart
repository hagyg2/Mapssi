//api 관련 클래스 입니다.

import 'package:http/http.dart' as http;
import 'dart:convert';


//loading.dart의 fetchData를 리팩토링하여 만든 dart 파일입니다.

class Network {
  final String url;
  Network(this.url); // Network 클래스의 생성자. API 요청을 보낼 url 주소를 입력받는다

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url)); //http GET 요청 (loading.dart에서 입력한 사용자 url이 여기로 연결됨)
    if (response.statusCode == 200) {// 200 응답코드는 정상적으로 동작했다는 응답임
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
}
