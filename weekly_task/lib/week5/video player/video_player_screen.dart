import 'dart:developer';
import 'dart:io';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:video_viewer/video_viewer.dart';

class VideoPlayerScreen extends StatefulWidget {
  final List<AssetEntity> videoList;
  // final Future<File?> file;
  var currentindex;

  VideoPlayerScreen(
      {Key? key, required this.videoList, required this.currentindex})
      : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  List<AssetEntity> assets = [];

  VideoPlayerController? _controller;
  bool initialized = false;
  bool tap = true;
  bool isFull = true;
  bool isMute = true;
  var mindex;
  int nextIndex = 0;

  @override
  void initState() {
    _initvideo(0);
    _controller?.setLooping(true);
    _controller?.play();
    mindex = widget.currentindex;
    super.initState();
  }

  setmount() {
    if (mounted) {
      setState(() {});
    }
  }

  // nextVideo() {
  //   _controller = null;
  //   widget.currentindex++;
  //   setmount();
  //   if(hiii==0){
  //     _initvideo(0);
  //   }
  //
  //
  // }
  //
  // previousVideo() {
  //   _controller = null;
  //   widget.currentindex--;
  //  setmount();
  //
  //   _initvideo();
  // }

  int hiii = 0;

  _initvideo(int nextIndex) async {
    print(
        "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<state is initstate>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>..");
    hiii = 1;
    final video = await widget.videoList[widget.currentindex + nextIndex].file;

    _controller = VideoPlayerController.file(video!);

    _controller!.addListener(
      () {
        setmount();
      },
    );
    _controller!.removeListener(
      () {
        setmount();
      },
    );
    _controller!.setLooping(true);
    _controller!.initialize().then((value) => setmount());
    _controller!.play();
    hiii = 0;
  }

  @override
  void dispose() {
    _controller?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    print(
        "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<state is dispose>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _controller!.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: _controller!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    )
                  : Container(child: CircularProgressIndicator()),
            ),
            GestureDetector(
              onTap: () {
                if (tap) {
                  tap = false;
                  setmount();
                } else {
                  tap = true;
                  setmount();
                }
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
            if (tap)
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //SizedBox(height:40),
                          Container(
                            // color: Colors.white,
                            height: 10,
                            width: MediaQuery.of(context).size.width - 30,
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.only(bottom: 10),

                            child: StreamBuilder<DurationState>(
                              builder: (context, snapshot) {

                                final progress = _controller!.value.position;
                                final total = _controller!.value.duration;

                                return ProgressBar(
                                  progress: progress,
                                  total: total,
                                  barHeight: 5,
                                  barCapShape: BarCapShape.round,
                                  baseBarColor: Colors.white,
                                  progressBarColor: Colors.blue,
                                  thumbColor: Colors.blue,
                                  timeLabelTextStyle: TextStyle(
                                    fontSize: 10,
                                  ),
                                  onSeek: (duration) {
                                    _controller!.seekTo(duration);
                                  },
                                );
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (isMute)
                                  IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      _controller!.setVolume(0.0);
                                      isMute = false;

                                      setmount();
                                    },
                                    icon: Icon(
                                      Icons.volume_up_rounded,
                                    ),
                                  )
                                else
                                  IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      _controller!.setVolume(10.0);
                                      isMute = true;
                                      setmount();
                                    },
                                    icon: Icon(
                                      Icons.volume_off_rounded,
                                    ),
                                  ),
                                IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    Duration targetPosition =
                                        _controller!.value.position -
                                            Duration(seconds: 10);
                                    _controller!.seekTo(targetPosition);

                                    setmount();
                                  },
                                  icon: Icon(Icons.rotate_left_rounded),
                                ),
                                IconButton(
                                  color: Colors.white,
                                  onPressed: () async {
                                    if (widget.currentindex + nextIndex == 0) {
                                      Fluttertoast.showToast(
                                          msg: "no more previous videos",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black54,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      await _controller!.dispose();
                                      log("${widget.currentindex}");
                                      nextIndex--;
                                      log("${nextIndex}");
                                      log("${widget.currentindex + nextIndex}");
                                      await _initvideo(nextIndex);
                                    }
                                    // previousVideo();
                                    // setmount();
                                  },
                                  icon: Icon(Icons.skip_previous_rounded),
                                ),
                                IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    _controller!.value.isPlaying
                                        ? _controller!.pause()
                                        : _controller!.play();
                                    setmount();
                                  },
                                  icon: Icon(
                                    _controller!.value.isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                  ),
                                  iconSize: 50,
                                ),
                                IconButton(
                                  color: Colors.white,
                                  onPressed: () async {
                                    if (widget.videoList.length ==
                                        widget.currentindex + nextIndex + 1) {
                                      Fluttertoast.showToast(
                                          msg: "no more videos",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black54,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      await _controller!.dispose();
                                      nextIndex++;
                                      print(
                                          "=============================${nextIndex}");
                                      await _initvideo(nextIndex);
                                    }
                                    setmount();
                                  },
                                  icon: Icon(
                                    Icons.skip_next_rounded,
                                  ),
                                ),
                                IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    Duration targetPosition =
                                        _controller!.value.position +
                                            Duration(seconds: 10);
                                    _controller!.seekTo(targetPosition);

                                    setmount();
                                  },
                                  icon: Icon(Icons.rotate_right_rounded),
                                ),
                                if (isFull)
                                  IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      SystemChrome.setPreferredOrientations([
                                        DeviceOrientation.landscapeLeft,
                                      ]);
                                      SystemChrome.setEnabledSystemUIMode(
                                          SystemUiMode.leanBack);
                                      isFull = false;
                                      setmount();
                                    },
                                    icon: Icon(
                                      Icons.fullscreen_rounded,
                                    ),
                                  )
                                else
                                  IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      SystemChrome.setPreferredOrientations([
                                        DeviceOrientation.portraitUp,
                                      ]);
                                      SystemChrome.setEnabledSystemUIMode(
                                          SystemUiMode.manual,
                                          overlays: SystemUiOverlay.values);
                                      isFull = true;
                                      setmount();
                                    },
                                    icon: Icon(
                                      Icons.fullscreen_exit_rounded,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(),
          ],
        ),
        backgroundColor: Colors.black87,
      ),
    );
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});

  Duration position, total;
}
