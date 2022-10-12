import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobifix/Models.dart';
import 'package:mobifix/api/APIConstant.dart';
import 'package:mobifix/api/APIService.dart';
import 'package:mobifix/models/CompanyResponse.dart';
import 'package:mobifix/size/MySize.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Company> companies = [];
  bool load = false;

  @override
  void initState() {
    getCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: load ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Platform.isAndroid ? getAndroidDesign() : getIOSDesign()
              ],
            ),
          ),
        )
        : const Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }

  getAndroidDesign() {
    return ListView.separated(
      itemCount: companies.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext buildContext, int index) {
        return const Divider(
          thickness: 1,
        );
      },
      itemBuilder: (BuildContext buildContext, int index) {
        return getAndroidFolder(companies[index]);
      },
    );
  }

  getAndroidFolder(Company company) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Models(id: company.id??"")
            )
        );
      },
      child: Row(
        children: [
          Flexible(
            child: Row(
              children: [
                Image.asset(
                  "assets/home/folder.png",
                  height: 38,
                  width: 38,
                ),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (company.name??""),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        "${company.total??"0"} items",
                        style: const TextStyle(
                            fontSize: 12
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
          )
        ],
      ),
    );
  }

  getIOSDesign() {
    return GridView.builder(
      itemCount: companies.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: MySize.size40(context)
      ),
      itemBuilder: (BuildContext buildContext, int index) {
        return getIOSFolder(companies[index]);
      },
    );
  }

  getIOSFolder(Company company) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Models(id: company.id??"")
            )
        );
      },
      child: Column(
        children: [
          Image.asset(
            "assets/home/folder.png",
            height: MySize.size21(context),
            width: MySize.size21(context),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            company.name??"",
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 14
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "${company.total??"0"} items",
            style: const TextStyle(
                fontSize: 12
            ),
          )
        ],
      ),
    );
  }

  Future<void> getCompanies() async {
    Map<String, dynamic> data = {
      APIConstant.act: APIConstant.getAll,
    };

    CompanyResponse companyResponse = await APIService().getCompanies(data);

    companies = companyResponse.company ?? [];

    load = true;
    setState(() {

    });
  }
}
