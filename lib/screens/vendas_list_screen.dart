import 'package:flutter/material.dart';
import 'package:mobile_madamestore/widgets/vendas_list_item.dart';

class VendasListScreen extends StatefulWidget {
  const VendasListScreen({Key? key}) : super(key: key);

  @override
  _VendasListScreenState createState() => _VendasListScreenState();
}

class _VendasListScreenState extends State<VendasListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Vendas',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: const [
                      VendasListItem(),
                      VendasListItem(),
                      VendasListItem(),
                      VendasListItem(),
                      VendasListItem(),
                      VendasListItem(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
