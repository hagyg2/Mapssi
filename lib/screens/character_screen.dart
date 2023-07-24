import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mapssi/main.dart';
import 'package:mapssi/color_table.dart';


bool gotResponse = false;
List gptResponse = [];
List recommended = [];

//화면 중앙 (현재 기온, 캐릭터, 체형 조절)
class SliderAndChkBox extends StatefulWidget {
  const SliderAndChkBox({super.key});

  @override
  _SliderAndChkBoxState createState() => _SliderAndChkBoxState();
}

class _SliderAndChkBoxState extends State<SliderAndChkBox> {
  // bool _isVisible = true;
  var height=165.0;   // 키 몸무게 초기화
  var weight=80.0;

  int? curTemp;

  @override
  Widget build(BuildContext context) {
    curTemp = Get.find<WeatherJasonData>().getData()[0];
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // // 체크 박스
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     child: Checkbox(
              //       value: _isVisible,
              //       onChanged: (value) {
              //         setState(() {
              //           _isVisible = value ?? true;
              //         });
              //       },
              //     ),
              //   ),
              // ),

              // 현재 기온
              Container(
                child: Text(
                  style: const TextStyle(fontSize: 50,
                    color: Colors.black,
                    fontFamily: 'SUITE',
                    fontWeight: FontWeight.w800,
                  ),
                  "$curTemp°C",
                ),
              ),
            ],
          ),
        ),
        // 아바타 이미지
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
            decoration: BoxDecoration(
              color: Color(0xFFFFFDF9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 1), // 그림자의 위치 조정
                )
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Image.asset(
                  'assets/male_avatar.png',
                  fit: BoxFit.contain,
              ),
            ),
          ),
        )
        // Expanded(
        //   flex: 4,
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         child: Image.asset(
        //           'assets/male_avatar.png',
        //           fit: BoxFit.fill,
        //         ),
        //       ),
        //       Expanded(
        //         child: Visibility(       // 아래 쪽 몸무게 슬라이더
        //           visible: !_isVisible,
        //           child: Slider(
        //             min: 40,
        //             max: 120,
        //             divisions : 16,
        //             value: weight,
        //             onChanged: (newValue) {
        //               setState(() {
        //                 weight = newValue;
        //                 build(context);
        //               });
        //             },
        //             label: '$weight',
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        // Expanded(               // 오른쪽 키 슬라이더
        //   flex: 1,
        //   child: Visibility(
        //     visible: !_isVisible,
        //     child: RotatedBox(
        //       quarterTurns: 3,
        //       child: Center(
        //         child: SizedBox(
        //           width: MediaQuery.of(context).size.height * 0.35,
        //           child: Slider(
        //             min: 130,
        //             max: 200,
        //             value: height,
        //             divisions : 14,
        //             onChanged: (newValue) {
        //               setState(() {
        //                 height = newValue;
        //                 build(context);
        //               });
        //             },
        //             label: '$height',
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}


// 메뉴 열리면 나오는 옷 정보
class ClothesInfo {
  AssetImage? clothesImage;
  String? clothesName;
  ClothesInfo (img, n) {
    clothesImage = img;
    clothesName = n;
  }
}

// 지피티 추천 파트
class ChatGPTRecommend extends StatefulWidget {
  ChatGPTRecommend({Key? key}) : super(key: key);

  @override
  State<ChatGPTRecommend> createState() => _ChatGPTRecommendState();
}

class _ChatGPTRecommendState extends State<ChatGPTRecommend> {
  @override
  Widget build(BuildContext context) {
    var curTemp = Get.find<WeatherJasonData>().getData()[0];
    UserDataFromServer userController = Get.find<UserDataFromServer>();
    var gender = userController.getUserGender()==1 ? 'men' : 'women';
    var prefType = userController.getUserPrefType();
    var perCol = userController.getUserPerCol();
    if (!gotResponse) {
      return ElevatedButton(onPressed: () async {
        chatRequest('''Please recommend 3 ${prefType} styles of clothing for ${gender} with ${perCol}-toned personal colors in sunny weather of ${curTemp} degrees.
        The format consists of color & top clothes + color & bottom clothes and requires no explanation.''');
      },
      style: ButtonStyle(fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width*0.7,0)),),
      child: const Text("AI 추천 생성"));
    } else {
      return ListView(
        children: <Widget>[
          GridView.count(
            childAspectRatio: 0.7,
            crossAxisCount: 3, // 한 행에 들어갈 아이템 의 개수
            shrinkWrap: true, // GridView 의 크기를 its contents 에 맞게 조절
            physics: const ScrollPhysics(), // GridView 에서 스크롤 가능 하게 만듦
            children: List.generate(3, (index) {
              return Center(
                child: InkWell(
                  onTap: () {
                    // 버튼 클릭 시 실행할 코드
                  },
                  child: Column(
                    children: [
                      Container(
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
                            offset: const Offset(0, 3), // 그림자의 위치 조정
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(flex: 1,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(recommended[index][0][0]),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)
                                    ),
                                  )
                              )
                          ),
                          Expanded(flex: 1,
                              child:Container(
                                  decoration: BoxDecoration(
                                    color: Color(recommended[index][1][0]),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30)
                                    ),
                                  )
                              )
                          ),
                        ],
                      ),
                    ),
                      Text(gptResponse[index],textAlign: TextAlign.center),
                    ],
                  ),
                ),
              );}
            ),
          ),
        ],
      );
    }
  }

  Future<String> chatRequest(String userInput) async {
    const serverUrl = 'http://52.79.164.56:50000'; // 노드 서버의 엔드포인트 URL
    var url ='$serverUrl/recommend';

    // ChatGPT API에 전달할 데이터
    print(userInput);
    var requestBody = {'question' : userInput};

    // API 요청 보내기
    final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody)
    );

    if (response.statusCode == 200) {
      // API 요청이 성공적으로 완료되었을 때
      var result = '';
      if (response.body=='No Response'){
        result = response.body;
      } else {
        result = json.decode(response.body)['content'].toString();
        print(result);
      }
      setState(() {
        parser(result);
        print(recommended);
        if (recommended.length==3) {
          gotResponse = true;
        }
        build(context);
      });
      return response.body;
    } else {
      // API 요청이 실패했을 때
      throw Exception('ChatGPT API 요청 실패: ${response.statusCode}');
    }
  }

  void parser (String result) {
    if (result=='No Response') {
      return;
    }
    for (var combination in result.split("\n")) {
      gptResponse.add(combination);
      var clothes = combination.split("+");
      var top = clothes[0].split(" ").sublist(1);
      var bottom = clothes[1].split(" ").sublist(1);
      int? topColor;
      int? bottomColor;
      var topType = "top";
      var bottomType = "bottom";
      if (colorMap.containsKey(top[1])) {
        topType = top.sublist(2).join(' ');
        String expectedColor = (top[0] + top[1]).toLowerCase();
        if (colorMap.containsKey(expectedColor)) {
          topColor = colorMap[expectedColor];
        } else {
          topColor = colorMap[top[1]];
        }
      } else {
        topColor = colorMap[top[0]];
        topType = top.sublist(1).join(' ');
      }
      if (colorMap.containsKey(bottom[1])) {
        bottomType = bottom.sublist(2).join(' ');
        String expectedColor = (bottom[0] + bottom[1]).toLowerCase();
        if (colorMap.containsKey(expectedColor)) {
          bottomColor = colorMap[expectedColor];
        } else {
          bottomColor = colorMap[bottom[1]];
        }
      } else {
        bottomColor = colorMap[bottom[0]];
        bottomType = bottom.sublist(1).join(' ');
      }
      topColor ?? (topColor = 0xFF000000);
      bottomColor ?? (bottomColor = 0xFF000000);
      recommended.add([[topColor, topType], [bottomColor, bottomType]]);
    }
  }
}


// 코디 선택 메뉴
class CoordiBottomSheet extends StatefulWidget {
  CoordiBottomSheet({Key? key, required this.index}) : super(key: key);
  final int index;

  final List topClothesList = [
    ClothesInfo(const AssetImage('assets/clothes/tops/casual_shirt.png'), "casual_shirt"),
    ClothesInfo(const AssetImage('assets/clothes/tops/casual_sweat_shirt.png'), "casual_sweat_shirt"),
    ClothesInfo(const AssetImage('assets/clothes/tops/casual_t_shirt.png'), "casual_t_shirt"),
    ClothesInfo(const AssetImage('assets/clothes/tops/hoodie.png'), "hoodie"),
    ClothesInfo(const AssetImage('assets/clothes/tops/pocket_t_shirt.png'), "pocket_t_shirt"),
    ClothesInfo(const AssetImage('assets/clothes/tops/polo_shirt.png'), "polo_shirt"),
    ClothesInfo(const AssetImage('assets/clothes/tops/reglan_sweat_shirt.png'), "reglan_sweat_shirt"),
    ClothesInfo(const AssetImage('assets/clothes/tops/reglan_t_shirt.png'), "reglan_t_shirt"),
    ClothesInfo(const AssetImage('assets/clothes/tops/sleeveless_shirt.png'), "sleeveless_shirt"),
    ClothesInfo(const AssetImage('assets/clothes/tops/sleeveless_top.png'), "sleeveless_top"),
    ClothesInfo(const AssetImage('assets/clothes/tops/tank_top.png'), "tank_top"),
    ClothesInfo(const AssetImage('assets/clothes/tops/v_neck_t_shirt.png'), "v_neck_t_shirt"),
    ClothesInfo(const AssetImage('assets/clothes/tops/zip_hoodie.png'), "zip_hoodie")
  ];

  final List pantsList = [
    ClothesInfo(const AssetImage('assets/clothes/bottoms/cargo.png'), "cargo"),
    ClothesInfo(const AssetImage('assets/clothes/bottoms/flare_pants.png'), "flare_pants"),
    ClothesInfo(const AssetImage('assets/clothes/bottoms/jogger_pants.png'), "jogger_pants"),
    ClothesInfo(const AssetImage('assets/clothes/bottoms/loose_pants.png'), "loose_pants"),
    ClothesInfo(const AssetImage('assets/clothes/bottoms/short_cargo.png'), "short_cargo"),
    ClothesInfo(const AssetImage('assets/clothes/bottoms/shorts.png'), "shorts"),
    ClothesInfo(const AssetImage('assets/clothes/bottoms/slim_fit_pants.png'), "slim_fit_pants"),
    ClothesInfo(const AssetImage('assets/clothes/bottoms/trousers.png'), "trousers"),
  ];

  final List shoesList = [
    ClothesInfo(const AssetImage('assets/clothes/shoes/chelsea_boot.png'), "chelsea_boot"),
    ClothesInfo(const AssetImage('assets/clothes/shoes/dress_shoes.png'), "dress_shoes"),
    ClothesInfo(const AssetImage('assets/clothes/shoes/flat_shoes.png'), "flat_shoes"),
    ClothesInfo(const AssetImage('assets/clothes/shoes/high_heel.png'), "high_heel"),
    ClothesInfo(const AssetImage('assets/clothes/shoes/running_shoes.png'), "running_shoes"),
    ClothesInfo(const AssetImage('assets/clothes/shoes/slip_on.png'), "slip_on"),
    ClothesInfo(const AssetImage('assets/clothes/shoes/slipper.png'), "slipper"),
    ClothesInfo(const AssetImage('assets/clothes/shoes/sneakers.png'), "sneakers"),
    ClothesInfo(const AssetImage('assets/clothes/shoes/walker.png'), "walker")
  ];

  final List overcoatList = [
    ClothesInfo(const AssetImage('assets/clothes/overcoat/bomber.png'), "bomber"),
    ClothesInfo(const AssetImage('assets/clothes/overcoat/cardigan.png'), "cardigan"),
    ClothesInfo(const AssetImage('assets/clothes/overcoat/casual_jacket.png'), "casual_jacket"),
    ClothesInfo(const AssetImage('assets/clothes/overcoat/collar_cardigan.png'), "collar_cardigan"),
    ClothesInfo(const AssetImage('assets/clothes/overcoat/leather_jacket.png'), "leather_jacket"),
    ClothesInfo(const AssetImage('assets/clothes/overcoat/overcoat.png'), "overcoat"),
    ClothesInfo(const AssetImage('assets/clothes/overcoat/parka.png'), "parka"),
    ClothesInfo(const AssetImage('assets/clothes/overcoat/sport_jacket.png'), "sport_jacket"),
    ClothesInfo(const AssetImage('assets/clothes/overcoat/track_jacket.png'), "track_jacket"),
    ClothesInfo(const AssetImage('assets/clothes/overcoat/windcheater.png'), "windcheater"),
  ];

  @override
  State<CoordiBottomSheet> createState() => _CoordiBottomSheetState();
}

class _CoordiBottomSheetState extends State<CoordiBottomSheet>  with TickerProviderStateMixin{
  int _currentSheetIndex = 0;
  late AnimationController _animationController;
  List clothesNum = [13,8,9,10,3]; // 상 하 신 외 개수

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

  StatefulWidget _buildBottomSheet() {
    if (_currentSheetIndex<4) {
      List clothesList = [
        widget.topClothesList,
        widget.pantsList,
        widget.shoesList,
        widget.overcoatList
      ];
      return BottomSheet(
        onClosing: () {},
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
                    children: List.generate(
                        clothesNum[_currentSheetIndex], (index) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            // 버튼 클릭 시 실행할 코드
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.27,
                            width: MediaQuery.of(context).size.width * 0.27,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  // 그림자 색상 및 투명도
                                  spreadRadius: 1,
                                  // 그림자의 퍼지는 정도
                                  blurRadius: 7,
                                  // 그림자의 흐림 정도
                                  offset: Offset(0, 3), // 그림자의 위치 조정
                                ),
                              ],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: clothesList[_currentSheetIndex][index].clothesImage
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    ),
                  ),
                ],
              )
          );
        },
        // 첫 번째 bottom sheet 의 위젯 구현
      );
    } else {
      return ChatGPTRecommend();
    }
  }

}


// 화면 하단 아이콘 누르면 위로 올라오게 하기
class Coordinater extends StatelessWidget {
  Coordinater({Key? key, required this.index}) : super(key: key);
  final int index;
  final List<String> categories = ["상의", "하의", "외투", "신발", "추천"];

  @override
  Widget build(BuildContext context) {
    String category = categories[index];
    if (index<4) {
      return TextButton(
        child: Text(category, style: TextStyle(color: Colors.black,
            fontFamily: 'SUITE',
            fontWeight: FontWeight.w800,
            fontSize: 20)),
        onPressed: () {
          showCoordiBottomSheet(context, index);
        },
      );
    } else {
      return TextButton(
        child: Text(category, style: TextStyle(color: Colors.red,
            fontFamily: 'SUITE',
            fontWeight: FontWeight.w800,
            fontSize: 20)),
        onPressed: () {
          showCoordiBottomSheet(context, index);
        },
      );
    }
  }

  showCoordiBottomSheet (BuildContext context, int ind) {
    // BuildContext temp;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return Container(
          child: Column(
              children: [
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
    gotResponse = false;
    recommended = [];
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
              // 페이지 표시 동그라미 두 개
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
                    SizedBox(width: 10), // 회색 동그라미와 검정색 동그라미 사이 간격
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
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child:
                  Container(
                    child: const Text(
                      '황사가 심해요! 마스크는 필수!',
                      style: TextStyle(fontSize: 16,
                        color: Colors.black,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w800,),
                    ),
                ),
              ),

              // 중간부 (체크 박스와 슬라이더, 캐릭터)
              const Expanded(flex:8, child: SliderAndChkBox()),

              // 하단부 (옷 메뉴)
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFDF9),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(0),top: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 1), // 그림자의 위치 조정
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Coordinater(index: 0),
                      const VerticalDivider(
                        color: Color(0xFFBCBCBC),
                        width: 2,
                        thickness: 1.5,
                      ),
                      Coordinater(index: 1),
                      const VerticalDivider(
                        color: Color(0xFFBCBCBC),
                        width: 2,
                        thickness: 1.5,
                      ),
                      Coordinater(index: 2),
                      const VerticalDivider(
                        color: Color(0xFFBCBCBC),
                        width: 2,
                        thickness: 1.5,
                      ),
                      Coordinater(index: 3),
                      const VerticalDivider(
                        color: Color(0xFFBCBCBC),
                        width: 2,
                        thickness: 1.5,
                      ),
                      Coordinater(index: 4)
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
