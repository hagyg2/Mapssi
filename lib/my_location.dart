
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation {
  //MyLocation = 사용자의 위/경도 값 할당받음
  late double latitude2;
  late double longtitude2;
  late String currentAddress;
  Position? currentPosition;
  late String addressDo;
  late String addressSi;

  Future<void> getMyCurrentLongilati() async {
    try {
      LocationPermission permission = await Geolocator
          .requestPermission(); //위치 권한
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high); //위경도 값 -> position변수에 저장
      latitude2 = position.latitude;
      longtitude2 = position.longitude;
      print(latitude2);
      print(longtitude2);


      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address = '${placemark.administrativeArea}, ${placemark
            .locality}';
        currentAddress = address;

        addressDo = '${placemark.administrativeArea}';
        addressSi = '${placemark.locality}';
      }
    } catch (e) {
      print("인터넷 연결에 문제가 있습니다.");
    }
  }
}