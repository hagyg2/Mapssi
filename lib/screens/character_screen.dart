import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mapssi/main.dart';
import 'package:mapssi/style_recommend.dart';
import 'package:mapssi/fnc_for_character_screen.dart';
import 'package:path_provider/path_provider.dart';


GlobalKey key = GlobalKey();
String gender = Get.find<UserDataFromServer>().getUserGender() == 0 ? 'female' : 'male';
String assetManifest = '';
bool gotManifest = false;
bool isFavorite = false;
bool isFavoriteSaving = false;
double topImageWidth = 0;
double botImageWidth = 0;
double botImageHeight = 0;
double outImageWidth = 0;
double shoeImageWidth = 0;


// 의상 이미지 전역변수화 (여러 클래스에서 사용하기 위함)
class ClothesImageController extends GetxController {
  String top='';
  String bot='';
  String out='';
  String shoe='';
  ColorFiltered topImage = setImage('assets/character/initialImage.png', topImageWidth); // 상의
  ColorFiltered botBg = setImage('assets/character/initialImage.png', botImageWidth);    // 하의 배경
  ColorFiltered botImage = setImage('assets/character/initialImage.png', botImageWidth); // 하의
  ColorFiltered outImage = setImage('assets/character/initialImage.png', outImageWidth); // 아우터
  ColorFiltered shoeBg = setImage('assets/character/initialImage.png', shoeImageWidth);    // 신발 배경
  ColorFiltered shoeImage = setImage('assets/character/initialImage.png', shoeImageWidth); // 신발

  resetImages() {
    top='';
    bot='';
    out='';
    shoe='';
    topImage = setImage('assets/character/initialImage.png', topImageWidth);
    botBg = setImage('assets/character/initialImage.png', botImageWidth);
    botImage = setImage('assets/character/initialImage.png', botImageWidth);
    outImage = setImage('assets/character/initialImage.png', outImageWidth);
    shoeBg = setImage('assets/character/initialImage.png', shoeImageWidth);
    shoeImage = setImage('assets/character/initialImage.png', shoeImageWidth);
  }

  setTopImage(String path, {Color? color=Colors.transparent}) {
    top = "${path.split("/").last}@${color.hashCode.toString()}";
    topImage =  setImage(path, topImageWidth, color!);
  }

  setBotImage(String path, {Color? color=Colors.transparent}) {
    var length = path.split("_").last;
    if (length =="long.png") {
      botBg = setImage('assets/character/$gender/botBgLong.png', botImageWidth*0.4);
    } else if (length == "short.png") {
      botBg = setImage('assets/character/$gender/botBgShort.png', botImageWidth*0.4);
    } else {
      botBg = setImage('assets/character/initialImage.png', botImageWidth);
    }
    bot = "${path.split("/").last}@${color.hashCode.toString()}";
    botImage = setImage(path, botImageWidth, color!);
  }

  setOutImage(String path, {Color? color=Colors.transparent}) {
    out = "${path.split("/").last}@${color.hashCode.toString()}";
    outImage = setImage(path, outImageWidth, color!);
  }

  setShoeImage(String path, {Color? color=Colors.transparent}) {
    shoe = "${path.split("/").last}@${color.hashCode.toString()}";
    shoeImage = setImage(path, shoeImageWidth, color!);
  }

  getImage() {
    return [shoeBg, shoeImage, topImage, botBg, botImage, outImage];
  }

  getFileName() {
    return "$top^$bot^$out^$shoe";
  }
}



// 메뉴가 올라 오지 않은 캐릭터 페이지 전체
class CharacterPage extends StatelessWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    topImageWidth = MediaQuery.of(context).size.width*0.405;
    botImageWidth = MediaQuery.of(context).size.width*0.41;
    outImageWidth = MediaQuery.of(context).size.width*0.405;
    shoeImageWidth = MediaQuery.of(context).size.width*0.416;

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
  List topTypes = ['상의', '티셔츠', '스웨터/맨투맨', '셔츠/블라우스', '후드', '민소매/조끼', '원피스', '크롭티', '스포츠'];
  List botTypes = ['하의', '데님', '카고', '조거', '반바지', '트라우저/슬랙스', '치마', '스포츠'];
  List outTypes = ['외투', '점퍼', '코트', '야상', '재킷', '조끼', '가디건', '바람막이'];
  List shoeTypes = ['신발', '운동화', '스니커즈', '부츠', '구두', '슬리퍼', '샌들'];
  List recTypes = ['추천', '캐주얼', '스트릿', '아메카지', '스포츠', '클래식', '러블리', '고프코어'];
  List clothesTypeNum = [9, 8, 8, 7, 8]; // 상 하 신 외 개수
  List clothesList = [];
  List<String> loadFiles = [];
  String bigCategory = "";
  var curClothes = Get.find<ClothesImageController>().getFileName();

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

  // 각 의상별 대표 이미지 썸네일 추출
  Future<List> getThumbnails(String path) async {
    String assetManifest = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(assetManifest);
    var files = [];
    for (int i=1; i<clothesTypeNum[_currentSheetIndex]; i++) {
      var result = manifestMap.keys.where((String key) => key.startsWith(path + typeKorToEng(i)));
      if (result.isNotEmpty) {
        files.add(result.first);
      } else {
        files.add("assets/character/initialImage.png");
      }
    }
    return files;
  }

  // 특정 의상들 중 한개 램덤으로 가져오기(의상 추천에 사용)
  Future<String> getRandomImages(String path) async {
    String assetManifest = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(assetManifest);
    String file = "assets/character/initialImage.png";
    var random = Random();
    path = "assets/character/$gender/$path";
    var result = manifestMap.keys.where((String key) => key.startsWith(path));
    if (result.isNotEmpty) {
      int randomNumber = random.nextInt(result.length);
      file= result.toList()[randomNumber];
    }
    return file;
  }

  // 의상 이름 한영 변환
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
          case '민소매/조끼':
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
    } else {
      switch (clothesList[_currentSheetIndex][selected]) {
        case '고프코어':
          chosenType = 'gofcore';
          break;
        case '스트릿':
          chosenType = 'street';
          break;
        case '아메카지':
          chosenType = 'americanCasual';
          break;
        case '스포츠':
          chosenType = 'spoty';
          break;
        case '클래식':
          chosenType = 'classic';
          break;
        case '러블리':
          chosenType = 'lovely';
          break;
        default :
          chosenType = 'casual';
      }
    }
    return chosenType;
  }

  // 의상 추천 함수
  Future<List<List>> recommendClothes(int style) async {
    var items = getItem(style);  // style_recommend.dart 파일
    print("recommend : $items");
    // getItem에서 얻은 의상 종류 중 구체적인 한 이미지를 선택해서 가져온 후 배열에 담아 반환
    var top = [await getRandomImages("top_${items[0][0]}"), Color(int.parse(items[0][1]))];
    var bot = [await getRandomImages("bot_${items[1][0]}"), Color(int.parse(items[1][1]))];
    var shoe = [await getRandomImages("shoe_${items[2][0]}"), Color(int.parse(items[2][1]))];
    var out = [await getRandomImages("out_${items[3][0]}"), Color(int.parse(items[3][1]))];
    var clothes = [top,bot,shoe,out];
    return clothes;
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

    switch (_currentSheetIndex) {
      case 0:
        bigCategory = "top";
        break;
      case 1:
        bigCategory = "bot";
        break;
      case 2:
        bigCategory = "out";
        break;
      case 3:
        bigCategory = "shoe";
        break;
      default :
        bigCategory = "rec";
    }

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
                            (widget.depth == 0) ? // 큰 카테고리인가?
                                (){Navigator.pop(context);} : // YES -> 메뉴 닫기
                                (){                           // NO -> 뒤로가기 (큰 카테고리로 이동)
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
                            // 카테고리에 따라 아이콘 변경
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
                (widget.depth == 0) ?  // 큰 카테고리인가?
                FutureBuilder<List>(   // YES -> 각 의상 카테고리별 썸네일 불러와서 출력
                  future: getThumbnails("assets/character/$gender/${bigCategory}_"),  // 썸네일 불러오는 비동기 작업
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // 데이터 로딩 중
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // 에러 발생
                      return Text('에러: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      // 데이터 로딩 완료
                      List loadFiles = snapshot.data!;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height*0.68,
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(overscroll: false), // 맥스 스크롤 효과 없애기
                          child: ListView(
                            shrinkWrap: true,
                            // 의상 종류 리스트 출력
                            children: List.generate(clothesTypeNum[_currentSheetIndex]-1, (index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                                    child: Row(
                                      children: [
                                        Expanded(flex: 2,
                                            // 대표 의상 이미지 버튼
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(22),
                                              child: Image.asset(
                                                  loadFiles[index],
                                                  height: MediaQuery.of(context).size.width*0.25,
                                                  fit: BoxFit.fitWidth,
                                                  alignment: Alignment.topCenter,
                                              ),
                                            )
                                        ),
                                        Expanded(flex: 4,
                                            // 의상 선택 버튼
                                            child: TextButton(
                                                onPressed: () {
                                                  // 세부 카테고리로 이동
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
                                    indent: 40,
                                    endIndent: 40,
                                  )
                                ],
                              );
                            }
                            ),
                          ),
                        )
                      );
                    } else {
                      // 데이터 없음
                      return const Text('데이터 없음');
                    }
                  },
                )
                : FutureBuilder<List<String>>(  // NO -> 저장된 의상 사진들 불러와서 리스트 출력
                  future: getFilesInDirectory("assets/character/$gender/${bigCategory}_${typeKorToEng(widget.indexes[1])}"),
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
                        child: ScrollConfiguration(
                          behavior: const ScrollBehavior().copyWith(overscroll: false),
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
                                  switch (_currentSheetIndex) {     // 현재 열려있는 메뉴에 따라
                                    case 0: // 상의 라면
                                      Get.find<ClothesImageController>().setTopImage(loadFiles[index]); // 상의 설정
                                      break;
                                    case 1:
                                      Get.find<ClothesImageController>().setBotImage(loadFiles[index]); // 하의 설정
                                      break;
                                    case 2:
                                      Get.find<ClothesImageController>().setOutImage(loadFiles[index]); // 아우터 설정
                                      break;
                                    case 3:
                                      Get.find<ClothesImageController>().setShoeImage(loadFiles[index]); // 신발 설정
                                      break;
                                    default:
                                      break;
                                  }
                                  isFavoriteSaving = false;
                                  // 화면 새로 고침 -> 옷 입혀짐
                                  Navigator.pushAndRemoveUntil(context,
                                      PageRouteBuilder(
                                          transitionDuration: const Duration(milliseconds: 200),
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
                                      color: const Color(0xFFA69185),
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
                                        fit: BoxFit.fitWidth,
                                        alignment: Alignment.topCenter,
                                      ), // 이미지를 불러옵니다. 이미지 경로에 맞게 수정하세요.
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
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
  nextStep (BuildContext context, ind) async {
    if (_currentSheetIndex < 4) {  // 큰 카테고리가 "추천"이 아닐때 (=상의,하의,외투,신발일 때)
      Navigator.pop(context);
      showModalBottomSheet(context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          builder: (BuildContext context) {
            return SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.77,
                child: ClothesOptions(depth: widget.depth + 1,
                    indexes: [_currentSheetIndex, ind + 1])
            );
          }
      );
    } else {  // 큰 카테고리가 추천일 때
      var recClothes = await recommendClothes(ind); // recommendClothes 함수 사용해서 받아온 결과
      Get.find<ClothesImageController>().setTopImage(recClothes[0][0],color:recClothes[0][1]); //상의로 설정
      Get.find<ClothesImageController>().setBotImage(recClothes[1][0],color:recClothes[1][1]); //하의로 설정
      Get.find<ClothesImageController>().setShoeImage(recClothes[2][0],color:recClothes[2][1]); //신발로 설정
      Get.find<ClothesImageController>().setOutImage(recClothes[3][0],color:recClothes[3][1]); //외투로 설정
      isFavoriteSaving = false;
      if (!mounted) return;
      // 화면 새로고침
      Navigator.pushAndRemoveUntil(context,
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
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
    }
  }
}