import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mobile_madamestore/models/Venda.dart';
import 'package:mobile_madamestore/services/vendas_services.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.vendaId}) : super(key: key);

  final int vendaId;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  VendasService vendasService = VendasService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MadameStore'),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Detalhes da venda',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              FutureBuilder(
                  future: vendasService.getVendaById(widget.vendaId),
                  builder: (context, snapshot) {
                    final vendaSnap = snapshot.data;

                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.pinkAccent,),
                      );
                    }

                    if (vendaSnap != null) {
                      //final Venda venda = Venda.fromJson(vendaSnap);
                      return Text('Venda achada');
                    }

                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    return const Text('Venda não encontrada');

                  }
              ),
            ],
          ),
        ));
  }


  Widget vendaDetails(Venda venda) {
    return Container(
      child: Column(
        children: [
          Text('nada'),
        ],
      ),
    );
  }
}
