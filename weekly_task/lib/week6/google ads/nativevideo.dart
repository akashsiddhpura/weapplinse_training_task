import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeVideo extends StatefulWidget {
  const NativeVideo({Key? key}) : super(key: key);

  @override
  State<NativeVideo> createState() => _NativeVideoState();
}

class _NativeVideoState extends State<NativeVideo> {
  NativeAd? _nativeVideo;
  bool _isAdLoadedVideo = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nativeVideo!.dispose();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nativeVideo = NativeAd(
        adUnitId: 'ca-app-pub-3940256099942544/1044960115',
        factoryId: 'listTile',
        listener: NativeAdListener(
          onAdLoaded: (_) {
            print(".================777777777777===================");
            setState(() {
              _isAdLoadedVideo = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Releases an ad resource when it fails to load
            ad.dispose();

            print(
                'Ad load failed (code=${error.code} message=${error.message} =====${ad})');
          },
        ),
        request: AdRequest());
    _nativeVideo!.dispose();
    _nativeVideo!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(

        children: [
          _isAdLoadedVideo
              ? Center(
                child: Container(
                    child: AdWidget(ad: _nativeVideo!),
                    height: 300.0,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                  ),
              )
              : CircularProgressIndicator(),
        ],
      ),
    );
  }
}
