import 'package:geolocator/geolocator.dart';
import 'dart:math';

class Weather_map_xy {
  int x;
  int y;
  Weather_map_xy(this.x, this.y);
}

class structlamc_parameter {
  double? Re; /* 사용할 지구반경 [ km ]      */
  double? grid; /* 격자간격        [ km ]      */
  double? slat1; /* 표준위도        [degree]    */
  double? slat2; /* 표준위도        [degree]    */
  double? olon; /* 기준점의 경도   [degree]    */
  double? olat; /* 기준점의 위도   [degree]    */
  double? xo; /* 기준점의 X 좌표  [격자거리]  */
  double? yo; /* 기준점의 Y 좌표  [격자거리]  */
  int? first; /* 시작여부 (0 = 시작)         */
}

//좌표 변환
Weather_map_xy changelaluMap(double longitude, double latitude) {
  int NX = 149; /* X 축 격자점 수 */
  int NY = 253; /* Y 축 격자점 수 */
  double? PI, DEGRAD, RADDEG;
  double? re, olon, olat, sn, sf, ro;
  double? slat1, slat2, alon, alat, xn, yn, ra, theta;
  structlamc_parameter map = structlamc_parameter();
  map.Re = 6371.00877; // 지도반경
  map.grid = 5.0; // 격자간격 (km)
  map.slat1 = 30.0; // 표준위도 1
  map.slat2 = 60.0; // 표준위도 2
  map.olon = 126.0; // 기준점 경도
  map.olat = 38.0; // 기준점 위도
  map.xo = 210 / map.grid!; // 기준점 X 좌표
  map.yo = 675 / map.grid!; // 기준점 Y 좌표
  map.first = 0;

  if ((map).first == 0) {
    // PI = asin(1.0) * 2.0;
    PI = 3.1415926535897931;
    DEGRAD = PI / 180.0;
    RADDEG = 180.0 / PI;
    re = map.Re! / map.grid!;
    slat1 = map.slat1! * DEGRAD;
    slat2 = map.slat2! * DEGRAD;
    olon = map.olon! * DEGRAD;
    olat = map.olat! * DEGRAD;
    sn = tan(PI * 0.25 + slat2 * 0.5) / tan(PI * 0.25 + slat1 * 0.5);
    sn = log(cos(slat1) / cos(slat2)) / log(sn);
    sf = tan(PI * 0.25 + slat1 * 0.5);
    sf = pow(sf, sn) * cos(slat1) / sn;
    ro = tan(PI * 0.25 + olat * 0.5);
    ro = re * sf / pow(ro, sn);
    map.first = 1;
  }
  ra = tan(PI! * 0.25 + latitude * DEGRAD! * 0.5);
  ra = re! * sf! / pow(ra, sn!);
  theta = longitude * DEGRAD - olon!;
  if (theta > PI) theta -= 2.0 * PI;
  if (theta < -PI) theta += 2.0 * PI;
  theta *= sn;

  double x = (ra * sin(theta)) + map.xo!;   //기준점 x좌표
  double y = (ro! - ra * cos(theta)) + map.yo!;  //기준점 Y좌표
  x = x + 1.5;
  y = y + 1.5;
  return Weather_map_xy(x.toInt(), y.toInt());
}

class MyLocation { //사용자의 현재 좌표, 위경도 값
  int? currentX;
  int? currentY;
  double? userlongi;
  double? userlati;

  Future<void> getMyCurrentLocation() async {
    try{
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      userlongi = position.longitude;
      userlati = position.latitude;
      //geolocator로 사용자의 현재 위경도 값을 받아옴


      //기상청API는 위치를 찾을 때, 위경도가 아닌 특정 좌표를 사용
      //사용자의 위경도 값을 매개변수로 받아아 좌표로 변환한 뒤, currentX와 currentY에 경도와 위도 값을 저장
      Weather_map_xy weathermapxy = changelaluMap(position.longitude, position.latitude);
      currentX = weathermapxy.x;
      currentY = weathermapxy.y;
    } catch(e){
      print('인터넷 연결이 불안정합니다');
    }
  }
}