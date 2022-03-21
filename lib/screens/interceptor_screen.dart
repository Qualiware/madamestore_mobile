import 'package:flutter/material.dart';
import 'package:mobile_madamestore/screens/login_screen.dart';
import 'package:mobile_madamestore/services/auth_services.dart';

import 'home_screen.dart';

class InterceptorScreen extends StatefulWidget {
  const InterceptorScreen({Key? key}) : super(key: key);

  @override
  _InterceptorScreenState createState() => _InterceptorScreenState();
}

class _InterceptorScreenState extends State<InterceptorScreen> {

  final authService = AuthService();


  @override
  void initState() {
    super.initState();
    authService.verifyToken().then((value) {
      if (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
