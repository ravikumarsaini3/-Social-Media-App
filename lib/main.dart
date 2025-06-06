import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/api/api_service.dart';
import 'package:social_media_app/screens/home_screen.dart';
import 'package:social_media_app/screens/post_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Media App',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: HomeScreen(),
    );
  }
}
