import 'package:flutter/material.dart';
import 'package:mobile_madamestore/models/Venda.dart';
import 'package:mobile_madamestore/models/ItemVenda.dart';
import 'package:mobile_madamestore/services/vendas_services.dart';
import 'package:mobile_madamestore/widgets/vendas_list.dart';
import 'package:mobile_madamestore/widgets/vendas_list_item.dart';

class VendasListScreen extends StatefulWidget {
  const VendasListScreen({Key? key}) : super(key: key);

  @override
  _VendasListScreenState createState() => _VendasListScreenState();
}

class _VendasListScreenState extends State<VendasListScreen> {
  VendasService vendasService = VendasService();

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
                  child: FutureBuilder<List>(
                    future: vendasService.getAll(),
                    builder: (context, snapshot) {
                      final List? vendas = snapshot.data;

                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.pinkAccent,),
                        );
                      }

                      if (vendas != null) {
                        return ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) {

                              List<Venda> vendasClass = [];
                              for (var venda in vendas) {
                                final Venda vendaObj = Venda.fromJson(venda);
                                vendasClass.add(vendaObj);
                              }
                              return VendasList(vendas: vendasClass);
                            });
                      }

                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }

                      return const Text('Nenhuma venda encontrada');
                    },
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
