import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobifix/Parts.dart';
import 'package:mobifix/api/APIConstant.dart';
import 'package:mobifix/api/APIService.dart';
import 'package:mobifix/models/ModelResponse.dart';
import 'package:mobifix/size/MySize.dart';

class Models extends StatefulWidget {
  final String id;
  const Models({Key? key, required this.id}) : super(key: key);

  @override
  State<Models> createState() => _ModelsState();
}

class _ModelsState extends State<Models> {

  List<Model> models = [];
  bool load = false;

  @override
  void initState() {
    getModels();
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
      itemCount: models.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext buildContext, int index) {
        return const Divider(
          thickness: 1,
        );
      },
      itemBuilder: (BuildContext buildContext, int index) {
        return getAndroidFolder(models[index]);
      },
    );
  }

  getAndroidFolder(Model model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Parts(id: model.id??"")
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
                        (model.name??""),
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
                        "${model.total??"0"} items",
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
      itemCount: models.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: MySize.size40(context)
      ),
      itemBuilder: (BuildContext buildContext, int index) {
        return getIOSFolder(models[index]);
      },
    );
  }

  getIOSFolder(Model model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Parts(id: model.id??"")
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
            model.name??"",
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
            "${model.total??"0"} items",
            style: const TextStyle(
                fontSize: 12
            ),
          )
        ],
      ),
    );
  }
  
  Future<void> getModels() async {
    Map<String, dynamic> data = {
      APIConstant.act: APIConstant.getAll,
      "id" : widget.id
    };

    ModelResponse modelResponse = await APIService().getModels(data);

    models = modelResponse.model ?? [];

    load = true;
    setState(() {

    });
  }

}
