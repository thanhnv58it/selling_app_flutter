// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchProduct _$SearchProductFromJson(Map<String, dynamic> json) =>
    SearchProduct(
      json['total'] as int,
      json['skip'] as int,
      json['limit'] as int,
      (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchProductToJson(SearchProduct instance) =>
    <String, dynamic>{
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
      'products': instance.products,
    };
