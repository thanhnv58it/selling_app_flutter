import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_app/config/theme.dart';
import 'package:selling_app/data/model/product.dart';
import 'package:selling_app/data/repositories/utils.dart';
import 'package:selling_app/presentation/features/product/products_bloc.dart';
import 'package:selling_app/presentation/widgets/data_driven/product_list_view.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _searchController = TextEditingController();
  bool showClearButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocConsumer<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ApiInitial) {
                  return buildApiLoadingView();
                } else if (state is CategoriesLoaded) {
                  return buildCategoriesLoaded(state);
                } else if (state is ProductsByCategoryLoaded) {
                  return buildProductsByCategoryLoaded(state);
                } else if (state is SearchingProducts) {
                  return buildApiLoadingView();
                } else if (state is SearchedProducts) {
                  List<Product> products = state.result.products;
                  return Column(
                    children: [
                      buildSearchBar(),
                      buildProductListView(products)
                    ],
                  );
                } else {
                  return Text("unimplemented state ${state}");
                }
              },
              listener: (context, state) {}),
        ));
  }

  Column buildApiLoadingView() {
    return Column(
      children: [
        buildSearchBar(),
        const SizedBox(height: 16.0),
        const CircularProgressIndicator()
      ],
    );
  }

  Expanded buildProductListView(List<Product> products) {
    return Expanded(
      child: ProductListView(
        products: products,
        onFavoritesTap: (product) => {},
        showProductInfo: (product) => {},
      ),
    );
  }

  Column buildProductsByCategoryLoaded(ProductsByCategoryLoaded state) {
    final List<String> categories = state.categories;
    return Column(
      children: [
        buildSearchBar(),
        buildCategoriesView(categories, state.selectedCategory),
        buildColectionHeader(),
        buildProductListView(state.products)
      ],
    );
  }

  Widget buildColectionHeader() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
        child: Row(
          children: [
            Text("New collection",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            TextButton(
                onPressed: () => {},
                child: Text('ALL',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)))
          ],
        ));
  }

  Column buildCategoriesLoaded(CategoriesLoaded state) {
    final List<String> categories = state.categories;
    return Column(
      children: [
        buildSearchBar(),
        buildCategoriesView(categories, state.selectedCategory)
      ],
    );
  }

  SizedBox buildCategoriesView(
      List<String> categories, String selectedCategory) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () => _handleCategoryTap(category),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Chip(
                backgroundColor: category == selectedCategory
                    ? AppColors.black
                    : AppColors.white,
                label: Text(
                  category.capitalize(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: category == selectedCategory
                          ? AppColors.white
                          : AppColors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: TextField(
          controller: _searchController,
          onChanged: (value) => {
            setState(
              () {
                showClearButton = value.isNotEmpty;
              },
            )
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            hintText: 'Search',
            // Add a clear button to the search bar
            suffixIcon: showClearButton
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  )
                : null,
            // Add a search icon or button to the search bar
            prefixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: _searchButtonTapped,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  void _searchButtonTapped() {
    BlocProvider.of<ProductsBloc>(context).add(
      SearchPressed(_searchController.text),
    );
  }

  void _handleCategoryTap(String category) {
    BlocProvider.of<ProductsBloc>(context).add(CategorySelectedEvent(category));
  }
}
