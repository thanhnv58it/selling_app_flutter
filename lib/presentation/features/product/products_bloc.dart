import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selling_app/data/model/product.dart';
import 'package:selling_app/data/model/search_product.dart';
import 'package:selling_app/data/repositories/abstract/product_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository productRepository;

  String _selectedCategory = "";
  List<String> _categories = [];
  List<Product> _products = [];

  ProductsBloc({required this.productRepository}) : super(ApiInitial()) {
    on<FetchDataEvent>(fetchCatagories);
    on<CategorySelectedEvent>(onCategorySelectedEvent);
    on<SearchPressedEvent>(searchPressed);
    on<ClearSearchQueryEvent>(clearSearchQuery);
  }

  Future<void> fetchCatagories(
      FetchDataEvent event, Emitter<ProductsState> emit) async {
    emit(ApiInitial());
    try {
      var result = await productRepository.getAllProductsCategories();
      _categories = result;
      _selectedCategory = result.first;
      emit(CategoriesLoaded(result, _selectedCategory));
      await fetchProductsByCatagory(event, emit);
    } catch (error) {
      emit(LoadDataError(error.toString()));
    }
  }

  Future<void> fetchProductsByCatagory(
      FetchDataEvent event, Emitter<ProductsState> emit) async {
    try {
      var result = await productRepository.getProductsByCategory(
          category: _selectedCategory);
      _products = result.products;
      emit(ProductsByCategoryLoaded(_selectedCategory, _categories, _products));
    } catch (error) {
      emit(LoadDataError(error.toString()));
    }
  }

  Future<void> onCategorySelectedEvent(
      CategorySelectedEvent event, Emitter<ProductsState> emit) async {
    try {
      _selectedCategory = event.category;
      emit(CategoriesLoaded(_categories, _selectedCategory));
      var result = await productRepository.getProductsByCategory(
          category: _selectedCategory);
      _products = result.products;
      emit(ProductsByCategoryLoaded(_selectedCategory, _categories, _products));
    } catch (error) {
      emit(LoadDataError(error.toString()));
    }
  }

  Future<void> searchPressed(
      SearchPressedEvent event, Emitter<ProductsState> emit) async {
    emit(ApiInitial());
    try {
      var result =
          await productRepository.searchProduct(keyword: event.keyword);
      emit(SearchedProducts(result));
    } catch (error) {
      emit(LoadDataError(error.toString()));
    }
  }

  Future<void> clearSearchQuery(
      ClearSearchQueryEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsByCategoryLoaded(_selectedCategory, _categories, _products));
  }
}
