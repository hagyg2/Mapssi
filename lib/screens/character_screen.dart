import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapssi/main.dart';

TextStyle txtStyle (fs) {
  return TextStyle(fontSize: fs,
    color: Colors.black,
    fontFamily: 'SUITE',
    fontWeight: FontWeight.w800,
  );
}

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
  String gender = 'male';
  List<Widget> clothesStack = []; // 동적으로 추가될 위젯들의 리스트

  @override
  Widget build(BuildContext context) {
    curTemp = Get.find<WeatherJasonData>().getData()[0];
    Get.find<UserDataFromServer>().getUserGender()==0 ? gender = 'female' : gender = 'male';
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
                  style: txtStyle(50),
                  "$curTemp°C",
                ),
              ),
            ],
          ),
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
                  // 기본 캐릭터
                  Image.asset(
                    'assets/character/${gender}_default.png',
                    fit: BoxFit.fill,
                  ),
                  // 위에 의상
                  ...clothesStack,
                ],
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
  ClothesInfo (img, name) {
    clothesImage = img;
    clothesName = name;
  }
}


// 옷 고르기
class ClothesOptions extends StatefulWidget {
  ClothesOptions({Key? key, required this.index}) : super(key: key);
  final int index;

  final List topTypes = ['상의', '스웨터/맨투맨', '셔츠', '티셔츠', '후드', '레글런', '민소매', '원피스', '크롭티', '스포츠'];
  final List botTypes = ['하의', '데님', '카고', '조거', '반바지', '트라우저/슬랙스', '치마', '스포츠'];
  final List outTypes = ['외투', '점퍼', '코트', '야상', '재킷', '조끼', '가디건', '바람막이'];
  final List shoeTypes = ['신발', '운동화', '스니커즈', '부츠', '구두', '슬리퍼', '샌들'];
  final List recTypes = ['추천템', '캐주얼', '스트릿', '아메카지', '스포츠', '클래식'];

  @override
  State<ClothesOptions> createState() => _ClothesOptionsState();
}

class _ClothesOptionsState extends State<ClothesOptions>  with TickerProviderStateMixin{
  int _currentSheetIndex = 0;
  late AnimationController _animationController;
  List clothesTypeNum = [10, 8, 8, 7, 6]; // 상 하 신 외 개수

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
    List clothesList = [
      widget.topTypes,
      widget.botTypes,
      widget.outTypes,
      widget.shoeTypes,
      widget.recTypes
    ];
    return BottomSheet(
      onClosing: () {},
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                curve: Curves.easeIn,
                parent: ModalRoute.of(context)!.animation!,
                reverseCurve: Curves.easeOut,
              ),
            ),
            child: Column(
              children: [
                // X 버튼과 의상 선택 글자
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,15,15,5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: IconButton(
                            onPressed: (){Navigator.pop(context);},
                            icon: const Icon(Icons.close_rounded),
                            iconSize: 40,
                            style: IconButton.styleFrom(
                              elevation: 0,
                              focusColor: Colors.transparent
                            )
                        ),
                      ),
                      Text(clothesList[_currentSheetIndex][0]+" 선택", style: txtStyle(22),
                      )
                    ],
                  ),
                ),

                // 의상 선택 옵션들
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.68,
                  child: ListView(
                    shrinkWrap: true,
                    children: List.generate(
                      clothesTypeNum[_currentSheetIndex]-1, (index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                              child: Row(
                                children: [
                                  Expanded(flex: 2,
                                      child: Image.asset('assets/clothes/tops/sweat_shirt.png', width: MediaQuery.of(context).size.width*0.2, fit: BoxFit.cover)
                                  ),
                                  Expanded(flex: 4,
                                      child: TextButton(
                                        onPressed: (){},
                                        style: ButtonStyle(
                                          overlayColor: MaterialStateProperty.all(Colors.black12), // 터치 효과를 없앰
                                        ),
                                        child: Text(clothesList[_currentSheetIndex][index+1], style: txtStyle(20)
                                        ), // 텍스트 색상 변경),
                                      )
                                  ),
                                  Expanded(flex: 1, child: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_rounded)))
                                ],
                              ),
                            ),
                            const Divider(
                              color: Color(0xFFDEDEDE),
                              height: 1,
                              thickness: 2,
                              indent: 25,
                              endIndent: 25,
                            )
                          ],
                        );
                      }
                    ),
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




// 메뉴 위로 올라오게 하기
class BottomMenu extends StatelessWidget {
  BottomMenu({Key? key, required this.index}) : super(key: key);
  final int index;
  final List<String> categories = ["상의", "하의", "외투", "신발", "추천"];

  @override
  Widget build(BuildContext context) {
    String category = categories[index];
    Color txtColor;
    if (index<4) {
      txtColor = Colors.black;
    } else {
      txtColor = Colors.red;
    }
    return TextButton(
      child: Text(category, style: TextStyle(color: txtColor,
          fontFamily: 'SUITE',
          fontWeight: FontWeight.w800,
          fontSize: 20)
      ),
      onPressed: () {
        showCoordiBottomSheet(context, index);
      },
    );
  }

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
          child: ClothesOptions(index: ind)
        );
      },
    );
  }
}


// 메뉴가 올라오지 않은 캐릭터 페이지 전체
class CharacterPage extends StatelessWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    '황사가 심해요! 마스크는 필수!',
                    style: txtStyle(16),
                  ),
              ),

              // 중간부 (체크 박스와 슬라이더, 캐릭터)
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
                          offset: const Offset(0, 1), // 그림자의 위치 조정
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
