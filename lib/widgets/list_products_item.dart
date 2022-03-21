import 'package:flutter/material.dart';
import 'package:mobile_madamestore/models/Produto.dart';

class ListProductsItem extends StatefulWidget {
  ListProductsItem(
      {Key? key, required this.produto, required this.removeProductFromList})
      : super(key: key);

  final Produto produto;
  final Function(Produto) removeProductFromList;

  @override
  _ListProductsItemState createState() => _ListProductsItemState();
}

class _ListProductsItemState extends State<ListProductsItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text('${widget.produto.nome} -\b\b\b\b\b\b\b\b${widget.produto.quantidadeAdd}      -     R\$${getValorProdutoAdd()}'),
                  Spacer(),
                  Ink(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(),
                      color: Colors.pinkAccent,
                    ),
                    child: IconButton(
                      onPressed: () {
                        widget.removeProductFromList(widget.produto);
                      },
                      icon: Icon(
                        Icons.clear,
                      ),
                      highlightColor: Colors.pinkAccent,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double getValorProdutoAdd() {
    return widget.produto.preco * widget.produto.quantidadeAdd;
  }
}
