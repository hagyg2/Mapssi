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


bool loadFace = false;
var characterImage = Image.asset( // 기본 캐릭터
  'assets/character/${gender}_default.png',
  fit: BoxFit.cover,
);

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

  int Count =0; //색 변경에 쓰이는 변수
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

  // 사용자 합성 얼굴 사진 불러오는 용도
  void loadUserImage() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = '$appDocPath/${gender}UserFace.png';
    print("Searching "+filePath);
    File file = File(filePath);

    if (await file.exists()) {
      setState(() {
        var oldImage = characterImage;
        var imageBytes = Uint8List.fromList(file.readAsBytesSync());

        characterImage = Image.memory(imageBytes, fit: BoxFit.cover);
        if (oldImage != characterImage) {
          showToast("새 이미지를 적용했습니다!");
          loadFace = true;
        }
      });
      if (!mounted) return;
      reloadCharacterScreen(context);
    } else {
      characterImage = Image.asset( // 기본 캐릭터
        'assets/character/${gender}_default.png',
        fit: BoxFit.cover,
      );
    }
  }

  // 색깔별 동그라미 버튼들
  ElevatedButton colorOnPalette(Color color) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color, //네이비
            shape: const CircleBorder(),
            minimumSize: const Size(20, 20)
        ),
        onPressed: (){
          var path = "assets/character/$gender/";
          if (Count==1) {
            var curTop = Get.find<ClothesImageController>().getTopPath();
            if (curTop!="") {
              Get.find<ClothesImageController>().setTopImage(path+curTop, color: color);
            }
          } else if (Count==2) {
            var curBot = Get.find<ClothesImageController>().getBotPath();
            if (curBot!="") {
              Get.find<ClothesImageController>().setBotImage(path+curBot, color: color);
            }
          } else if (Count==3) {
            var curOut = Get.find<ClothesImageController>().getOutPath();
            if (curOut!="") {
              Get.find<ClothesImageController>().setOutImage(path+curOut, color: color);
            }
          }
          Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => const MyPageView(pageIndex: 1)),(route)=>false);
        },
        child: null
    );
  }

  @override
  Widget build(BuildContext context) {
    if (! loadFace) {
      loadUserImage();
    }
    // 현재 옷이 즐겨찾기인지 확인
    if ( !isFavoriteSaving ) {  // 즐겨찾기 저장 중이 아닌 경우에만 (저장하는 비동기 작업 시간차 때문에 chkIsFavorite 결과 이상함)
      chkIsFavorite(curClothes).then((result) { // 현재 옷이 즐겨찾기 인지 아닌지 확인
        if (result != isFavorite) {           // 상태가 바뀌었다면 (즐겨찾기 맞음<->즐겨찾기 아님)
          isFavorite = result;
          reloadCharacterScreen(context);
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
          reloadCharacterScreen(context);
        },
        icon: const Icon(Icons.refresh,color: Colors.black,))
    );

    // 즐겨찾기 버튼
    var favoriteButton = clothesPosition(5, 5,
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
              reloadCharacterScreen(context);
              showToast("즐겨찾기 삭제 되었습니다.");
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Image.asset('assets/favorite_selected.png',fit: BoxFit.cover),
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
              if (!mounted) return;
              reloadCharacterScreen(context);
              showToast("즐겨찾기에 등록 되었습니다.");
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Image.asset('assets/favorite_not_selected.png',fit: BoxFit.cover),
          ),
        )
    );

    // 동그라미 색상 버튼들
    List<Widget> buildBox(int count) {
      List<Widget> buttons = [];
      switch(count){
        case 1: //상의
        case 3: //아우터
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(Colors.red)),
            clothesPositionFromBottom(15, 60,colorOnPalette(Colors.orange)),
            clothesPositionFromBottom(15, 90,colorOnPalette(Colors.yellow)),
            clothesPositionFromBottom(15, 120,colorOnPalette(Colors.green)),
            clothesPositionFromBottom(15, 150,colorOnPalette(Colors.blue)),
            clothesPositionFromBottom(15, 180,colorOnPalette(Colors.blueGrey)),
            clothesPositionFromBottom(15, 210,colorOnPalette(Colors.deepPurpleAccent)),
            clothesPositionFromBottom(15, 240,colorOnPalette(Colors.white)),
            clothesPositionFromBottom(15, 270,colorOnPalette(Colors.grey)),
            clothesPositionFromBottom(15, 300,colorOnPalette(Colors.black))
          ];
          return buttons;
        case 2: //하의
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFFc4c4c4))),
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFFbeb6a9))),
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFF978868))),
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF201716))),
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF383838))),
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFF151514))),
            clothesPositionFromBottom(15, 210,colorOnPalette(const Color(0xFF917188))),
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFF131824))),
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFF323b32)))
          ];
          return buttons;
        default:
          return [];
      }
    }

    //색상 팔레트 아이콘 클릭
    void _buttonclickcount(){
      setState(() {
        Count =(Count + 1) % 4;
      });
    }

    // 팔레트 버튼 이미지
    Image colorbutton(){
      //초기
      if(Count == 0){
        return Image.asset("assets/icon_color.png", width: 20, height: 20,);
      }
      //상의
      else if(Count == 1){
        return Image.asset("assets/icon_top.png", width: 20, height: 20,);
      }
      //하의
      else if(Count == 2){
        return Image.asset("assets/icon_bottom.png", width: 20, height: 20,);
      }
      //아우터
      else{
        return Image.asset("assets/icon_outer.png", width: 20, height: 20,);
      }
    }

    //색상 팔레트 버튼
    var colorButton = clothesPositionFromBottom(15, 15, InkWell(
      onTap: () {
        _buttonclickcount();
      },
      child: colorbutton()
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
                        children: [
                          characterImage,
                          // 위에 의상
                          ...clothesStack]
                    ),
                  ),
                  // 기타 버튼들
                  resetButton,
                  favoriteButton,
                  colorButton,
                  ... buildBox(Count)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}