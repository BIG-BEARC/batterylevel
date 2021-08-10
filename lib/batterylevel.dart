import 'dart:async';

import 'package:flutter/services.dart';

class Batterylevel {
  static const MethodChannel _channel = const MethodChannel('Native_service');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get getBatteryLevel async {
    final String batteryLevel = await _channel.invokeMethod('getBatteryLevel');
    return batteryLevel;
  }

  static Future<int> getResult(int a, int b) async {
    Map<String, dynamic> argument = {"a": a, "b": b};
    final int result = await _channel.invokeMethod("getResult", argument);
    return result;
  }
}
