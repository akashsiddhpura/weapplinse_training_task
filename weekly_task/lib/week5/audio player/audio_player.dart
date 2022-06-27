import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'package:weekly_task/week5/audio%20player/recording_sound.dart';
//Audio_player

class Audio_player extends StatefulWidget {
  const Audio_player({Key? key}) : super(key: key);

  @override
  _Audio_playerState createState() => _Audio_playerState();
}

class _Audio_playerState extends State<Audio_player> {
  //audio plugin
  final OnAudioQuery _audioQuery = OnAudioQuery();

  //player
  final AudioPlayer _player = AudioPlayer();

  List<SongModel> songs = [];
  String currentSongTitle = '';
  int currentIndex = 0;

  bool isPlayerViewVisible = false;

  Color bgcolor = Color.fromARGB(255, 250, 244, 253);

  //duration state stream
  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          _player.positionStream,
          _player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));
  @override
  void initState() {
    super.initState();
    requestPermission();

    _player.currentIndexStream.listen((index) {
      if (index != null) {
        _updateCurrentPlayerSongDetails(index);
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }



  Future<void> deleteFile(File file) async {
    try {
      var status = await Permission.storage.status;
      print(status);
      if (status.isGranted) {
        if (await file.exists()) {
          await file.delete();
          print("delete successfully");
        }
      }
    } catch (e) {
      if (await file.exists()) {
        print("file exist");
      }
      print(e.toString());
      // Error in getting access to the file.
    }
  }

  requestPermission() async {
    // Web platform don't support permissions methods.
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isPlayerViewVisible) {
      return Scaffold(
        backgroundColor: bgcolor,
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 56, right: 20, left: 20),
          decoration: BoxDecoration(color: bgcolor),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: _changePlayerViewVisibility,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      currentSongTitle,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    flex: 5,
                  ),
                ],
              ),
              Container(
                width: 400,
                height: 400,
                margin: EdgeInsets.only(top: 30, bottom: 90),
                child: Image(image: AssetImage("assets/images/audio3.jpg")),
              ),

              //slider
              Column(
                children: [
                  Container(
                    // padding: EdgeInsets.only(bottom: 0),
                    // decoration: getRectDecoration(
                    //     BorderRadius.circular(10), Offset(2, 2), 5, 0),
                    child: StreamBuilder<DurationState>(
                      stream: _durationStateStream,
                      builder: (context, snapshot) {
                        final durationState = snapshot.data;
                        final progress =
                            durationState?.position ?? Duration.zero;
                        final total = durationState?.total ?? Duration.zero;

                        return ProgressBar(
                          progress: progress,
                          total: total,
                          barHeight: 10,
                          baseBarColor: Colors.grey.shade300,
                          progressBarColor: Colors.black,
                          thumbColor: Colors.black,
                          timeLabelTextStyle: TextStyle(fontSize: 0),
                          onSeek: (duration) {
                            _player.seek(duration);
                          },
                        );
                      },
                    ),
                  ),
                  StreamBuilder<DurationState>(
                    stream: _durationStateStream,
                    builder: (context, snapshot) {
                      final durationState = snapshot.data;
                      final progress = durationState?.position ?? Duration.zero;
                      final total = durationState?.total ?? Duration.zero;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: Text(
                              progress.toString().split(".")[0],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              total.toString().split(".")[0],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  StreamBuilder<DurationState>(
                    stream: _durationStateStream,
                    builder: (context, snapshot) {
                      final durationState = snapshot.data;
                      final progress = durationState?.position ?? Duration.zero;
                      final total = durationState?.total ?? Duration.zero;

                      return  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //skip to previous
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                if (_player.hasPrevious) {
                                  _player.seekToPrevious();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                // decoration: getDecoration(
                                //     BoxShape.circle, Offset(2, 2), 2, 0),
                                child: Icon(
                                  Icons.skip_previous_rounded,
                                  color: Colors.black54,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () async {
                                if (_player.position.inSeconds >= 10) {
                                  await _player.seek(Duration(
                                      seconds: _player.position.inSeconds - 10));
                                } else {
                                  await _player.seek(Duration.zero);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                // decoration: getDecoration(
                                //     BoxShape.circle, Offset(2, 2), 2, 0),
                                child: Icon(
                                  Icons.fast_rewind_rounded,
                                  color: Colors.black54,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                if (_player.playing) {
                                  _player.pause();
                                } else {
                                  if (_player.currentIndex != null) {
                                    _player.play();
                                  }
                                }
                              },
                              child: Container(
                                // padding: EdgeInsets.all(10),
                                // margin: EdgeInsets.only(right: 30, left: 0),
                                // decoration: getDecoration(BoxShape.circle, Offset(0,0), 0, 0),
                                child: StreamBuilder<bool>(
                                  stream: _player.playingStream,
                                  builder: (context, snapshot) {
                                    bool? playingState = snapshot.data;
                                    if (playingState != null && playingState) {
                                      return Icon(
                                        Icons.pause_circle_outline,
                                        size: 70,
                                        color: Colors.black,
                                      );
                                    }
                                    return Icon(
                                      Icons.play_circle_outline_rounded,
                                      size: 70,
                                      color: Colors.black,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () async {

                                print(total);
                                if (_player.position.inSeconds <= total.inSeconds - 9) {
                                  await _player.seek(Duration(
                                      seconds: _player.position.inSeconds + 10));
                                } else {
                                  await _player.position == total;
                                  _player.seekToNext();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                // decoration: getDecoration(
                                //     BoxShape.circle, Offset(2, 2), 2, 0),
                                child: Icon(
                                  Icons.fast_forward_rounded,
                                  color: Colors.black54,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                if (_player.hasNext) {
                                  _player.seekToNext();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.skip_next_rounded,
                                  color: Colors.black54,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 20, bottom: 20),
                  //   child:
                  // )
                ],
              ),

              //contoller butoons

            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Player"),
        elevation: 2,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: bgcolor,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.mic),
        backgroundColor: Colors.black87,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Recording_sound()));
        },
      ),
      body: FutureBuilder<List<SongModel>>(
        // Default values:
        future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          // Loading content
          if (item.data == null)
            return Center(child: CircularProgressIndicator());

          // When you try "query" without asking for [READ] or [Library] permission
          // the plugin will return a [Empty] list.
          if (item.data!.isEmpty) return const Text("Nothing found!");

          songs.clear();
          songs = item.data!;

          return ListView.builder(
            // shrinkWrap: false,

            itemCount: item.data!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    // decoration: BoxDecoration(
                    //     color: bgcolor,
                    //     borderRadius: BorderRadius.circular(15),
                    //     boxShadow: [
                    //       BoxShadow(
                    //           blurRadius: 4.0,
                    //           offset: Offset(-4, -4),
                    //           color: Colors.white24),
                    //       BoxShadow(
                    //           blurRadius: 4.0,
                    //           offset: Offset(4, 4),
                    //           color: Colors.grey)
                    //     ]),
                    child: ListTile(
                      title: Text(item.data![index].displayName),
                      subtitle: Text(item.data![index].fileExtension),
                      // trailing: IconButton(
                      //     onPressed: () async {
                      //       Directory? storageDirectory =
                      //           await getExternalStorageDirectory();
                      //
                      //       print(item.data![index].data);
                      //
                      //       deleteFile(File(item.data![index].data));
                      //
                      //       setState(() {
                      //         _player.currentIndexStream.listen((index) {
                      //           if (index != null) {
                      //             _updateCurrentPlayerSongDetails(index);
                      //           }
                      //         });
                      //       });
                      //     },
                      //     icon: Icon(Icons.delete)),
                      // This Widget will query/load image. Just add the id and type.
                      // You can use/create your own widget/method using [queryArtwork].
                      leading:
                          Image(image: AssetImage("assets/images/audio.png")),
                      onTap: () async {
                        _changePlayerViewVisibility();
                        // String? uri = item.data![index].uri;
                        // await _player.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
                        await _player.setAudioSource(createPlaylist(item.data!),
                            initialIndex: index);
                        await _player.play();
                      },
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }

  //create playlist
  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> source = [];
    for (var song in songs) {
      source.add(AudioSource.uri(Uri.parse(song.uri!)));
    }
    return ConcatenatingAudioSource(children: source);
  }

  void _updateCurrentPlayerSongDetails(int index) {
    setState(() {
      if (songs.isNotEmpty) {
        currentSongTitle = songs[index].title;
        currentIndex = index;
      }
    });
  }

  //delete playlist

  void _changePlayerViewVisibility() {
    setState(() {
      isPlayerViewVisible = !isPlayerViewVisible;
      _player.stop();
    });
  }

  BoxDecoration getDecoration(
      BoxShape shape, Offset offset, double blurRadius, double spreadRadius) {
    return BoxDecoration(color: bgcolor, shape: shape, boxShadow: [
      BoxShadow(
        offset: -offset,
        color: Colors.white24,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
      BoxShadow(
        offset: offset,
        color: Colors.grey,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      )
    ]);
  }

  BoxDecoration getRectDecoration(BorderRadius borderRadius, Offset offset,
      double blurRadius, double spreadRadius) {
    return BoxDecoration(
        borderRadius: borderRadius,
        color: bgcolor,
        boxShadow: [
          BoxShadow(
            offset: -offset,
            color: Colors.white24,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
          ),
          BoxShadow(
            offset: offset,
            color: Colors.grey,
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
          )
        ]);
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}


