import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class SignInWithGoogle {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  //카카오로그인 처리 함수
  //카카오톡으로 실행 가능 여부 확인
  //카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오 계정으로 로그인
  void signInWithKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

/*
  //구글로그인 처리 함수
  Future signInWithGoogle() async {
    final user = await GoogleSignInApi.login();

    //로그인 실패
    if(user == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign in Failed')));
    }
    //로그인 성공
    else {
      print('name = ${user.displayName}');
      print('email = ${user.email}');
      print('id = ${user.id}');
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PersonalGender()));
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //카카오 로그인 버튼
            ElevatedButton(
              onPressed: signInWithKakao,
              child: Row(
                //spaceEvenly: 요소들을 균등하게 배치하는 속성
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
                primary: Colors.yellow,
                minimumSize: Size.fromHeight(50), // 높이만 50으로 설정
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
                  print(user.displayName);
                  print(user.email);
                }
              },
              child: Row(
                //spaceEvenly: 요소들을 균등하게 배치하는 속성
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
                primary: Colors.white,
                minimumSize: Size.fromHeight(50), // 높이만 50으로 설정
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
            SizedBox(height: 10.0,),
            //이메일 로그인 버튼
            ElevatedButton(
              onPressed: (){},
              child: Row(
                //spaceEvenly: 요소들을 균등하게 배치하는 속성
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.mail, color: Colors.white),
                  Text('이메일 로그인',
                      style: TextStyle(color: Colors.white, fontSize: 15.0)),
                  Opacity(opacity: 0.0, child: Icon(Icons.mail)),
                ],
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  minimumSize: Size.fromHeight(50),
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0))
              ),
            ),
          ],
        ),
      ),
    );
  }
}