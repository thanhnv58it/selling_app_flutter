import 'package:flutter/material.dart';
import 'package:selling_app/config/theme.dart';
import 'package:selling_app/data/model/product.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products;
  final Function(Product product) onFavoritesTap;
  final Function(Product product) showProductInfo;

  const ProductListView(
      {super.key,
      required this.products,
      required this.onFavoritesTap,
      required this.showProductInfo});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        childAspectRatio: 0.63,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: products
            .map((product) => getProductView(
                context: context,
                product: product,
                showProductInfo: (() => {showProductInfo(product)}),
                onFavoritesClick: (() => {onFavoritesTap(product)})))
            .toList(growable: false));
  }

  Widget getProductView(
      {required BuildContext context,
      required Product product,
      required VoidCallback showProductInfo,
      required VoidCallback onFavoritesClick}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    product.thumbnail,
                    fit: BoxFit.cover,
                  )),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: AppColors.background,
                            shape: BoxShape.circle),
                        child: const Icon(
                          Icons.favorite_outline,
                          size: 20,
                        ))),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        Text('\$ ${product.price.toString()}',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
