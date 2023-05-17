import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mapssi/coordi_icons.dart';

class VerticalSlider extends StatefulWidget {
  const VerticalSlider({Key? key}) : super(key: key);

  @override
  _VerticalSliderState createState() => _VerticalSliderState();
}

class _VerticalSliderState extends State<VerticalSlider> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Slider(
        value: _value,
        onChanged: (newValue) {
          setState(() {
            _value = newValue;
          });
        },
      ),
    );
  }
}

//체형 조절
class SliderAndChkBox extends StatefulWidget {
  const SliderAndChkBox({super.key,required this.currentTemperature});
  final double currentTemperature;



  @override
  _SliderAndChkBoxState createState() => _SliderAndChkBoxState();
}

class _SliderAndChkBoxState extends State<SliderAndChkBox> {
  bool _isVisible = true;
  var height=160.0;
  var weight=80.0;
  // var temperature=15;


  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 체크 박스
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
            child: Checkbox(
              value: _isVisible,
              onChanged: (value) {
                setState(() {
                  _isVisible = value ?? true;
                });
              },
            ),
          ),
        ),
        // 아바타 이미지
        Expanded(
          flex: 4,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                    child: Text(
                      "${currentTempera}",
                      style: TextStyle(fontSize: 35),
                    )
                ),
              ),
              Expanded(
                flex: 7,
                child: Image.asset(
                  'assets/avatar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              // 아래 쪽 몸무게 슬라이더
              Visibility(
                visible: !_isVisible,
                child: Slider(
                  min: 40,
                  max: 120,
                  divisions : 16,
                  value: weight,
                  onChanged: (newValue) {
                    setState(() {
                      weight = newValue;
                    });
                  },
                  label: '$weight',
                ),
              )
            ],
          ),
        ),
        // 오른쪽 키 슬라이더
        Expanded(
          flex: 1,
          child: Visibility(
            visible: !_isVisible,
            child: RotatedBox(
              quarterTurns: 3,
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.height * 0.35,
                  child: Slider(
                    min: 130,
                    max: 200,
                    value: height,
                    divisions : 14,
                    onChanged: (newValue) {
                      setState(() {
                        height = newValue;
                      });
                    },
                    label: '$height',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// 코디 선택 메뉴
class CoordiBottomSheet extends StatefulWidget {
  const CoordiBottomSheet({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<CoordiBottomSheet> createState() => _CoordiBottomSheetState();
}

class _CoordiBottomSheetState extends State<CoordiBottomSheet>  with TickerProviderStateMixin{
  int _currentSheetIndex = 0;
  int randomNumber = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _currentSheetIndex = widget.index;
      randomNumber = Random().nextInt(12);
    });
    return _buildBottomSheet();
  }

  BottomSheet _buildBottomSheet() {
    // 상의 선택
    if (_currentSheetIndex == 1) {
      return BottomSheet(
        onClosing: () {  },
        builder: (BuildContext context) {
          return FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  curve: Curves.easeIn,
                  parent: ModalRoute.of(context)!.animation!,
                  reverseCurve: Curves.easeOut,
                ),
              ),
              child: ListView(
                children: <Widget>[
                  GridView.count(
                    crossAxisCount: 3, // 한 행에 들어갈 아이템 의 개수
                    shrinkWrap: true, // GridView 의 크기를 its contents 에 맞게 조절
                    physics: const ScrollPhysics(), // GridView 에서 스크롤 가능 하게 만듦
                    children: List.generate(randomNumber, (index) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            // 버튼 클릭 시 실행할 코드
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                            ),
                            child: Image.network(
                              'https://picsum.photos/id/${index+1}/200/200', // 임의의 이미지 URL
                            ),
                          ),
                        ),
                      );}
                    ),
                  ),
                ],
              )
          );
        },
        // 첫 번째 bottom sheet 의 위젯 구현
      );
    }
    // 하의 선택
    else if (_currentSheetIndex == 2) {
      return BottomSheet(
        onClosing: () {  },
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              GridView.count(
                crossAxisCount: 3, // 한 행에 들어갈 아이템 의 개수
                shrinkWrap: true, // GridView 의 크기를 its contents 에 맞게 조절
                physics: const ScrollPhysics(), // GridView 에서 스크롤 가능 하게 만듦
                children: List.generate(randomNumber, (index) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        // 버튼 클릭 시 실행할 코드
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: Image.network(
                          'https://picsum.photos/id/${index+1}/200/200', // 임의의 이미지 URL
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
        // 두 번째 bottom sheet 의 위젯 구현
      );
    }
    // 신발 선택
    else if (_currentSheetIndex == 3) {
      return BottomSheet(
        onClosing: () {  },
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              GridView.count(
                crossAxisCount: 3, // 한 행에 들어갈 아이템 의 개수
                shrinkWrap: true, // Grid View 의 크기를 its contents 에 맞게 조절
                physics: const ScrollPhysics(), // GridView 에서 스크롤 가능 하게 만듦
                children: List.generate(randomNumber, (index) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        // 버튼 클릭 시 실행할 코드
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: Image.network(
                          'https://picsum.photos/id/${index+1}/200/200', // 임의의 이미지 URL
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
        // 두 번째 bottom sheet 의 위젯 구현
      );
    }
    // 외투 선택
    else if (_currentSheetIndex == 4) {
      return BottomSheet(
        onClosing: () {  },
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              GridView.count(
                crossAxisCount: 3, // 한 행에 들어갈 아이템 의 개수
                shrinkWrap: true, // GridView 의 크기를 its contents 에 맞게 조절
                physics: const ScrollPhysics(), // GridView 에서 스크롤 가능 하게 만듦
                children: List.generate(randomNumber, (index) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        // 버튼 클릭 시 실행할 코드
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: Image.network(
                          'https://picsum.photos/id/${index+1}/200/200', // 임의의 이미지 URL
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
        // 두 번째 bottom sheet 의 위젯 구현
      );
    }
    // AI 코디
    else {
      return BottomSheet(
        onClosing: () {  },
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              GridView.count(
                crossAxisCount: 3, // 한 행에 들어갈 아이템 의 개수
                shrinkWrap: true, // GridView 의 크기를 its contents 에 맞게 조절
                physics: const ScrollPhysics(), // GridView 에서 스크롤 가능 하게 만듦
                children: List.generate(randomNumber, (index) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        // 버튼 클릭 시 실행할 코드
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                        ),
                        child: Image.network(
                          'https://picsum.photos/id/${index+1}/200/200', // 임의의 이미지 URL
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
        // 두 번째 bottom sheet 의 위젯 구현
      );
    }
  }

}


class Coordinater extends StatelessWidget {
  Coordinater({Key? key, required this.index}) : super(key: key);
  final int index;
  final List<Icon> icons = [const Icon(CoordiIcons.shirts), const Icon(CoordiIcons.pants), const Icon(CoordiIcons.shoes), const Icon(CoordiIcons.coat), const Icon(CoordiIcons.ai_recommend)];

  @override
  Widget build(BuildContext context) {
    Icon varIcon;
    varIcon = icons[index-1];

    return IconButton(
      icon: varIcon,
      onPressed: () {
        showCoordiBottomSheet(context, index);
      },
    );
  }

  showCoordiBottomSheet (BuildContext context, int ind) {
    BuildContext temp;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: IconButton(onPressed: () {
                      temp = context;
                      Navigator.pop(context);
                      showCoordiBottomSheet(temp, 1);
                    }, icon: icons[0])),
                    Expanded(child: IconButton(onPressed: () {
                      temp = context;
                      Navigator.pop(context);
                      showCoordiBottomSheet(context, 2);
                    }, icon: icons[1])),
                    Expanded(child: IconButton(onPressed: () {
                      temp = context;
                      Navigator.pop(context);
                      showCoordiBottomSheet(context, 3);
                    }, icon: icons[2])),
                    Expanded(child: IconButton(onPressed: () {
                      temp = context;
                      Navigator.pop(context);
                      showCoordiBottomSheet(context, 4);
                    }, icon: icons[3])),
                    Expanded(child: IconButton(onPressed: () {
                      temp = context;
                      Navigator.pop(context);
                      showCoordiBottomSheet(context, 5);
                    }, icon: icons[4])),
                  ],
                ),
                Expanded(
                  child: CoordiBottomSheet(index: index),
                )
              ]
          ),
        );
      },
    );
  }
}


// 캐릭터 페이지
class CharacterPage extends StatelessWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded( // 조언 멘트
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10,3,10,3),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(45.0),
                ),
                child: const Text(
                  '황사가 심해요! 마스크는 필수!',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          // 체크 박스와 슬라이더
          const Expanded(flex:7, child: SliderAndChkBox()),
          // 옷 메뉴
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black,width: 1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Coordinater(index: 1),
                  Coordinater(index: 2),
                  Coordinater(index: 3),
                  Coordinater(index: 4),
                  Coordinater(index: 5)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
