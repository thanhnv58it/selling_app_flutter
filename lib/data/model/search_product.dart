import 'package:json_annotation/json_annotation.dart';
import 'package:selling_app/data/model/product.dart';

part 'search_product.g.dart';

@JsonSerializable()
class SearchProduct {
  final int total;
  final int skip;
  final int limit;
  final List<Product> products;

  SearchProduct(this.total, this.skip, this.limit, this.products);

  factory SearchProduct.fromJson(Map<String, dynamic> json) =>
      _$SearchProductFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SearchProductToJson(this);
}
