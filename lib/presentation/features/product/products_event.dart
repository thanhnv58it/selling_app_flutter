part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchDataEvent extends ProductsEvent {}

class CategorySelectedEvent extends ProductsEvent {
  final String category;

  const CategorySelectedEvent(this.category);

  @override
  List<Object> get props => [category];
}

class SearchPressedEvent extends ProductsEvent {
  final String keyword;

  const SearchPressedEvent(this.keyword);

  @override
  List<Object> get props => [keyword];
}

class ClearSearchQueryEvent extends ProductsEvent {}
