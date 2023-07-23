part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductsState {}

class SearchingProducts extends ProductsState {}

class SearchedProducts extends ProductsState {
  final SearchProduct result;

  const SearchedProducts(this.result);

  @override
  List<Object> get props => [result];
}

class SearchingProductsError extends ProductsState {
  final String error;

  const SearchingProductsError(this.error);

  @override
  List<Object> get props => [error];
}
