import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fnc_for_character_screen.dart';

class testPage extends StatefulWidget {
  @override
  _testPageState createState() => _testPageState();
}



class _testPageState extends State<testPage> {

  int Count = 0;

  //int count = 0;

  Color primaryColor =Color(0xFFbeb6a9);


  Color primaryColorTop = Color(0xFFbeb6a9);
  Color primaryColorBot = Color(0xFFbeb6a9);
  Color primaryColorOut = Color(0xFFbeb6a9);


  //색상 팔레트 아이콘 클릭
  void _buttonclickcount() {
    setState(() {
      Count = (Count + 1) % 4;
    });
  }


  @override
  Widget build(BuildContext context) {
    Widget colorButton() {
      //초기
      if (Count == 0) {
        return Image.asset("assets/icon_color.png", width: 30, height: 30,);
      }
      //상의
      else if (Count == 1) {
        return Image.asset("assets/icon_top.png", width: 30, height: 30,);
      }
      //하의
      else if (Count == 2) {
        return Image.asset("assets/icon_bottom.png", width: 30, height: 30,);
      }
      //아우터
      else {
        return Image.asset("assets/icon_outer.png", width: 30, height: 30,);
      }
    }

    var colorbutton = clothesPosition(400, 10, InkWell(
      onTap: () {
        _buttonclickcount();
      },
      child: colorButton(),
    )
    );

    List<Widget> buildBox(int count) {
      List<Widget> buttons = [];

      List<Color> myColorsDefault = [];

      List<Color> myColors = [
        Colors.red,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue,
        Colors.blueGrey,
        Colors.deepPurpleAccent,
        Colors.white,
        Colors.grey,
        Colors.black,
      ];

      List<Color> myColors2 = [
        Color(0xFFc4c4c4),
        Color(0xFFbeb6a9),
        Color(0xFF978868),
        Color(0xFF201716),
        Color(0xFF383838),
        Color(0xFF151514),
        Color(0xFF917188),
        Color(0xFF131824),
        Color(0xFF323b32),
      ];

      List<Color> selectedColors = count == 1 || count == 3
          ? myColors
          : (count == 2 ? myColors2 : myColorsDefault);

      for (Color color in selectedColors) {
        buttons.add(
          clothesPosition(
            400,
            selectedColors.indexOf(color) * 30 + 50, // 간격 조정
            SizedBox(
              width: 15,
              height: 15,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: color,
                  padding: EdgeInsets.all(3),
                ),
                onPressed: () {
                  setState(() {
                    if (count == 1) {
                      primaryColorTop = color;
                    } else if (count == 2) {
                      primaryColorBot = color;
                    } else if (count == 3) {
                      primaryColorOut = color;
                    }
                  });
                },
                child: null,
              ),
            ),
          ),
        );
      }

      return buttons;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Color Filters"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,

              children: [
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildImageTop(primaryColorTop),
                      buildImageBot(primaryColorBot),
                      buildImageOut(primaryColorOut),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Positioned(
                      bottom: 30,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          colorbutton,
                          SizedBox(width: 10), // 버튼 간격 조절
                          ...buildBox(Count),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),);
  }


  Widget buildImageTop(Color color) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.modulate),
      child: SizedBox(
        width: 200,
        height: 200,
          child: Image.asset(
            'assets/character/female/top_croptop_white_001_in.PNG',
            fit: BoxFit.contain,
          ),
        ),
    );
  }

  Widget buildImageBot(Color color) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.modulate),
      child: SizedBox(
        width: 200,
        height: 200,
          child: Image.asset(
            'assets/character/female/bot_cargo_001_long.png',
            fit: BoxFit.contain,
          ),
        ),

    );
  }

  Widget buildImageOut(Color color) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.modulate),
      child: SizedBox(
        width: 200,
        height: 200,
          child: Image.asset(
            'assets/character/female/out_cardigan_001.png',
            fit: BoxFit.contain,
          ),
        ),

    );
  }

}
