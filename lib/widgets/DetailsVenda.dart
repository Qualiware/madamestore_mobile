import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_madamestore/models/ItemVenda.dart';
import 'package:mobile_madamestore/models/Venda.dart';

class DetailsVenda extends StatefulWidget {
  const DetailsVenda({Key? key, required this.venda}) : super(key: key);

  final Venda venda;

  @override
  _DetailsVendaState createState() => _DetailsVendaState();
}

class _DetailsVendaState extends State<DetailsVenda> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                'Data: ${DateFormat('dd/MM/yyyy').format(widget.venda.dataVenda)}'),
            SizedBox(
              height: 20,
            ),
            Text(
              'Produtos',
              style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            produtoList(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'TOTAL: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'R\$ ${widget.venda.valorTotal.toString()}',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('Finalizar'),
            )
          ],
        ),
      ),
    );
  }

  Widget produtoList() {
    List<TableRow> listProdutos = [
      buildRow(['Nome', 'Quantidade', 'Valor'], isHeader: true),
    ];

    for (ItemVenda produto in widget.venda.itemVendaList) {
      final valorVenda = produto.preco * produto.quantidadeVendida;
      final List<String> produtoInfo = [
        produto.nomeProduto,
        produto.quantidadeVendida.toString(),
        valorVenda.toString(),
      ];
      final TableRow row = buildRow(produtoInfo);

      listProdutos.add(row);
    }

    Widget table = Table(border: TableBorder.all(), children: listProdutos);
    return table;
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
          children: cells.map((cell) {
        final style = TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal);
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(
              cell,
              style: style,
            ),
          ),
        );
      }).toList());
}
