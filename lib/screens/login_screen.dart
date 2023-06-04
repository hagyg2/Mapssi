import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mapssi/main.dart';
import 'package:mapssi/personal_info.dart';

// 최초 로그인이면 /splash -> /login -> /perinfo -> /index
// 로그인 되어 있지 않고 최초 로그인이 아니면 /splash -> /login -> /index
// 로그인 되어 있으면 /splash -> /index

var loginplatform;

//구글 로그인
class SignInWithGoogle {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future signOut() => _googleSignIn.signOut();
}

//로그인 화면
class LoginScreen extends StatelessWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/mapssi_logo.jpg', height: 120, width: 120,),
            Text('맵씨', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Cafe24Ssurround')),
            SizedBox(height: 60),
            Text('------------------ 로그인 ------------------', style: TextStyle(color: Colors.white)),

            SizedBox(height: 20,),

            //카카오 로그인 버튼
            ElevatedButton(
              onPressed: () async {
                //카카오톡이 설치되어 있는 경우
                if (await isKakaoTalkInstalled()) {
                  //카카오톡이 설치되어 있고 카카오계정이 연결되어 있는 경우
                  try {
                    OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
                    //토큰으로부터 사용자 정보 가져오기
                    var user = await UserApi.instance.me();
                    var userId = user.id.toString(); //사용자 고유 식별자
                    var userName = user.kakaoAccount?.profile?.nickname.toString();
                    print(userId);
                    loginplatform = 'kakao';
                    chkIfRegisteredAndRedirect(context, userId, userName);
                  } catch (error) {
                    print('카카오톡으로 로그인 실패 $error');

                    // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                    try {
                      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
                      //토큰으로부터 사용자 정보 가져오기
                      var user = await UserApi.instance.me();
                      var userId = user.id.toString(); //사용자 고유 식별자
                      var userName = user.kakaoAccount?.profile?.nickname.toString();
                      print(userId);
                      loginplatform = 'kakao';
                      chkIfRegisteredAndRedirect(context, userId, userName);
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }
                }
                //카카오톡이 설치되어 있지 않은 경우
                else {
                  try {
                    OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
                    //토큰으로부터 사용자 정보 가져오기
                    var user = await UserApi.instance.me();
                    var userId = user.id.toString(); //사용자 고유 식별자
                    var userName = user.kakaoAccount?.profile?.nickname.toString();
                    print(userId);
                    loginplatform = 'kakao';
                    chkIfRegisteredAndRedirect(context, userId, userName);
                  } catch (error) {
                    print('카카오계정으로 로그인 실패 $error');
                  }
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.chat_bubble, color: Colors.black,),
                  Text('카카오 로그인',
                      style: TextStyle(color: Colors.black87, fontSize: 15.0)),
                  Opacity(
                    opacity: 0.0, child: Icon(Icons.chat_bubble),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                minimumSize: Size.fromHeight(50),
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            ),

            SizedBox(height: 10.0,),

            //구글 로그인 버튼
            ElevatedButton(
              onPressed: () async {
                var user = await SignInWithGoogle.login();
                var userId = user?.id;
                var userName = user?.displayName;
                if(user != null){
                  loginplatform = 'google';
                  chkIfRegisteredAndRedirect(context, userId, userName);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/google_login.jpg'),
                  Text('구글 로그인',
                      style: TextStyle(color: Colors.black87, fontSize: 15.0)),
                  Opacity(
                    opacity: 0.0, child: Image.asset('assets/google_login.jpg'),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size.fromHeight(50),
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  chkIfRegisteredAndRedirect (context, userId, userName) async {
    const serverUrl = 'http://52.79.164.56:50000/'; // 노드 서버의 엔드포인트 URL
    UserDataFromServer userController = Get.find<UserDataFromServer>();

    var registeredUser = false;  // 디비에 저장된 유저인가?
    try {
      var url = '${serverUrl}get-userdata/$userId';
      var response = await http.get(Uri.parse(url)); // GET 요청 보내기

      if (response.statusCode == 200) {  // 요청이 성공했을 경우
        print(response.body);
        // 저장된 것이 확인되면 true로 변경
        if (response.body!="No Input Data" && response.body!="NoSuchData"){
          registeredUser = true;
        }
      } else {
        // 요청이 실패했을 경우
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // 에러 처리
      print('Error: $error');
    }
    userController.setUserId(userId);
    userController.setUserName(userName);
    if (!registeredUser) {  // 등록 안된 유저의 경우 초기 등록하기
      var url = '${serverUrl}user-register';
      var userData = {
        '_id': userId,
        'name': userName,
        'gender': 0,
        'perCol': "",
        'prefType': "",
      };
      var response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );
      if (response.statusCode == 200) {  // 요청이 성공했을 경우
        print(response.body);
        // 저장된 것이 확인되면 true로 변경
        if (response.body=="Successfully Done"){
          print("***등록 성공!***");
        }
      } else {
        // 요청이 실패했을 경우
        print('Request failed with status: ${response.statusCode}');
      }
      print('로그인 성공');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PersonalInfoState()), (route) => false);
    }
    else {  // 등록된 유저의 경우 바로 화면 전환
      print('로그인 성공');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyPageView()), (route) => false);
    }
  }
}


