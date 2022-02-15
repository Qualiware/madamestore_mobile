import 'package:flutter/material.dart';

import 'package:mobile_madamestore/screens/vendas_form_screen.dart';
import 'package:mobile_madamestore/screens/vendas_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final screens = [
    VendasListScreen(),
    VendasFormScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MadameStore'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.pinkAccent,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Vendas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Adicionar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Opções',
          ),
        ],
      ),
    );
  }
}
