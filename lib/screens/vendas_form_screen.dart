import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_madamestore/services/vendas_services.dart';

class VendasFormScreen extends StatefulWidget {
  const VendasFormScreen({Key? key}) : super(key: key);

  @override
  State<VendasFormScreen> createState() => _VendasFormScreenState();
}

class _VendasFormScreenState extends State<VendasFormScreen> {
  final clients = ['Julio Cesar', 'Caio Martins', 'Lucas Serafim'];
  String? value;

  VendasService vendasService = VendasService();

  DateTime date = DateTime.now();
  double valorTotal = 200.00;

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
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              DateFormat('dd/MM/yyyy').format(date),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () => pickDate(context),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: DropdownButton(
                        value: value,
                        isExpanded: true,
                        hint: Text('Cliente'),
                        items: clients.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => this.value = value as String?),
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Text('Valor Total: R\$ $valorTotal'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pinkAccent,
                  ),
                  onPressed: () {
                    vendasService.getAll();
                  },
                  child: Text('Salvar'),
                ),

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

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.pinkAccent,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    if (newDate == null) return;

    setState(() {
      date = newDate;
    });
  }
}
