part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends ProductsEvent {}

class FetchProductsEvent extends ProductsEvent {}

class CategorySelectedEvent extends ProductsEvent {
  final String category;

  const CategorySelectedEvent(this.category);

  @override
  List<Object> get props => [category];
}

class SearchPressed extends ProductsEvent {
  final String keyword;

  const SearchPressed(this.keyword);

  @override
  List<Object> get props => [keyword];
}
