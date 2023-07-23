import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_app/config/theme.dart';
import 'package:selling_app/presentation/features/product/products_bloc.dart';

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
        body: BlocConsumer<ProductsBloc, ProductsState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: buildSearchBar(),
                  ),
                ),
              );
            },
            listener: (context, state) {}));
  }

  Container buildSearchBar() {
    return Container(
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
    );
  }

  void _searchButtonTapped() {
    BlocProvider.of<ProductsBloc>(context).add(
      SearchPressed(_searchController.text),
    );
  }
}
