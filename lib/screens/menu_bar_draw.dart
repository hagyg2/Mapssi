//weater_screen에 넣으면 너무 복잡할 것 같아서
//햄버거 바 화면은 일단 여기서 만들어서 weather_screen으로 넘길겁니당

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapssi/screens/search_area_screen.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mapssi/screens/login_screen.dart';

class MenuBarDraw extends StatelessWidget {
  @override
  const MenuBarDraw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //햄버거 바 메뉴
    final beigeColor = Color.fromRGBO( 236,230,204, 1.0);
    final beigeColor2 = Color.fromRGBO(	236,230,204, 1.0);


    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: beigeColor,
            ),
            accountName: const Text("권지원", style: TextStyle(color: Colors.black),),
            accountEmail: const Text("32190250@dankook.ac.kr", style: TextStyle(color: Colors.black),),
            decoration: BoxDecoration( color: Color(0xffFFFAF3)),
          ),

          SizedBox(height: 15.0),
            ListTile(
              leading: IconButton(icon: SvgPicture.asset(
                  "assets/icons/account_circle_black_24dp.svg"),
                onPressed: () {},
              ),
              title:  Text('프로필', style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w600,),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()) ); },
              trailing: Icon(Icons.navigate_next_outlined),
            ),

          SizedBox(height: 15.0),
            ListTile(
              leading: IconButton(icon: SvgPicture.asset(
                  "assets/icons/star_black_24dp.svg"),
                onPressed: () {},
              ),
              title:  Text('즐겨찾는 지역', style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w600,),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteArea()) ); },
              trailing: Icon(Icons.navigate_next_outlined),
            ),

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
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteCoordi()) ); },
              trailing: Icon(Icons.navigate_next_outlined),
            ),

          SizedBox(height: 15.0),
            ListTile(
              leading: IconButton(icon: SvgPicture.asset(
                  "assets/icons/settings_black_24dp.svg"),
                onPressed: () {},
              ),
              title: Text('설정', style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w600,),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => setting()) ); },
              trailing: Icon(Icons.navigate_next_outlined),
            ),

          SizedBox(height: 15.0),
          ListTile(
            leading: IconButton(icon: SvgPicture.asset(
                "assets/icons/assignment_black_24dp.svg"),
              onPressed: () {},
            ),
            title: Text('게시판', style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontFamily: 'SUITE',
              fontWeight: FontWeight.w600,),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Board()) ); },
            trailing: Icon(Icons.navigate_next_outlined),
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
        title: Text("프로필"),
        //로그아웃 버튼
        actions: [IconButton(onPressed: () async {
          if(loginplatform == 'kakao'){
            await UserApi.instance.unlink();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          }
          else{
            SignInWithGoogle.signOut();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          }
          }, icon: Icon(Icons.logout))]
      ),
    );
    throw UnimplementedError();
  }
}

class FavoriteArea extends StatelessWidget {
  const FavoriteArea({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("즐겨찾는 지역"),
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
        title: Text("즐겨찾는 코디"),
      ),
    );
    throw UnimplementedError();
  }
}

class setting extends StatelessWidget {
  const setting({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("설정"),
      ),
    );
    throw UnimplementedError();
  }
}

class Board extends StatelessWidget {
  const Board({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("게시판"),
      ),
    );
    throw UnimplementedError();
  }
}
