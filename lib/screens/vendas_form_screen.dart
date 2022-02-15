import 'package:flutter/material.dart';

class VendasFormScreen extends StatefulWidget {
  const VendasFormScreen({Key? key}) : super(key: key);

  @override
  State<VendasFormScreen> createState() => _VendasFormScreenState();
}

class _VendasFormScreenState extends State<VendasFormScreen> {
  final clients = ['Julio Cesar', 'Caio Martins', 'Lucas Serafim'];
  String? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Cadastro de venda',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  value: value,
                  isExpanded: true,
                  hint: Text('Cliente'),
                  items: clients.map(buildMenuItem).toList(),
                  onChanged: (value) =>
                      setState(() => this.value = value as String?),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pinkAccent,
                  ),
                  onPressed: () {},
                  child: Text('Salvar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );
}
