//weater_screen에 넣으면 너무 복잡할 것 같아서
//햄버거 바 화면은 일단 여기서 만들어서 weather_screen으로 넘길겁니당

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mapssi/screens/search_area_screen.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mapssi/screens/login_screen.dart';
//import 'package:mapssi/screens/search_area_screen2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../personal_info.dart';
import 'character/character_screen.dart';
import 'package:mapssi/screens/character/fnc_for_character_screen.dart';




// 현재 페이지 에서 쓰일 TextStyle (글씨체, 색상 고정 / 크기, 굵기 조절)
TextStyle myTextStyle(double fs, {FontWeight fontWeight = FontWeight.w600}) {
  return TextStyle(
    fontSize: fs,
    color: Colors.black,
    fontFamily: 'SUITE',
    fontWeight: fontWeight,
  );
}

TextStyle myTextStyle2(double fs) {
  return TextStyle(
    fontSize: fs,
    color: Colors.black,
    fontFamily: 'Dovemayo_gothic',
  );
}

class MenuBarDraw extends StatefulWidget {
  @override
  _MenuBarDrawState createState() => _MenuBarDrawState();
}

class _MenuBarDrawState extends State<MenuBarDraw> {

  @override
  Widget build(BuildContext context) {
    //햄버거 바 메뉴

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            // UserAccountsDrawerHeader 내에 동그라미 원, 이름, 메일 주소
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/mapssi_logo.jpg',
                fit: BoxFit.cover, // 이미지를 클립 및 확대/축소하여 맞출 수 있도록 설정
                width: 100, // 이미지의 너비 설정
                height: 80, // 이미지의 높이 설정
              ),
            ),

            accountName: const Text("",),
            accountEmail: Text(' " Mapssi로 맵시있게 " ', style: myTextStyle(20.0),),
            decoration: BoxDecoration(color: Color(0xFFECE7E0)),
            // UserAccountsDrawerHeader 내에 로그아웃 버튼 추가
            otherAccountsPictures: <Widget>[
              GestureDetector(
                child: IconButton(onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                          "로그아웃 하시겠습니까?", style: myTextStyle2(15.0),),
                        actions: <Widget>[
                          TextButton(
                            child: Text("확인", style: myTextStyle2(15.0),),
                            onPressed: () async {
                              if (loginplatform == 'kakao') {
                                await UserApi.instance.unlink();
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setBool('isLoggedIn', false);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/login', (route) => false);
                              }
                              else {
                                SignInWithGoogle.signOut();
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setBool('isLoggedIn', false);
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/login', (route) => false);
                              }
                            },
                          ),
                          TextButton(
                            child: Text("취소", style: myTextStyle2(15.0),),
                            onPressed: () {
                              // 알림 대화 상자를 닫기 위한 코드
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }, icon: Icon(Icons.logout)),
              ),
            ],),

          //프로픨(완성)
          SizedBox(height: 30.0),
          ListTile(
            leading: IconButton(icon: SvgPicture.asset(
                "assets/icons/account_circle_black_24dp.svg"),
              onPressed: () {},
            ),
            title: Text(
              '프로필', style: myTextStyle(20.0, fontWeight: FontWeight.w600),),
            onTap: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            trailing: Icon(Icons.navigate_next_outlined),
          ),


          // //즐겨찾는 지역(미완성)
          // SizedBox(height: 15.0),
          // ListTile(
          //   leading: IconButton(icon: SvgPicture.asset(
          //       "assets/icons/star_black_24dp.svg"),
          //     onPressed: () {},
          //   ),
          //   title: Text(
          //     '지역 검색', style: myTextStyle(20.0, fontWeight: FontWeight.w600),),
          //   onTap: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => CityDropdown()));
          //   },
          //   trailing: Icon(Icons.navigate_next_outlined),
          // ),
          //

          //즐겨찾는 코디(미완성)
          SizedBox(height: 15.0),
          ListTile(
            leading: IconButton(icon: SvgPicture.asset(
                "assets/icons/wc_black_24dp.svg"),
              onPressed: () {},
            ),
            title: Text('즐겨찾는 코디',
              style: myTextStyle(20.0, fontWeight: FontWeight.w600),),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteCoordi()));
            },
            trailing: Icon(Icons.navigate_next_outlined),
          ),


        ],),
    );
  }
}




class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? perCol;
  String? prefType;
  String? gender;
  String? name;
  String? id;

  @override
  Widget build(BuildContext context) {
    id = Get.find<UserDataFromServer>().getUserId();
    perCol = Get.find<UserDataFromServer>().getUserPerCol();
    prefType = Get.find<UserDataFromServer>().getUserPrefType();
    gender =
    Get.find<UserDataFromServer>().getUserGender() == 0 ? 'female' : 'male';
    name = Get.find<UserDataFromServer>().getUserName();

    String? userName = name;
    String? userGender = englishToKoreanforGender[gender];
    String? userStyle = englishToKoreanforStyle[prefType];
    String? userPerCol = englishToKoreanforPerCol[perCol];

    print("사용자 이름 = $name");
    print("사용자 성별 = $gender");
    print("사용자 스타일 = $prefType");
    print("사용자 퍼스널 = $perCol");
    print("사용자 아이디 = $id");

    print("dddddddddddddddddddddddddddddddddddddddddddd");
    print("사용자 이름 = $userName");
    print("사용자 성별 = $userGender");
    print("사용자 스타일 = $userStyle");
    print("사용자 퍼스널 = $userPerCol");


    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFECE7E0),
          title: Text("프로필", style: myTextStyle(22.0),),
          iconTheme: IconThemeData(color: Colors.black,) // 뒤로 가는 화살표 색상 설정
      ),

      body: Center(


        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            CircleAvatar( //나중에 사용자 이미지 추가
              radius: 60,
              backgroundColor: Color(0xFFECE7E0),
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              '$userName',
              style: myTextStyle(30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30,),


            //개인 정보
            Container(
              margin: EdgeInsets.all(16.0), // 여백 추가
              padding: EdgeInsets.fromLTRB(5.0, 30.0, 15.0, 30.0,), //여백(왼위오아래)
              //height: MediaQuery.of(context).size.height*0.3,
              decoration: BoxDecoration(
                color: Color(0xFFCCCCCC),
                borderRadius: BorderRadius.circular(
                    12.0), // 첫 번째 Container의 테두리 둥글게 설정
              ),


              child: Column(
                children: [
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.wc, size: 30.0),
                        SizedBox(width: 10.0,),
                        Text('성별', style: myTextStyle2(18.0),),
                        Spacer(),
                        // 빈 공간 추가
                        //  Text('여자', style: myTextStyle(22.0, fontWeight: FontWeight.w700),),

                        ElevatedButton(
                          onPressed: () async {},
                          child:
                          Text('$userGender', style: myTextStyle(
                              18.0, fontWeight: FontWeight.w700),),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFECE7E0),
                              surfaceTintColor: Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(120, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // 박스의 모서리 둥글게 설정
                              )
                          ),
                        ),

                      ],),
                  ),

                  SizedBox(height: 30,),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.favorite, size: 30.0),
                        SizedBox(width: 10.0,),
                        Text('선호 스타일', style: myTextStyle2(18.0),),
                        Spacer(), // 빈 공간 추가

                        ElevatedButton(
                          onPressed: () async {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => prefstylepage()),
                            // );
                          },
                          child:
                          Row(
                            children: [
                              Text('$userStyle', style: myTextStyle(
                                  18.0, fontWeight: FontWeight.w700),),
                              // SizedBox(width: 8.0,),
                              // Icon(Icons.arrow_forward, size: 25,),
                            ],),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFECE7E0),
                              surfaceTintColor: Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(120, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // 박스의 모서리 둥글게 설정
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),

                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.color_lens, size: 30.0),
                        SizedBox(width: 10.0,),
                        Text('퍼스널 컬러', style: myTextStyle2(18.0),),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => percolpage()),
                            // );
                          },
                          child:
                          Row(
                            children: [
                              Text('$userPerCol', style: myTextStyle(
                                  18.0, fontWeight: FontWeight.w700),),
                              // SizedBox(width: 8.0,),
                              // Icon(Icons.arrow_forward, size: 25,),
                            ],),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFECE7E0),
                              surfaceTintColor: Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(120, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // 박스의 모서리 둥글게 설정
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),),

            SizedBox(height: 30,),


            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // 수평 방향으로 요소들을 공간을 균등하게 배치
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // 여기에 원하는 페이지 이동 코드 작성
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => genderpage()),
                      );
                    },
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      height: 70,
                      padding: EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFECE7E0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('회원정보 수정하기', style: myTextStyle2(18.0)),
                        ],
                      ),
                    ),
                  ),


                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(
                              "탈퇴 하시겠습니까?", style: myTextStyle2(15),),
                            actions: <Widget>[
                              TextButton(
                                child: Text("확인", style: myTextStyle2(15),),
                                onPressed: () async {
                                  bool isDeleted = await sendUserDataToDelete(); // 사용자 정보 삭제 함수 호출
                                  if (isDeleted) {
                                    // 삭제 성공 시 작업
                                    Navigator.of(context)
                                        .pop(); // 다이얼로그 닫기 등의 작업 수행
                                  } else {
                                    // 삭제 실패 시 작업
                                    // 실패 메시지 표시 등의 작업 수행
                                  }
                                },
                              ),

                              TextButton(
                                child: Text("취소", style: myTextStyle2(15),),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.4,
                      height: 70,
                      padding: EdgeInsets.fromLTRB(15.0, 7.0, 15.0, 7.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFECE7E0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('탈퇴하기', style: myTextStyle2(18.0)),
                        ],
                      ),
                    ),
                  ),
                ]
            ),
          ],),
      ),
    );
  }

  Future<bool> sendUserDataToDelete() async {
    var url = 'http://13.209.46.142:50000/userdata/$id';

    var response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // 삭제 성공
      print("***회원 정보 삭제 성공!***");
      return true;
    } else {
      // 삭제 실패
      print('Failed to delete user data with status: ${response.statusCode}');
      return false;
    }
  }

}




class FavoriteCoordi extends StatelessWidget {
  const FavoriteCoordi({super.key});
  // 특정 디렉토리 에서 파일 목록을 가져오는 함수
  Future<List<FileSystemEntity>> getFilesInDirectory() async {
    String directoryPath = '${(await getApplicationDocumentsDirectory()).path}/favorites/';
    final directory = Directory(directoryPath);
    final files = directory.listSync();
    print(files);
    return files;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ClothesImageController());
    createSubDirectory("favorites");
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFECE7E0),
          title: Text("즐겨찾는 코디", style: myTextStyle(22.0),),
          iconTheme: IconThemeData(color: Colors.black,) // 뒤로 가는 화살표 색상 설정
      ),
      body: FutureBuilder<List<FileSystemEntity>>(
        future: getFilesInDirectory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 데이터 로딩 중
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // 에러 발생
            return Text('에러: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // 데이터 로딩 완료
            List<FileSystemEntity> loadFiles = snapshot.data!;
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(overscroll: false),
                    child: GridView.builder(
                      itemCount: loadFiles.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 한 줄에 2개의 이미지 버튼을 배치
                        childAspectRatio: 0.7, // 가로세로 비율 조절
                      ),
                      padding: const EdgeInsets.all(5),
                      itemBuilder: (BuildContext context, int index) {
                        // 즐겨찾기 된 옷 다시 입히기
                        return InkWell(
                          highlightColor: Colors.transparent, // 터치 시 강조 효과를 숨김
                          splashColor: Colors.transparent,     // 터치 시 스플래시 효과를 숨김
                          onTap: () {
                            var clothesNotParsed = loadFiles[index].path.split("/").last;
                            var clothes = clothesNotParsed.split("^");
                            var path = 'assets/character/$gender/';
                            if (clothes[0]!="") {
                              var top = clothes[0].split("@");
                              Get.find<ClothesImageController>().setTopImage(path + top[0], color: Color(int.parse(top[1]))); // 상의
                            } else{
                              Get.find<ClothesImageController>().setTopImage('assets/character/initialImage.png');
                            }
                            if (clothes[1]!="") {
                              var bot = clothes[1].split("@");
                              Get.find<ClothesImageController>().setBotImage(path + bot[0], color: Color(int.parse(bot[1]))); // 하의
                            } else{
                              Get.find<ClothesImageController>().setBotImage('assets/character/initialImage.png');
                            }
                            if (clothes[2]!="") {
                              var out = clothes[2].split("@");
                              Get.find<ClothesImageController>().setOutImage(path + out[0], color: Color(int.parse(out[1]))); // 아우터
                            } else{
                              Get.find<ClothesImageController>().setOutImage('assets/character/initialImage.png');
                            }
                            if (clothes[3]!="") {
                              var shoe = clothes[3].split("@");
                              Get.find<ClothesImageController>().setShoeImage(path + shoe[0], color: Color(int.parse(shoe[1]))); // 신발
                            } else{
                              Get.find<ClothesImageController>().setShoeImage('assets/character/initialImage.png');
                            }

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
                                child: Image.file(
                                  File(loadFiles[index].path),
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.center,
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
    );
  }
}


Map<String, String> englishToKoreanforGender = {
  'female': '여자',
  'male': '남자',
};

Map<String, String> englishToKoreanforPerCol = {
  'Spring Warm': '봄 웜톤',
  'Summer Cool': '여름 쿨톤',
  'Autumn Warm': '가을 웜톤',
  'Winter Cool': '겨울 쿨톤',


};

Map<String, String> englishToKoreanforStyle = {
  'Casual': '캐주얼',
  'Street': '스트릿',
  'Amekaji': '아메카지',
  'Classic': '클래식',
  'GoffCore': '고프코어',
  'Dandy': '댄디',
  'Sports': '스포츠',
  'Lovely': '러블리',


};




