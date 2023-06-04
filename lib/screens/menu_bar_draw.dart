//weater_screen에 넣으면 너무 복잡할 것 같아서
//햄버거 바 화면은 일단 여기서 만들어서 weather_screen으로 넘길겁니당
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mapssi/screens/search_area_screen.dart';

class MenuBarDraw extends StatelessWidget {
  @override
  const MenuBarDraw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //햄버거 바 메뉴
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.lightBlue,
            ),
            accountName: const Text("권지원"),
            accountEmail: const Text("32190250@dankook.ac.kr"),
            decoration: BoxDecoration( color: Colors.purple,),
          ),


          ListTile(
            leading: IconButton(icon: SvgPicture.asset(
                "assets/icons/account_circle_black_24dp.svg"),
              onPressed: () {},
            ),
            title: Text('프로필'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()) ); },
            trailing: Icon(Icons.navigate_next_outlined),
          ),

          ListTile(
            leading: IconButton(icon: SvgPicture.asset(
                "assets/icons/star_black_24dp.svg"),
              onPressed: () {},
            ),
            title: Text('즐겨찾는 지역'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteArea()) ); },
            trailing: Icon(Icons.navigate_next_outlined),
          ),

          ListTile(
            leading: IconButton(icon: SvgPicture.asset(
                "assets/icons/wc_black_24dp.svg"),
              onPressed: () {},
            ),
            title: Text('즐겨찾는 코디'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteCoordi()) ); },
            trailing: Icon(Icons.navigate_next_outlined),
          ),

          ListTile(
            leading: IconButton(icon: SvgPicture.asset(
                "assets/icons/settings_black_24dp.svg"),
              onPressed: () {},
            ),
            title: Text('설정'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => setting()) ); },
            trailing: Icon(Icons.navigate_next_outlined),
          ),

          ListTile(
            leading: IconButton(icon: SvgPicture.asset(
                "assets/icons/assignment_black_24dp.svg"),
              onPressed: () {},
            ),
            title: Text('게시판'),
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
