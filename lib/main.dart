import 'package:flutter/material.dart';
import 'package:mobile_madamestore/screens/login_screen.dart';
import 'package:mobile_madamestore/screens/interceptor_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MadameSore',
      theme: ThemeData(
        primaryColor: Colors.pinkAccent
      ),
      debugShowCheckedModeBanner: false,
      home: InterceptorScreen(),
    );
  }
}
