
class Produto {
  final int id;
  final String nome;
  final int idTipoProduto;
  final int idVenda;
  final String nomeTipoProduto;
  final double preco;
  final int quantidade;
  final int vliquido;
  final String descricao;
  final int quantidadeVendida;
  final DateTime dataCadastro;
  late final int quantidadeAdd;

  Produto(
      {required this.id,
        required this.nome,
        required this.idTipoProduto,
        required this.idVenda,
        required this.nomeTipoProduto,
        required this.preco,
        required this.quantidade,
        required this.vliquido,
        required this.descricao,
        required this.quantidadeVendida,
        required this.dataCadastro,
      });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      nome: json['nome'],
      idTipoProduto: json['idTipoProduto'],
      idVenda: json['idVenda'],
      nomeTipoProduto: json['nomeTipoProduto'],
      preco: json['preco'],
      quantidade: json['quantidade'],
      vliquido: json['vliquido'],
      descricao: json['descricao'],
      quantidadeVendida: json['quantidadeVendida'],
      dataCadastro: DateTime.parse(json['dataCadastro']),
    );
  }

  Map<String, dynamic> toJson() => {
    'idProduto': id,
    'nomeProduto': nome,
    'preco': preco,
    'quantidadeVendida': quantidadeAdd,
    'valorTotal': 0,
  };
}
