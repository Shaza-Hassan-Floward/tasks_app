import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class DeviceInfoService {
  static const _channel = MethodChannel('native/battery');

  Future<String> getBatteryStatus() async {
    try {
      final int level = await _channel.invokeMethod('getBatteryLevel');

      if (level == -1) {
        return 'Battery unavailable';
      }
      return '$level%';
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());

      }
      return 'Error reading battery';
    }
  }
}