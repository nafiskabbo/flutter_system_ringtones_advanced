import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_system_ringtones_advanced/flutter_system_ringtones_advanced.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Ringtone> ringtones = [];

  @override
  void initState() {
    super.initState();
    getRingtones();
  }

  Future<void> getRingtones() async {
    try {
      final temp = await FlutterSystemRingtones.getRingtoneSounds();
      if (!mounted) return;
      setState(() {
        ringtones = temp;
      });
    } on PlatformException {
      debugPrint('Failed to load ringtones.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: ringtones.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(ringtones[index].title),
                subtitle: Text(ringtones[index].uri),
              );
            },
          ),
        ),
      ),
    );
  }
}
