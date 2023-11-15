

import 'my_location.dart';
import 'network.dart';
//WeatherModel 클래스를 정의합니다.
// 날씨 정보를 가져오는 역할을 합니다.
// 현재 위치 또는 선택한 도시의 날씨 정보를 가져오기 위해 사용됩니다.
// 날씨 아이콘 및 메시지를 가져오는 함수도 정의되어 있습니다.

const apiKey = "122328b0a95baa0ce0c0a7697d3a30c7";


class WeatherModel {

  Future<dynamic> getLocationWeather() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLongilati();
    double latitude3 = myLocation.latitude2;
    double longitude3 = myLocation.longtitude2;
    print(latitude3);
    print(longitude3);

    String currentWeather = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric';
    String dailyWeather = 'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric';
    String weeklyWeather = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric';
    String airCondition = 'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apiKey';

    Network network = Network(
        currentWeather, dailyWeather, weeklyWeather, airCondition);
    var currentWeatherData = await network.getCurrentWeatherData();
    var dailyWeatherData = await network.getdailyWeatherData();
    var weeklyWeatherData = await network.getWeeklyeatherData();
    var airConditionData = await network.getAirConditionData();
    print(currentWeatherData);
    print(dailyWeatherData);
    print(weeklyWeatherData);
    print(airConditionData);
    return currentWeatherData;
  }


  Future<dynamic> getCityWeather(double latitude, double longitude) async {
    String currentWeather = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    String dailyWeather = 'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    String weeklyWeather = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    String airCondition = 'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKey';
    Network network = Network(
        currentWeather, dailyWeather, weeklyWeather, airCondition);
    var currentWeatherData = await network.getCurrentWeatherData();
    var dailyWeatherData = await network.getdailyWeatherData();
    var weeklyWeatherData = await network.getWeeklyeatherData();
    var airConditionData = await network.getAirConditionData();

    print('현재 날씨 정보========================================');
    print(currentWeatherData);


    print('데일리 날씨 정보======================================');
    print(dailyWeatherData);

    print("위클리 날씨 정보=====================================");
    print(weeklyWeatherData);

    print("미세먼지 정보=========================================");
    print(airConditionData);

    //print(dailyWeatherData);
    //print(weeklyWeatherData);
    //print(airConditionData);
    return currentWeatherData;



  }


}
