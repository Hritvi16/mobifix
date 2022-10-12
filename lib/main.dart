// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_information/device_information.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:mobifix/Device.dart';
import 'package:mobifix/HomeScreen.dart';
import 'package:mobifix/Login.dart';
import 'package:mobifix/Packages.dart';
import 'package:mobifix/VerifyCode.dart';
import 'package:mobifix/api/APIConstant.dart';
import 'package:mobifix/api/APIService.dart';
import 'package:mobifix/colors/MyColors.dart';
import 'package:mobifix/models/SubscriptionResponse.dart';
import 'package:mobifix/size/MySize.dart';
import 'package:mobifix/toast/Toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   if(Platform.isAndroid)
//     await Firebase.initializeApp();
//   print("handling a background message${message.messageId}");
// }

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     "high_importance_channel", "High Importance notification",
//     importance: Importance.high);

//Remove this
// "This channel is used for important notification.",

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if(Platform.isAndroid) {
    // await Firebase.initializeApp();
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //     AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);
    // await FirebaseMessaging.instance
    //     .setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobifix',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        primarySwatch: MyColors.generateMaterialColor(MyColors.colorPrimary),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fcmId = "";

  late SharedPreferences sharedPreferences;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late AndroidDeviceInfo androidDeviceInfo;
  late IosDeviceInfo iosDeviceInfo;

  String? imei;
  @override
  void initState() {
    // if(Platform.isAndroid) {
    //   var initializationSettingsAndroid =
    //   AndroidInitializationSettings("app_icon");
    //   var initializationSettings =
    //   InitializationSettings(android: initializationSettingsAndroid);
    //
    //   flutterLocalNotificationsPlugin.initialize(initializationSettings);
    //
    //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //     RemoteNotification? notification = message.notification;
    //     AndroidNotification? android = message.notification?.android;
    //     if (notification != null && android != null) {
    //       flutterLocalNotificationsPlugin.show(
    //           notification.hashCode,
    //           notification.title,
    //           notification.body,
    //           NotificationDetails(
    //               android: AndroidNotificationDetails(channel.id, channel.name,
    //                   //,Remove this channel.description,
    //                   icon: "app_icon")));
    //     }
    //   });
    //   getToken();
    // }

    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MySize.size100(context),
        height: MySize.sizeh100(context),
        color: MyColors.white,
        child: Image.asset(
          "assets/logo/logo.png"
        ),
      ),
    );
  }

  // getToken() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   print("token");
  //   print(token);
  //   print("token");
  //   insertUserFCM(token!);
  // }

  // Future<void> insertUserFCM(String token) async {
  //   Map<String, dynamic> data = new Map();
  //   data['fcm'] = token;
  //
  //   print(data);
  //
  //   Response response = await APIService().insertUserFCM(data);
  //
  //   print("response.message");
  //   print(response.message);
  // }


  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    taketo();
  }

  Future<void> taketo() async {
    if (sharedPreferences.getString("status") == "logged in") {
      imei = await Device().setDeviceInfo();
      setState(() {

      });
      if(imei!=null) {
        checkPackage();
      }
      else {
        print("No Device Id");
      }
    }
    else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => const Login()),
                (Route<dynamic> route) => false);
    }

  }

  Future<void> checkPackage() async {
    if(Platform.isAndroid || Platform.isIOS) {
      Map<String, dynamic> data = {};
      data[APIConstant.act] = APIConstant.check;
      data['s_id'] = sharedPreferences.getString("s_id");
      data['date'] = DateFormat("yyyy-MM-dd").format(DateTime.now());
      data['hardware_id'] = imei;
      data['source'] = Platform.isAndroid ? 'ANDROID' : 'IOS';


      SubscriptionResponse subscriptionResponse = await APIService().checkSubscription(data);

      print(subscriptionResponse.toJson());

      if(subscriptionResponse.message=="Subscribed") {
        sharedPreferences.setString("sub_id", subscriptionResponse.id??"");
        if(sharedPreferences.getString("subscription")=="verified") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
                  (Route<dynamic> route) => false);
        }
        else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => VerifyCode()),
                  (Route<dynamic> route) => false);
        }
      }

      else if(subscriptionResponse.message=="Payment in process") {
        sharedPreferences.setString("subscription", "in process");
        Toast.sendToast(context, subscriptionResponse.message??"");
      }
      else {
        sharedPreferences.setString("subscription", "unsubscribed");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Packages()),
                (Route<dynamic> route) => false);
      }
    }
  }
}
