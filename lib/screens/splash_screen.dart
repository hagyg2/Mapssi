import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

//앱 실행시켰을 때 잠깐 나타나는 화면(2초)
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserDataFromServer userController = Get.find<UserDataFromServer>();
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
      userController.setUserId(prefs.getString("id"));
      userController.setUserName(prefs.getString("name"));
      userController.setUserGender(prefs.getInt('gender'));
      userController.setUserPerCol(prefs.getString("perCol"));
      userController.setUserPrefType(prefs.getString("prefType"));

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