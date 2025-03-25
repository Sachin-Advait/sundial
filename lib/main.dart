import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('Hello, World!'))),
    ),
  );
}
