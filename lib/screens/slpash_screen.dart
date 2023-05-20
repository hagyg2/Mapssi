import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//앱 실행시켰을 때 잠깐 나타나는 화면(2초)
class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>{

  Future<bool> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    return isLogin;
  }

  void moveScreen() async {
    await checkLogin().then((isLogin){

      //로그인 되어 있을 경우 나타나는 화면
      if(isLogin){
        Navigator.of(context).pushReplacementNamed('/index');
      }
      //로그인 되어 있지 않을 경우 나타나는 화면
      else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }


  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2000), (){
      moveScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: null,
        body: Center(
            child: Image.asset('assets/mapssi_logo.jpg', width: 120, height: 120,))
        );
  }
}