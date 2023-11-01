//weater_screen에 넣으면 너무 복잡할 것 같아서
//햄버거 바 화면은 일단 여기서 만들어서 weather_screen으로 넘길겁니당

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapssi/screens/search_area_screen.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mapssi/screens/login_screen.dart';


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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFECE7E0),
          title: Text("즐겨찾는 코디", style: myTextStyle(22.0),),
          iconTheme: IconThemeData(color: Colors.black,) // 뒤로 가는 화살표 색상 설정
      ),
    );
    throw UnimplementedError();
  }
}

