
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mapssi/screens/weather_screen.dart';

import '../my_location.dart';
import 'character_screen.dart';
import 'loading.dart';
import 'menu_bar_draw.dart';

class CityDropdown extends StatefulWidget {
  @override
  _CityDropdownState createState() => _CityDropdownState();
}

class _CityDropdownState extends State<CityDropdown> {

  String? selectedCity;
  String? selectedLocal;
  String? message = '';
  late double latitude;
  late double longitude;

  Map<String, List<String>> collectionDoSi = {
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


  List<String> collectionDo = [
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


/*
  // 지역 -> 위경도
  Future<List<double>?> convertLocationToCoordinates(String selectedCity,
      String selectedLocal) async {
    String address = '$selectedLocal, $selectedCity';
    List<Location> locations = await locationFromAddress(address);

    if (locations.isNotEmpty) {
      Location firstLocation = locations.first;
      return [firstLocation.latitude, firstLocation.longitude];
    }

    return null;
  }


  Future<void> showLocation() async {
    List<double>? coordinates = await convertLocationToCoordinates(
        '$selectedCity', '$selectedLocal');
    if (coordinates != null) {
      latitude = coordinates[0];
      longitude = coordinates[1];
    }

    print("위도!!!!!!!!! $latitude");
    print("경도!!!!!!!!!! $longitude");

    }
*/



  Future<void> convertLocationToCoordinatesAndShow(String selectedCity, String selectedLocal) async {
    String address = '$selectedLocal, $selectedCity';
    List<Location> locations = await locationFromAddress(address);

    if (locations.isNotEmpty) {
      Location firstLocation = locations.first;
      latitude = firstLocation.latitude;
      longitude = firstLocation.longitude;
      print("위도 $latitude");
      print("경도 $longitude");
    }

  }

  Future<void> showLocation() async {
    await convertLocationToCoordinatesAndShow(selectedCity!, selectedLocal!);
  }








//위경도 업데이트
  // void onUpdateLocation(double latitude, double longitude) {
  //   setState(() {
  //     // 위도와 경도 값을 업데이트
  //     this.latitude = latitude;
  //     this.longitude = longitude;
  //   });
  // }


  // Navigator.pushReplacement(context, MaterialPageRoute(
  //     builder: (context) =>
  //         MyLocation(
  //           latitude,
  //           longitude,
  //         ),
  // ),


/*
  void _showLocationAlertDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('위치 권한 요청'),
              content: Text('선택한 지역으로 날씨 정보를 변경합니다.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Loading()),
                        // 위치 설정창으로 이동
                      );
                    },
                  child: Text('확인'),

                   ),
                ],
               );
            },
         );
        }
*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('도시 선택'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // DropdownButton for "XX도"
            DropdownButton<String>(
              value: selectedCity, // 도의 값을 나타냄
              hint: Text('도 선택'),
              // 도를 선택 -> 해당하는 시 목록을 보여줌.
              onChanged: (String? value) {
                setState(() {
                  selectedCity = value; //선택된 '도'의 값을 업데이트
                  selectedLocal = null; //'시'는 초기화
                });
              }, //onChanged: 사용자가 '도'를 선택시 호출되는 콜백함수

              //'도' 목록을 mapping해서 DropdownMenuItem 위젯의 리스트로 반환
              items: collectionDo.map<DropdownMenuItem<String>>((
                  String value) {
                return DropdownMenuItem<String>(
                  value: value, //value = '도'
                  child: Text(value), //'도'이름을 text로
                );
              }).toList(),
            ),

            // DropdownButton for "XX시"
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: selectedLocal,
              hint: Text('시 선택'),
              onChanged: (String? value) {
                setState(() {
                  selectedLocal = value; //선택된 '시'의 값을 업데이트
                });
              }, //onChanged: 사용자가 '시'를 선택시 호출되는 콜백함수

              items: selectedCity != null //사용자가 도를 선택한 경우
              //선택된 '도'를 바탕으로 시의 목록(DropdownMenuItem으로 반환)을 가져옴.
                  ? collectionDoSi[selectedCity!]!.map<
                  DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(
                    value),); //여기서 value = 시
              }).toList() //map의 반환값인 iterable -> list로 변환 하여 item에 전
                  : null, //사용자가 '도'를 선택하지 않은 경우 - 시 선택 불가
            ),

            SizedBox(height: 20.0),
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                showLocation();
                if (selectedCity != null && selectedLocal != null) {
                  // 도와 시가 모두 선택된 경우 실행되는 코드
                  setState(() {
                    message =
                    '\n 선택한 지역은   " $selectedCity, $selectedLocal"';
                  });
                  return;
                }
                else {
                  setState(() {
                    message = '도와 시를 선택해주세요.';
                  });
                  // 도나 시가 선택되지 않은 경우 실행되는 코드
                }
              },


            ),
            Text(message!, style: TextStyle(
                fontSize: 18.0, fontWeight: FontWeight.bold),),


            // SizedBox(height: 30.0,),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(
            //       builder: (context) => FavoriteArea(),
            //       //builder: (context) => WeatherScreen(location: location),
            //     ),
            //     );
            //   },
            //   child: Container(
            //     padding: EdgeInsets.all(16),
            //     color: Colors.blue,
            //     child: Text(
            //       '즐겨찾기에 추가하기',
            //       style: TextStyle(color: Colors.white, fontSize: 18,
            //       ),
            //     ),
            //   ),
            // ),

            SizedBox(height: 58),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => Loading(),
            //       ),
            //     );
            //   },
            ElevatedButton(
              onPressed: () {
                setState(() {
                  longitude = longitude;
                  latitude = latitude;
                });

               // Navigatior.push(context, MaterialPageRoute(
               //   builder: (context) => WeatherScreen()


              },
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.lightBlueAccent,
                child: Text(
                  '해당 지역 날씨 바로가기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

          ],),

      ),
    );
  }


}
