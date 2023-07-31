import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const prefstylepage()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const prefstylepage()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const prefstylepage()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const prefstylepage()));
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

//선호 스타일
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
        UserInfo[2] = 'Lovely';
      }
      else if(index == 6){
        UserInfo[2] = 'Sports';
      }
      else if(index == 7){
        UserInfo[2] = 'Casual';
      }
      else{
        UserInfo[2] = 'Casual';
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
                              minimumSize: Size(150, 150),
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

                      SizedBox(width: 10,height: 10,),

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
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
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

                      SizedBox(width: 10,height: 10,),

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
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
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

                      SizedBox(width: 10,height: 10,),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: selectedButtonIndex == 7? Colors.grey : Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(150, 150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              )
                          ),
                          onPressed: () => _handleButtonPress(7),
                          child: Text('캐주얼', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                        ),
                      ),

                      SizedBox(width: 10,height: 10,),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: selectedButtonIndex == 8? Colors.grey : Color(0xffFFFAF3),
                              foregroundColor: Colors.black,
                              minimumSize: Size(150, 150),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)
                              )
                          ),
                          onPressed: () => _handleButtonPress(8),
                          child: Text('캐주얼', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
                        ),
                      )
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


//퍼스널 컬러 진단 질문
//질문1
class test1 extends StatelessWidget {
  const test1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 피부색은 어떤가요?'),
            SizedBox(height: 30,),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('밝은 편이다.'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test2()));
                },
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('어두운 편이다.'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test2()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//질문2
class test2 extends StatelessWidget {
  const test2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 눈동자 색은 어떤가요?'),
            SizedBox(height: 30,),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('짙은 갈색, 검정'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test4()));
                },
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('밝은 갈색'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test3()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//질문3
class test3 extends StatelessWidget {
  const test3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 눈 인상은 어떤가요?'),
            SizedBox(height: 30,),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('강한 편이다.'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test4()));
                },
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('부드러운 편이다.'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test5()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//질문4
class test4 extends StatelessWidget {
  const test4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('맨 얼굴로 블랙 컬러 옷을 입는다면?'),
            SizedBox(height: 30,),
            Container(
              width: 250,
              child: ElevatedButton(
                child: const Text('이목구비가 뚜렷하게 보인다.'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test7()));
                },
              ),
            ),
            Container(
              width: 250,
              child: ElevatedButton(
                child: const Text('얼굴색이 안 좋아 보인다.'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test6()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//질문5
class test5 extends StatelessWidget {
  const test5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신에게 잘 어울리는 액세서리 컬러는?'),
            SizedBox(height: 30,),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('골드 제품'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test8()));
                },
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('실버 제품'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test6()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//질문6
class test6 extends StatelessWidget {
  const test6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('퍼스널컬러 진단'),
      centerTitle: true,
      backgroundColor: Colors.black26,),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('황토색, 겨자색, 이끼색, 적갈색 등\n차분하고 고생한 색이 잘 어울리는가?'),
          SizedBox(height: 30,),
          Container(
            width: 200,
            child: ElevatedButton(
              child: const Text('잘 어울린다.'),
              style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const test8()));
              },
            ),
          ),
          Container(
            width: 200,
            child: ElevatedButton(
              child: const Text('잘 어울리지 않는다.'),
              style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const test9()));
              },
            ),
          )
        ],
      ),
    ),
    );
  }
}

//질문7
class test7 extends StatelessWidget {
  const test7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 첫 인상은 어떤가요?'),
            SizedBox(height: 30,),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('강한 인상'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test10()));
                },
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('부드러운 인상'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test8()));
                },
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('평범한 인상'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test5()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//질문8
class test8 extends StatelessWidget {
  const test8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 피부는 햇볕에 노출되면\n어떻게 되나요?'),
            SizedBox(height: 30,),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('잘 탄다.'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test9()));
                },
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('잘 타지 않는다.'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test11()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//질문9
class test9 extends StatelessWidget {
  const test9({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 이미지는?'),
            SizedBox(height: 30,),
            Container(
              width: 250,
              child: ElevatedButton(
                child: const Text('친근감 있고 부드러운 이미지'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test13()));
                },
              ),
            ),
            Container(
              width: 250,
              child: ElevatedButton(
                child: const Text('강하고 차가운 이미지'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test10()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//질문10
class test10 extends StatelessWidget {
  const test10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('잘 어울리는 색은?'),
            SizedBox(height: 30,),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('선명한 원색'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test14()));
                },
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('부드러운 파스텔 색'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test13()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//질문11
class test11 extends StatelessWidget {
  const test11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 헤어 컬러는 어떤가요?'),
            SizedBox(height: 30,),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('진한 갈색, 진한 검정'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test14()));
                },
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('밝은 갈색, 부드러운 검정'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test9()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//질문12
class test12 extends StatelessWidget {
  const test12({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 얼굴은 어려 보이는 편인가?'),
            SizedBox(height: 30,),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('그렇다.'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PerColorSpring()), (route) => false);
                },
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('그렇지 않다.'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PerColorAutumn()), (route) => false);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//질문13
class test13 extends StatelessWidget {
  const test13({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신에게 잘 어울리는 스웨터 색은?'),
            SizedBox(height: 30,),
            Container(
              width: 220,
              child: ElevatedButton(
                child: const Text('노란 기가 있는 따뜻한 색'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test12()));
                },
              ),
            ),
            Container(
              width: 220,
              child: ElevatedButton(
                child: const Text('푸른 기가 있는 차가운 색'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PerColorSummer()), (route) => false);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

//질문14
class test14 extends StatelessWidget {
  const test14({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퍼스널컬러 진단'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신이 어두운 색 정장을 입는다면\n어울리는 색은?'),
            SizedBox(height: 30,),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('검정, 회색 계열'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PerColorWinter()), (route) => false);
                },
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text('다크 브라운 계열'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PerColorAutumn()), (route) => false);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


//퍼스널 컬러 진단 결과 보여주는 화면
//봄웜톤
class PerColorSpring extends StatelessWidget {
  const PerColorSpring({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_image.png'),
              fit: BoxFit.cover,
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('당신의 퍼스널컬러는', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic'),),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('봄 웜톤', style: TextStyle(fontSize: 55, fontFamily: 'Dovemayo_gothic', color: Color(0xffEDB8A8)),),
                  Text('입니다!', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic'),)
                ],
              ),
              SizedBox(height: 150),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('확인 버튼을 누르고', style: TextStyle(fontSize: 15, fontFamily: 'Dovemayo_gothic', color: Colors.grey)),
                  Text('퍼스널컬러를 다시 선택해주세요', style: TextStyle(fontSize: 15, fontFamily: 'Dovemayo_gothic', color: Colors.grey),)
                ],
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                child: Text('확인', style: TextStyle(fontFamily: 'Dovemayo_gothic'),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFFFAF3),
                    surfaceTintColor: Color(0xffFFFAF3),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    )
                ),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const percolpage()), (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

//여름쿨톤
class PerColorSummer extends StatelessWidget {
  const PerColorSummer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_image.png'),
              fit: BoxFit.cover,
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('당신의 퍼스널컬러는', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic'),),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('여름 쿨톤', style: TextStyle(fontSize: 55, fontFamily: 'Dovemayo_gothic', color: Color(0xffECA7BB)),),
                  Text('입니다!', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic'),)
                ],
              ),
              SizedBox(height: 150),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('확인 버튼을 누르고', style: TextStyle(fontSize: 15, fontFamily: 'Dovemayo_gothic', color: Colors.grey)),
                  Text('퍼스널컬러를 다시 선택해주세요', style: TextStyle(fontSize: 15, fontFamily: 'Dovemayo_gothic', color: Colors.grey),)
                ],
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                child: Text('확인', style: TextStyle(fontFamily: 'Dovemayo_gothic'),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFFFAF3),
                    surfaceTintColor: Color(0xffFFFAF3),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    )
                ),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const percolpage()), (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

//가을웜톤
class PerColorAutumn extends StatelessWidget {
  const PerColorAutumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_image.png'),
              fit: BoxFit.cover,
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('당신의 퍼스널컬러는', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic'),),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('가을 웜톤', style: TextStyle(fontSize: 55, fontFamily: 'Dovemayo_gothic', color: Color(0xffF1A78E)),),
                  Text('입니다!', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic'),)
                ],
              ),
              SizedBox(height: 150),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('확인 버튼을 누르고', style: TextStyle(fontSize: 15, fontFamily: 'Dovemayo_gothic', color: Colors.grey)),
                  Text('퍼스널컬러를 다시 선택해주세요', style: TextStyle(fontSize: 15, fontFamily: 'Dovemayo_gothic', color: Colors.grey),)
                ],
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                child: Text('확인', style: TextStyle(fontFamily: 'Dovemayo_gothic'),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFFFAF3),
                    surfaceTintColor: Color(0xffFFFAF3),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    )
                ),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const percolpage()), (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

//겨울쿨톤
class PerColorWinter extends StatelessWidget {
  const PerColorWinter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_image.png'),
              fit: BoxFit.cover,
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('당신의 퍼스널컬러는', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic'),),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('겨울 쿨톤', style: TextStyle(fontSize: 55, fontFamily: 'Dovemayo_gothic', color: Color(0xffEC70BF)),),
                  Text('입니다!', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic'),)
                ],
              ),
              SizedBox(height: 150),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('확인 버튼을 누르고', style: TextStyle(fontSize: 10, fontFamily: 'Dovemayo_gothic', color: Colors.grey)),
                  Text('퍼스널컬러를 다시 선택해주세요', style: TextStyle(fontSize: 10, fontFamily: 'Dovemayo_gothic', color: Colors.grey),)
                ],
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                child: Text('확인', style: TextStyle(fontFamily: 'Dovemayo_gothic'),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFFFAF3),
                    surfaceTintColor: Color(0xffFFFAF3),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    )
                ),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const percolpage()), (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

