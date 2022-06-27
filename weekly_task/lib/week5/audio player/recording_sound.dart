import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:weekly_task/week5/audio%20player/audio_player.dart';
import 'package:weekly_task/week5/week5.dart';

class Recording_sound extends StatefulWidget {
  @override
  _Recording_soundState createState() => _Recording_soundState();
}

class _Recording_soundState extends State<Recording_sound> {
  String statusText = "";
  bool isComplete = false;
  bool recordStatus = true;
  int recordDuration = 0;
  Timer? timer;
  static const countdownDuration = Duration(hours: 2);
  Duration duration = Duration();
  bool countDown = true;

  @override
  void dispose() {
    timer?.cancel();

    // TODO: implement dispose
    stopRecord();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Recording'),
          backgroundColor: Colors.black87,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){Navigator.pop(context);setState(() {
            
          });},),
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 50),
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.end
              , children: [
            Center(
                child: Text(
              _printDuration(Duration(seconds: timeRunning)),
              style: TextStyle(fontSize: 90),
            )),
            SizedBox(height: 90,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: recordStatus
                      ? CircleAvatar(
                          radius: 40,
                          child: IconButton(
                            onPressed: () async {
                              startRecord();
                              time();
                              setState(() {
                                recordStatus = false;
                                print(recordStatus);
                              });
                            },
                            icon: Icon(Icons.mic),
                            color: Colors.white,
                            iconSize: 40,
                          ),
                          backgroundColor: Colors.redAccent,
                        )
                      : CircleAvatar(
                    radius: 40,
                        backgroundColor: Colors.grey.shade300,
                        child: IconButton(
                            onPressed: () async {
                              pauseRecord();
                            },
                            icon: Icon(
                                RecordMp3.instance.status == RecordStatus.PAUSE
                                    ? Icons.play_arrow:
                                    Icons.pause,)

                          ,
                          iconSize: 40,
                          color: Colors.black,
                          ),
                      ),

                  // child: GestureDetector(
                  //   child: Container(
                  //     height: 48.0,
                  //     decoration: BoxDecoration(color: Colors.red.shade300),
                  //     child: Center(
                  //       child: Text(
                  //         'start',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: () async {
                  //     startRecord();
                  //   },
                  // ),

                  // Expanded(
                  //   child: IconButton(onPressed: ()async{pauseRecord(); },
                  //     icon: Icon(RecordMp3.instance.status == RecordStatus.PAUSE
                  //                   ? Icons.play_arrow
                  //                   : Icons.pause),
                  //    )
                  // GestureDetector(
                  //   child: Container(
                  //     height: 48.0,
                  //     decoration: BoxDecoration(color: Colors.blue.shade300),
                  //     child: Center(
                  //       child: Text(
                  //         RecordMp3.instance.status == RecordStatus.PAUSE
                  //             ? 'resume'
                  //             : 'pause',
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     pauseRecord();
                  //   },
                  // ),
                ),
                Expanded(child:
                CircleAvatar(
                  radius: 40,
                  child: IconButton(
                    onPressed: () async {
                      stopRecord();
                            setState(() {
                              recordStatus = true;
                            });
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Audio_player()), ModalRoute.withName('/week5'));
                    },
                    icon: Icon(Icons.done),

                    color: Colors.white,
                    iconSize: 40,
                  ),
                  backgroundColor: Colors.green,
                ))
                // Expanded(
                //   child: GestureDetector(
                //     child: Container(
                //       height: 48.0,
                //       decoration: BoxDecoration(color: Colors.green.shade300),
                //       child: Center(
                //         child: Text(
                //           'stop',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //       ),
                //     ),
                //     onTap: () {
                //       stopRecord();
                //       setState(() {
                //         recordStatus = true;
                //       });
                //     },
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                statusText,
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),

          ]),
        ),
      ),
    );
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  void pauseRecord() {
    timer?.cancel();
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording...";
        setState(() {
          time();

          // timeCount++;
        });
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }

  int timeRunning = 0;

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Recording Saved";
      isComplete = true;
      setState(() {
        timer?.cancel();
        timeRunning = 0;
      });
    }
  }

  void resumeRecord() {
    timer?.cancel();
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  late String recordFilePath;

  // void play() {
  //   if (recordFilePath != null && File(recordFilePath).existsSync()) {
  //     AudioPlayer audioPlayer = AudioPlayer();
  //     audioPlayer.play(recordFilePath, isLocal: true);
  //   }
  // }

  int i = 0;

  Future<String> getFilePath() async {
    Directory? storageDirectory = await getExternalStorageDirectory();
    String sdPath = storageDirectory!.path + "/record";
    print(sdPath);
    var d = Directory("storage/emulated/0/Music");
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }

    return "storage/emulated/0/Music" +
        "/test${DateTime.now().millisecondsSinceEpoch}.mp3";
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
}
