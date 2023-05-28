import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:mapssi/main.dart';
import 'package:mapssi/personal_info.dart';

// 최초 로그인이면 /splash -> /login -> /perinfo -> /index
// 로그인 되어 있지 않고 최초 로그인이 아니면 /splash -> /login -> /index
// 로그인 되어 있으면 /splash -> /index

var loginplatform;
List<dynamic> userinfo = [];

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
                    print(userId);

                    //if - userId가 database에 없으면(최초 로그인인 경우)
                    //userinfo.add(userId);
                    //print('카카오톡으로 로그인 성공 ${token.accessToken}');
                    //loginplatform = 'kakao';
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInfoState()));

                    //else - userId가 database에 있으면(로그인한 적이 있을 경우)
                    print('카카오톡으로 로그인 성공 ${token.accessToken}');
                    loginplatform = 'kakao';
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPageView()));
                  } catch (error) {
                    print('카카오톡으로 로그인 실패 $error');

                    // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                    try {
                      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
                      //토큰으로부터 사용자 정보 가져오기
                      var user = await UserApi.instance.me();
                      var userId = user.id.toString(); //사용자 고유 식별자
                      print(userId);

                      //if - userId가 database에 없으면(최초 로그인인 경우)
                      //userinfo.add(userId);
                      //print('카카오계정으로 로그인 성공 ${token.accessToken}');
                      //loginplatform = 'kakao';
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInfoState()));

                      //else - userId가 database에 있으면(로그인한 적이 있을 경우)
                      print('카카오계정으로 로그인 성공 ${token.accessToken}');
                      loginplatform = 'kakao';
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyPageView()));
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
                    print(userId);

                    //if - userId가 database에 없으면(최초 로그인인 경우)
                    //userinfo.add(userId);
                    //print('카카오계정으로 로그인 성공 ${token.accessToken}');
                    //loginplatform = 'kakao';
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInfoState()));

                    //else - userId가 database에 있으면(로그인한 적이 있을 경우)
                    print('카카오계정으로 로그인 성공 ${token.accessToken}');
                    loginplatform = 'kakao';
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

                  //if - user.id가 데이터베이스에 없으면(최초 로그인인 경우)
                  //print(user.id);
                  //userinfo.add(user.id);
                  //print('구글 로그인 성공');

                  //else - user.id가 데이터베이스에 있으면(로그인한 적이 있을 경우)
                  loginplatform = 'google';
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyPageView()));
                  print(user.id); //사용자 고유 식별자
                  print('구글 로그인 성공');
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