import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../features/common/data/storage_repository.dart';

Future<StorageSource> getNativeStorageSource() async {
  var storage = await SharedPreferences.getInstance();
  if (!kIsWeb || !storage.containsKey('device-id')) {
    storage.setString('device-id', await getNativeDeviceId());
  }

  return SharedPreferencesStorageSource(storage);
}

Future<String> getNativeDeviceId() async {
  if (kIsWeb) {
    return const Uuid().v4();
  } else {
    if (Platform.isAndroid) {
      var androidId = const AndroidId();
      return (await androidId.getId()) ?? "";
    } else if (Platform.isIOS) {
      var deviceInfo = DeviceInfoPlugin();
      return (await deviceInfo.iosInfo).identifierForVendor ?? "";
    } else {
      return '';
    }
  }
}
