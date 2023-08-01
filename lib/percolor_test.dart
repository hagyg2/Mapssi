import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapssi/personal_info.dart';

//퍼스널 컬러 진단 질문
//질문1
class test1 extends StatelessWidget {
  const test1({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('당신의 피부색은 어떤가요?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('밝은 편이다', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test2()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('어두운 편이다', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test2()));
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

//질문2
class test2 extends StatelessWidget {
  const test2({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('당신의 눈동자 색은 어떤가요?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('짙은 갈색, 검정', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test4()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('밝은 갈색', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test3()));
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

//질문3
class test3 extends StatelessWidget {
  const test3({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('당신의 눈 인상은 어떤가요?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('강한 편이다', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test4()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('부드러운 편이다', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test5()));
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

//질문4
class test4 extends StatelessWidget {
  const test4({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('맨 얼굴로 블랙 컬러 옷을 입는다면?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('이목구비가 뚜렷하게 보인다', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test7()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('얼굴색이 안 좋아 보인다', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test6()));
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

//질문5
class test5 extends StatelessWidget {
  const test5({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('당신에게 잘 어울리는 액세서리 컬러는?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('골드 제품', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test8()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('실버 제품', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test6()));
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

//질문6
class test6 extends StatelessWidget {
  const test6({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('황토색, 겨자색, 이끼색, 적갈색 등 차분하고 고생한 색이 잘 어울리는가?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('잘 어울린다', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test8()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('잘 어울리지 않는다', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test9()));
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

//질문7
class test7 extends StatelessWidget {
  const test7({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('당신의 첫 인상은 어떤가요?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('강한 인상', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test10()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('부드러운 인상', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test8()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('평범한 인상', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test5()));
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

//질문8
class test8 extends StatelessWidget {
  const test8({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('당신의 피부는 햇볕에 노출되면 어떻게 되나요?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('잘 탄다', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test9()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('잘 타지 않는다', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test11()));
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

//질문9
class test9 extends StatelessWidget {
  const test9({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('당신의 이미지는?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('친근감 있고 부드러운 이미지', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test13()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('강하고 차가운 이미지', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test10()));
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

//질문10
class test10 extends StatelessWidget {
  const test10({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('잘 어울리는 색은?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('선명한 원색', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test14()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('부드러운 파스텔 색', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test13()));
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

//질문11
class test11 extends StatelessWidget {
  const test11({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('당신의 헤어 컬러는 어떤가요?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('진한 갈색, 진한 검정', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test14()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('밝은 갈색, 부드러운 검정', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test9()));
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

//질문12
class test12 extends StatelessWidget {
  const test12({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('당신의 얼굴은 어려 보이는 편인가?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('그렇다', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PerColorSpring()), (route) => false);
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('그렇지 않다', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PerColorAutumn()), (route) => false);
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

//질문13
class test13 extends StatelessWidget {
  const test13({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('당신에게 잘 어울리는 스웨터 색은?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('노란 기가 있는 따뜻한 색', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const test12()));
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('푸른 기가 있는 차가운 색', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PerColorSummer()), (route) => false);
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

//질문14
class test14 extends StatelessWidget {
  const test14({Key? key}) : super(key: key);

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
              children: [
                SizedBox(height: 25,),
                Text('퍼스널컬러 진단', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Text('당신이 어두운 색 정장을 입는다면 어울리는 색은?', style: TextStyle(fontSize: 25, fontFamily: 'Dovemayo_gothic')),
                )
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('검정, 회색 계열', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PerColorWinter()), (route) => false);
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  child: const Text('다크 브라운 계열', style: TextStyle(fontSize: 20, fontFamily: 'Dovemayo_gothic')),
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
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const PerColorAutumn()), (route) => false);
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