import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
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
        backgroundColor: Color(0xffFFFDF9),
        appBar: null,
        body: Center(
            child: Image.asset('assets/logo.jpg', width: 120, height: 120,))
    );
  }
}
*/
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 2000), (){
      checkLoginStatus();
    });
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // 이미 로그인한 상태라면 메인 화면으로 이동
      Navigator.of(context).pushReplacementNamed('/index');
    } else {
      // 로그인되어 있지 않으면 로그인 화면으로 이동
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFFFDF9),
        appBar: null,
        body: Center(
            child: Image.asset('assets/logo.jpg', width: 120, height: 120,))
    );
  }
}