import 'package:flutter/material.dart';
import 'package:mobile_madamestore/screens/home_screen.dart';
import 'package:mobile_madamestore/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.store_mall_directory,
                    color: Colors.pinkAccent,
                    size: 160,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                      hintText: 'E-mail',
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pinkAccent,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 5,
                        right: 30,
                        bottom: 30,
                        top: 30,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    controller: _emailController,
                    validator: validateEmail,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.password_outlined,
                        color: Colors.white,
                      ),
                      hintText: 'Senha',
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pinkAccent,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 5,
                        right: 30,
                        bottom: 30,
                        top: 30,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    controller: _passwordController,
                    validator: validatePassword,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (_formKey.currentState!.validate()) {
                        bool ok = await loginButton();
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if (ok) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        } else {
                          _passwordController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent,
                      padding: EdgeInsets.all(16),
                    ),
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final snackBar = SnackBar(
    content: Text(
      'E-mail ou senha são inválidos',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.pinkAccent,
      ),
    ),
  );

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Por favor, digite seu e-mail';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
      return 'Por favor, digite um e-mail correto';
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.length < 4) {
      return 'Por favor, digite sua senha';
    } else if (password.length < 4) {
      return 'Por favor, digite uma senha válida';
    }

    return null;
  }

  Future<bool> loginButton() async {
    return await authService.login(
        _emailController.text, _passwordController.text);
  }
}
