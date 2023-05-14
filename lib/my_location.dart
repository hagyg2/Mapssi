//사용자의 위치 정보를 얻고
//위치 정보 권한 여부를 묻는 클래스입니다.


import 'package:geolocator/geolocator.dart';

class MyLocation{  //MyLocation = 사용자의 위/경도 값 할당받음
  double? latitude2;
  double? longtitude2;


  Future<void> getMyCurrentLocation() async{
    try{
      LocationPermission permission = await Geolocator.requestPermission(); //위치 권한
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high); //위경도 값 -> position변수에 저장
      latitude2 = position.latitude;
      longtitude2 = position.longitude;
      print(latitude2);
      print(longtitude2);
    }catch(e) {
      print("인터넷 연결에 문제가 있습니다.");
    }
  }

}