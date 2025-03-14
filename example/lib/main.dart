import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quantum/bindings.dart';
import 'package:quantum/database/database.dart';
import 'package:quantum/filesystem/file.dart';
import 'package:quantum/quantum.dart' as quantum;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await quantum.Quantum.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(children: [
            SizedBox(
              child: Text('Running on: $_platformVersion\n'),
            ),
            SizedBox(
                child: TextButton(
                    child: const Text('nativeAdd'),
                    onPressed: () async {
                      var quantumFFI = FFIBindings();
                      var sum = quantumFFI.nativeAdd(3, 8);
                      debugPrint("quantumNativeAdd: $sum");
                    })),
            SizedBox(
                child: TextButton(
                    child: const Text('chooseFiles'),
                    onPressed: () async {
                      var files = await QMFileModel.chooseFiles();
                      debugPrint("chooseFiles $files");
                    })),
            SizedBox(
                child: TextButton(
                    child: const Text('getHostLanguage'),
                    onPressed: () async {
                      var files = await quantum.Quantum.getHostLanguage();
                      debugPrint("getHostLanguage $files");
                    })),
            SizedBox(
                child: TextButton(
                    child: const Text('sqliteVersion'),
                    onPressed: () async {
                      var files = await QMSqliteClient.sqliteVersion();
                      debugPrint("sqliteVersion $files");
                    })),
            SizedBox(
                child: TextButton(
                    child: const Text('sqliteSelectNames'),
                    onPressed: () async {
                      await sqliteSelectNames();
                    }))
          ])),
    );
  }
}
