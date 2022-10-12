import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobifix/Device.dart';
import 'package:mobifix/VerifyCode.dart';
import 'package:mobifix/api/APIConstant.dart';
import 'package:mobifix/api/APIService.dart';
import 'package:mobifix/colors/MyColors.dart';
import 'package:mobifix/models/LoginResponse.dart';
import 'package:mobifix/models/PackageResponse.dart';
import 'package:mobifix/models/Response.dart';
import 'package:mobifix/models/SubscriptionResponse.dart';
import 'package:mobifix/toast/Toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Packages extends StatefulWidget {
  const Packages({Key? key}) : super(key: key);

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {

  List<Package> packages = [];
  late SharedPreferences sharedPreferences;
  bool load = false;

  @override
  void initState() {
    start();
    super.initState();
  }

  Future<void> start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    getPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: load ?
      SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                 Center(
                   child: Text(
                    "Subscription Packages",
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
                ListView.separated(
                  itemCount: packages.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext buildContext, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (BuildContext buildContext, int index) {
                    return getPackageCard(packages[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      )
      : const Center(
        child: CircularProgressIndicator(),
      )
    );
  }


  Widget getPackageCard(Package package) {
    return GestureDetector(
      onTap: () {
        addSubscription(package);
      },
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                MyColors.colorDarkPrimary,
                MyColors.colorPrimary,
                MyColors.colorLightPrimary
              ]
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              package.name??"",
              style: TextStyle(
                color: MyColors.white,
                fontSize: 24
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              package.description??"",
              style: TextStyle(
                  color: MyColors.white,
                  fontSize: 18
              ),
            ),
          ],
        ),
      ),
    );
  }

  getPackages() async {
    Map<String, dynamic> data = {
      APIConstant.act: APIConstant.getAll,
    };

    PackageResponse packageResponse = await APIService().getPackages(data);

    packages = packageResponse.package ?? [];

    load = true;
    setState(() {

    });
  }

  Future<void> addSubscription(Package package) async {
    DateTime date = DateTime.now();
    Map<String, dynamic> data = {
      APIConstant.act: APIConstant.add,
      "s_id" : sharedPreferences.getString("s_id"),
      "p_id" : package.id,
      "start_date" : DateFormat("yyyy-MM-dd").format(date),
      "end_date" : DateFormat("yyyy-MM-dd").format(DateTime(date.year, date.month+int.parse(package.tenure??"0"), date.day)),
      "hardware_id" : await Device().setDeviceInfo(),
      "source" : Platform.isAndroid ? 'ANDROID' : 'IOS',
      "payment" : package.price??"0"
    };

    print(data);

    SubscriptionResponse subscriptionResponse = await APIService().addSubscription(data);

    print(subscriptionResponse.toJson());

    if(subscriptionResponse.status=="Success") {
      sharedPreferences.setString("subscription", "subscribed");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => const VerifyCode()),
              (Route<dynamic> route) => false);
    }


    Toast.sendToast(context, subscriptionResponse.message??"");
  }
}
