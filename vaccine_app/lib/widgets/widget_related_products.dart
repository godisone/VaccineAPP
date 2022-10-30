import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccine_app/components/product_cart.dart';
import 'package:vaccine_app/models/pagination.dart';
import 'package:vaccine_app/models/product_filter.dart';
import 'package:vaccine_app/providers.dart';

import '../models/product.dart';

class RelatedProductsWidget extends ConsumerWidget {
  const RelatedProductsWidget(this.relatedProducts, {Key? key})
      : super(key: key);
  final List<String> relatedProducts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        child: Column(
      children: [
        const Text(
          "Related Products",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Visibility(
          visible: relatedProducts.isNotEmpty,
          child: _productList(ref),
        )
      ],
    ));
  }

  Widget _productList(WidgetRef ref) {
    final products = ref.watch(
      relatedProductsProvider(
        ProductFilterModel(
          paginationModel: PaginationModel(page: 1, pageSize: 10),
          productIds: relatedProducts,
        ),
      ),
    );
    return products.when(
        data: (list) {
          return _buildProductList(list!);
        },
        error: (_, __) => const Center(
              child: Text("Error"),
            ),
        loading: () => const Center(child: CircularProgressIndicator()));
  }

  Widget _buildProductList(List<Product> products) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var data = products[index];
          return GestureDetector(
            onTap: () {},
            child: ProductCard(
              model: data,
            ),
          );
        },
      ),
    );
  }
}
