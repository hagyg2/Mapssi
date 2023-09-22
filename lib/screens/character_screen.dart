import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mapssi/main.dart';

// 현재 페이지 에서 쓰일 TextStyle (글씨체 색상 굵기 고정 / 크기만 조절)
TextStyle txtStyle (double fs) {
  return TextStyle(fontSize: fs,
    color: Colors.black,
    fontFamily: 'SUITE',
    fontWeight: FontWeight.w800,
  );
}

// 이미지 사이즈 조절 및 설정
Rx<Image> setImage(String url, double w, double h) {
  return Rx<Image>(Image.asset(
    url,
    width: w,
    height: h,
    fit: BoxFit.fill,
  ));
}

// 스택 에서의 이미지 위치 조절
Positioned clothesPosition (double x, double y,var img) {
  return Positioned(
    top: x,
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

// 의상 이미지 전역변수화
class ClothesImageController extends GetxController {
  Rx<Image> topImage = setImage('assets/character/initialImage.png', 365, 175); // 상의
  Rx<Image> botImage = setImage('assets/character/initialImage.png', 145, 263); // 하의
  Rx<Image> outImage = setImage('assets/character/initialImage.png', 365, 175); // 아우터
  Rx<Image> shoeImage = setImage('assets/character/initialImage.png', 350, 70); // 신발

  resetImages() {
    topImage = setImage('assets/character/initialImage.png', 365, 175);
    botImage = setImage('assets/character/initialImage.png', 145, 263);
    outImage = setImage('assets/character/initialImage.png', 365, 175);
    shoeImage = setImage('assets/character/initialImage.png', 350, 70);
  }

  setTopImage(String path) {
    topImage = setImage(path, 365, 175);
  }

  setBotImage(String path) {
    botImage = setImage(path, 145, 263);
  }

  setOutImage(String path) {
    outImage = setImage(path, 365, 175);
  }

  setShoeImage(String path) {
    shoeImage = setImage(path, 350, 70);
  }

  getImage() {
    return [shoeImage, topImage, botImage, outImage];
  } // 신발
}

String gender = Get.find<UserDataFromServer>().getUserGender() == 0
    ? 'female'
    : 'male';
String assetManifest = '';
bool gotManifest = false;

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

  @override
  Widget build(BuildContext context) {
    curTemp = Get.find<WeatherJasonData>().getData()[0];
    clothesStack = [  // 순서대로 신발, 상의, 하의, 아우터
      clothesPosition(490, 5, clothesImages[0].value),  // 신발
      clothesPosition(120, 0, clothesImages[1].value),    // 상의
      clothesPosition(225, 100, clothesImages[2].value),   // 하의
      clothesPosition(120, 0, clothesImages[3].value)    // 아우터
    ];
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
        icon: const Icon(Icons.refresh,color: Colors.white,))
    );
    return Column(
      children: [
        Row(
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
                  // 기본 캐릭터
                  Image.asset(
                    'assets/character/${gender}_default.png',
                    fit: BoxFit.fill,
                  ),
                  // 위에 의상
                  ...clothesStack,
                  resetButton
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



// 옷 고르기
class ClothesOptions extends StatefulWidget {
  const ClothesOptions({Key? key, required this.depth, required this.indexes}) : super(key: key);
  final int depth;
  final List<int> indexes;

  @override
  State<ClothesOptions> createState() => _ClothesOptionsState();
}

class _ClothesOptionsState extends State<ClothesOptions>  with TickerProviderStateMixin{
  int _currentSheetIndex = 0;
  late AnimationController _animationController;
  List topTypes = ['상의', '티셔츠', '스웨터/맨투맨', '셔츠/블라우스', '후드', '레글런', '민소매', '원피스', '크롭티', '스포츠'];
  List botTypes = ['하의', '데님', '카고', '조거', '반바지', '트라우저/슬랙스', '치마', '스포츠'];
  List outTypes = ['외투', '점퍼', '코트', '야상', '재킷', '조끼', '가디건', '바람막이'];
  List shoeTypes = ['신발', '운동화', '스니커즈', '부츠', '구두', '슬리퍼', '샌들'];
  List recTypes = ['추천템', '캐주얼', '스트릿', '아메카지', '스포츠', '클래식', '러블리', '고프코어'];
  List clothesTypeNum = [10, 8, 8, 7, 6]; // 상 하 신 외 개수
  List clothesList = [];
  List<String> loadFiles = [];

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

  // 특정 디렉토리 에서 파일 목록을 가져오는 함수
  Future<List<String>> getFilesInDirectory(String path) async {
    String assetManifest = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(assetManifest);
    print(path);
    // 디렉토리 내의 파일 목록 가져오기
    var files = manifestMap.keys.where((String key) => key.startsWith(path)).toList();
    print(files);
    return files;
  }

  String typeKorToEng (int selected) {
    String chosenType='';
    if (_currentSheetIndex == 0) {
      switch (clothesList[_currentSheetIndex][selected]) {
        case '티셔츠':
          chosenType = 'tshirts';
          break;
        case '스웨터/맨투맨':
          chosenType = 'sweatshirts';
          break;
        case '셔츠/블라우스':
          chosenType = 'shirts';
          break;
        case '후드':
          chosenType = 'hoodie';
          break;
        case '레글런':
          chosenType = 'reglan';
          break;
        case '민소매':
          chosenType = 'sleeveless';
          break;
        case '원피스':
          chosenType = 'onepiece';
          break;
        case '크롭티':
          chosenType = 'croptop';
          break;
        default :
          chosenType = 'sports';
      }
    } else if (_currentSheetIndex == 1) {
      switch (clothesList[_currentSheetIndex][selected]) {
        case '데님':
          chosenType = 'denim';
          break;
        case '카고':
          chosenType = 'cargo';
          break;
        case '조거':
          chosenType = 'jogger';
          break;
        case '반바지':
          chosenType = 'shorts';
          break;
        case '트라우저/슬랙스':
          chosenType = 'trouser';
          break;
        case '치마':
          chosenType = 'skirt';
          break;
        default :
          chosenType = 'sports';
      }
    } else if (_currentSheetIndex == 2) {
      switch (clothesList[_currentSheetIndex][selected]) {
        case '코트':
          chosenType = 'coat';
          break;
        case '야상':
          chosenType = 'field';
          break;
        case '재킷':
          chosenType = 'jacket';
          break;
        case '조끼':
          chosenType = 'vest';
          break;
        case '가디건':
          chosenType = 'cardigan';
          break;
        case '바람막이':
          chosenType = 'windshield';
          break;
        default:
          chosenType = 'jumper';
          break;
      }
    } else if (_currentSheetIndex == 3) {
      switch (clothesList[_currentSheetIndex][selected]) {
        case '스니커즈':
          chosenType = 'sneakers';
          break;
        case '부츠':
          chosenType = 'boots';
          break;
        case '구두':
          chosenType = 'dress';
          break;
        case '슬리퍼':
          chosenType = 'slipper';
          break;
        case '샌들':
          chosenType = 'sandal';
          break;
        default :
          chosenType = 'sports';
      }
    }
    return chosenType;
  }

  @override
  Widget build(BuildContext context) {
    clothesList = [
      topTypes,
      botTypes,
      outTypes,
      shoeTypes,
      recTypes
    ];
    setState(()  {
      _currentSheetIndex = widget.indexes[0];
    });

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
                // 닫기 버튼(X) 또는 뒤로 가기 버튼(<)과 의상 선택 글자
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,15,15,5),
                  child: Row(
                    children: [
                      Padding(
                        padding: (widget.depth == 0) ? const EdgeInsets.only(right: 5.0) : const EdgeInsets.symmetric(horizontal: 5.0),
                        child: IconButton(
                            onPressed:
                            (widget.depth == 0) ?
                                (){Navigator.pop(context);} :
                                (){
                                  Navigator.pop(context);
                                  showModalBottomSheet(context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                                      ),
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                            height: MediaQuery.of(context).size.height*0.77,
                                            child: ClothesOptions(depth: 0, indexes: [_currentSheetIndex,0])
                                        );
                                      }
                                  );
                                },
                            icon: (widget.depth == 0) ? const Icon(Icons.close_rounded) : const Icon(Icons.arrow_back_ios_rounded),
                            iconSize: (widget.depth == 0) ? 40 : 27,
                            style: IconButton.styleFrom(
                                elevation: 0,
                                focusColor: Colors.transparent
                            )
                        ),
                      ),
                      Text(clothesList[_currentSheetIndex][widget.indexes[1]], style: txtStyle(22),
                      )
                    ],
                  ),
                ),
                // 의상 선택 옵션들
                (widget.depth == 0) ? SizedBox(
                  height: MediaQuery.of(context).size.height*0.68,
                  child: ListView(
                    shrinkWrap: true,
                    // 의상 종류 리스트
                    children: List.generate(clothesTypeNum[_currentSheetIndex]-1, (index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                            child: Row(
                              children: [
                                Expanded(flex: 2,
                                    // 대표 의상 이미지
                                    child: Image.asset('assets/character/female/상의/tshirts/tshirt_white_001.png', width: MediaQuery.of(context).size.width*0.2, fit: BoxFit.cover)
                                ),
                                Expanded(flex: 4,
                                  // 의상 선택 버튼
                                  child: TextButton(
                                      onPressed: () {
                                        nextStep(context, index);
                                      },
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(Colors.black12), // 터치 효과를 없앰
                                      ),
                                      child: Text(clothesList[_currentSheetIndex][index+1], style: txtStyle(20))
                                    )
                                ) ,
                                Expanded(flex: 1, child: IconButton(onPressed: (){nextStep(context, index);}, icon: const Icon(Icons.arrow_forward_ios_rounded)))
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
                ):
                    
                // 저장된 의상 사진들 불러와서 리스트 출력
                FutureBuilder<List<String>>(
                  future: getFilesInDirectory("assets/character/$gender/${clothesList[_currentSheetIndex][0]}/${typeKorToEng(widget.indexes[1])}/"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // 데이터 로딩 중
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // 에러 발생
                      return Text('에러: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      // 데이터 로딩 완료
                      List<String> loadFiles = snapshot.data!;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height*0.68,
                        child: GridView.builder(
                          itemCount: loadFiles.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 한 줄에 3개의 이미지 버튼을 배치
                          ),
                          padding: const EdgeInsets.all(5),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              highlightColor: Colors.transparent, // 터치 시 강조 효과를 숨김
                              splashColor: Colors.transparent,     // 터치 시 스플래시 효과를 숨김
                              onTap: () {
                                switch (_currentSheetIndex) {
                                  case 0: // 상의
                                    Get.find<ClothesImageController>().setTopImage(loadFiles[index]); // 상의
                                    break;
                                  case 1:
                                    Get.find<ClothesImageController>().setBotImage(loadFiles[index]); // 하의
                                    break;
                                  case 2:
                                    Get.find<ClothesImageController>().setOutImage(loadFiles[index]); // 아우터
                                    break;
                                  case 3:
                                    Get.find<ClothesImageController>().setShoeImage(loadFiles[index]); // 신발
                                    break;
                                  default: // AI추천
                                    break;
                                }
                                Navigator.pushAndRemoveUntil(context,
                                    PageRouteBuilder(
                                        transitionDuration: Duration(milliseconds: 200),
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          return Align(
                                            child: SizeTransition(
                                              sizeFactor: animation,
                                              child: child,
                                            ),
                                          );
                                        },
                                        pageBuilder: (context, animation, secondaryAnimation) => const MyPageView(pageIndex: 1)
                                    ),
                                    (route) => false);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(22)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1), // 그림자 의 위치 조정
                                      )
                                    ]
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(22.0), // 모서리를 둥글게 하는 정도를 지정합니다.
                                    child: Image.asset(
                                      loadFiles[index],
                                      fit: BoxFit.cover,
                                    ), // 이미지를 불러옵니다. 이미지 경로에 맞게 수정하세요.
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      );
                    } else {
                      // 데이터 없음
                      return const Text('데이터 없음');
                    }
                  },
                ),
              ],
            )
        );
      },
      // 첫 번째 bottom sheet 의 위젯 구현
    );
  }

  // 의상 상세 카테고리 로 이동
  nextStep (BuildContext context, ind){
    Navigator.pop(context);
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        builder: (BuildContext context) {
          return SizedBox(
              height: MediaQuery.of(context).size.height*0.77,
              child: ClothesOptions(depth: widget.depth+1, indexes: [_currentSheetIndex,ind+1])
          );
        }
    );
  }

}


// 메뉴 위로 올라 오게 하기
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
          child: ClothesOptions(depth: 0, indexes: [ind, 0])
        );
      },
    );
  }
}


// 메뉴가 올라 오지 않은 캐릭터 페이지 전체
class CharacterPage extends StatelessWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    weatherCast(),
                    style: txtStyle(16),
                  ),
              ),

              // 중간부 (체크 박스와 슬라이더, 캐릭터)
              Expanded(flex:8, child: CharAndTemp()),

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
