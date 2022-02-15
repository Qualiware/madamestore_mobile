import 'package:flutter/material.dart';

class VendasListItem extends StatefulWidget {
  const VendasListItem({Key? key}) : super(key: key);

  @override
  _VendasListItemState createState() => _VendasListItemState();
}

class _VendasListItemState extends State<VendasListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Text(
                      'Julio Cesar',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'R\$ 200,00',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  'Finalizada',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Detalhes'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent,
                ),
              )
            ],
          ),
        ));
  }
}
