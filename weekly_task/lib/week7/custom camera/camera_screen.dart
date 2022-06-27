import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:weekly_task/week7/custom%20camera/preview_screen.dart';

import '../../main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key? key,
  }) : super(key: key);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? controller;
  VideoPlayerController? videoController;

  File? _imageFile;
  File? _videoFile;

  int dropdownEmploymentTypeValue = 0;

  // Initial values
  bool _isCameraInitialized = false;
  bool _isCameraPermissionGranted = false;
  bool _isRearCameraSelected = true;
  bool _isVideoCameraSelected = false;
  bool _isRecordingInProgress = false;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 100.0;

  // Current values
  double _currentZoomLevel = 1.0;
  double _currentExposureOffset = 0.0;
  FlashMode? _currentFlashMode;

  List<File> allFileList = [];

  final resolutionPresets = ResolutionPreset.values;

  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;

  getPermissionStatus() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;

    if (status.isGranted) {
      log('Camera Permission: GRANTED');
      setState(() {
        _isCameraPermissionGranted = true;
      });
      // Set and initialize the new camera
      onNewCameraSelected(cameras[0]);
      refreshAlreadyCapturedImages();
    } else {
      log('Camera Permission: DENIED');
    }
  }

  refreshAlreadyCapturedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();
    List<Map<int, dynamic>> fileNames = [];

    fileList.forEach((file) {
      if (file.path.contains('.jpg') || file.path.contains('.mp4')) {
        allFileList.add(File(file.path));

        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    });

    if (fileNames.isNotEmpty) {
      final recentFile =
          fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
      String recentFileName = recentFile[1];
      if (recentFileName.contains('.mp4')) {
        _videoFile = File('${directory.path}/$recentFileName');
        _imageFile = null;
        _startVideoPlayer();
      } else {
        _imageFile = File('${directory.path}/$recentFileName');
        _videoFile = null;
      }

      setState(() {});
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;

    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  Future<void> _startVideoPlayer() async {
    if (_videoFile != null) {
      videoController = VideoPlayerController.file(_videoFile!);
      await videoController!.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        // even before the play button has been pressed.
        setState(() {});
      });
      await videoController!.setLooping(true);
      await videoController!.pause();
    }
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (controller!.value.isRecordingVideo) {
      // A recording has already started, do nothing.
      return;
    }

    try {
      await cameraController!.startVideoRecording();
      setState(() {
        _isRecordingInProgress = true;
        print(_isRecordingInProgress);
      });
    } on CameraException catch (e) {
      print('Error starting to record video: $e');
    }
    setState(() {});
  }

  Future<XFile?> stopVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Recording is already is stopped state
      return null;
    }

    try {
      XFile file = await controller!.stopVideoRecording();
      print(
          "???????????????????? ${videoController!.dataSourceType.toString()}");
      print(file);
      setState(() {
        timer?.cancel();
        timeRunning = 0;

        _isRecordingInProgress = false;
      });
      return file;
    } on CameraException catch (e) {
      print('Error stopping video recording: $e');
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // Video recording is not in progress
      return;
    }

    try {
      timer?.cancel();
      setState(() {
        time();

        // timeCount++;
      });
      await controller!.pauseVideoRecording();
    } on CameraException catch (e) {
      print('Error pausing video recording: $e');
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!controller!.value.isRecordingVideo) {
      // No video recording was in progress
      return;
    }

    try {
      timer?.cancel();
      await controller!.resumeVideoRecording();
      setState(() {});
    } on CameraException catch (e) {
      print('Error resuming video recording: $e');
    }
  }

  void resetCameraValues() async {
    _currentZoomLevel = 1.0;
    _currentExposureOffset = 0.0;
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;

    final CameraController cameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await previousCameraController?.dispose();

    resetCameraValues();

    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
      await Future.wait([
        cameraController
            .getMinExposureOffset()
            .then((value) => _minAvailableExposureOffset = value),
        cameraController
            .getMaxExposureOffset()
            .then((value) => _maxAvailableExposureOffset = value),
        cameraController
            .getMaxZoomLevel()
            .then((value) => _maxAvailableZoom = value),
        cameraController
            .getMinZoomLevel()
            .then((value) => _minAvailableZoom = value),
      ]);

      _currentFlashMode = controller!.value.flashMode;
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

  @override
  void initState() {
    // Hide the status bar in Android
    // SystemChrome.setEnabledSystemUIOverlays([]);

    getPermissionStatus();

    _currentFlashMode = FlashMode.always;
    super.initState();
  }

  int dropDownValue = 0;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    videoController?.dispose();
    timer?.cancel();
    super.dispose();
  }

  Timer? timer;
  int timeRunning = 0;
  Duration duration = Duration();
  bool countDown = true;
  static const countdownDuration = Duration(hours: 2);

  time() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeRunning++;
      });
    });
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    if (twoDigits(duration.inHours) != "00") {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    } else if (twoDigits(duration.inHours) == "00") {
      if (twoDigitMinutes != "00") {
        return "$twoDigitMinutes:$twoDigitSeconds";
      } else {
        return twoDigitSeconds;
      }
    } else {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
  }

  void reset() {
    if (countDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = Duration());
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isCameraPermissionGranted
          ? _isCameraInitialized
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / controller!.value.aspectRatio,
                      child: Stack(
                        children: [
                          CameraPreview(
                            controller!,
                            child: LayoutBuilder(builder: (BuildContext context,
                                BoxConstraints constraints) {
                              final scale = 1 /
                                  (controller!.value.aspectRatio *
                                      MediaQuery.of(context).size.aspectRatio);
                              return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTapDown: (details) =>
                                      onViewFinderTap(details, constraints),
                                  child: Transform.scale(
                                      alignment: Alignment.center,
                                      scale: scale,
                                      child: CameraPreview(controller!)));
                            }),
                          ),
                          // TODO: Uncomment to preview the overlay

                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(18.0, 0.0, 16.0, 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      _currentFlashMode = FlashMode.always;
                                    });
                                    await controller!.setFlashMode(
                                      FlashMode.always,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.flash_on,
                                    color: _currentFlashMode == FlashMode.always
                                        ? Colors.deepPurpleAccent
                                        : Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      _currentFlashMode = FlashMode.auto;
                                    });
                                    await controller!.setFlashMode(
                                      FlashMode.auto,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.flash_auto,
                                    color: _currentFlashMode == FlashMode.auto
                                        ? Colors.deepPurpleAccent
                                        : Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      _currentFlashMode = FlashMode.off;
                                    });
                                    await controller!.setFlashMode(
                                      FlashMode.off,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.flash_off,
                                    color: _currentFlashMode == FlashMode.off
                                        ? Colors.deepPurpleAccent
                                        : Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      _currentFlashMode = FlashMode.torch;
                                    });
                                    await controller!.setFlashMode(
                                      FlashMode.torch,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.highlight,
                                    color: _currentFlashMode == FlashMode.torch
                                        ? Colors.deepPurpleAccent
                                        : Colors.black,
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 10,top: 3),
                                //   child: Theme(
                                //     data: Theme.of(context).copyWith(canvasColor: Colors.white),
                                //     child: DropdownButtonHideUnderline(
                                //       child: DropdownButton(
                                //         value: dropdownEmploymentTypeValue,
                                //         isDense: false,
                                //         iconDisabledColor: Colors.transparent,
                                //         iconEnabledColor: Colors.transparent,
                                //         onTap: () {
                                //           FocusScope.of(context)
                                //               .requestFocus(FocusNode());
                                //         },
                                //         onChanged: (newValue) {
                                //           FocusScope.of(context)
                                //               .requestFocus(FocusNode());
                                //
                                //           setState(() {
                                //             dropdownEmploymentTypeValue = newValue! as int;
                                //           });
                                //           print(dropdownEmploymentTypeValue);
                                //           clickDropDown(dropdownEmploymentTypeValue);
                                //         },
                                //         items: <int>[
                                //           0,1,2,3
                                //         ].map<DropdownMenuItem<int>>(
                                //                 (int value) {
                                //               return DropdownMenuItem<int>(
                                //                 value: value,
                                //                 child: returnIconFromValue(value),
                                //               );
                                //             }).toList(),
                                //         autofocus: true,
                                //         alignment: Alignment.center,
                                //         borderRadius: BorderRadius.circular(10),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              8.0,
                              16.0,
                              8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _isVideoCameraSelected
                                    ? Center(
                                        child: Text(
                                        _printDuration(
                                            Duration(seconds: timeRunning)),
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      ))
                                    : Container(
                                        height: 35,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 0.0, top: 239.0),
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Text(
                                        _currentExposureOffset
                                                .toStringAsFixed(1) +
                                            'x',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Container(
                                      height: 30,
                                      child: Slider(
                                        value: _currentExposureOffset,
                                        min: _minAvailableExposureOffset,
                                        max: _maxAvailableExposureOffset,
                                        // thumbIcon: Icon(Icons.brightness_7,color: Colors.white,size: 20,),
                                        activeColor: Colors.deepPurpleAccent,
                                        inactiveColor: Colors.white30,
                                        onChanged: (value) async {
                                          setState(() {
                                            controller!.setFlashMode(
                                              FlashMode.off,
                                            );
                                            _currentExposureOffset = value;
                                          });
                                          await controller!
                                              .setExposureOffset(value);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Slider(
                                        // showTicks: true,

                                        value: _currentZoomLevel,
                                        min: _minAvailableZoom,
                                        max: _maxAvailableZoom,
                                        // interval: 0.5,
                                        // trackShape: SfTrackShape(),
                                        // enableTooltip: true,
                                        // tooltipShape: SfPaddleTooltipShape(),
                                        activeColor: Colors.deepPurpleAccent,
                                        inactiveColor: Colors.white30,
                                        onChanged: (value) async {
                                          setState(() {
                                            controller!.setFlashMode(
                                              FlashMode.off,
                                            );
                                            _currentZoomLevel = value;
                                          });
                                          await controller!.setZoomLevel(value);
                                        },
                                      ),
                                    ),
                                    // Padding(
                                    //   padding:
                                    //       const EdgeInsets.only(right: 8.0),
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.black87,
                                    //       borderRadius:
                                    //           BorderRadius.circular(10.0),
                                    //     ),
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(8.0),
                                    //       child: Text(
                                    //         _currentZoomLevel
                                    //                 .toStringAsFixed(1) +
                                    //             'x',
                                    //         style:
                                    //             TextStyle(color: Colors.white),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 4.0,
                                              ),
                                              child: TextButton(
                                                onPressed:
                                                    _isRecordingInProgress
                                                        ? null
                                                        : () {
                                                            if (_isVideoCameraSelected) {
                                                              setState(() {
                                                                _isVideoCameraSelected =
                                                                    false;
                                                              });
                                                            }
                                                          },
                                                style: TextButton.styleFrom(
                                                  primary:
                                                      _isVideoCameraSelected
                                                          ? Colors.white
                                                          : Colors
                                                              .deepPurpleAccent,
                                                  // backgroundColor:
                                                  // _isVideoCameraSelected
                                                  //     ? Colors.white30
                                                  //     : Colors.white,
                                                ),
                                                child: Text('IMAGE'),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0, right: 8.0),
                                              child: TextButton(
                                                onPressed: () {
                                                  if (!_isVideoCameraSelected) {
                                                    setState(() {
                                                      _isVideoCameraSelected =
                                                          true;
                                                    });
                                                  }
                                                },
                                                style: TextButton.styleFrom(
                                                  primary:
                                                      _isVideoCameraSelected
                                                          ? Colors
                                                              .deepPurpleAccent
                                                          : Colors.white,
                                                  // backgroundColor:
                                                  // _isVideoCameraSelected
                                                  //     ? Colors.white
                                                  //     : Colors.white30,
                                                ),
                                                child: Text('VIDEO'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: _imageFile != null ||
                                              _videoFile != null
                                          ? () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PreviewScreen(
                                                            imageFile:
                                                                _imageFile!,
                                                            fileList:
                                                                allFileList)),
                                              );
                                            }
                                          : null,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                          image: _imageFile != null
                                              ? DecorationImage(
                                                  image: FileImage(_imageFile!),
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                        ),
                                        child: videoController != null &&
                                                videoController!
                                                    .value.isInitialized
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                child: AspectRatio(
                                                  aspectRatio: videoController!
                                                      .value.aspectRatio,
                                                  child: VideoPlayer(
                                                      videoController!),
                                                ),
                                              )
                                            : Container(),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: _isVideoCameraSelected
                                          ? () async {
                                              if (_isRecordingInProgress) {
                                                XFile? rawVideo =
                                                    await stopVideoRecording();
                                                File videoFile =
                                                    File(rawVideo!.path);

                                                int currentUnix = DateTime.now()
                                                    .millisecondsSinceEpoch;

                                                final directory =
                                                    await getApplicationDocumentsDirectory();

                                                String fileFormat = videoFile
                                                    .path
                                                    .split('.')
                                                    .last;

                                                _videoFile =
                                                    await videoFile.copy(
                                                  '${directory.path}/$currentUnix.$fileFormat',
                                                );

                                                _startVideoPlayer();
                                              } else {
                                                await startVideoRecording();
                                                time();
                                                setState(() {});
                                              }
                                            }
                                          : () async {

                                              XFile? rawImage =
                                                  await takePicture();
                                              File imageFile =
                                                  File(rawImage!.path);

                                              int currentUnix = DateTime.now()
                                                  .millisecondsSinceEpoch;

                                              final directory =
                                                  await getApplicationDocumentsDirectory();

                                              String fileFormat = imageFile.path
                                                  .split('.')
                                                  .last;

                                              print(fileFormat);

                                              await imageFile.copy(
                                                '${directory.path}/$currentUnix.$fileFormat',
                                              );

                                              refreshAlreadyCapturedImages();
                                            },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Icon(
                                            Icons.radio_button_off,
                                            color: _isVideoCameraSelected
                                                ? Colors.white
                                                : Colors.white,
                                            size: 80,
                                          ),
                                          Icon(
                                            Icons.circle,
                                            color: _isVideoCameraSelected
                                                ? Colors.red
                                                : Colors.transparent,
                                            size: 65,
                                          ),
                                          _isVideoCameraSelected &&
                                                  _isRecordingInProgress
                                              ? Icon(
                                                  Icons.stop_rounded,
                                                  color: Colors.white,
                                                  size: 32,
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: _isRecordingInProgress
                                          ? () async {
                                              if (controller!
                                                  .value.isRecordingPaused) {
                                                await resumeVideoRecording();
                                              } else {
                                                await pauseVideoRecording();
                                              }
                                            }
                                          : () {
                                              setState(() {
                                                _isCameraInitialized = false;
                                              });
                                              onNewCameraSelected(cameras[
                                                  _isRearCameraSelected
                                                      ? 1
                                                      : 0]);
                                              setState(() {
                                                _isRearCameraSelected =
                                                    !_isRearCameraSelected;
                                              });
                                            },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          _isRecordingInProgress
                                              ? controller!
                                                      .value.isRecordingPaused
                                                  ? Icon(
                                                      Icons.play_arrow,
                                                      color: Colors.white,
                                                      size: 30,
                                                    )
                                                  : Icon(
                                                      Icons.pause,
                                                      color: Colors.white,
                                                      size: 30,
                                                    )
                                              : Icon(
                                                  // _isRearCameraSelected
                                                  //     ? Icons.camera_front
                                                  //     :
                                                  Icons.autorenew_rounded,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    'LOADING',
                    style: TextStyle(color: Colors.white),
                  ),
                )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(),
                Text(
                  'Permission denied',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    getPermissionStatus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Give permission',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget returnIconFromValue(int index) {
    switch (index) {
      case 0:
        return Icon(
          Icons.flash_off,
          color: dropdownEmploymentTypeValue == index
              ? Colors.deepPurpleAccent
              : Colors.black,
        );
      case 1:
        return Icon(
          Icons.flash_auto,
          color: dropdownEmploymentTypeValue == index
              ? Colors.deepPurpleAccent
              : Colors.black,
        );
      case 2:
        return Icon(
          Icons.flash_on,
          color: dropdownEmploymentTypeValue == index
              ? Colors.deepPurpleAccent
              : Colors.black,
        );
      case 3:
        return Icon(
          Icons.highlight,
          color: dropdownEmploymentTypeValue == index
              ? Colors.deepPurpleAccent
              : Colors.black,
        );
      default:
        return Icon(Icons.scale);
    }
  }

  clickDropDown(int index) async {
    switch (index) {
      case 0:
        setState(() {
          _currentFlashMode = FlashMode.off;
        });
        await controller!.setFlashMode(
          FlashMode.off,
        );
        break;
      case 1:
        setState(() {
          _currentFlashMode = FlashMode.auto;
        });
        await controller!.setFlashMode(
          FlashMode.auto,
        );
        break;
      case 2:
        setState(() {
          _currentFlashMode = FlashMode.always;
        });
        await controller!.setFlashMode(
          FlashMode.always,
        );
        break;
      case 3:
        setState(() {
          _currentFlashMode = FlashMode.torch;
        });
        await controller!.setFlashMode(
          FlashMode.torch,
        );
        break;
      default:
        return Icon(Icons.scale);
    }
  }
}
