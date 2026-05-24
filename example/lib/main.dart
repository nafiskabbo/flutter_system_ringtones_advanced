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
  String? errorMessage;

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
        errorMessage = null;
      });
    } on PlatformException catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            if (!FlutterSystemRingtones.isSupported)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'System ringtone listing is only supported on Android. '
                  'On iOS this example shows an empty list.',
                ),
              ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
