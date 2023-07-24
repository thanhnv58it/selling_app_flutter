import 'dart:convert';

import 'package:selling_app/data/model/search_product.dart';
import 'package:selling_app/data/repositories/abstract/product_repository.dart';
import 'package:http/http.dart' as http;
import 'package:selling_app/config/server_addresses.dart';
import 'utils.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<SearchProduct> searchProduct({required String keyword}) async {
    var route =
        HttpClient().createUri(ServerAddresses.searchPath, {'q': keyword});

    var response = await http.get(route);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (response.statusCode != 200) {
      throw jsonResponse['message'];
    }
    return SearchProduct.fromJson(jsonResponse);
  }

  @override
  Future<List<String>> getAllProductsCategories() async {
    var route = HttpClient().createUri(ServerAddresses.categoriesPath);
    var response = await http.get(route);
    List<dynamic> list = json.decode(response.body);
    List<String> categoriesList = List<String>.from(list);
    return categoriesList;
  }

  @override
  Future<SearchProduct> getProductsByCategory(
      {required String category}) async {
    var route = HttpClient()
        .createUri(ServerAddresses.getProductsByCategoryPath(category));

    var response = await http.get(route);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (response.statusCode != 200) {
      throw jsonResponse['message'];
    }
    return SearchProduct.fromJson(jsonResponse);
  }
}
