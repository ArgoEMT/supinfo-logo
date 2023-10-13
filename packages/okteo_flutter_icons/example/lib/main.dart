import 'package:flutter/material.dart';
import 'package:okteo_flutter_icons/model/okteo_icons.dart';
import 'package:okteo_flutter_icons/okteo_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Text('OkteoIcons', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              Wrap(
                children: [
                  for (var icon in OkteoIcons.wallIcons)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: OkteoIcon(icon, size: 36),
                    ),
                ],
              ),
              const SizedBox(height: 48),
              const Text('MaterialIcons', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              const Wrap(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: OkteoIcon(Icons.abc, size: 36),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: OkteoIcon(Icons.ac_unit, size: 36),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: OkteoIcon(Icons.access_alarm, size: 36),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: OkteoIcon(Icons.access_time, size: 36),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: OkteoIcon(Icons.access_time_filled, size: 36),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
