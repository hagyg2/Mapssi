import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mapssi/main.dart';
import 'package:mapssi/screens/character/fnc_for_character_screen.dart';
import 'package:mapssi/screens/character/char_and_temp.dart';
import 'package:mapssi/screens/character/clothes_options.dart';


GlobalKey key = GlobalKey();
String gender = Get.find<UserDataFromServer>().getUserGender() == 0 ? 'female' : 'male';
String assetManifest = '';
bool gotManifest = false;
bool loadFace = false;
double topBgImageWidth = 0;
double topImageWidth = 0;
double botImageWidth = 0;
double outImageWidth = 0;
double shoeBgImageWidth = 0;
double shoeImageWidth = 0;


// 의상 이미지 전역변수화 (여러 클래스에서 사용하기 위함)
class ClothesImageController extends GetxController {
  String top='';
  String bot='';
  String out='';
  String shoe='';
  ColorFiltered topBg = setImage('assets/character/initialImage.png', topBgImageWidth); // 상의 배경
  ColorFiltered topImage = setImage('assets/character/initialImage.png', topImageWidth); // 상의
  ColorFiltered botBg = setImage('assets/character/initialImage.png', botImageWidth);    // 하의 배경
  ColorFiltered botImage = setImage('assets/character/initialImage.png', botImageWidth); // 하의
  ColorFiltered outImage = setImage('assets/character/initialImage.png', outImageWidth); // 아우터
  ColorFiltered shoeBg = setImage('assets/character/initialImage.png', shoeBgImageWidth);    // 신발 배경
  ColorFiltered shoeImage = setImage('assets/character/initialImage.png', shoeImageWidth); // 신발

  resetImages() {
    top='';
    bot='';
    out='';
    shoe='';
    topBg = setImage('assets/character/initialImage.png', topBgImageWidth);
    topImage = setImage('assets/character/initialImage.png', topImageWidth);
    botBg = setImage('assets/character/initialImage.png', botImageWidth);
    botImage = setImage('assets/character/initialImage.png', botImageWidth);
    outImage = setImage('assets/character/initialImage.png', outImageWidth);
    shoeBg = setImage('assets/character/initialImage.png', shoeBgImageWidth);
    shoeImage = setImage('assets/character/initialImage.png', shoeImageWidth);
    return;
  }

  setTopImage(String path, {Color? color=Colors.white}) {
    var needBg = path.split("_").last;
    if (needBg != "noBg.png") {
      topBg = setImage('assets/character/$gender/top_bg.jpg', topBgImageWidth);
    } else {
      topBg = setImage('assets/character/initialImage.png', botImageWidth);
    }
    top = "${path.split("/").last}@${color?.value.toString()}";
    topImage =  setImage(path, topImageWidth, color!);
    return;
  }

  setBotImage(String path, {Color? color=Colors.white}) {
    var length = path.split("_").last;
    if (length =="long.png") {
      botBg = setImage('assets/character/$gender/botBgLong.png', botImageWidth*0.4);
    } else if (length == "short.png") {
      botBg = setImage('assets/character/$gender/botBgShort.png', botImageWidth*0.4);
    } else {
      botBg = setImage('assets/character/initialImage.png', botImageWidth);
    }
    bot = "${path.split("/").last}@${color?.value.toString()}";
    botImage = setImage(path, botImageWidth, color!);
    return;
  }

  setOutImage(String path, {Color? color=Colors.white}) {
    out = "${path.split("/").last}@${color?.value.toString()}";
    outImage = setImage(path, outImageWidth, color!);
    return;
  }

  setShoeImage(String path, {Color? color=Colors.white}) {
    var needBg = path.split("_").last;
    if (needBg != "noBg.png") {
      shoeBg = setImage('assets/character/$gender/shoe_bg.jpg', shoeBgImageWidth);
    } else {
      shoeBg = setImage('assets/character/initialImage.png', botImageWidth);
    }
    shoe = "${path.split("/").last}@${color?.value.toString()}";
    shoeImage = setImage(path, shoeImageWidth, color!);
    return;
  }

  getImage() {
    return [shoeBg, shoeImage, topBg, topImage, botBg, botImage, outImage];
  }

  getFileName() {
    if (top.startsWith("initialImage")){
      top = "";
    }
    if (bot.startsWith("initialImage")){
      bot = "";
    }
    if (out.startsWith("initialImage")){
      out = "";
    }
    if (shoe.startsWith("initialImage")){
      shoe = "";
    }
    return "$top^$bot^$out^$shoe";
  }

  getTopPath() {
    if (top==""){
      return top;
    } else {
      return top.split("@").first;
    }
  }

  getBotPath() {
    if (bot==""){
      return bot;
    } else {
      return bot.split("@").first;
    }
  }

  getOutPath() {
    if (out==""){
      return out;
    } else {
      return out.split("@").first;
    }
  }
}



// 메뉴가 올라 오지 않은 캐릭터 페이지 전체
class CharacterPage extends StatelessWidget {
  const CharacterPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    gender = Get.find<UserDataFromServer>().getUserGender() == 0 ? 'female' : 'male';
    // 옷 크기 설정
    if (gender == "female") {
      topBgImageWidth = MediaQuery.of(context).size.width*0.9;
      topImageWidth = MediaQuery.of(context).size.width*0.405;
      botImageWidth = MediaQuery.of(context).size.width*0.41;
      outImageWidth = MediaQuery.of(context).size.width*0.405;
      shoeBgImageWidth = MediaQuery.of(context).size.width*0.88;
      shoeImageWidth = MediaQuery.of(context).size.width*0.416;
    } else {
      topBgImageWidth = MediaQuery.of(context).size.width*0.9;
      topImageWidth = MediaQuery.of(context).size.width*0.49;
      botImageWidth = MediaQuery.of(context).size.width*0.476;
      outImageWidth = MediaQuery.of(context).size.width*0.475;
      shoeBgImageWidth = MediaQuery.of(context).size.width*0.9;
      shoeImageWidth = MediaQuery.of(context).size.width*0.475;
    }

    Get.put(ClothesImageController());
    // 메뉴 옵션들 간에 벽(divider)
    var divider = const VerticalDivider(
      color: Color(0xFFBCBCBC),
      width: 2,
      thickness: 1.5,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_image.png'),
              fit: BoxFit.cover,
            )
        ),
        child: Padding( // 양 옆 간격
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 페이지 인디케이터
              Padding(
                padding: const EdgeInsets.fromLTRB(0,50,0,20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 15,
                      height: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 10), // 회색 동그라미와 검정색 동그라미 사이 간격
                    Container(
                      width: 15,
                      height: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // 조언 멘트
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  weatherCast(),
                  style: txtStyle(16),
                ),
              ),

              // 중간부 (체크 박스와 슬라이더, 캐릭터) (상세한건 바로 아래 CharAndTemp 클래스에서 구현)
              const Expanded(flex:8, child: CharAndTemp()),

              // 하단부 (옷 메뉴)
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFFDF9),
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(0),top: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 1), // 그림자 의 위치 조정
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BottomMenu(index: 0),
                      divider,
                      BottomMenu(index: 1),
                      divider,
                      BottomMenu(index: 2),
                      divider,
                      BottomMenu(index: 3),
                      divider,
                      BottomMenu(index: 4)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// 위로 올라오는 메뉴
class BottomMenu extends StatelessWidget {
  BottomMenu({Key? key, required this.index}) : super(key: key);
  final int index;
  final List<String> categories = ["상의", "하의", "외투", "신발", "추천"];

  @override
  Widget build(BuildContext context) {
    Color txtColor;
    if (index<4) {
      txtColor = Colors.black;
    } else {
      txtColor = Colors.red;
    }
    return TextButton(
      child: Text(categories[index], style: TextStyle(color: txtColor,
          fontFamily: 'SUITE',
          fontWeight: FontWeight.w800,
          fontSize: 20)
      ),
      onPressed: () {
        showCoordiBottomSheet(context, index);
      },
    );
  }

  // 눌렀을 때 메뉴가 위로 올라오게 함 (상세한 부분은 아래 ClothesOption 클래스에서 구현)
  showCoordiBottomSheet (BuildContext context, int ind) {
    // BuildContext temp;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
            height: MediaQuery.of(context).size.height*0.77,
            child: ClothesOptions(depth: 0, indexes: [ind, 0])
        );
      },
    );
  }
}