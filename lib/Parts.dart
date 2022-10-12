import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobifix/api/APIConstant.dart';
import 'package:mobifix/api/APIService.dart';
import 'package:mobifix/models/PartResponse.dart';
import 'package:mobifix/size/MySize.dart';

class Parts extends StatefulWidget {
  final String id;
  const Parts({Key? key, required this.id}) : super(key: key);

  @override
  State<Parts> createState() => _PartsState();
}

class _PartsState extends State<Parts> {

  List<Part> parts = [];
  bool load = false;

  @override
  void initState() {
    getParts();
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
      itemCount: parts.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext buildContext, int index) {
        return const Divider(
          thickness: 1,
        );
      },
      itemBuilder: (BuildContext buildContext, int index) {
        return getAndroidFolder(parts[index]);
      },
    );
  }

  getAndroidFolder(Part part) {
    return GestureDetector(
      onTap: () {
        
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
                        (part.name??""),
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
                        "${part.total??"0"} items",
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
      itemCount: parts.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: MySize.size40(context)
      ),
      itemBuilder: (BuildContext buildContext, int index) {
        return getIOSFolder(parts[index]);
      },
    );
  }

  getIOSFolder(Part part) {
    return GestureDetector(
      onTap: () {

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
            part.name??"",
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
            "${part.total??"0"} items",
            style: const TextStyle(
                fontSize: 12
            ),
          )
        ],
      ),
    );
  }
  
  Future<void> getParts() async {
    Map<String, dynamic> data = {
      APIConstant.act: APIConstant.getAll,
      "id" : widget.id
    };

    PartResponse partResponse = await APIService().getParts(data);

    parts = partResponse.part ?? [];

    load = true;
    setState(() {

    });
  }

}
