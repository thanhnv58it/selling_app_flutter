part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class SearchPressed extends ProductsEvent {
  final String keyword;

  const SearchPressed(this.keyword);

  @override
  List<Object> get props => [keyword];
}
