import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sizer/sizer.dart';
import 'package:weekly_task/main.dart';

class LocalNotification extends StatefulWidget {
  const LocalNotification({Key? key}) : super(key: key);

  @override
  State<LocalNotification> createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initNotifications() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('icon_avtar');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: (i, string1, string2, string3) {
      print("received notifications");
    });
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (string) {
      print("selected notification");
    });
  }

  @override
  void initState() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('icon_avtar');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (string) {
      print("selected notification");
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Notification"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              elevation: 5,
              height: 5.h,
              disabledTextColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.cyan.shade200,
              onPressed: _showNotificationWithDefaultSound,
              child: Text(
                "notification with sound",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // MaterialButton(
            //   elevation: 5,
            //   height: 5.h,
            //   disabledTextColor: Colors.white,
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20)),
            //   color: Colors.cyan.shade200,
            //   onPressed: _showNotificationWithNoSound,
            //   child: Text(
            //     "notification with no sound",
            //     style: TextStyle(color: Colors.black54),
            //   ),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            MaterialButton(
              elevation: 5,
              height: 5.h,
              disabledTextColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.cyan.shade200,
              onPressed: showScheduleNotification,
              child: Text(
                "Schedule Notification ",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              elevation: 5,
              height: 5.h,
              disabledTextColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.cyan.shade200,
              onPressed: showBigImageNotification,
              child: Text(
                "BigImage Notification",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
              elevation: 5,
              height: 5.h,
              disabledTextColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.cyan.shade200,
              onPressed: showProgressNotification,
              child: Text(
                "Progress Notification",
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Message',
      'you have received new local notification',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  Future _showNotificationWithNoSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Message',
      'you have received new local notification',
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }

  Future<void> showScheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var androidDetails = AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      icon: 'icon_avtar',
      largeIcon: DrawableResourceAndroidBitmap('icon_avtar'),
    );
    var iOSDetails = IOSNotificationDetails();
    var platformDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Flutter Local Notification',
        'Flutter Schedule Notification',
        scheduledNotificationDateTime,
        platformDetails,
        payload: 'Destination Screen(Schedule Notification)');
  }

  Future<void> showBigImageNotification() async {
    var bigPictureStyleInfo = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("icon_avtar"),
        largeIcon: DrawableResourceAndroidBitmap("icon_avtar"),
        contentTitle: 'Flutter Big Image Notification',
        summaryText: 'Flutter Big Image Notification summary');
    var androidDetails = AndroidNotificationDetails("channelId", "channelName",
        styleInformation: bigPictureStyleInfo);
    var platformDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.show(0, 'flutter Local Notification',
        'Flutter Big Image Notification', platformDetails,
        payload: '‘Destination Screen(Big Picture Notification)');
  }

  Future<void> showProgressNotification() async {
    const int maxProgress = 5;
    for (int i = 0; i <= maxProgress; i++) {
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        final AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails('channel_id', 'Channel Name',
                channelShowBadge: false,
                importance: Importance.max,
                priority: Priority.high,
                onlyAlertOnce: true,
                showProgress: true,
                maxProgress: maxProgress,
                progress: i);
        final NotificationDetails notificationDetails =
            NotificationDetails(android: androidNotificationDetails);
        await flutterLocalNotificationsPlugin.show(
            0,
            'Flutter Local Notification',
            'Flutter Progress Notification',
            notificationDetails,
            payload: 'Destination Screen(Progress Notification)');
      });
    }
  }

  Future onSelectNotification(String payload) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Here is your payload"),
              content: Text("Payload : $payload"),
            ));
  }
}
