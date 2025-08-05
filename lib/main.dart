// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:latihan_api/pages/post/list_post_screen.dart';
import 'package:latihan_api/pages/quran/list_quran_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListQuranScreen(),
      ),
    );
  }
}
