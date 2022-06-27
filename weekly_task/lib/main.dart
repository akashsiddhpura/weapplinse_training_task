import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:weekly_task/homepage/Homepage.dart';
import 'package:weekly_task/week1/week1_task/navigator/firstpage.dart';
import 'package:weekly_task/week3/API/apicalling.dart';
import 'package:weekly_task/week5/audio%20player/audio_player.dart';
import 'package:weekly_task/week5/week5.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:weekly_task/week9/FireStore_database/View_TODO.dart';
import 'package:weekly_task/week9/Firebase_Auth/Login_page/login_page.dart';
import 'package:weekly_task/week9/Firebase_Auth/login_home/login_home.dart';
import 'package:weekly_task/week9/week9.dart';

List<CameraDescription> cameras = [];

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  await MobileAds.instance.initialize();
  WidgetsFlutterBinding.ensureInitialized();

  String? token = await FirebaseMessaging.instance.getToken();

  print("Token --------------${token}");

  AwesomeNotifications().initialize('resource://drawable/icon_avtar', [
    // notification icon
    NotificationChannel(
        channelGroupKey: 'basic_test',
        channelKey: 'basic',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        channelShowBadge: true,
        importance: NotificationImportance.High,
        playSound: true),
    //add more notification type with different configuration
  ]);

  //click listiner on local notification
  AwesomeNotifications()
      .actionStream
      .listen((ReceivedNotification receivedNotification) {
    print(receivedNotification.payload!['title']);

    //output from local notification click.
  });

  await Firebase.initializeApp(); //initilization of Firebase app
  FirebaseMessaging.instance
      .subscribeToTopic("all"); //subscribe firebase message on topic

  // FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);

  FirebaseMessaging.onMessage.listen(firebaseForegroundMessage);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  Stripe.publishableKey =
      'pk_test_51KxW8DSHJPwGKhHI8AGGQ3t6pML8CQyvR0ybC9hjlo5gQIpa7uLcOHWZxZfjNwPgVUJ2mgwP3hR04nt46Ackx9L700ZOaIMDrp';
  // await Stripe.instance.applySettings();

  runApp(EasyLocalization(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('en', 'GB'),
      Locale('hi', 'IN'),
      Locale('gu', 'IN'),
      Locale('mr', 'IN'),
      Locale('kn', 'IN'),
      Locale('pa', 'IN')
    ],
    path: 'assets/translations',
    saveLocale: true,
    child: MyApp(),
  ));
  routes:
  <String, WidgetBuilder>{
    '/audioPlayer': (BuildContext context) => new Audio_player(),
    '/week5': (BuildContext context) => new Week5(),
    '/apiCalling': (BuildContext context) => new Homepage(),
  };
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: message.data["image"],
    //             largeIcon: message.data["image"]
    //
    //           ),
    //         ));
    //   }
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
    // FirebaseMessaging.onMessage.listen(firebaseBackgroundMessage);
    //active app listiner.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        defaultTransition: Transition.circularReveal,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.elementAt(3);
        },
        routes: {
          '/firstpage': (context) => Firstpage(),
          '/loginPage': (context) => Logintab(),
          '/todoView': (context)=>View_TODO(),
          '/week9':(context)=>week9()
        },
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Colors.teal.shade300),
        home: Homepage(),
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
        debugShowCheckedModeBanner: false,
      );
    });
  }
}

Future<void> firebaseForegroundMessage(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        //with image from URL
          id: 1,
          channelKey: 'basic',
          //channel configuration key
          title: message.notification!.title,
          body: message.notification!.body,

          bigPicture: message.notification!.android!.imageUrl != null ? message
              .notification!.android!.imageUrl.toString() : null,
          notificationLayout: message.notification!.android!.imageUrl != null
              ? NotificationLayout.BigPicture
              : null,
          payload: {"name": "flutter"}));
  print(message.notification!.body);
  print(message.notification!.android!.imageUrl.toString());
}
//hii
// Future<void> firebaseForegroundMessage(RemoteMessage message) async {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   print("++++${notification!.body.toString()}");
//   print(android!.imageUrl.toString());
//   if (notification != null && android != null ) {
//     flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//
//         await NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             color: Colors.blue,
//             playSound: true,
//             icon: android.smallIcon,
//           ),
//         ));
// print(message);
//     print("================${ channel.id.toString()}");
//     print("================${ channel.name.toString()}");
//     print("================${message.data["image"].toString()}");
//     //     content: NotificationContent( //with image from URL
//     //         id: notification.hashCode,
//     //         channelKey: channel.id,
//     //         icon: message.data["image"],
//     //         largeIcon: message.data["image"],
//     //
//     //         title: message.data["title"],
//     //         body: message.data["body"],
//     //         bigPicture: message.data["image"],
//     //         notificationLayout: NotificationLayout.BigPicture,
//     //         payload: {"name":"flutter"}
//     //     )
//     // );
//   }
// }
//hii