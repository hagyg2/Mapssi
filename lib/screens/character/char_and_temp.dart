import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mapssi/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mapssi/screens/character/character_screen.dart';
import 'package:mapssi/screens/character/fnc_for_character_screen.dart';

//화면 중앙 (현재 기온, 캐릭터)
class CharAndTemp extends StatefulWidget {
  const CharAndTemp({super.key});

  @override
  _CharAndTempState createState() => _CharAndTempState();
}

class _CharAndTempState extends State<CharAndTemp> {
  // bool _isVisible = true;
  // var height=165.0;   // 키 몸무게 초기화
  // var weight=80.0;

  int? curTemp;
  late List<Widget> clothesStack;
  var clothesImages = Get.find<ClothesImageController>().getImage();
  var curClothes = Get.find<ClothesImageController>().getFileName();

  // 현재 화면 캡쳐해서 저장
  void captureAndSave(String fileName) async {
    RenderRepaintBoundary boundary = key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    if (boundary.debugNeedsPaint) {
      await Future.delayed(const Duration(milliseconds: 20));
      return captureAndSave(fileName);
    }

    createSubDirectory("favorites");
    ui.Image image = await boundary.toImage(pixelRatio: 1.0); // 해상도 설정
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8List = byteData!.buffer.asUint8List();

    // 저장할 파일 경로 설정
    final directory = (await getApplicationDocumentsDirectory()).path;
    String filePath = '$directory/favorites/$fileName';

    print("$directory : $fileName");
    // 파일로 저장
    File(filePath).writeAsBytes(uint8List);
  }

  @override
  Widget build(BuildContext context) {
    // 현재 옷이 즐겨찾기인지 확인
    if ( !isFavoriteSaving ) {  // 즐겨찾기 저장 중이 아닌 경우에만 (저장하는 비동기 작업 시간차 때문에 chkIsFavorite 결과 이상함)
      chkIsFavorite(curClothes).then((result) { // 현재 옷이 즐겨찾기 인지 아닌지 확인
        if (result != isFavorite) {           // 상태가 바뀌었다면 (즐겨찾기 맞음<->즐겨찾기 아님)
          isFavorite = result;
          Navigator.pushAndRemoveUntil(   // 화면 다시 빌드
              context,
              PageRouteBuilder(
                  transitionDuration: Duration.zero,
                  pageBuilder: (context, animation,
                      secondaryAnimation) => const MyPageView(pageIndex: 1)
              ),
                  (route) => false);
        }
      }).catchError((error) {
        print('An error occurred: $error');
      });
    }
    sleep(const Duration(milliseconds: 50));
    // 기온 불러오기
    curTemp = Get.find<WeatherJasonData>().getData()[0];
    clothesStack = [  // 순서대로 신발, 상의, 하의, 아우터
      clothesPositionFromBottom(MediaQuery.of(context).size.height*0.003, MediaQuery.of(context).size.width*0.244, clothesImages[0]),  // 신발 배경
      clothesPositionFromBottom(MediaQuery.of(context).size.height*0.003, MediaQuery.of(context).size.width*0.22, clothesImages[1]),  // 신발
      clothesPosition(MediaQuery.of(context).size.height*0.125, MediaQuery.of(context).size.width*0.19, clothesImages[2]),    // 상의
      clothesPosition(MediaQuery.of(context).size.height*0.34, MediaQuery.of(context).size.width*0.32, clothesImages[3]),   // 하의 배경
      clothesPosition(MediaQuery.of(context).size.height*0.25, MediaQuery.of(context).size.width*0.19, clothesImages[4]),   // 하의
      clothesPosition(MediaQuery.of(context).size.height*0.125, MediaQuery.of(context).size.width*0.19, clothesImages[5])    // 아우터
    ];

    // 새로고침 버튼
    var resetButton = clothesPosition(5, 300, IconButton(
        onPressed: (){
          Get.find<ClothesImageController>().resetImages();
          Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration.zero,
                  pageBuilder: (context, animation, secondaryAnimation) => const MyPageView(pageIndex: 1)
              ),
                  (route) => false);
        },
        icon: const Icon(Icons.refresh,color: Colors.black,))
    );

    // 즐겨찾기 버튼
    var favoriteButton = clothesPosition(5, 10,
        isFavorite == true ? // 현재 옷이 즐겨찾기 인가?
        // YES -> 즐겨찾기 삭제
        SizedBox(
          height: 55,
          width: 55,
          child: ElevatedButton(
            onPressed: (){
              curClothes = Get.find<ClothesImageController>().getFileName();
              deleteFile(curClothes);
              isFavorite = false;
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (context, animation, secondaryAnimation) => const MyPageView(pageIndex: 1)
                  ),
                      (route) => false);
              showToast("즐겨찾기 삭제 되었습니다.");
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Image.asset('assets/favorite_selected.png'),
          ),
        )
        // NO -> 즐겨찾기 등록
            : SizedBox(
          height: 55,
          width: 55,
          child: ElevatedButton(
            onPressed: (){
              curClothes = Get.find<ClothesImageController>().getFileName();
              captureAndSave(curClothes);
              isFavoriteSaving = true;
              isFavorite = true;
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      pageBuilder: (context, animation, secondaryAnimation) => const MyPageView(pageIndex: 1)
                  ),
                      (route) => false);
              showToast("즐겨찾기에 등록 되었습니다.");
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Image.asset('assets/favorite_not_selected.png'),
          ),
        )
    );

    // 실제 화면이 나타나는 부분
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 현재 기온
            Text(
              style: txtStyle(50),
              "$curTemp°C",
            ),
          ],
        ),
        // 캐릭터 이미지
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            // 그림자
            decoration: BoxDecoration(
                color: const Color(0xFFFFFDF9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 1), // 위치 조정
                  )
                ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              // 캐릭터 의상 스택 부분
              child: Stack(
                fit: StackFit.expand,
                children: [
                  RepaintBoundary(
                    key: key,
                    child: Stack(
                        fit: StackFit.expand,
                        children: [// 기본 캐릭터
                          Image.asset(
                            'assets/character/${gender}_default.png',
                            fit: BoxFit.cover,
                          ),
                          // 위에 의상
                          ...clothesStack]
                    ),
                  ),
                  // 기타 버튼들
                  resetButton,
                  favoriteButton
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}