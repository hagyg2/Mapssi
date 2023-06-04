import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mapssi/main.dart';

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
                if (await isKakaoTalkInstalled()) {
                  try {
                    await UserApi.instance.loginWithKakaoTalk();
                    print('카카오톡으로 로그인 성공');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPageView()));
                  } catch (error) {
                    print('카카오톡으로 로그인 실패 $error');

                    // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyPageView()));
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                  }
                }
                else {
                  try {
                    await UserApi.instance.loginWithKakaoAccount();
                    print('카카오계정으로 로그인 성공');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPageView()));
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
                if(user != null){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyPageView()));
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
                minimumSize: Size.fromHeight(50), // 높이만 50으로 설정
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
}