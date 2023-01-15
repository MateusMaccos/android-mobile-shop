import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.PRODUCT_FORM,
                    arguments: product,
                  );
                },
                icon: const Icon(Icons.edit),
                color: Theme.of(context).primaryColor),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: const Text('Excluir Produto.'),
                            content: const Text('Tem certeza?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop(false);
                                  },
                                  child: const Text('Não')),
                              TextButton(
                                  onPressed: () => Navigator.of(ctx).pop(true),
                                  child: const Text('Sim')),
                            ],
                          )).then((value) async {
                    if (value ?? false) {
                      try {
                        Provider.of<ProductList>(
                          context,
                          listen: false,
                        ).removeProduct(product);
                      } on HttpException catch (error) {
                        msg.showSnackBar(
                            SnackBar(content: Text(error.toString())));
                      }
                    }
                  });
                },
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor)
          ],
        ),
      ),
    );
  }
}
