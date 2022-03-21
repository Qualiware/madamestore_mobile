import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mobile_madamestore/dto/VendaDTO.dart';
import 'package:mobile_madamestore/models/Cliente.dart';
import 'package:mobile_madamestore/models/Produto.dart';
import 'package:mobile_madamestore/screens/home_screen.dart';
import 'package:mobile_madamestore/services/clients_service.dart';
import 'package:mobile_madamestore/services/products_service.dart';
import 'package:mobile_madamestore/services/vendas_services.dart';
import 'package:mobile_madamestore/widgets/list_products_item.dart';

class VendasFormScreen extends StatefulWidget {
  const VendasFormScreen({Key? key}) : super(key: key);

  @override
  State<VendasFormScreen> createState() => _VendasFormScreenState();
}

class _VendasFormScreenState extends State<VendasFormScreen> {
  final clients = ['Julio Cesar', 'Caio Martins', 'Lucas Serafim'];
  String? valueClient;
  String? valueProduct;

  List<Cliente> clientesList = [];
  List<Produto> produtosList = [];

  List<Produto> cart = [];

  ClientsService clientsService = ClientsService();
  ProductsService productsService = ProductsService();
  VendasService vendasService = VendasService();

  DateTime date = DateTime.now();
  double valorTotal = 0.00;

  final TextEditingController quantidadeController =
      TextEditingController(text: '1');
  int quantidade = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Cadastro de venda',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              DateFormat('dd/MM/yyyy').format(date),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () => pickDate(context),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: FutureBuilder<List>(
                      future: clientsService.getAll(),
                      builder: (context, snapshot) {
                        final List? clientsA = snapshot.data;

                        if (clientsA != null) {
                          List<Cliente> clientesClass = [];
                          for (var client in clientsA) {
                            final Cliente clientObj = Cliente.fromJson(client);
                            clientesClass.add(clientObj);
                          }

                          clientesList = clientesClass;
                          List<String> clientNameList = [];
                          for (Cliente client in clientesList) {
                            clientNameList.add(client.nome);
                          }

                          return DropdownButton(
                            value: valueClient,
                            isExpanded: true,
                            hint: Text('Cliente'),
                            items: clientNameList.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(
                                () => this.valueClient = value as String?),
                          );
                        }

                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }

                        return const Text('Nenhum cliente encontrado');
                      },
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: FutureBuilder<List>(
                        future: productsService.getAll(),
                        builder: (context, snapshot) {
                          final List? productsA = snapshot.data;

                          if (productsA != null) {
                            List<Produto> produtosClass = [];
                            for (var product in productsA) {
                              final Produto productObj =
                                  Produto.fromJson(product);
                              produtosClass.add(productObj);
                            }

                            produtosList = produtosClass;
                            List<String> productNameList = [];
                            for (Produto produto in produtosList) {
                              productNameList.add(produto.nome);
                            }

                            return DropdownButton(
                              value: valueProduct,
                              isExpanded: true,
                              hint: Text('Produto'),
                              items:
                                  productNameList.map(buildMenuItem).toList(),
                              onChanged: (value) => setState(
                                  () => this.valueProduct = value as String?),
                            );
                          }

                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }

                          return const Text('Nenhum produto encontrado');
                        },
                      ),
                    ),
                    Expanded(
                      child: minAndPlusButton(),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                      ),
                      onPressed: () {
                        Produto produtoAdd = getProdutoByName(valueProduct);
                        if (produtoAdd.quantidade >= quantidade) {
                          produtoAdd.quantidadeAdd = quantidade;
                          setState(() {
                            cart.add(produtoAdd);
                            valorTotal +=
                                (produtoAdd.quantidadeAdd * produtoAdd.preco);
                          });
                        }
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: ListView(
                    shrinkWrap: true,
                    children: listProductsItem(),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'TOTAL: ',
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'R\$ ${valorTotal}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pinkAccent,
                  ),
                  onPressed: () async {
                    Cliente clienteToSave = getClienteByName(valueClient);
                    VendaDTO vendaToSave = VendaDTO(
                      dataVenda: date,
                      idCliente: clienteToSave.id,
                      valorTotal: valorTotal,
                      itemVendaList: cart,
                    );

                    // TO DO SAVE VENDA
                    await vendasService.postVenda(vendaToSave);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                  },
                  child: Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.pinkAccent,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    if (newDate == null) return;

    setState(() {
      date = newDate;
    });
  }

  ShapeDecoration buttonDecoration = ShapeDecoration(
    shape: CircleBorder(),
    color: Colors.pinkAccent,
  );

  Widget minAndPlusButton() {
    Widget minsButton = Ink(
      decoration: buttonDecoration,
      child: IconButton(
        onPressed: () {
          if (quantidade > 1) {
            --quantidade;
            quantidadeController.text = quantidade.toString();
          }
        },
        icon: Icon(
          Icons.remove,
        ),
        highlightColor: Colors.pinkAccent,
      ),
    );

    Widget plusButton = Ink(
      decoration: buttonDecoration,
      child: IconButton(
        onPressed: () {
          ++quantidade;
          quantidadeController.text = quantidade.toString();
        },
        icon: Icon(
          Icons.add,
        ),
        highlightColor: Colors.pinkAccent,
      ),
    );

    Widget quantidadeText = TextField(
      controller: quantidadeController,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
    );

    Widget minAndPlus = Row(
      children: [minsButton, Expanded(child: quantidadeText), plusButton],
    );

    return minAndPlus;
  }

  Produto getProdutoByName(String? nome) {
    Produto produtoReturn;
    for (Produto produto in produtosList) {
      if (produto.nome == nome) {
        produtoReturn = produto;
        return produtoReturn;
      }
    }

    return produtosList[0];
  }

  Cliente getClienteByName(String? nome) {
    Cliente clienteReturn;
    for (Cliente cliente in clientesList) {
      if (cliente.nome == nome) {
        clienteReturn = cliente;
        return clienteReturn;
      }
    }

    return clientesList[0];
  }

  List<ListProductsItem> listProductsItem() {
    List<ListProductsItem> listListProductsItem = [];

    for (Produto produto in cart) {
      ListProductsItem listProductsItem = ListProductsItem(
        produto: produto,
        removeProductFromList: removeProductFromList,
      );
      listListProductsItem.add(listProductsItem);
    }

    return listListProductsItem;
  }

  void removeProductFromList(Produto produto) {
    setState(() {
      cart.remove(produto);

      valorTotal -= (produto.quantidadeAdd * produto.preco);
    });
  }
}
