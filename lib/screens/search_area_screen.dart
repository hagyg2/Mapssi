//나중에 시간 되면 dropdown 으로 구현해보기
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';


class LocationSearchPage extends StatefulWidget {
  @override
  _LocationSearchPageState createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();

  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> searchLocation() async {
    final city = cityController.text;
    final district = districtController.text;

    try {
      List<Location> locations = await locationFromAddress('$city $district');
      if (locations.isNotEmpty) {
        setState(() {
          latitude = locations.first.latitude;
          longitude = locations.first.longitude;
        });
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('위치 검색'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: '시/도'),
            ),
            TextField(
              controller: districtController,
              decoration: InputDecoration(labelText: '동/읍/면'),
            ),
            ElevatedButton(
              onPressed: searchLocation,
              child: Text('날씨 정보 불러오기'),

            ),
            Text('위도: $latitude'),
            Text('경도: $longitude'),
          ],
        ),
      ),
    );
  }
}





