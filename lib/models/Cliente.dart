
class Cliente {
  final int id;
  final String nome;
  final String email;
  final String telefone;
  final DateTime dataCadastro;
  final int quantidade;

  Cliente(
      {required this.id,
        required this.nome,
        required this.email,
        required this.telefone,
        required this.dataCadastro,
        required this.quantidade,
        });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone'],
      dataCadastro: DateTime.parse(json['dataCadastro']),
      quantidade: json['quantidade'],
    );
  }
}
