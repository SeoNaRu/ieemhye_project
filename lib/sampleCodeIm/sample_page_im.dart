import 'dart:async';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SamplePageIm extends StatefulWidget {
  @override
  _SamplePageImState createState() => _SamplePageImState();
}

class _SamplePageImState extends State<SamplePageIm> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    final frontCamera = cameras?.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    if (frontCamera != null) {
      _controller = CameraController(frontCamera, ResolutionPreset.high);
      await _controller?.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    }
    //test
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? Stack(
              children: [
                // 전체 화면을 차지하는 카메라 프리뷰
                Positioned.fill(
                  child: CameraPreview(_controller!),
                ),
                // 블러 효과 추가
                // Positioned.fill(
                //   child: BackdropFilter(
                //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                //     child: Container(
                //       color: Colors.black.withOpacity(0.3),
                //     ),
                //   ),
                // ),
                // 날짜와 시간
                Positioned(
                  top: 28,
                  left: 28,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SUNDAY, April 3rd",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        width: 77,
                        height: 1,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "06:30 ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "PM",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 1,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 오른쪽 아이콘 메뉴 컨테이너
                Positioned(
                  top: 25,
                  right: 18,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: _buildIcon("assets/test_icon/main_icon_1.png",
                              isTopIcon: true),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        _buildIcon("assets/test_icon/main_icon_2.png"),
                        SizedBox(
                          height: 17,
                        ),
                        _buildIcon("assets/test_icon/main_icon_3.png"),
                        SizedBox(
                          height: 17,
                        ),
                        _buildIcon("assets/test_icon/main_icon_4.png"),
                        SizedBox(
                          height: 17,
                        ),
                        _buildIcon("assets/test_icon/main_icon_5.png"),
                        SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildIcon(String imagePath, {bool isTopIcon = false}) {
    return Image.asset(
      imagePath,
      width: 7,
      height: 7,
      color: isTopIcon ? Colors.black : Colors.white,
    );
  }
}
