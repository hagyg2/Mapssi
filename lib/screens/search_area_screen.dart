
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapssi/screens/model.dart';
import 'package:mapssi/screens/weather_screen.dart';
import 'menu_bar_draw.dart';

// 현재 페이지 에서 쓰일 TextStyle (글씨체, 색상 고정 / 크기, 굵기 조절)
TextStyle myTextStyle(double fs, {FontWeight fontWeight = FontWeight.w600}) {
  return TextStyle(
    fontSize: fs,
    color: Colors.black,
    fontFamily: 'SUITE',
    fontWeight: fontWeight,
  );
}

ButtonStyle myButtonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Color(0xffFFFAF3),
    surfaceTintColor: Color(0xffFFFAF3),
    foregroundColor: Colors.black,
    minimumSize: Size(280, 40),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  );
}


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

  List<String> doList = MappingDoSi.collectionDo;
  Map<String, List<String>> doSiMap = MappingDoSi.collectionDoSi;


  Future<void> convertLocationToCoordinatesAndShow(String selectedCity, String selectedLocal) async {
    String address = '$selectedLocal ($selectedCity)';
    List<Location> locations = await locationFromAddress(address);

    if (locations.isNotEmpty) {
      Location firstLocation = locations.first;
      setState(() {
        latitude = firstLocation.latitude;
        longitude = firstLocation.longitude;
      });
      print(address);

      print("위도 $latitude");
      print("경도 $longitude");
    }

  }

  Future<void> showLocation() async {
    await convertLocationToCoordinatesAndShow(selectedCity!, selectedLocal!);
    if (latitude != null && longitude != null) {
      print('변환 후 위도: $latitude');
      print('변환 후 경도: $longitude');
      Navigator.pop(context, [latitude, longitude]);
    }
  }



  Future<void> resetLocation() async {

    try {
      LocationPermission permission = await Geolocator.checkPermission(); //위치 권한
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high); //위경도 값 -> position변수에 저장
      latitude = position.latitude;
      longitude = position.longitude;

    } catch (e) {
      print("인터넷 연결에 문제가 있습니다.");
    }
    Navigator.pop(context, [latitude, longitude]);

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFECE7E0),
        title: Text("지역 검색", style: myTextStyle(22.0),),
        iconTheme: IconThemeData(color: Colors.black,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        // 전체 = 세로로 배치
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16.0), // 여백 추가
              padding: EdgeInsets.all(16.0),
              height: MediaQuery.of(context).size.height*0.2,
              decoration: BoxDecoration(
                color: Color(0xFFCCCCCC),
                borderRadius: BorderRadius.circular(12.0), // 첫 번째 Container의 테두리 둥글게 설정
              ) ,


              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 가로 방향으로 중앙 배치
                children: [

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // DropdownButton for "XX도"
                        DropdownButton<String>(
                          value: selectedCity, // 도의 값을 나타냄
                          hint: Text('도 선택', style: myTextStyle(17.0)),
                          // 도를 선택 -> 해당하는 시 목록을 보여줌.
                          onChanged: (String? value) {
                            setState(() {
                              selectedCity = value; //선택된 '도'의 값을 업데이트
                              selectedLocal = null; //'시'는 초기화
                            });
                          }, //onChanged: 사용자가 '도'를 선택시 호출되는 콜백함수
                          //'도' 목록을 mapping해서 DropdownMenuItem 위젯의 리스트로 반환
                          items: doList.map<DropdownMenuItem<String>>((
                              String value) {
                            return DropdownMenuItem<String>(
                              value: value, //value = '도'
                              child: Text(value, style: myTextStyle(17.0)), //'도'이름을 text로
                            );
                          }).toList(),
                        ),

                        // DropdownButton for "XX시"
                        SizedBox(height: 16.0),
                        DropdownButton<String>(
                          value: selectedLocal,
                          hint: Text('시 선택', style: myTextStyle(17.0)),
                          onChanged: (String? value) {
                            setState(() {
                              selectedLocal = value; //선택된 '시'의 값을 업데이트
                            });
                          }, //onChanged: 사용자가 '시'를 선택시 호출되는 콜백함수
                          items: selectedCity != null //사용자가 도를 선택한 경우
                          //선택된 '도'를 바탕으로 시의 목록(DropdownMenuItem으로 반환)을 가져옴.
                              ? doSiMap[selectedCity]?.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(value: value, child: Text(
                                value, style: myTextStyle(17.0)),); //여기서 value = 시
                          }).toList() //map의 반환값인 iterable -> list로 변환 하여 item에 전
                              : null, //사용자가 '도'를 선택하지 않은 경우 - 시 선택 불가
                        ),

                        //izedBox(width: 10.0), // 간격 조절


                      ],
                    ),


                  ),

                  //go버튼
                  ElevatedButton(
                    onPressed: ()async {
                      if(selectedCity != null && selectedLocal != null){
                        showLocation();

                      }
                      else{
                        MyCustomDialog.showCustomDialog(context, '도와 시를 모두 선택해주세요.');
                      }
                    },
                    child: Text('지역\n검색', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFFFAF3),
                        surfaceTintColor: Color(0xffFFFAF3),
                        foregroundColor: Colors.black,
                        minimumSize: Size(50, 70),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)
                        )
                    ),
                  ),
                ],),),

            ElevatedButton(
              onPressed: ()async {
                resetLocation();
              },
              child: Text('현재 위치로 설정', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffCFC7B4),
                  surfaceTintColor: Color(0xffFFFAF3),
                  foregroundColor: Colors.black,
                  minimumSize: Size(50, 70),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)
                  )
              ),

            ),

          ],),
      ),);

  }




}


class MyCustomDialog {
  static void showCustomDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Text(
            message,
            style: TextStyle(fontSize: 15, fontFamily: 'Dovemayo_gothic'),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(); // AlertDialog 닫기
                },
                child: Text(
                  '확인',
                  style: TextStyle(fontSize: 15, fontFamily: 'Dovemayo_gothic'),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}


