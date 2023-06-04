import 'package:flutter/material.dart';

//피부색
class SkinColor extends StatelessWidget {
  const SkinColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center (
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('나의 피부 색과 가까운 색은?', style: TextStyle(fontSize: 15)),
                SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            child: const Text(''),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const EyeColor()));
                            },
                            style: ElevatedButton.styleFrom(primary: const Color(0xffECD4B2)),
                          )
                      ),
                      SizedBox(height: 150, width: 10),
                      SizedBox(
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            child: const Text(''),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const EyeColor()));
                            },
                            style: ElevatedButton.styleFrom(primary: const Color(0xffECCFBD)),
                          )
                      )
                    ]
                ),
              ],
            )
        )
    );
  }
}

//눈동자 색
class EyeColor extends StatelessWidget {
  const EyeColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('나의 눈동자 색과 가장 가까운 색은?', style: TextStyle(fontSize: 15)),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        child: const Text(''),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HairColor()));
                        },
                        style: ElevatedButton.styleFrom(primary: const Color(0xff825737)),
                      )
                  ),
                  SizedBox(height: 150, width: 10),
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        child: const Text(''),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HairColor()));
                        },
                        style: ElevatedButton.styleFrom(primary: const Color(0xff2E2E2E)),
                      )
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        child: const Text(''),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HairColor()));
                        },
                        style: ElevatedButton.styleFrom(primary: const Color(0xff3D2D20)),
                      )
                  ),
                  SizedBox(height: 150, width: 10,),
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        child: const Text(''),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HairColor()));
                        },
                        style: ElevatedButton.styleFrom(primary: const Color(0xff060405)),
                      )
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}

//머리카락 색
class HairColor extends StatelessWidget {
  const HairColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('나의 머리카락 색과 가장 가까운 색은?', style: TextStyle(fontSize: 15)),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        child: const Text(''),
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(primary: const Color(0xff825737)),
                      )
                  ),
                  SizedBox(height: 150, width: 10,),
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        child: const Text(''),
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(primary: const Color(0xff2E2E2E)),
                      )
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        child: const Text(''),
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(primary: const Color(0xff3D2D20)),
                      )
                  ),
                  SizedBox(height: 150, width: 10),
                  SizedBox(
                      height: 150,
                      width: 150,
                      child: ElevatedButton(
                        child: const Text(''),
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(primary: const Color(0xff060405)),
                      )
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}

//성별, 퍼스널컬러 정보 입력
class PersonalInfoState extends StatefulWidget {
  const PersonalInfoState({Key? key}) : super(key: key);

  @override
  State<PersonalInfoState> createState() => _PersonalInfoState();
}

enum Gender {MAN, WOMEN}

class _PersonalInfoState extends State<PersonalInfoState> {

  //라디오 버튼, 드롭다운 버튼의 선택 초기화
  Gender _gender = Gender.MAN;
  final _personalColor = ['봄웜톤', '여름쿨톤', '가을웜톤', '겨울쿨톤'];
  var _selectedcolor = '봄웜톤';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personal Information'),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
            children: [
                  Text('성별을 선택해주세요.'),
                  RadioListTile(
                      title: Text('남자'),
                      value: Gender.MAN,
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      }
                  ),
                  RadioListTile(
                      title: Text('여자'),
                      value: Gender.WOMEN,
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      }
                  ),
                  SizedBox(height: 20,),
                  Text('퍼스널컬러를 선택해주세요.\n모를 경우 진단하기 버튼을 눌러주세요.'),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SkinColor()));
              }, child: const Text('진단하기')),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){}, child: const Text('제출하기'))
            ],
          ),
        ),
    );
  }
}


