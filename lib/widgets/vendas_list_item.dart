import 'package:flutter/material.dart';
import 'package:mobile_madamestore/models/Venda.dart';
import 'package:mobile_madamestore/screens/details_screen.dart';

class VendasListItem extends StatefulWidget {
  VendasListItem({Key? key, required this.venda}) : super(key: key);

  final Venda venda;

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
                  children: [
                    Text(
                      widget.venda.nomeCliente,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'R\$ ${widget.venda.valorTotal}',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: statusText(),
              ),
            ],
          ),
        ));
  }

  Text statusText() {
    Text text;
    if (widget.venda.statusPendente) {
      text = Text(
        'Pendente',
        style: TextStyle(
          color: Colors.pinkAccent,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );
    } else {
      text = Text(
        'Finalizada',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );
    }

    return text;
  }
}
