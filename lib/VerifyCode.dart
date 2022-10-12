import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobifix/Device.dart';
import 'package:mobifix/HomeScreen.dart';
import 'package:mobifix/api/APIConstant.dart';
import 'package:mobifix/api/APIService.dart';
import 'package:mobifix/colors/MyColors.dart';
import 'package:mobifix/models/Response.dart';
import 'package:mobifix/size/MySize.dart';
import 'package:mobifix/toast/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({Key? key}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController code = TextEditingController();

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Code Verification",
                        style: TextStyle(
                            fontSize: 30,
                            color: MyColors.black
                          // foreground: Paint()..shader = LinearGradient(
                          //   colors: <Color>[
                          //     MyColors.colorDarkPrimary,
                          //     MyColors.colorPrimary,
                          //     MyColors.colorLightPrimary,
                          //   ],
                          // ).createShader(Rect.fromLTWH(0.0, 0.0, MediaQuery.of(context).size.width, 100.0))
                        )
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if(value.isNotEmpty) {
                        code.text = value.toUpperCase();
                        code.selection = TextSelection.fromPosition(TextPosition(offset: code.text.length));
                      }
                    },
                    controller: code,
                    maxLength: 16,
                    keyboardType: TextInputType.name,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    ],
                    decoration: const InputDecoration(
                        labelText: "Activation Code",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10)
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "* Required";
                      }
                      else if (value!.length<16) {
                        return "* Inavlid Code";
                      }
                      else {
                        return null;
                      }
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      if(add) {
                        if (formkey.currentState!.validate()) {
                          verifyCode();
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
                          "VERIFY",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  verifyCode() async {
    add = false;
    setState(() {

    });

    Map<String, dynamic> data = {
      APIConstant.act: APIConstant.verifyCode,
      "id" : sharedPreferences.getString("sub_id"),
      "hardware_id" : await Device().setDeviceInfo(),
      "source" : Platform.isAndroid ? 'ANDROID' : 'IOS',
      "code" : code.text
    };


    Response response = await APIService().verifyCode(data);


    if(response.message=="Verified User") {
      sharedPreferences.setString("subscription", "verified");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()),
              (Route<dynamic> route) => false);
    }
    else {
      Toast.sendToast(context, response.message??"");
    }

    add = true;
    setState(() {

    });

  }
}
