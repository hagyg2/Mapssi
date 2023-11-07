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
import 'package:path_provider/path_provider.dart';

import '../main.dart';
import 'character_screen.dart';


// 현재 페이지 에서 쓰일 TextStyle (글씨체, 색상 고정 / 크기, 굵기 조절)
TextStyle myTextStyle(double fs, {FontWeight fontWeight = FontWeight.w600}) {
  return TextStyle(
    fontSize: fs,
    color: Colors.black,
    fontFamily: 'SUITE',
    fontWeight: fontWeight,
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

            accountName: const Text("", ),
            accountEmail:  Text(' " Mapssi로 맵시있게 " ', style: myTextStyle(20.0),),
            decoration: BoxDecoration(color: Color(0xFFECE7E0)),
            // UserAccountsDrawerHeader 내에 로그아웃 버튼 추가
            otherAccountsPictures: <Widget>[
              GestureDetector(
                child: IconButton(onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("로그아웃 하시겠습니까?"
                          , style: TextStyle(
                              fontSize: 15, fontFamily: 'Dovemayo_gothic'),),
                        actions: <Widget>[
                          TextButton(
                            child: Text("확인", style: TextStyle(
                                fontSize: 15, fontFamily: 'Dovemayo_gothic'),),
                            onPressed: () async {
                              if (loginplatform == 'kakao') {
                                await UserApi.instance.unlink();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/login', (route) => false);
                              }
                              else {
                                SignInWithGoogle.signOut();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/login', (route) => false);
                              }
                            },
                          ),
                          TextButton(
                            child: Text("취소", style: TextStyle(
                                fontSize: 15, fontFamily: 'Dovemayo_gothic'),),
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
            title: Text('프로필', style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: 'SUITE',
              fontWeight: FontWeight.w600,),),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            trailing: Icon(Icons.navigate_next_outlined),
          ),


          //즐겨찾는 지역(미완성)
          SizedBox(height: 15.0),
          ExpansionTile(
            leading: IconButton(icon: SvgPicture.asset(
                "assets/icons/star_black_24dp.svg"),
              onPressed: () {},
            ),
            title: Text('즐겨찾는 지역', style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: 'SUITE',
              fontWeight: FontWeight.w600,),),
            trailing: Icon(Icons.navigate_next_outlined),
            children: [
              ListTile(
                title: Text('즐겨찾는 지역 추가하러 가기'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CityDropdown(),),
                  );
                },
              ),


            ],
          ),

          //즐겨찾는 코디(미완성)
          SizedBox(height: 15.0),
          ListTile(
            leading: IconButton(icon: SvgPicture.asset(
                "assets/icons/wc_black_24dp.svg"),
              onPressed: () {},
            ),
            title: Text('즐겨찾는 코디', style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w600),),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteCoordi()));
            },
            trailing: Icon(Icons.navigate_next_outlined),
          ),


          // //로그아웃 버튼 - 목록으로 (ListTile)
          // SizedBox(height: 30.0,),
          // ListTile(
          //   title: Row(
          //     children: [
          //       Icon(Icons.logout),
          //       GestureDetector(
          //         onTap: () async { // 텍스트를 눌렀을 때만 dialog 동작하도록 감싸기
          //           showDialog(
          //             context: context,
          //             builder: (BuildContext context) {
          //               return AlertDialog(
          //                 content: Text("로그아웃 하시겠습니까?"
          //                   , style: TextStyle(
          //                       fontSize: 15, fontFamily: 'Dovemayo_gothic'),),
          //                 actions: <Widget>[
          //                   TextButton(
          //                     child: Text("확인",
          //                       style: TextStyle(fontSize: 15,
          //                           fontFamily: 'Dovemayo_gothic'),),
          //                     onPressed: () async {
          //                       if (loginplatform == 'kakao') {
          //                         await UserApi.instance.unlink();
          //                         Navigator.pushNamedAndRemoveUntil(
          //                             context, '/login', (route) => false);
          //                       }
          //                       else {
          //                         SignInWithGoogle.signOut();
          //                         Navigator.pushNamedAndRemoveUntil(
          //                             context, '/login', (route) => false);
          //                       }
          //                     },
          //                   ),
          //                   TextButton(
          //                     child: Text("취소",
          //                       style: TextStyle(fontSize: 15,
          //                           fontFamily: 'Dovemayo_gothic'),),
          //                     onPressed: () {
          //                       // 알림 대화 상자를 닫기 위한 코드
          //                       Navigator.of(context).pop();
          //                     },
          //                   ),
          //                 ],
          //               );
          //             },
          //           );
          //         },
          //
          //         child: Row(
          //           children: [
          //             SizedBox(width: 4.0),
          //             Text('로그아웃', style: TextStyle(
          //                 fontSize: 20.0,
          //                 color: Colors.black,
          //                 fontFamily: 'SUITE',
          //                 fontWeight: FontWeight.w600),),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          //로그아웃 버튼 - 목록으로 (ListTile)
          SizedBox(height: 30.0,),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end, // 아이콘과 텍스트를 오른쪽 정렬

              children: [
                Icon(Icons.logout),
                GestureDetector(
                  onTap: () async { // 텍스트를 눌렀을 때만 dialog 동작하도록 감싸기
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("로그아웃 하시겠습니까?"
                            , style: TextStyle(
                                fontSize: 15, fontFamily: 'Dovemayo_gothic'),),
                          actions: <Widget>[
                            TextButton(
                              child: Text("확인",
                                style: TextStyle(fontSize: 15,
                                    fontFamily: 'Dovemayo_gothic'),),
                              onPressed: () async {
                                if (loginplatform == 'kakao') {
                                  await UserApi.instance.unlink();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/login', (route) => false);
                                }
                                else {
                                  SignInWithGoogle.signOut();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/login', (route) => false);
                                }
                              },
                            ),
                            TextButton(
                              child: Text("취소",
                                style: TextStyle(fontSize: 15,
                                    fontFamily: 'Dovemayo_gothic'),),
                              onPressed: () {
                                // 알림 대화 상자를 닫기 위한 코드
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },

                  child: Row(
                    children: [
                      SizedBox(width: 4.0),
                      Text('로그아웃', style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}




class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFECE7E0),
        title: Text("프로필", style: myTextStyle(22.0),),
        iconTheme: IconThemeData(color: Colors.black,) // 뒤로 가는 화살표 색상 설정
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFFECE7E0),
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 22.0),
            Text(
              '   캡스톤',
              style: myTextStyle(30, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 60),
            ListTile(
              contentPadding: EdgeInsets.only(left: 16.0, bottom: 30.0), // 간격 추가
              leading: Icon(Icons.wc, size: 35.0),
              title: Padding(
                padding: EdgeInsets.only(bottom: 13.0),
                child: Text('성별',  style: myTextStyle(18.0),),
              ),
              subtitle: Text('"여자"', style: myTextStyle(25.0),),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 16.0, bottom: 30.0), // 간격 추가
              leading: Icon(Icons.favorite, size: 35.0),
              title: Padding(
                padding: EdgeInsets.only(bottom: 13.0),
                child: Text('선호 스타일',  style: myTextStyle(18.0),),
              ),
              subtitle: Text('"러블리"', style: myTextStyle(25.0),),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 16.0, bottom: 30.0), // 간격 추가
              leading: Icon(Icons.color_lens, size: 35.0),
              title: Padding(
                padding: EdgeInsets.only(bottom: 13.0),
                child: Text('퍼스널 컬러',  style: myTextStyle(18.0),),
              ),
              subtitle: Text('"여름 쿨톤"', style: myTextStyle(25.0),),

              // decoration: BoxDecoration(
                //   //여기에 컬러 팔레트 보여주면 좋을듯!!
                //   shape: BoxShape.rectangle,
                // ),
              //),

            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteArea extends StatelessWidget {
  const FavoriteArea({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("즐겨찾는 지역", style: myTextStyle(22.0),),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  CityDropdown(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView( //전체적인 화면을 위아래로 스크롤
        child: Column(

            children: [
            ]
        ),
      ),

    );
    throw UnimplementedError();
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
                        childAspectRatio: 0.8, // 가로세로 비율 조절
                      ),
                      padding: const EdgeInsets.all(5),
                      itemBuilder: (BuildContext context, int index) {
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
    throw UnimplementedError();
  }
}

