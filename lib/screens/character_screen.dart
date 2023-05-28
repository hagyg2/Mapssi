import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mapssi/main.dart';
import 'package:mapssi/customIconSets/coordi_icons.dart';
import 'package:mapssi/customIconSets/top_clothes_icons.dart';
import 'package:mapssi/customIconSets/overcoat_icons.dart';
import 'package:mapssi/customIconSets/shoes_icons.dart';
// import 'package:mapssi/customIconSets/pants.dart';


//화면 중앙 (현재 기온, 캐릭터, 체형 조절)
class SliderAndChkBox extends StatefulWidget {
  const SliderAndChkBox({super.key});

  @override
  _SliderAndChkBoxState createState() => _SliderAndChkBoxState();
}

class _SliderAndChkBoxState extends State<SliderAndChkBox> {
  bool _isVisible = true;
  var height=165.0;   // 키 몸무게 초기화
  var weight=80.0;

  int? curTemp;

  @override
  Widget build(BuildContext context) {
    curTemp = Get.find<WeatherJasonData>().getData()[0];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 체크 박스
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
            child: Checkbox(
              value: _isVisible,
              onChanged: (value) {
                setState(() {
                  _isVisible = value ?? true;
                });
              },
            ),
          ),
        ),
        // 아바타 이미지
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Expanded(         // 현재 기온
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.03,),
                  child: Text(
                    style: const TextStyle(fontSize: 40),
                    "$curTemp°C",
                  ),
                ),
              ),
              SizedBox(
                height: height*2.6,
                width: weight*3,
                child: Image.asset(
                  'assets/male_avatar.png',
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Visibility(       // 아래 쪽 몸무게 슬라이더
                  visible: !_isVisible,
                  child: Slider(
                    min: 40,
                    max: 120,
                    divisions : 16,
                    value: weight,
                    onChanged: (newValue) {
                      setState(() {
                        weight = newValue;
                        build(context);
                      });
                    },
                    label: '$weight',
                  ),
                ),
              )
              ],
          ),
        ),
        Expanded(               // 오른쪽 키 슬라이더
          flex: 1,
          child: Visibility(
            visible: !_isVisible,
            child: RotatedBox(
              quarterTurns: 3,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.35,
                  child: Slider(
                    min: 130,
                    max: 200,
                    value: height,
                    divisions : 14,
                    onChanged: (newValue) {
                      setState(() {
                        height = newValue;
                        build(context);
                      });
                    },
                    label: '$height',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// 메뉴 열리면 나오는 옷 정보
class ClothesInfo {
  Icon? clothesIcon;
  String? clothesName;
  ClothesInfo (ic, n) {
    clothesIcon = ic;
    clothesName = n;
  }
}


// 코디 선택 메뉴
class CoordiBottomSheet extends StatefulWidget {
  CoordiBottomSheet({Key? key, required this.index}) : super(key: key);
  final int index;

  final List topClothesList = [
    ClothesInfo(const Icon(TopClothes.casual_shirt, size: 45), "casual_shirt"),
    ClothesInfo(const Icon(TopClothes.casual_sweat_shirt, size: 45), "casual_sweat_shirt"),
    ClothesInfo(const Icon(TopClothes.casual_t_shirt, size: 45), "casual_t_shirt"),
    ClothesInfo(const Icon(TopClothes.hoodie, size: 45), "hoodie"),
    ClothesInfo(const Icon(TopClothes.pocket_t_shirt, size: 45), "pocket_t_shirt"),
    ClothesInfo(const Icon(TopClothes.polo_shirt, size: 45), "polo_shirt"),
    ClothesInfo(const Icon(TopClothes.reglan_sweat_shirt, size: 45), "reglan_sweat_shirt"),
    ClothesInfo(const Icon(TopClothes.reglan_t_shirt, size: 45), "reglan_t_shirt"),
    ClothesInfo(const Icon(TopClothes.sleeveless_shirt, size: 45), "sleeveless_shirt"),
    ClothesInfo(const Icon(TopClothes.sleeveless_top, size: 45), "sleeveless_top"),
    ClothesInfo(const Icon(TopClothes.tank_top, size: 45), "tank_top"),
    ClothesInfo(const Icon(TopClothes.v_neck_t_shirt, size: 45), "v_neck_t_shirt"),
    ClothesInfo(const Icon(TopClothes.zip_hoodie, size: 45), "zip_hoodie")
  ];

  final List pantsList = [];

  final List shoesList = [
    ClothesInfo(const Icon(Shoes.chelsea_boot, size: 45), "chelsea_boot"),
    ClothesInfo(const Icon(Shoes.dress_shoes, size: 45), "dress_shoes"),
    ClothesInfo(const Icon(Shoes.flat_shoes, size: 45), "flat_shoes"),
    ClothesInfo(const Icon(Shoes.high_heel, size: 45), "high_heel"),
    ClothesInfo(const Icon(Shoes.running_shoes, size: 45), "running_shoes"),
    ClothesInfo(const Icon(Shoes.slip_on, size: 45), "slip_on"),
    ClothesInfo(const Icon(Shoes.slipper, size: 45), "slipper"),
    ClothesInfo(const Icon(Shoes.sneakers, size: 45), "sneakers"),
    ClothesInfo(const Icon(Shoes.walker, size: 45), "walker")
  ];

  final List overcoatList = [
    ClothesInfo(const Icon(Overcoat.bomber, size: 45), "bomber"),
    ClothesInfo(const Icon(Overcoat.cardigan, size: 45), "cardigan"),
    ClothesInfo(const Icon(Overcoat.casual_jacket, size: 45), "casual_jacket"),
    ClothesInfo(const Icon(Overcoat.collar_cardigan, size: 45), "collar_cardigan"),
    ClothesInfo(const Icon(Overcoat.leather_jacket, size: 45), "leather_jacket"),
    ClothesInfo(const Icon(Overcoat.overcoat, size: 45), "overcoat"),
    ClothesInfo(const Icon(Overcoat.parka, size: 45), "parka"),
    ClothesInfo(const Icon(Overcoat.sport_jacket, size: 45), "sport_jacket"),
    ClothesInfo(const Icon(Overcoat.track_jacket, size: 45), "track_jacket"),
    ClothesInfo(const Icon(Overcoat.windcheater, size: 45), "windcheater"),
  ];

  @override
  State<CoordiBottomSheet> createState() => _CoordiBottomSheetState();
}

class _CoordiBottomSheetState extends State<CoordiBottomSheet>  with TickerProviderStateMixin{
  int _currentSheetIndex = 0;
  late AnimationController _animationController;
  List clothesNum = [13,0,9,10,0]; // 상 하 신 외 개수

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _currentSheetIndex = widget.index;
    });
    return _buildBottomSheet();
  }

  BottomSheet _buildBottomSheet() {
    List clothesList = [widget.topClothesList, widget.pantsList, widget.shoesList, widget.overcoatList];
    return BottomSheet(
      onClosing: () {  },
      builder: (BuildContext context) {
        return FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                curve: Curves.easeIn,
                parent: ModalRoute.of(context)!.animation!,
                reverseCurve: Curves.easeOut,
              ),
            ),
            child: ListView(
              children: <Widget>[
                GridView.count(
                  crossAxisCount: 3, // 한 행에 들어갈 아이템 의 개수
                  shrinkWrap: true, // GridView 의 크기를 its contents 에 맞게 조절
                  physics: const ScrollPhysics(), // GridView 에서 스크롤 가능 하게 만듦
                  children: List.generate(clothesNum[_currentSheetIndex], (index) {
                    return Center(
                      child: InkWell(
                        onTap: () {
                          // 버튼 클릭 시 실행할 코드
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.27,
                          width: MediaQuery.of(context).size.width * 0.27,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black,width: 1),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(1), // 그림자 색상 및 투명도
                                spreadRadius: 1, // 그림자의 퍼지는 정도
                                blurRadius: 7, // 그림자의 흐림 정도
                                offset: Offset(0, 3), // 그림자의 위치 조정
                              ),
                            ],
                          ),
                          child: clothesList[_currentSheetIndex][index].clothesIcon,
                        ),
                      ),
                    );}
                  ),
                ),
              ],
            )
        );
      },
      // 첫 번째 bottom sheet 의 위젯 구현
    );
  }
}


// 화면 하단 아이콘 누르면 위로 올라오게 하기
class Coordinater extends StatelessWidget {
  Coordinater({Key? key, required this.index}) : super(key: key);
  final int index;
  final List<Icon> icons = [const Icon(CoordiIcons.shirts), const Icon(CoordiIcons.pants), const Icon(CoordiIcons.shoes), const Icon(CoordiIcons.coat), const Icon(CoordiIcons.ai_recommend)];

  @override
  Widget build(BuildContext context) {
    Icon varIcon;
    varIcon = icons[index];

    return IconButton(
      icon: varIcon,
      onPressed: () {
        showCoordiBottomSheet(context, index);
      },
    );
  }

  showCoordiBottomSheet (BuildContext context, int ind) {
    BuildContext temp;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: IconButton(onPressed: () {
                      temp = context;
                      Navigator.pop(context);
                      showCoordiBottomSheet(temp, 0);
                    }, icon: icons[0])),
                    Expanded(child: IconButton(onPressed: () {
                      temp = context;
                      Navigator.pop(context);
                      showCoordiBottomSheet(temp, 1);
                    }, icon: icons[1])),
                    Expanded(child: IconButton(onPressed: () {
                      temp = context;
                      Navigator.pop(context);
                      showCoordiBottomSheet(temp, 2);
                    }, icon: icons[2])),
                    Expanded(child: IconButton(onPressed: () {
                      temp = context;
                      Navigator.pop(context);
                      showCoordiBottomSheet(temp, 3);
                    }, icon: icons[3])),
                    Expanded(child: IconButton(onPressed: () {
                      temp = context;
                      Navigator.pop(context);
                      showCoordiBottomSheet(temp, 4);
                    }, icon: icons[4])),
                  ],
                ),
                Expanded(
                  child: CoordiBottomSheet(index: ind),
                )
              ]
          ),
        );
      },
    );
  }
}


// 캐릭터 페이지
class CharacterPage extends StatelessWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(flex: 1,child: SizedBox()),
          Expanded( // 조언 멘트
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10,3,10,3),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    child: const Text(
                      '황사가 심해요! 마스크는 필수!',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 체크 박스와 슬라이더
          const Expanded(flex:9, child: SliderAndChkBox()),
          // 옷 메뉴
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black,width: 1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Coordinater(index: 0),
                  Coordinater(index: 1),
                  Coordinater(index: 2),
                  Coordinater(index: 3),
                  Coordinater(index: 4)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
