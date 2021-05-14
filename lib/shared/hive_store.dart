import 'dart:convert';

import 'package:hive/hive.dart';

class HiveStore {
  String _boxName;
  Box _hiveBox;
  //static initHiveBox(boxName) => await Hive.openBox(boxName);
  HiveStore({boxName = "appBox", Box hiveBox})
      : _boxName = boxName,
        _hiveBox = hiveBox; //initHiveBox(boxName);

  String get boxName => _boxName;
  Box get hiveBox => _hiveBox;

  read(String key) {
    if (!contains(key)) {
      return null;
    }
    String value = _hiveBox.get(key) as String;
    if (value.contains("{")) {
      return json.decode(value);
    } else {
      return value;
    }
  }

  save(String key, dynamic value) {
    if (value is String && !value.contains("{")) {
      _hiveBox.put(key, value);
    } else {
      _hiveBox.put(key, json.encode(value));
    }
  }

  contains(String key) {
    return _hiveBox.containsKey(key);
  }

  remove(String key) {
    _hiveBox.delete(key);
  }

  clear() {
    _hiveBox.clear();
  }

  // --- reusable methods for ease of access ---
  bool isIOSPlatform() {
    return _hiveBox.get("DEVICEPLATFORM") == "ios";
  }

  bool isAndroidPlatform() {
    return _hiveBox.get("DEVICEPLATFORM") == "android";
  }

  bool isPhysicalDevice() {
    return _hiveBox.get("IS_PHYSICAL_DEVICE") == "true";
  }
}
