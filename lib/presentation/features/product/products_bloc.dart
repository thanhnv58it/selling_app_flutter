import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selling_app/data/model/search_product.dart';
import 'package:selling_app/data/repositories/abstract/product_repository.dart';
import 'package:selling_app/data/repositories/abstract/user_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository productRepository;

  ProductsBloc({required this.productRepository}) : super(ProductInitial()) {
    on<SearchPressed>(searchPressed);
  }

  Future<void> searchPressed(
      SearchPressed event, Emitter<ProductsState> emit) async {
    emit(SearchingProducts());
    try {
      var result =
          await productRepository.searchProduct(keyword: event.keyword);
      emit(SearchedProducts(result));
    } catch (error) {
      emit(SearchingProductsError(error.toString()));
    }
  }
}
