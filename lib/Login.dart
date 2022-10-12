// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobifix/Device.dart';
import 'package:mobifix/HomeScreen.dart';
import 'package:mobifix/Register.dart';
import 'package:mobifix/Packages.dart';
import 'package:mobifix/VerifyCode.dart';
import 'package:mobifix/api/APIConstant.dart';
import 'package:mobifix/api/APIService.dart';
import 'package:mobifix/colors/MyColors.dart';
import 'package:mobifix/models/LoginResponse.dart';
import 'package:mobifix/models/Response.dart';
import 'package:mobifix/size/MySize.dart';
import 'package:mobifix/toast/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();

  bool add = true;

  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    start();
    super.initState();
  }

  start() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              children: [
                Image.asset(
                  "assets/logo/logo.png",
                  height: 250,
                  width: MySize.size100(context),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 80),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 35,
                      foreground: Paint()..shader = LinearGradient(
                        colors: <Color>[
                          MyColors.colorDarkPrimary,
                          MyColors.colorPrimary,
                          MyColors.colorLightPrimary,
                        ],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, MediaQuery.of(context).size.width, 100.0))
                    )
                  ),
                ),
                TextFormField(
                  controller: username,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    contentPadding: EdgeInsets.symmetric(horizontal: 10)
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "* Required";
                    }  else {
                      return null;
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    if(add) {
                      if (formkey.currentState!.validate()) {
                        login();
                      }
                    }
                  },
                  child: Container(
                    height: 45,
                    margin: const EdgeInsets.only(bottom: 25, left: 30, right: 30, top: 100),
                    width: MySize.size100(context),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                            MyColors.colorDarkPrimary,
                            MyColors.colorPrimary,
                            MyColors.colorLightPrimary
                          ]
                      ),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: add ? Text(
                      "LOGIN",
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 16
                      ),
                    )
                    : CircularProgressIndicator(
                      color: MyColors.white,
                    )
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account?\t",
                    style: TextStyle(
                      color: MyColors.colorDarkPrimary
                    ),
                    children: [
                      TextSpan(
                        text: "Register.",
                        style: TextStyle(
                          color: MyColors.colorPrimary
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register()
                            )
                          );
                        },
                      )
                    ]
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    add = false;
    setState(() {

    });

    Map<String, dynamic> data = {
      APIConstant.act: APIConstant.login,
      "username" : username.text,
      "date" : DateFormat("yyyy-MM-dd").format(DateTime.now()),
      "hardware_id" : await Device().setDeviceInfo(),
      "source" : Platform.isAndroid ? 'ANDROID' : 'IOS'
    };


    LoginResponse loginResponse = await APIService().login(data);


    if(loginResponse.message=="User does not exist") {
      Toast.sendToast(context, loginResponse.message??"");
    }
    else {
      sharedPreferences.setString("s_id", loginResponse.s_id??"");
      sharedPreferences.setString("status", "logged in");

      if(loginResponse.message=="Subscribed") {
        sharedPreferences.setString("subscription", "subscribed");
        sharedPreferences.setString("sub_id", loginResponse.id??"");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => const VerifyCode()),
                (Route<dynamic> route) => false);
      }
      else if(loginResponse.message=="Payment in process") {
        sharedPreferences.setString("subscription", "in process");
        Toast.sendToast(context, loginResponse.message??"");
      }
      else {
        sharedPreferences.setString("subscription", "unsubscribed");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => const Packages()),
                (Route<dynamic> route) => false);
      }
    }

    add = true;
    setState(() {

    });

  }
}
