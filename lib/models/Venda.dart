import 'package:mobile_madamestore/models/ItemVenda.dart';

class Venda {
  final int id;
  final int idCliente;
  final String nomeCliente;
  final double valorTotal;
  final List<ItemVenda> itemVendaList; // tipar
  final bool statusPendente;
  final bool statusVendido;
  final DateTime dataVenda;

  Venda(
      {required this.dataVenda,
      required this.statusPendente,
      required this.statusVendido,
      required this.id,
      required this.idCliente,
      required this.nomeCliente,
      required this.valorTotal,
      required this.itemVendaList});

  factory Venda.fromJson(Map<String, dynamic> json) {
    var itemList = json['itemVenda'];

    List<ItemVenda> itens = [];

    for (var itemVenda in itemList) {
      ItemVenda item = ItemVenda.fromJson(itemVenda);

      itens.add(item);
    }

    return Venda(
      id: json['id'],
      idCliente: json['idCliente'],
      nomeCliente: json['nomeCliente'],
      statusPendente: json['statusEspera'],
      statusVendido: json['statusVendido'],
      valorTotal: double.parse(json['valorTotal']),
      dataVenda: DateTime.parse(json['dataVenda']),
      itemVendaList: itens,
    );
  }
}
