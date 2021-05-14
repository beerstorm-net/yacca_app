import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class CommonUtils {
  // TODO: isDebug is a manual switch, but it must come from isPhysicalDevice
  static final isDebug = true;
  static final Logger logger = Logger(
    level: isDebug ? Level.debug : Level.warning,
    printer: PrettyPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: false, // Print an emoji for each log message
        printTime: true // Should each log print contain a timestamp
        ),
  );

  static String nullSafe(String source) {
    return (source == null || source.isEmpty || source == "null") ? "" : source;
  }

  static String nullSafeSnap(dynamic source) {
    return source != null ? nullSafe(source as String) : "";
  }

  static String generateUuid() {
    var uuid = Uuid();
    return uuid.v5(Uuid.NAMESPACE_URL, 'beerstorm.net');
  }

  static String getFormattedDate({DateTime date}) {
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(date ?? DateTime.now());
  }

  static Future<Map<String, dynamic>> parseJsonFromAssets(
      String filePath) async {
    return rootBundle
        .loadString(filePath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static Future<bool> isPhysicalDevice({String devicePlatform}) async {
    if (nullSafe(devicePlatform).isEmpty) {
      devicePlatform = await getDevicePlatform();
    }
    if (devicePlatform?.toLowerCase() == "ios") {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      return iosDeviceInfo.isPhysicalDevice;
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      return androidDeviceInfo.isPhysicalDevice;
    }
  }

  static Future<String> getDevicePlatform() async {
    String devicePlatform = "";

    if (Platform.isIOS) {
      devicePlatform = "ios";
    } else if (Platform.isMacOS) {
      devicePlatform = "macos";
    } else if (Platform.isAndroid) {
      devicePlatform = "android";
    }
    return devicePlatform;
  }
  /*static Future<String> getDevicePlatform() async {
    try {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      if (iosDeviceInfo != null) {
        CommonUtils.logger.d('iOS device!');
        return "ios";
      }
    } catch (_) {
      CommonUtils.logger.d('ANDROID device!');
      return "android";
    }
    return "android"; // default
  }*/
}
