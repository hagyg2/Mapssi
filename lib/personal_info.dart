import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

//성별, 퍼스널 컬러, 선호 스타일 정보 입력
class PersonalInfoState extends StatefulWidget {
  const PersonalInfoState({Key? key}) : super(key: key);

  @override
  State<PersonalInfoState> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfoState> {
  UserDataFromServer userController = Get.find<UserDataFromServer>();

  // 드롭다운 버튼의 선택 초기화
  final _gender = ['선택 안됨', '남자', '여자'];
  final _personalColor = ['선택 안됨', '봄 웜톤', '여름 쿨톤', '가을 웜톤', '겨울 쿨톤'];
  final _favstyle = ['선택 안됨', '캐주얼', '스트릿', '아메카지', '스포츠', '클래식', '고프코어'];

  var _selectedgender = '선택 안됨';
  var _selectedcolor = '선택 안됨';
  var _selectedstyle = '선택 안됨';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Info'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    Text('1. 성별을 선택해주세요.'),
                    DropdownButton(
                      value: _selectedgender,
                      items: _gender.map(
                          (value) {
                            return DropdownMenuItem(
                               value: value,
                               child: Text(value)
                            );
                          }
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedgender = value!;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    Text('2. 퍼스널컬러를 선택해주세요.\n모를 경우 진단하기 버튼을 눌러주세요.'),
                    DropdownButton(
                      value: _selectedcolor,
                      items: _personalColor.map(
                          (value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value)
                            );
                          }
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedcolor = value!;
                        });
                      }
                      ),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const test1()));
                }, child: const Text('진단하기'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,)),
                SizedBox(height: 20,),
                Text('3. 선호 스타일을 선택해주세요.'),
                DropdownButton(
                    value: _selectedstyle,
                    items: _favstyle.map(
                            (value) {
                          return DropdownMenuItem(
                              value: value,
                              child: Text(value)
                          );
                        }
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedstyle = value!;
                      });
                    }
                ),
                SizedBox(height: 30,),
                ElevatedButton(onPressed: () async {
                  //셋 중 하나라도 '선택 안됨'이면 제출 안 되도록
                  if ((_selectedgender != '선택 안됨') && (_selectedcolor != '선택 안됨') && (_selectedstyle != '선택 안됨')) {
                    //영어로 바꾸기
                    List<Object> userinfo = ktoe(_selectedgender, _selectedcolor, _selectedstyle);
                    userController.setUserGender(userinfo[0] as int?);
                    userController.setUserPerCol(userinfo[1].toString());
                    userController.setUserPrefType(userinfo[2].toString());
                    //백엔드로 정보(userinfo) 넘겨주기
                    if (await sendUserData(userController.getUserId(), userinfo[0], userinfo[1], userinfo[2])) {
                      //메인 화면으로 이동
                      Navigator.of(context).pushReplacementNamed('/index');
                    }
                  }
                  else{
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext ctx){
                          return AlertDialog(
                            content: Text('성별, 퍼스널 컬러, 선호 스타일을 모두 선택하였는지 확인하여주세요.'),
                            actions: [
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                    child: Text('확인')
                                ),
                              )
                            ],
                          );
                        }
                     );
                  }
                }, child: const Text('제출하기'),
                    style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,)
                )
              ],
            ),
      ),
    );
  }
}

//영어로 변환
List<Object> ktoe(kgender, kcolor, kstyle) {
  List<Object> info = [];
  //성별
  if(kgender == '남자'){
    kgender = 1;
  }
  else{
    kgender = 0;
  }
  info.add(kgender);

  //퍼스널 컬러
  if(kcolor == '봄 웜톤'){
    kcolor = 'Spring Warm';
  }
  else if(kcolor == '여름 쿨톤'){
    kcolor = 'Summer Cool';
  }
  else if(kcolor == '가을 웜톤'){
    kcolor = 'Autumn Warm';
  }
  else{
    kcolor = 'Winter Cool';
  }
  info.add(kcolor);

  //선호 스타일
  if(kstyle == '캐주얼'){
    kstyle = 'Casual';
  }
  else if(kstyle == '스트릿'){
    kstyle = 'Street';
  }
  else if(kstyle == '아메카지'){
    kstyle = 'Amekaji';
  }
  else if(kstyle == '스포츠'){
    kstyle = 'Sports';
  }
  else if(kstyle == '클래식'){
    kstyle = 'Classic';
  }
  else {
    kstyle = 'GoffCore';
  }
  info.add(kstyle);

  return info;
}

//성별, 퍼스널 컬러, 선호 스타일 백엔드로 넘겨주기
Future<bool> sendUserData(id, seletedgender, selectedcolor, selectedstyle) async {
  var url = 'http://52.79.164.56:50000/set-userdata/$id';

  var userData = {
    'gender': seletedgender,
    'perCol': selectedcolor,
    'prefType': selectedstyle
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
      appBar: AppBar(title: Text('퍼스널컬러 진단 결과'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 퍼스널 컬러는'),
                SizedBox(height: 30,),
                Text('봄 웜톤 입니다!'),
                SizedBox(height: 30,),
                Text('확인 버튼을 누르고 입력 화면에서\n퍼스널컬러를 다시 선택해주세요.'),
                SizedBox(height: 10,),
                ElevatedButton(
                child: const Text('확인'),
                style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/perinfo', (route) => false);
                },
              ),
          ],
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
      appBar: AppBar(title: Text('퍼스널컬러 진단 결과'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 퍼스널 컬러는'),
            SizedBox(height: 30,),
            Text('여름 쿨톤 입니다!'),
            SizedBox(height: 30,),
            Text('확인 버튼을 누르고 입력 화면에서\n퍼스널컬러를 다시 선택해주세요.'),
            SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('확인'),
              style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, '/perinfo', (route) => false);
              },
            ),
          ],
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
      appBar: AppBar(title: Text('퍼스널컬러 진단 결과'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 퍼스널 컬러는'),
            SizedBox(height: 30,),
            Text('가을 웜톤 입니다!'),
            SizedBox(height: 30,),
            Text('확인 버튼을 누르고 입력 화면에서\n퍼스널컬러를 다시 선택해주세요.'),
            SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('확인'),
              style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, '/perinfo', (route) => false);
              },
            ),
          ],
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
      appBar: AppBar(title: Text('퍼스널컬러 진단 결과'),
        centerTitle: true,
        backgroundColor: Colors.black26,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('당신의 퍼스널 컬러는'),
            SizedBox(height: 30,),
            Text('겨울 쿨톤 입니다!'),
            SizedBox(height: 30,),
            Text('확인 버튼을 누르고 입력 화면에서\n퍼스널컬러를 다시 선택해주세요.'),
            SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('확인'),
              style: ElevatedButton.styleFrom(primary: Colors.black26, onPrimary: Colors.white,),
              onPressed: (){
                Navigator.pushNamedAndRemoveUntil(context, '/perinfo', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}



