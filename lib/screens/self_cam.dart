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

String gender = Get.find<UserDataFromServer>().getUserGender() == 0 ? 'female' : 'male';

// 현재 페이지 에서 쓰일 TextStyle (글씨체,색상 고정 / 크기,굵기 조절)
TextStyle myTextStyle(double fs, {FontWeight fontWeight = FontWeight.w600}) {
  return TextStyle(
    fontSize: fs,
    color: Colors.black,
    fontFamily: 'SUITE',
    fontWeight: fontWeight,
  );
}


late List<CameraDescription> _cameras;

// 메인 화면(카메라로 촬영)
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
    print("#######################CAM ON#########################");
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
        ):
        Center(
          child: Column(
            children: [
              const SizedBox(height: 29),
              Expanded(flex: 7,
                  child: CameraPreview(
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
                  )
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
                            )
                        );
                      } : null,
                      icon: Image.asset("assets/photo_capture.png")
                  )
              )
            ],
          ),
        )
    );
  }
}

// 촬영 후 확인 및 전송
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

  Future<Object> uploadImage() async {
    // 주소
    final uri = Uri.parse('http://192.168.0.7:5000/process_image');
    final path = join(
        ( await getTemporaryDirectory() ).path,
        '${DateTime.now()}.png'
    );
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
      File file = File('$appDocumentsPath/userFace.jpg');

      var responseStream = response.stream;
      var byteList = await http.ByteStream(responseStream).toBytes();
      var imageBytes = Uint8List.fromList(byteList);
      // Write the image bytes to the file
      await file.writeAsBytes(imageBytes);

      // Convert File to XFile
      XFile faceResult = XFile(file.path);
      // 사진 저장
      faceResult.saveTo(path);
      print('Image saved to: ${faceResult.path}');
      return response;
    } else {
      throw ('Image upload failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 29),
          SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Image.file( File(widget.imagePath) , fit: BoxFit.fitHeight),
              )
          ),
          Text(time,style: TextStyle(fontSize: 20)),
          Text(state,style: TextStyle(fontSize: 20)),
          Text(carNumber,style: TextStyle(fontSize: 20)),
          Expanded(
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () { Navigator.pop(context); },
                      child: const Text("다시 찍기",style: TextStyle(color: Colors.black)),
                    )
                ),
                const VerticalDivider(color: Color(0x676767FF),width: 2),
                Expanded(
                    child: TextButton(
                      onPressed: ()  {
                        uploadImage().then((response) {
                          setState(() {});
                        }).catchError((error) {
                          // 에러 처리 로직
                          print(error);
                        });
                        Navigator.pushNamedAndRemoveUntil(context, '/index', (route) => false);
                      },
                      child: const Text("스캔 시작",style: TextStyle(color: Colors.black)),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}