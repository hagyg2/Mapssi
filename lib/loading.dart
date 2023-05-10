import 'my_location.dart';
import 'network.dart';

const WEATHER_API_KEY = 'TKPlhIHeHlFWyt%2B%2F1ghOEDHuZF3F8WxzyLC7rgIQeFfH6w1IBpgssS9%2B7ft16xHXJFCM5CbCWhaYsgrqtbpGUA%3D%3D';


late double latitude3;
late double longitude3;

@override
void initState() {
  getLocation();
}

void getLocation() async {

  MyLocation myLocation = MyLocation();
  await myLocation.getMyCurrentLocation();

  // 받아온 위치(위, 경도 값)을 변수에 저장
  latitude3 = myLocation.latitude2!;
  longitude3 = myLocation.longitude2!;

  /* 네트워크 인스턴스 영역
  Network network = Network('https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$WEATHER_API_KEY&units=metric',
      'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$WEATHER_API_KEY'),
      */

} // ...getLocation()