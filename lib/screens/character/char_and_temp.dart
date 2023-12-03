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

var perCol = Get.find<UserDataFromServer>().getUserPerCol();
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
  int count =0; //색 변경에 쓰이는 변수
  int? curTemp;
  bool isChecked = false;
  bool isFavorite = false;
  bool faceNotMadeYet = false;
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

  // 현재 의상이 즐겨찾기 인지 확인
  void chkIsFavorite(String fileName) async {
    isChecked = true;
    // 디렉토리 경로를 열기
    String directoryPath = '${(await getApplicationDocumentsDirectory()).path}/favorites/';
    final directory = Directory(directoryPath);
    final files = directory.listSync();
    print("checking '$fileName' is favorite in $files");
    // 파일 목록을 반복하며 원하는 파일 이름과 일치하는지 확인
    for (var file in files) {
      if (file is File && file.path.endsWith(fileName)) {
        print("☆☆☆☆☆");
        setState(() {
          isFavorite = true;
        });
        return;
      }
    }
    setState(() {
      isFavorite = false;
    });
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
          showToast("이미지를 적용했습니다");
          loadFace = true;
        }
      });
      if (!mounted) return;
      reloadCharacterScreen(context);
    } else {
      faceNotMadeYet = true;
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
          if (count==1) {
            var curTop = Get.find<ClothesImageController>().getTopPath();
            if (curTop!="") {
              Get.find<ClothesImageController>().setTopImage(path+curTop, color: color);
            }
          } else if (count==2) {
            var curBot = Get.find<ClothesImageController>().getBotPath();
            if (curBot!="") {
              Get.find<ClothesImageController>().setBotImage(path+curBot, color: color);
            }
          } else if (count==3) {
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
    // 여성 옷 위치 설정
    var femaleShoeBgPosition = [MediaQuery.of(context).size.height*0.003,0.0];
    var femaleShoePosition = [MediaQuery.of(context).size.height*0.003, MediaQuery.of(context).size.width*0.22];
    var femaleTopBgPosition = [MediaQuery.of(context).size.height*0.138, -5.0];
    var femaleTopPosition = [MediaQuery.of(context).size.height*0.125, MediaQuery.of(context).size.width*0.19];
    var femaleBotBgPosition = [MediaQuery.of(context).size.height*0.34, MediaQuery.of(context).size.width*0.32];
    var femaleBotPosition = [MediaQuery.of(context).size.height*0.25, MediaQuery.of(context).size.width*0.19];
    var femaleOutPosition = [MediaQuery.of(context).size.height*0.125, MediaQuery.of(context).size.width*0.19];

    // 남성 옷 위치 설정
    var maleShoeBgPosition = [0.0, 0.0];
    var maleShoePosition = [0.0, MediaQuery.of(context).size.width*0.18];
    var maleTopBgPosition = [MediaQuery.of(context).size.height*0.132, -5.0];
    var maleTopPosition = [MediaQuery.of(context).size.height*0.107, MediaQuery.of(context).size.width*0.17];
    var maleBotBgPosition = [MediaQuery.of(context).size.height*0.34, MediaQuery.of(context).size.width*0.32];
    var maleBotPosition = [MediaQuery.of(context).size.height*0.25, MediaQuery.of(context).size.width*0.182];
    var maleOutPosition = [MediaQuery.of(context).size.height*0.105, MediaQuery.of(context).size.width*0.182];

    // 성별에 따른 위치 확정
    var shoeBgPosition = (gender=="male") ? maleShoeBgPosition : femaleShoeBgPosition;
    var shoePosition = (gender=="male") ? maleShoePosition : femaleShoePosition;
    var topBgPosition = (gender=="male") ? maleTopBgPosition : femaleTopBgPosition;
    var topPosition = (gender=="male") ? maleTopPosition : femaleTopPosition;
    var botBgPosition = (gender=="male") ? maleBotBgPosition : femaleBotBgPosition;
    var botPosition = (gender=="male") ? maleBotPosition : femaleBotPosition;
    var outPosition = (gender=="male") ? maleOutPosition : femaleOutPosition;

    // 합성된 얼굴 적용
    if (! loadFace && ! faceNotMadeYet) {
      loadUserImage();
    }

    // 현재옷 즐겨찾기 확인
    if (!isChecked) {
      chkIsFavorite(curClothes);
    }

    // 기온 불러오기
    curTemp = Get.find<WeatherJasonData>().getData()[0];
    clothesStack = [  // 순서대로 신발, 상의, 하의, 아우터
      clothesPositionFromBottom(shoeBgPosition[0], shoeBgPosition[1], clothesImages[0]),  // 신발 배경
      clothesPositionFromBottom(shoePosition[0], shoePosition[1], clothesImages[1]),  // 신발
      clothesPosition(topBgPosition[0], topBgPosition[1], clothesImages[2]),    // 상의 배경
      clothesPosition(topPosition[0], topPosition[1], clothesImages[3]),    // 상의
      clothesPosition(botBgPosition[0], botBgPosition[1], clothesImages[4]),   // 하의 배경
      clothesPosition(botPosition[0], botPosition[1], clothesImages[5]),   // 하의
      clothesPosition(outPosition[0], outPosition[1], clothesImages[6])    // 아우터
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
              setState(() {
                isFavorite = false;
              });
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
              setState(() {
                isFavorite = true;
              });
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
    //봄 웜
    List<Widget> buildBoxSpring(int count) {
      List<Widget> buttons = [];
      switch(count){
        case 1: //상의
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFF5e1e13))), //red
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFFeec8c5))), //pink
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFF588f54))), //green
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF303e2f))), //khaki
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF2c3755))), //navy
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFFa291b3))), //purple
            clothesPositionFromBottom(15, 210,colorOnPalette(const Color(0xFF3a2b22))),//brown
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFFebebeb))), //white
            clothesPositionFromBottom(15, 270,colorOnPalette(const Color(0xFF727272))), //gray
            clothesPositionFromBottom(15, 300,colorOnPalette(const Color(0xFF272727))), //black
          ];
          return buttons;
        case 2: //하의
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFFebebeb))), //white
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFFa69879))), //beige
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFF413c38))), //brown
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF7c6375))), //pink
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF414c41))), //khaki
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFF96abb8))), //denim(연청)
            clothesPositionFromBottom(15, 210,colorOnPalette(const Color(0xFF2c3755))), //navy
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFF5e5e5e))), //gray
            clothesPositionFromBottom(15, 270,colorOnPalette(const Color(0xFF272727))) //black
          ];
          return buttons;
        case 3: //아우터
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFF5e1e13))), //red
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFFeec8c5))), //pink
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFF588f54))), //green
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF303e2f))), //khaki
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF2c3755))), //navy
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFFa291b3))), //purple
            clothesPositionFromBottom(15, 210,colorOnPalette(const Color(0xFF3a2b22))),//brown
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFFebebeb))), //white
            clothesPositionFromBottom(15, 270,colorOnPalette(const Color(0xFF727272))), //gray
            clothesPositionFromBottom(15, 300,colorOnPalette(const Color(0xFF272727))), //black
          ];
          return buttons;
        default:
          return [];
      }
    }

    //여름 쿨
    List<Widget> buildBoxSummer(int count) {
      List<Widget> buttons = [];
      switch(count){
        case 1: //상의
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFFa43636))),  //red
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFFe092b8))),  //pink
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFFc9c47e))),  //yellow
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF79b4ad))), //mint
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF8aa0ce))), //blue
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFF1e2a4a))), //navy
            clothesPositionFromBottom(15, 200,colorOnPalette(const Color(0xFFa588ce))), //purple
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFFb0b0b0))), //white
            clothesPositionFromBottom(15, 270,colorOnPalette(const Color(0xFF6d6d6d))), //gray
            clothesPositionFromBottom(15, 300,colorOnPalette(const Color(0xFF212121))), //black
          ];
          return buttons;
        case 2: //하의
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFFc4c4c4))), //white
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFFa69879))), //beige
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFF413c38))), //brown
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF7c6375))), //pink
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF414c41))), //khaki
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFF96abb8))), //denim(연청)
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF2c3755))), //navy
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFF5e5e5e))), //gray
            clothesPositionFromBottom(15, 270,colorOnPalette(const Color(0xFF1a1a1a))) //black
          ];
          return buttons;
        case 3: //아우터
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFFa43636))),  //red
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFFe092b8))),  //pink
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFFc9c47e))),  //yellow
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF79b4ad))), //mint
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF8aa0ce))), //blue
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFF1e2a4a))), //navy
            clothesPositionFromBottom(15, 200,colorOnPalette(const Color(0xFFa588ce))), //purple
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFFb0b0b0))), //white
            clothesPositionFromBottom(15, 270,colorOnPalette(const Color(0xFF6d6d6d))), //gray
            clothesPositionFromBottom(15, 300,colorOnPalette(const Color(0xFF212121))), //black
          ];
          return buttons;
        default:
          return [];
      }
    }

    //가을 웜
    List<Widget> buildBoxAutumn(int count) {
      List<Widget> buttons = [];
      switch(count){
        case 1: //상의
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFF2e030a))), //red
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFF84657b))), //pink
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFF17280e))), //green
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF303e2f))), //khaki
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF2c3755))), //navy
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFF260629))), //purple
            clothesPositionFromBottom(15, 210,colorOnPalette(const Color(0xFF272022))),//brown
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFFebebeb))), //white
            clothesPositionFromBottom(15, 270,colorOnPalette(const Color(0xFF727272))), //gray
            clothesPositionFromBottom(15, 300,colorOnPalette(const Color(0xFF272727))), //black
          ];
          return buttons;
        case 2: //하의
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFFc4c4c4))), //white
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFFa69879))), //beige
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFF413c38))), //brown
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF7c6375))), //pink
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF414c41))), //khaki
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFF96abb8))), //denim(연청)
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF2c3755))), //navy
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFF5e5e5e))), //gray
            clothesPositionFromBottom(15, 270,colorOnPalette(const Color(0xFF1a1a1a))) //black
          ];
          return buttons;
        case 3: //아우터
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFF2e030a))), //red
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFF84657b))), //pink
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFF17280e))), //green
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF303e2f))), //khaki
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF2c3755))), //navy
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFF260629))), //purple
            clothesPositionFromBottom(15, 210,colorOnPalette(const Color(0xFF272022))),//brown
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFFebebeb))), //white
            clothesPositionFromBottom(15, 270,colorOnPalette(const Color(0xFF727272))), //gray
            clothesPositionFromBottom(15, 300,colorOnPalette(const Color(0xFF272727))), //black
          ];
          return buttons;
        default:
          return [];
      }
    }

    //겨울 쿨
    List<Widget> buildBoxWinter(int count) {
      List<Widget> buttons = [];
      switch(count){
        case 1: //상의
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFF7c0000))), //red
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFFcb136d))), //pink
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFFe7da3c))), //yellow
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF0b655a))), //mint
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF1810c8))), //blue
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFF1e2a4a))), //navy
            clothesPositionFromBottom(15, 210,colorOnPalette(const Color(0xFF5d0dcd))),//purple
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFFb0b0b0))), //white
            clothesPositionFromBottom(15, 270,colorOnPalette(const Color(0xFF3b3b3b))), //gray
            clothesPositionFromBottom(15, 300,colorOnPalette(const Color(0xFF212121))), //black
          ];
          return buttons;
        case 2: //하의
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFFc4c4c4))), //white
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFFa69879))), //beige
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFF413c38))), //brown
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF7c6375))), //pink
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF414c41))), //khaki
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFF96abb8))), //denim(연청)
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF2c3755))), //navy
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFF5e5e5e))), //gray
            clothesPositionFromBottom(15, 270,colorOnPalette(const Color(0xFF1a1a1a))) //black
          ];
          return buttons;
        case 3: //아우터
          buttons = [
            clothesPositionFromBottom(15, 30,colorOnPalette(const Color(0xFF7c0000))), //red
            clothesPositionFromBottom(15, 60,colorOnPalette(const Color(0xFFcb136d))), //pink
            clothesPositionFromBottom(15, 90,colorOnPalette(const Color(0xFFe7da3c))), //yellow
            clothesPositionFromBottom(15, 120,colorOnPalette(const Color(0xFF0b655a))), //mint
            clothesPositionFromBottom(15, 150,colorOnPalette(const Color(0xFF1810c8))), //blue
            clothesPositionFromBottom(15, 180,colorOnPalette(const Color(0xFF1e2a4a))), //navy
            clothesPositionFromBottom(15, 210,colorOnPalette(const Color(0xFF5d0dcd))),//purple
            clothesPositionFromBottom(15, 240,colorOnPalette(const Color(0xFFb0b0b0))), //white
            clothesPositionFromBottom(15, 270,colorOnPalette(const Color(0xFF3b3b3b))), //gray
            clothesPositionFromBottom(15, 300,colorOnPalette(const Color(0xFF212121))), //black
          ];
          return buttons;
        default:
          return [];
      }
    }

    List<Widget> displayButtons(var percol, int count){
      switch(percol){
        case "Spring Warm":
          return buildBoxSpring(count);
        case "Summer Cool":
          return buildBoxSummer(count);
        case "Autumn Warm":
          return buildBoxAutumn(count);
        case "Winter Cool":
          return buildBoxWinter(count);
        default:
          return [];
      }
    }

    //색상 팔레트 아이콘 클릭
    void _buttonclickcount(){
      setState(() {
        count =(count + 1) % 4;
      });
    }

    // 팔레트 버튼 이미지
    Image colorbutton(){
      //초기
      if(count == 0){
        return Image.asset("assets/icon_color.png", width: 20, height: 20,);
      }
      //상의
      else if(count == 1){
        return Image.asset("assets/icon_top.png", width: 20, height: 20,);
      }
      //하의
      else if(count == 2){
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
                  ... displayButtons(perCol, count)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}