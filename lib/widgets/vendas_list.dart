import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_madamestore/models/Item.dart';
import 'package:mobile_madamestore/models/Venda.dart';
import 'package:mobile_madamestore/widgets/DetailsVenda.dart';
import 'package:mobile_madamestore/widgets/vendas_list_item.dart';

class VendasList extends StatefulWidget {
  const VendasList({Key? key, required this.vendas}) : super(key: key);

  final List vendas;

  @override
  _VendasListState createState() => _VendasListState();
}

class _VendasListState extends State<VendasList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList.radio(
        children: widget.vendas
            .map<ExpansionPanel>((venda) => ExpansionPanelRadio(
                  headerBuilder: (context, isExpanded) =>
                      VendasListItem(venda: venda),
                  body: DetailsVenda(
                    venda: venda,
                  ),
                  value: venda.id,
                ))
            .toList(),
      ),
    );
  }
}
