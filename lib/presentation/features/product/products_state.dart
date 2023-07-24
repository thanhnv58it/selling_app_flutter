part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ApiInitial extends ProductsState {}

class CategoriesLoaded extends ProductsState {
  final List<String> categories;
  final String selectedCategory;

  const CategoriesLoaded(this.categories, this.selectedCategory);

  @override
  List<Object> get props => [categories, selectedCategory];
}

class ProductsByCategoryLoaded extends ProductsState {
  final List<String> categories;
  final String selectedCategory;
  final List<Product> products;

  const ProductsByCategoryLoaded(
      this.selectedCategory, this.categories, this.products);

  @override
  List<Object> get props => [products, categories, selectedCategory];
}

class SearchingProducts extends ProductsState {}

class SearchedProducts extends ProductsState {
  final SearchProduct result;

  const SearchedProducts(this.result);

  @override
  List<Object> get props => [result];
}

class LoadDataError extends ProductsState {
  final String error;

  const LoadDataError(this.error);

  @override
  List<Object> get props => [error];
}
