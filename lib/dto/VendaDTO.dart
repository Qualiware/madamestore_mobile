import 'dart:convert';

import 'package:mobile_madamestore/models/ItemVenda.dart';
import 'package:mobile_madamestore/models/Produto.dart';

class VendaDTO {
  final int idCliente;
  final double valorTotal;
  final List<Produto> itemVendaList;
  final DateTime dataVenda;

  VendaDTO(
      {required this.dataVenda,
        required this.idCliente,
        required this.valorTotal,
        required this.itemVendaList,
      });

  Map<String, dynamic> toJson(List<String> produtos) => {

    'idCLiente': idCliente,
    'valorTotal': valorTotal,
    'itemVenda': produtos,
    'dataVenda': dataVenda.toString(),
  };
}
