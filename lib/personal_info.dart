import 'package:flutter/material.dart';

//성별
class PersonalGender extends StatelessWidget {
  const PersonalGender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center (
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('나의 성별은?', style: TextStyle(fontSize: 20)),
                SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            child: const Text('여자'),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SkinColor()));
                            },
                            style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                          )
                      ),
                      SizedBox(height: 150, width: 10),
                      SizedBox(
                          width: 150,
                          height: 150,
                          child: ElevatedButton(
                            child: const Text('남자'),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const SkinColor()));
                            },
                            style: ElevatedButton.styleFrom(primary: Colors.blue),
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
                Text('나의 피부 색과 가까운 색은?', style: TextStyle(fontSize: 20)),
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
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.grey,
                )
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
              Text('나의 눈동자 색과 가장 가까운 색은?', style: TextStyle(fontSize: 20)),
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
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.grey,
              )
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
              Text('나의 머리카락 색과 가장 가까운 색은?', style: TextStyle(fontSize: 20)),
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
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.grey,
              )
            ],
          )
      ),
    );
  }
}