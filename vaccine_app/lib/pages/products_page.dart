// ignore_for_file: library_private_types_in_public_api

// ignore: implementation_imports
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccine_app/api/api_service.dart';
import 'package:vaccine_app/components/product_cart.dart';
import 'package:vaccine_app/models/pagination.dart';
import 'package:vaccine_app/models/product_filter.dart';
import 'package:vaccine_app/models/product_sort.dart';
import 'package:vaccine_app/providers.dart';

import '../models/product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductsPage> {
  String? categoryId;
  String? categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              tooltip: 'Search Medicines',
              icon: const Icon(Icons.search),
              onPressed: () async {
                [
                  // showSearch(
                  //     context: context,
                  //     delegate: _ProductList());
                ];
              },
            ),
          ),
        ],
      ),
      body: Container(
          color: Colors.grey[300],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProductFilters(
                categoryId: categoryId,
                categoryName: categoryName,
              ),
              Flexible(
                flex: 1,
                child: _ProductList(),
              )
            ],
          )),
    );
  }

  @override
  void didChangeDependencies() {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments != null) {
      categoryName = arguments['categoryName'];
      categoryId = arguments['categoryId'];
    }

    super.didChangeDependencies();
  }
}

class _ProductFilters extends ConsumerWidget {
  final _sortByOptions = [
    ProductSortModel(value: "createdAt", label: "Latest"),
    ProductSortModel(value: "-productPrice", label: "Price: High To Low"),
    ProductSortModel(value: "productPrice", label: "Price : Low To High"),
  ];

  _ProductFilters({
    Key? key,
    this.categoryName,
    this.categoryId,
  });

  final String? categoryName;
  final String? categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterProvider = ref.watch(productsFilterProvider);
    return Container(
      height: 51,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              categoryName!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Container(
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: PopupMenuButton(
                onSelected: (sortBy) {
                  ProductFilterModel filterModel = ProductFilterModel(
                      paginationModel: PaginationModel(page: 0, pageSize: 10),
                      categoryId: filterProvider.categoryId,
                      sortBy: sortBy.toString());

                  ref
                      .read(productsFilterProvider.notifier)
                      .setProductFilter(filterModel);

                  ref.read(productsNotifierProvider.notifier).getProducts();
                },
                initialValue: filterProvider.sortBy,
                itemBuilder: (BuildContext context) {
                  return _sortByOptions.map((item) {
                    return PopupMenuItem(
                      value: item.value,
                      child: InkWell(
                        child: Text(item.label!),
                      ),
                    );
                  }).toList();
                },
                icon: const Icon(Icons.filter_list_alt),
              ))
        ],
      ),
    );
  }
}

class _ProductList extends ConsumerWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productsNotifierProvider);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final productsViewModel = ref.read(productsNotifierProvider.notifier);
        final productState = ref.watch(productsNotifierProvider);

        if (productState.hasNext) {
          productsViewModel.getProducts();
        }
      }
    });

    if (productState.products.isEmpty) {
      if (!productState.hasNext && !productState.isLoading) {
        return const Center(child: Text("No Products"));
      }
      return const LinearProgressIndicator();
    }

    return RefreshIndicator(
        onRefresh: () async {
          ref.read(productsNotifierProvider.notifier).refreshProducts();
        },
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: GridView.count(
                crossAxisCount: 2,
                controller: _scrollController,
                children: List.generate(productState.products.length, (index) {
                  return ProductCard(
                    model: productState.products[index],
                  );
                }),
              ),
            ),
            Visibility(
              visible:
                  productState.isLoading && productState.products.isNotEmpty,
              child: const SizedBox(
                height: 35,
                width: 35,
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ));
  }
}
