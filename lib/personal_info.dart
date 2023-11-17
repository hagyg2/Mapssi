import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mapssi/percolor_test.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'main.dart';

List<Object> UserInfo = [0, 0, 0];

//성별
class genderpage extends StatelessWidget {
  const genderpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image:DecorationImage(
                image:AssetImage('assets/background_image.png'),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25,),
                Text('성별', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 20,
                    lineHeight: 10,
                    percent: 1/3,
                    backgroundColor: Colors.black12,
                    progressColor: Colors.black,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                  ),
                )
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('성별이 어떻게 되시나요?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('남성', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFFAF3),
                      surfaceTintColor: Color(0xffFFFAF3),
                      foregroundColor: Colors.black,
                      minimumSize: Size(280, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  ),
                  onPressed: () {
                    UserInfo[0] = 1;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const percolpage()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('여성', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFFAF3),
                      surfaceTintColor: Color(0xffFFFAF3),
                      foregroundColor: Colors.black,
                      minimumSize: Size(280, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  ),
                  onPressed: () {
                    UserInfo[0] = 0;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const percolpage()));
                  },
                ),
                SizedBox(height: 25,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//퍼스널컬러
class percolpage extends StatelessWidget {
  const percolpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image:DecorationImage(
                image:AssetImage('assets/background_image.png'),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25,),
                Text('퍼스널컬러', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 20,
                    lineHeight: 10,
                    percent: 2/3,
                    backgroundColor: Colors.black12,
                    progressColor: Colors.black,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                  ),
                )
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('퍼스널컬러가 무엇인가요?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text('모름 버튼을 누르면 퍼스널컬러 진단 페이지로 이동합니다!', style: TextStyle(fontSize: 18, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('봄 웜톤', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFFAF3),
                      surfaceTintColor: Color(0xffFFFAF3),
                      foregroundColor: Colors.black,
                      minimumSize: Size(280, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  ),
                  onPressed: () {
                    UserInfo[1] = 'Spring Warm';
                    if(UserInfo[0] == 1){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const prefstylepage()));
                    }
                    else
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const prefstylepagew()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('여름 쿨톤', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFFAF3),
                      surfaceTintColor: Color(0xffFFFAF3),
                      foregroundColor: Colors.black,
                      minimumSize: Size(280, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  ),
                  onPressed: () {
                    UserInfo[1] = 'Summer Cool';
                    if(UserInfo[0] == 1){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const prefstylepage()));
                    }
                    else
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const prefstylepagew()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('가을 웜톤', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFFAF3),
                      surfaceTintColor: Color(0xffFFFAF3),
                      foregroundColor: Colors.black,
                      minimumSize: Size(280, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  ),
                  onPressed: () {
                    UserInfo[1] = 'Autumn Warm';
                    if(UserInfo[0] == 1){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const prefstylepage()));
                    }
                    else
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const prefstylepagew()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('겨울 쿨톤', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFFAF3),
                      surfaceTintColor: Color(0xffFFFAF3),
                      foregroundColor: Colors.black,
                      minimumSize: Size(280, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  ),
                  onPressed: () {
                    UserInfo[1] = 'Winter Cool';
                    if(UserInfo[0] == 1){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const prefstylepage()));
                    }
                    else
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const prefstylepagew()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('모름', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFFFAF3),
                      surfaceTintColor: Color(0xffFFFAF3),
                      foregroundColor: Colors.black,
                      minimumSize: Size(280, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test1()));
                  },
                ),
                SizedBox(height: 25,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//선호 스타일(남)
class prefstylepage extends StatefulWidget {
  const prefstylepage({Key? key}) : super(key: key);

  @override
  State<prefstylepage> createState() => _prefstylepage();
}

class _prefstylepage extends State<prefstylepage> {
  UserDataFromServer userController = Get.find<UserDataFromServer>();
  int selectedButtonIndex = -1; //선택된 버튼의 인덱스 (-1은 아무 버튼도 선택되지 않음을 의미)

  void _handleButtonPress(int index) {
    setState(() {
      selectedButtonIndex = index;
      if (index == 0){
        UserInfo[2] = 'Casual';
      }
      else if (index == 1){
        UserInfo[2] = 'Street';
      }
      else if(index == 2){
        UserInfo[2] = 'Amekaji';
      }
      else if(index == 3){
        UserInfo[2] = 'Classic';
      }
      else if(index == 4){
        UserInfo[2] = 'GoffCore';
      }
      else if(index == 5){
        UserInfo[2] = 'Dandy';
      }
      else{
        UserInfo[2] = 'Sports';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image:DecorationImage(
                image:AssetImage('assets/background_image.png'),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25,),
                Text('선호 스타일', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 20,
                    lineHeight: 10,
                    percent: 3/3,
                    backgroundColor: Colors.black12,
                    progressColor: Colors.black,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                  ),
                )
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('선호 스타일이 무엇인가요?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress(0),
                          style: ElevatedButton.styleFrom(
                              primary: selectedButtonIndex == 0? Colors.grey : Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(250, 150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              )
                          ),
                          child: Text('캐주얼', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                        ),
                      ),

                      SizedBox(width: 10,height: 10,),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress(1),
                          child: Text('스트릿', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                          style: ElevatedButton.styleFrom(
                              primary: selectedButtonIndex == 1? Colors.grey : Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(150, 150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              )
                          ),
                        ),
                      ),
                              ]
                              ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress(2),
                          child: Text('아메카지', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                          style: ElevatedButton.styleFrom(
                              primary: selectedButtonIndex == 2? Colors.grey : Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(150, 150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 10,height: 10,),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress(3),
                          child: Text('클래식', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                          style: ElevatedButton.styleFrom(
                              primary: selectedButtonIndex == 3? Colors.grey : Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(150, 150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              )
                          ),
                        ),
                      ),

                      SizedBox(width: 10,height: 10,),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress(4),
                          child: Text('고프코어', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                          style: ElevatedButton.styleFrom(
                              primary: selectedButtonIndex == 4? Colors.grey : Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(150, 150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              )
                          ),
                        ),
                      ),
                  ]
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress(5),
                          child: Text('댄디', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                          style: ElevatedButton.styleFrom(
                              primary: selectedButtonIndex == 5? Colors.grey : Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(150, 150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 10,height: 10,),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: selectedButtonIndex == 6? Colors.grey : Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(150, 150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              )
                          ),
                          onPressed: () => _handleButtonPress(6),
                          child: Text('스포츠', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    child: Text('제출하기', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic'),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFFFAF3),
                        surfaceTintColor: Color(0xffFFFAF3),
                        foregroundColor: Colors.black,
                        minimumSize: Size(280, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        )
                    ),
                    onPressed: ()async{
                      if(UserInfo[2] != 0){
                        print(UserInfo[0]);
                        print(UserInfo[1]);
                        print(UserInfo[2]);
                        /*
                        userController.setUserGender(UserInfo[0] as int?);
                        userController.setUserPerCol(UserInfo[1].toString());
                        userController.setUserPrefType(UserInfo[2].toString());
                        //백엔드로 정보(userinfo) 넘겨주기
                        if (await sendUserData(userController.getUserId(), UserInfo[0], UserInfo[1], UserInfo[2])) {
                          //메인 화면으로 이동
                          Navigator.pushNamedAndRemoveUntil(context, '/index', (route) => false);
                        }
                        */
                        Navigator.pushNamedAndRemoveUntil(context, '/index', (route) => false);
                      }
                      else{
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext ctx){
                              return AlertDialog(
                                content: Text('선호 스타일을 선택하였는지 확인하여주세요.', style: TextStyle(fontSize: 15, fontFamily: 'Dovemayo_gothic'),),
                                actions: [
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('확인', style: TextStyle(fontSize: 15, fontFamily: 'Dovemayo_gothic'),),
                                    ),
                                  )
                                ],
                              );
                            }
                        );
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//선호 스타일(여)
class prefstylepagew extends StatefulWidget {
  const prefstylepagew({Key? key}) : super(key: key);

  @override
  State<prefstylepagew> createState() => _prefstylepagewState();
}

class _prefstylepagewState extends State<prefstylepagew> {
  UserDataFromServer userController = Get.find<UserDataFromServer>();
  int selectedButtonIndex = -1; //선택된 버튼의 인덱스 (-1은 아무 버튼도 선택되지 않음을 의미)

  void _handleButtonPress(int index) {
    setState(() {
      selectedButtonIndex = index;
      if (index == 0){
        UserInfo[2] = 'Casual';
      }
      else if (index == 1){
        UserInfo[2] = 'Street';
      }
      else if(index == 2){
        UserInfo[2] = 'Amekaji';
      }
      else if(index == 3){
        UserInfo[2] = 'Classic';
      }
      else if(index == 4){
        UserInfo[2] = 'GoffCore';
      }
      else if(index == 5){
        UserInfo[2] = 'Lovely';
      }
      else{
        UserInfo[2] = 'Sports';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image:DecorationImage(
                image:AssetImage('assets/background_image.png'),
                fit: BoxFit.cover
            )
        ),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25,),
                Text('선호 스타일', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 20,
                    lineHeight: 10,
                    percent: 3/3,
                    backgroundColor: Colors.black12,
                    progressColor: Colors.black,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                  ),
                )
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('선호 스타일이 무엇인가요?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _handleButtonPress(0),
                            style: ElevatedButton.styleFrom(
                                primary: selectedButtonIndex == 0? Colors.grey : Color(0xffFFFAF3),
                                foregroundColor: Colors.black,
                                minimumSize: Size(250, 150),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)
                                )
                            ),
                            child: Text('캐주얼', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                          ),
                        ),

                        SizedBox(width: 10,height: 10,),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _handleButtonPress(1),
                            child: Text('스트릿', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                            style: ElevatedButton.styleFrom(
                                primary: selectedButtonIndex == 1? Colors.grey : Color(0xffFFFAF3),
                                foregroundColor: Colors.black,
                                minimumSize: Size(150, 150),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)
                                )
                            ),
                          ),
                        ),
                      ]
                  ),

                  SizedBox(height: 10,),
                  Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _handleButtonPress(2),
                            child: Text('아메카지', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                            style: ElevatedButton.styleFrom(
                                primary: selectedButtonIndex == 2? Colors.grey : Color(0xffFFFAF3),
                                foregroundColor: Colors.black,
                                minimumSize: Size(150, 150),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)
                                )
                            ),
                          ),
                        ),
                        SizedBox(width: 10,height: 10,),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _handleButtonPress(3),
                            child: Text('클래식', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                            style: ElevatedButton.styleFrom(
                                primary: selectedButtonIndex == 3? Colors.grey : Color(0xffFFFAF3),
                                foregroundColor: Colors.black,
                                minimumSize: Size(150, 150),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)
                                )
                            ),
                          ),
                        ),

                        SizedBox(width: 10,height: 10,),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _handleButtonPress(4),
                            child: Text('고프코어', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                            style: ElevatedButton.styleFrom(
                                primary: selectedButtonIndex == 4? Colors.grey : Color(0xffFFFAF3),
                                foregroundColor: Colors.black,
                                minimumSize: Size(150, 150),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)
                                )
                            ),
                          ),
                        ),
                      ]
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress(5),
                          child: Text('러블리', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                          style: ElevatedButton.styleFrom(
                              primary: selectedButtonIndex == 5? Colors.grey : Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(150, 150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              )
                          ),
                        ),
                      ),
                      SizedBox(width: 10,height: 10,),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: selectedButtonIndex == 6? Colors.grey : Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(150, 150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              )
                          ),
                          onPressed: () => _handleButtonPress(6),
                          child: Text('스포츠', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    child: Text('제출하기', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic'),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFFFAF3),
                        surfaceTintColor: Color(0xffFFFAF3),
                        foregroundColor: Colors.black,
                        minimumSize: Size(280, 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        )
                    ),
                    onPressed: ()async{
                      if(UserInfo[2] != 0){
                        print(UserInfo[0]);
                        print(UserInfo[1]);
                        print(UserInfo[2]);
                        /*
                        userController.setUserGender(UserInfo[0] as int?);
                        userController.setUserPerCol(UserInfo[1].toString());
                        userController.setUserPrefType(UserInfo[2].toString());
                        //백엔드로 정보(userinfo) 넘겨주기
                        if (await sendUserData(userController.getUserId(), UserInfo[0], UserInfo[1], UserInfo[2])) {
                          //메인 화면으로 이동
                          Navigator.pushNamedAndRemoveUntil(context, '/index', (route) => false);
                        }
                        */
                        Navigator.pushNamedAndRemoveUntil(context, '/selfcam', (route) => false);
                      }
                      else{
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext ctx){
                              return AlertDialog(
                                content: Text('선호 스타일을 선택하였는지 확인하여주세요.', style: TextStyle(fontSize: 15, fontFamily: 'Dovemayo_gothic'),),
                                actions: [
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('확인', style: TextStyle(fontSize: 15, fontFamily: 'Dovemayo_gothic'),),
                                    ),
                                  )
                                ],
                              );
                            }
                        );
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//성별, 퍼스널 컬러, 선호 스타일 백엔드로 넘겨주기
Future<bool> sendUserData(id, usergender, usercolor, userstyle) async {
  var url = 'http://52.79.164.56:50000/set-userdata/$id';

  var userData = {
    'gender': usergender,
    'perCol': usercolor,
    'prefType': userstyle
  };
  var response = await http.put(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(userData),
  );
  print(userData.toString());
  if (response.statusCode == 200) {  // 요청이 성공했을 경우
    // 저장된 것이 확인되면 true로 변경
    print(response.body);
    print("***회원 정보 수정 성공!***");
    return true;
  } else {
    // 요청이 실패했을 경우
    print('Request failed with status: ${response.statusCode}');
    return false;
  }
}

