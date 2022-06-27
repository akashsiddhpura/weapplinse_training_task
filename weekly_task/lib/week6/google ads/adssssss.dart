import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// import 'ads2.dart';

class Adsss extends StatefulWidget {
  const Adsss({Key? key}) : super(key: key);

  @override
  State<Adsss> createState() => _AdsssState();
}

class _AdsssState extends State<Adsss> {
  BannerAd? bannerAd;
  bool isLoaded = false;
  RewardedAd? rewardedAd;
  InterstitialAd? interstitialAd;
  InterstitialAd? interstitialVideoAd;
  NativeAd? _adSmall;
  NativeAd? _adMedium;
  NativeAd? _nativeVideo;
  bool _isAdLoaded = false;
  bool _isBannerLoaded = false;
  bool _isAdLoadedMedium = false;
  RewardedInterstitialAd? _rewardedInterstitialAd;
  bool _isInterstitialAdReady = false;
  int rewardPoint = 0;
  Color btnColor = Colors.blue;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createInterstitialAd();
    _createRewardedAd();
    _createInterstitialAd();
    createRewardedInterstitialAd();
    _createInterstitialVideoAd();
    // nativeVideo();
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isLoaded = true;
            _isBannerLoaded = true;
          });
          print("BANNER ADS WORKING");
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    bannerAd!.load();
    // _nativeVideo = NativeAd (
    //     adUnitId: 'ca-app-pub-3940256099942544/1044960115',
    //     factoryId: 'listTile',
    //     listener: NativeAdListener(
    //       onAdLoaded: (_) {
    //         print(".================777777777777===================");
    //         setState(() {
    //           _isAdLoadedVideo = true;
    //         });
    //       },
    //       onAdFailedToLoad: (ad, error) {
    //         // Releases an ad resource when it fails to load
    //         ad.dispose();
    //
    //         print('Ad load failed (code=${error.code} message=${error.message})');
    //       },
    //     ),
    //     request: AdRequest()
    // );
    // _nativeVideo!.load();

    _adSmall = NativeAd(
      // Here in adUnitId: add your own ad unit ID before release build
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',
      factoryId: 'listTileSmall',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          print("================hhhhhhhhhhhhhh===================");
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _adSmall!.load();

    _adMedium = NativeAd(
      // Here in adUnitId: add your own ad unit ID before release build

      adUnitId:'ca-app-pub-3940256099942544/2247696110',
      factoryId: 'listTileMedium',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          print("================tttttttttttttttttt===================");
          setState(() {
            _isAdLoadedMedium = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _adMedium!.load();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    rewardedAd!.dispose();
    interstitialAd!.dispose();
    _rewardedInterstitialAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AdMob demo"),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Image(image: AssetImage("assets/images/admob.png")),
              SizedBox(height: 10,),
              Text("Banner Ads"),
              _isBannerLoaded ? Container(
                height: bannerAd!.size.height.toDouble(),
                width: bannerAd!.size.width.toDouble(),
                child: AdWidget(ad: bannerAd!),
              ): CircularProgressIndicator(),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  _showInterstitialAd();
                  setState(() {});
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
                      Text("InterstitialAd"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  _showRewardedAd();
                  setState(() {});
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
                      Text("Reward Ads"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  _showInterstitialVideoAd();
                  setState(() {

                  });
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
                      Text("Interstitial video Ad"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  showRewardedInterstitialAd();
                  setState(() {

                  });
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
                      Text("Rewarded Interstitial video Ad"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  // showNativeVideo();
                  setState(() {

                  });
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
                      Text("Native small Ad"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text("Native Ads",style: TextStyle(fontSize: 20),),
              _isAdLoaded
                  ? Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  child: AdWidget(ad: _adSmall!),
                  height: 150,
                  width: 400,
                ),
              )
                  : CircularProgressIndicator(),
              SizedBox(height: 10,),
              _isAdLoadedMedium
                  ? Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  child: AdWidget(ad: _adMedium!),
                  height: 550,
                  width: 400,
                ),
              )
                  : CircularProgressIndicator(),

            ],
          ),
        ),
      ),
    );
  }
  
  // void nativeVideo(){
  //   NativeAd(
  //       adUnitId: 'ca-app-pub-3940256099942544/1044960115',
  //       factoryId: 'listTile',
  //       listener: NativeAdListener(
  //         onAdLoaded: (_) {
  //           print(".================hhhhhhhhhhhhhh===================");
  //           setState(() {
  //             _isAdLoadedVideo = true;
  //           });
  //         },
  //         onAdFailedToLoad: (ad, error) {
  //           // Releases an ad resource when it fails to load
  //           ad.dispose();
  //
  //           print('Ad load failed (code=${error.code} message=${error.message})');
  //         },
  //       ),
  //       request: AdRequest()
  //   );
  //   _nativeVideo!.load();
  // }

  // void showNativeVideo(){
  //   if(_nativeVideo != null ) {
  //     AdWidget(ad: _nativeVideo!);
  //   }
  // }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            setState(() {
              isLoaded = true;
              this.interstitialAd = ad;
            });
            print("its workingffff");
          },
          onAdFailedToLoad: (error) {
            print("its not working");
          },
        ));
  }

  void _showInterstitialAd() {
    if (interstitialAd != null) {
      InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/1033173712",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            this.interstitialAd = ad;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                interstitialAd!.dispose();
              },
            );

            isLoaded = true;
          },
          onAdFailedToLoad: (err) {
            print('Failed to load an interstitial ad: ${err.message}');
            isLoaded = false;
          },
        ),
      );
      interstitialAd!.show();
    }
  }

  void _createInterstitialVideoAd() {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/8691691433",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            setState(() {
              isLoaded = true;
              this.interstitialVideoAd = ad;
            });
            print("its workingffff");
          },
          onAdFailedToLoad: (error) {
            print("its not working");
          },
        ));
  }

  void _showInterstitialVideoAd() {
    if (interstitialVideoAd != null) {
      InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/8691691433",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            this.interstitialVideoAd = ad;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                interstitialVideoAd!.dispose();
              },
            );

            isLoaded = true;
          },
          onAdFailedToLoad: (err) {
            print('Failed to load an interstitial ad: ${err.message}');
            isLoaded = false;
          },
        ),
      );
      interstitialVideoAd!.show();
    }
  }
  void _createRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          // print('$ad loaded.');
          // // Keep a reference to the ad so you can show it later.
          rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          rewardedAd = null;
        },

      ),
    );
  }

  void _showRewardedAd() {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {
          print('ad onAdShowedFullScreenContent.');
        },
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          print('ad onAdDismissedFullScreenContent.');
          _createRewardedAd();
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          print('onAdFailedToShowFullScreenContent: $error');
          _createRewardedAd();
          ad.dispose();
        },
      );
      rewardedAd!.setImmersiveMode(true);
      rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          rewardPoint = rewardPoint + reward.amount as int;
          Fluttertoast.showToast(
              msg: "${rewardPoint}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {
            rewardPoint;
          });

          print("--------------${rewardPoint},${reward.type}-------------");
        },
      );
    }
  }

  void createRewardedInterstitialAd() {
    RewardedInterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5354046379',
      request: AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          print('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          _rewardedInterstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedInterstitialAd failed to load: $error');
          _rewardedInterstitialAd = null;
        },
      ),);
  }

  void showRewardedInterstitialAd() {
    if (_rewardedInterstitialAd != null) {
      _rewardedInterstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
                print('$ad onAdShowedFullScreenContent.'),
            onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
              print('$ad onAdDismissedFullScreenContent.');
              createRewardedInterstitialAd();
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (RewardedInterstitialAd ad,
                AdError error) {
              print('$ad onAdFailedToShowFullScreenContent: $error');
              createRewardedInterstitialAd();

              ad.dispose();
            },
            onAdImpression: (RewardedInterstitialAd ad) =>
                print('$ad impression occurred.'),
          );
      _rewardedInterstitialAd!.setImmersiveMode(true);
      _rewardedInterstitialAd!.show(onUserEarnedReward: (ad, reward) {
        rewardPoint = rewardPoint + reward.amount as int;
        Fluttertoast.showToast(
            msg: "${rewardPoint}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          rewardPoint;
        });
      },);
    }

  }
}
class AdsMethods {
  final String adsTitle;
  final Widget adstap;

  AdsMethods({required this.adsTitle, required this.adstap});
}

Widget ads2() {
  return Scaffold();
}
