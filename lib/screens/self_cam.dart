import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../personal_info.dart';
import 'character/fnc_for_character_screen.dart';

String gender = Get.find<UserDataFromServer>().getUserGender() == 0 ? 'female' : 'male';
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// 현재 페이지 에서 쓰일 TextStyle (글씨체,색상 고정 / 크기,굵기 조절)
TextStyle myTextStyle(double fs, {FontWeight fontWeight = FontWeight.w600}) {
  return TextStyle(
    fontSize: fs,
    color: Colors.black,
    fontFamily: 'Dovemayo_gothic',
    fontWeight: fontWeight,
  );
}


late List<CameraDescription> _cameras;

// 카메라 촬영 화면
class SelfCam extends StatefulWidget {

  const SelfCam({super.key});

  @override
  State<SelfCam> createState() => _SelfCamState();
}

class _SelfCamState extends State<SelfCam> {
  late CameraController controller;
  bool cameraInitialized = false;
  bool isPictureCapturing = false;
  double x = 0;
  double y = 0;

  @override
  void initState() {
    super.initState();
    prepareCam();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void prepareCam() async {
    _cameras = await availableCameras();
    CameraDescription frontCam = _cameras[0];
    for( var cam in _cameras ) // 전면카메라 찾기
        {
      if( cam.lensDirection == CameraLensDirection.front )
      {
        frontCam = cam;
        break;
      }
    }

    controller = CameraController(frontCam, ResolutionPreset.veryHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller.setFlashMode(FlashMode.off);
      setState(() {
        cameraInitialized = true;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: !cameraInitialized ?
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background_image.png'),
                  fit: BoxFit.cover,
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/loading_new.gif', // 로딩 이미지 파일 경로
                  width: 200, // 이미지의 너비 설정
                  height: 200,
                ),
                Text(
                  'Loading...',
                  style:  myTextStyle(25.0, fontWeight: FontWeight.w500),),
              ],
            ),
          ),
        ):
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image.png'),
                fit: BoxFit.cover,
              )
          ),
          child: Center(
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text("※알림※",textAlign: TextAlign.center,style: myTextStyle(24)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("캐릭터에 적용될 얼굴 사진을 촬영합니다!",
                      textAlign: TextAlign.center,style: myTextStyle(20, fontWeight: FontWeight.w500)
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  // 그림자
                  decoration: BoxDecoration(
                      color: const Color(0xFFFFFDF9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 1), // 위치 조정
                        )
                      ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CameraPreview(
                          controller,
                          child: GestureDetector(onTapDown: (TapDownDetails details) {
                            x = details.localPosition.dx;
                            y = details.localPosition.dy;

                            double fullWidth = MediaQuery.of(context).size.width;
                            double cameraHeight = fullWidth * controller.value.aspectRatio;

                            double xp = x / fullWidth;
                            double yp = y / cameraHeight;

                            Offset point = Offset(xp,yp);
                            controller.setFocusPoint(point);
                          },),
                        ),
                        Image.asset("assets/face_frame.png",width: MediaQuery.of(context).size.width*0.8,),
                        const Positioned(
                            bottom: 40,
                            child: Text("틀에 얼굴을 맞춰 찍어주세요!",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontFamily: 'Dovemayo_gothic',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                        ),
                        const Positioned(
                          bottom: 40,
                            child: Text("틀에 얼굴을 맞춰 찍어주세요!",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontFamily: 'Dovemayo_gothic',
                                fontWeight: FontWeight.w500,
                              ),

                            )
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: !isPictureCapturing ? () async {
                          isPictureCapturing = true;
                          // 경로 생성
                          final path = join(
                              ( await getTemporaryDirectory() ).path,
                              '${DateTime.now()}.png'
                          );
                          // 사진 촬영
                          // 포커스 모드 고정 안하면 STATE_WAITING_FOCUS 뜨면서 엄청 오래걸림
                          controller.setFocusMode(FocusMode.locked);
                          XFile picture = await controller.takePicture();
                          controller.setFocusMode(FocusMode.auto);
                          // 사진 저장
                          picture.saveTo(path);
                          if (!mounted) return;
                          isPictureCapturing = false;
                          // 검사 화면으로 전환
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: ( context ) => ChkAndSend( imagePath: path )
                              ),
                          );
                        } : null,
                        icon: Image.asset("assets/photo_capture.png")
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}

// 촬영 후 확인 및 전송 화면
class ChkAndSend extends StatefulWidget {
  final String imagePath;

  const ChkAndSend({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<ChkAndSend> createState() => _ChkAndSendState();
}

class _ChkAndSendState extends State<ChkAndSend> {
  var jsonResult = {};
  var time = "";
  var state = "";
  var carNumber = "";

  // 이미지 전송 및 합성 사진 생성
  Future<Object> uploadAndGetImage() async {
    // 주소
    final uri = Uri.parse('http://59.11.201.30:5000/process_image');
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = appDocumentsDirectory.path;

    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', widget.imagePath));
    request.fields['gender'] = gender;
    print("Image sent");
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image scanned successfully!");
      // Create a file in the documents directory
      File file = File('$appDocumentsPath/${gender}UserFace.png');

      var responseStream = response.stream;
      var byteList = await http.ByteStream(responseStream).toBytes();
      var imageBytes = Uint8List.fromList(byteList);

      // Write the image bytes to the file
      await file.writeAsBytes(imageBytes);

      // 사진 저장
      print('Image saved to: ${file.path}');
      return response;
    } else {
      throw ('Image upload failed with status: ${response.statusCode}');
    }
  }

  // 화면 구현
  @override
  Widget build(BuildContext context) {

    // 화면 구현
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background_image.png'),
              fit: BoxFit.cover,
            )
        ),
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                // 그림자
                decoration: BoxDecoration(
                    color: const Color(0xFFFFFDF9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 1), // 위치 조정
                      )
                    ]
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Image.file( File(widget.imagePath) , fit: BoxFit.cover),
                  ),
                )
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () { Navigator.pop(context); },
                        child: Text("다시 찍기",style:  myTextStyle(25.0, fontWeight: FontWeight.w500)),
                      )
                  ),
                  const VerticalDivider(color: Color(0xFF000000),thickness: 1.5),
                  Expanded(
                      child: TextButton(
                        onPressed: ()  {
                          // 생성 이후
                          uploadAndGetImage().then((response) {
                            showToast("얼굴 생성이 완료되었습니다!");
                            setState(() {});
                          }).catchError((error) {
                            // 에러 처리 로직
                            print(error);
                          });
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const percolpage()), (route) => false);
                        },
                        child: Text("스캔 시작",style: myTextStyle(25.0, fontWeight: FontWeight.w500)),
                      ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}