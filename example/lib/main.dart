import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:batterylevel/batterylevel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _batteryLevel = 'Unknown';
  int _result = -1;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Batterylevel.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> getBatteryLevel() async {
    String batteryLevel;
    int result;
    try {
      batteryLevel = await Batterylevel.getBatteryLevel;
      result = await Batterylevel.getResult(2, 3);
    } on PlatformException {
      batteryLevel = 'Failed to get batteryLevel .';
      result = -1;
    }

    setState(() {
      _result = result;
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        floatingActionButton: IconButton(icon: Icon(Icons.refresh), onPressed: getBatteryLevel),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              Text('_batteryLevel:$_batteryLevel'),
              Text('result 2 + 3:$_result'),
            ],
          ),
        ),
      ),
    );
  }
}
