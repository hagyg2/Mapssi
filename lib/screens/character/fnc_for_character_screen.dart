import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mapssi/main.dart';
import 'package:path_provider/path_provider.dart';

// 현재 페이지 에서 쓰일 TextStyle (글씨체 색상 굵기 고정 / 크기만 조절)
TextStyle txtStyle (double fs) {
  return TextStyle(fontSize: fs,
    color: Colors.black,
    fontFamily: 'SUITE',
    fontWeight: FontWeight.w800,
  );
}

// 이미지 사이즈 조절 및 설정
ColorFiltered setImage(String url, double w, [Color color=Colors.white]) {
  return ColorFiltered(
    colorFilter: ColorFilter.mode(
      color,
      BlendMode.modulate,
    ),
    child: Image.asset(url, width: w, fit: BoxFit.cover),
  );
}

// 스택 에서의 이미지 위치 조절
Positioned clothesPosition (double x, double y, var img) {
  return Positioned(
    top: x,
    left: y,
    child: img,
  );
}
// 스택 에서의 이미지 위치 조절
Positioned clothesPositionFromBottom (double x, double y, var img) {
  return Positioned(
    bottom: x,
    left: y,
    child: img,
  );
}
// 날씨 관련 조언 멘트 알고리즘
String weatherCast () {
  double airDust = Get.find<WeatherJasonData>().getData()[7];
  String recMent = '';
  if (airDust>75){
    recMent = '미세먼지 매우 나쁨! 마스크 꼭 챙기세요!';
  } else if (airDust>35) {
    recMent = '미세먼지 나쁨! 마스크 챙기세요!';
  } else {
    String description = Get.find<WeatherJasonData>().getData()[8];
    switch (description) {
      case '맑음':
        recMent = '맑고 화창한 날씨! 자외선에 유의해요!';
        break;
      case '소나기':
      case '많은 비':
      case '천둥번개':
      case '이슬비':
        recMent = '비가 내려요! 우산 꼭 챙기세요!';
        break;
      case '눈':
        recMent = '눈이 온대요! 빙판길 조심하세요!';
        break;
      case '안개':
        recMent = '운전자분들은 안개 조심하세요!';
        break;
      case '돌풍':
      case '토네이도(회오리 바람)':
        recMent = '바람이 거세요! 낙하물에 유의해요!';
        break;
      case '구름':
      case '흐림':
      case '정보 없음':
      default:
        recMent = '행복한 하루되세요!';
        break;
    }
  }
  return recMent;
}

// 하위 디렉토리 생성
void createSubDirectory(String dirName) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  String newDirPath = '$appDocPath/$dirName';
  await Directory(newDirPath).create();
}

// 현재 의상이 즐겨찾기 인지 확인
Future<bool> chkIsFavorite(String fileName) async {
  // 디렉토리 경로를 열기
  String directoryPath = '${(await getApplicationDocumentsDirectory()).path}/favorites/';
  final directory = Directory(directoryPath);
  final files = directory.listSync();

  // 파일 목록을 반복하며 원하는 파일 이름과 일치하는지 확인
  for (var file in files) {
    if (file is File && file.path.endsWith(fileName)) {
      return true;
    }
  }
  return false;
}

// 파일 삭제
void deleteFile(String fileName) async {
  final directory = (await getApplicationDocumentsDirectory()).path;
  String filePath = '$directory/favorites/$fileName';
  File file = File(filePath);
  if (await file.exists()) {
    file.delete();
  }
}

// 토스트 알림 띄우기
void showToast(String content) {
  Fluttertoast.showToast(
    msg: content,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}


// 특정 디렉토리 에서 파일 목록을 가져오는 함수
Future<List<String>> getFilesInDirectory(String path) async {
  String assetManifest = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(assetManifest);
  var files = manifestMap.keys.where((String key) => key.startsWith(path)).toList();
  print("Files in $path = $files");
  return files;
}

// 캐릭터 화면 다시 로드(상태 바뀌었을때 사용)
reloadCharacterScreen(context) {
  return Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
          transitionDuration: Duration.zero,
          pageBuilder: (context, animation, secondaryAnimation) => const MyPageView(pageIndex: 1)
      ), (route) => false
  );
}