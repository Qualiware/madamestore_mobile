class ItemVenda {
  final int id;
  final int idVenda;
  final int idProduto;
  final String nomeProduto;
  final double preco;
  final int quantidade;
  final int quantidadeVendida;
  final double vLiquido;

  ItemVenda({
    required this.id,
    required this.idVenda,
    required this.idProduto,
    required this.nomeProduto,
    required this.preco,
    required this.quantidade,
    required this.quantidadeVendida,
    required this.vLiquido,
  });

  factory ItemVenda.fromJson(Map<String, dynamic> json) {
    return ItemVenda(
      id: int.parse(json['id']),
      idVenda: int.parse(json['idVenda']),
      idProduto: int.parse(json['idProduto']),
      nomeProduto: json['nomeProduto'],
      preco: json['preco'].toDouble(),
      quantidade: int.parse(json['quantidade']),
      quantidadeVendida: int.parse(json['quantidadeVendida']),
      vLiquido: double.parse(json['vliquido']),
    );
  }
}
