import 'package:flutter/material.dart';
import 'package:mobile_madamestore/screens/interceptor_screen.dart';
import 'package:mobile_madamestore/services/auth_services.dart';

class OptionsScreen extends StatefulWidget {
  OptionsScreen({Key? key}) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person,
                color: Colors.pinkAccent,
                size: 160,
              ),
              FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  var user = snapshot.data as Map;

                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.pinkAccent,
                      ),
                    );
                  }

                  if (user != null) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Nome: ${user['nome']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Email: ${user['email']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    );
                  }
                  return const Text('nada');
                },
              ),
              SizedBox(
                height: 200,
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.symmetric(vertical: 330),
                          title: Text('Sair'),
                          content: Column(
                            children: [
                              Text('Tem certeza que deseja sair?'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancelar'),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.grey
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      authService.clearAccesToken()
                                          .whenComplete(() =>
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InterceptorScreen(),))
                                      );
                                    },
                                    child: Text('Sair'),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.redAccent
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }
                  );
                },
                style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                child: Text('Sair'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Map> getUser() async {
    var userInformation = await authService.getUserInformation();

    return userInformation;
  }
}
