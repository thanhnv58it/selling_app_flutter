import 'package:selling_app/data/model/search_product.dart';

abstract class ProductRepository {
  /// Search product with [keyword] and return
  /// search result data as [SearchProduct]
  Future<SearchProduct> searchProduct({
    required String keyword,
  });

  Future<List<String>> getAllProductsCategories();

  Future<SearchProduct> getProductsByCategory({
    required String category,
  });
}
