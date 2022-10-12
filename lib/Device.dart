import 'dart:io';

import 'package:device_information/device_information.dart';
import 'package:permission_handler/permission_handler.dart';

class Device {

  Future<String?> setDeviceInfo() async {
    if(Platform.isAndroid || Platform.isIOS) {
      if (await Permission.phone.request().isGranted) {
        String imei = await DeviceInformation.deviceIMEINumber;
        return imei;
      }
      else {
        print("not granted");
        return null;
      }
    }
    else {
      return null;
    }
  }
}