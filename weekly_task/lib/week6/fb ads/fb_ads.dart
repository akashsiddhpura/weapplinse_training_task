//https://admob-plus.github.io/docs/cordova/test-ads



import 'package:flutter/material.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FbAds extends StatefulWidget {
  const FbAds({
    Key? key,
  }) : super(key: key);

  @override
  FbAdsState createState() => FbAdsState();
}

class FbAdsState extends State<FbAds> {
  bool _isInterstitialAdLoaded = true;
  bool _isRewardedAdLoaded = true;
  int rewardPoint = 0;

  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  @override
  void dispose() {
    _isRewardedAdLoaded = false;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    FacebookAudienceNetwork.init(
      testingId: "a77955ee-3304-4635-be65-81029b0f5201",
    );

    _loadInterstitialAd();
    _loadRewardedVideoAd();
  }

  set() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facebook Ads"),
        backgroundColor: Colors.black87,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text("Reward : ${rewardPoint.toString()}",style: TextStyle(fontSize: 20),),
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              FacebookBannerAd(
                placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
                //#2312433698835503_2964944860251047",
                bannerSize: BannerSize.STANDARD,
                listener: (result, value) {
                  print("Banner Ad: $result -->  $value");
                },
              ),

              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  _showBannerAd();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.ad_units_sharp),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Banner Ads"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  _showNativeBannerAd();
                  set();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.ad_units_sharp),
                      SizedBox(
                        width: 20,
                      ),
                      Text("NativeBanner Ads"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  _showInterstitialAd();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.ad_units_sharp),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Interstitial Ads"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  _showMediumRectangleAd();
                  set();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.ad_units_sharp),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Medium rectangle Ads"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  _showNativeAd();
                  set();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.ad_units_sharp),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Native Ads"),
                    ],
                  ),
                ),
              ),


              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  _showRewardedAd();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.ad_units_sharp),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Rewarded Ads"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: Align(
                  alignment: Alignment(0, 1.0),
                  child: _currentAd,
                ),
              ),
              // Container(child: Text("Reward : ${rewardPoint.toString()}",style: TextStyle(fontSize: 30),))
            ],
          ),
        ),
      ),
    );
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;

        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
        }
      },
    );
  }

  void _loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: "VID_HD_16_9_15S_APP_INSTALL#YOUR_PLACEMENT_ID",
      listener: (result, value) {
        print("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED)
          setState(() {
            _isRewardedAdLoaded = true;
          });
        if (result == RewardedVideoAdResult.VIDEO_CLOSED) {
          _isRewardedAdLoaded = false;

          _loadRewardedVideoAd();
        }
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
          print(
              "======================reward collected===========================================");
          rewardPoint = rewardPoint + 10;
          Fluttertoast.showToast(
              msg: "reward collected",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);

          setState(() {
            rewardPoint;
          });
        }
      },
    );
  }

  void _showInterstitialAd() {
    if (_isInterstitialAdLoaded == true) {
      FacebookInterstitialAd.showInterstitialAd();
    } else
      Fluttertoast.showToast(
          msg: "Rewarded Ad not yet loaded!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black26,
          textColor: Colors.white,
          fontSize: 16.0);
  }

  void _showRewardedAd() {
    if (_isRewardedAdLoaded == true) {
      FacebookRewardedVideoAd.showRewardedVideoAd().whenComplete(
        () {
          if (RewardedVideoAdResult.VIDEO_COMPLETE == true) {
            print(
                "======================reward collected on completed===========================================");
          }
          // rewardPoint = rewardPoint + 10;
          //
          // Fluttertoast.showToast(
          //     msg: "${rewardPoint}",
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.TOP,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
          setState(
            () {
              rewardPoint;
            },

          );
        },
      );
    } else
      Fluttertoast.showToast(
          msg: "Rewarded Ad not yet loaded!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
  }

  void _showBannerAd() {
    _currentAd = FacebookBannerAd(
      placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
      //#2312433698835503_2964944860251047",
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        print("Banner Ad: $result -->  $value");
      },
    );
    set();
  }

  void _showMediumRectangleAd() {
    _currentAd = FacebookBannerAd(
      placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
      //#2312433698835503_2964944860251047",
      bannerSize: BannerSize.MEDIUM_RECTANGLE,
      listener: (result, value) {
        print("Banner Ad: $result -->  $value");
      },
    );
    set();
  }

  void _showNativeBannerAd() {
    _currentAd = _nativeBannerAd();
    set();
  }

  Widget _nativeBannerAd() {
    return FacebookNativeAd(
      placementId: "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512",
      adType: NativeAdType.NATIVE_BANNER_AD,
      bannerAdSize: NativeBannerAdSize.HEIGHT_100,
      width: double.infinity,
      backgroundColor: Colors.black87,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Banner Ad: $result --> $value");
      },
    );
  }

  void _showNativeAd() {
    _currentAd = _nativeAd();
    set();
  }

  Widget _nativeAd() {
    return FacebookNativeAd(
      placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 300,
      backgroundColor: Colors.black38,
      titleColor: Colors.white,
      descriptionColor: Colors.white,
      buttonColor: Colors.deepPurple,
      buttonTitleColor: Colors.white,
      buttonBorderColor: Colors.white,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }
}
