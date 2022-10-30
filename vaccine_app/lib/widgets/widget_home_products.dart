import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccine_app/components/product_cart.dart';
import 'package:vaccine_app/models/pagination.dart';
import 'package:vaccine_app/models/product_filter.dart';
import 'package:vaccine_app/providers.dart';
import '../models/product.dart';

class HomeProductWidget extends ConsumerWidget {
  const HomeProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List<Product> list = List<Product>.empty(growable: true);
    // list.add(Product(
    //   productName: "Codeines",
    //   category: Category(
    //       categoryName: "Analgesics",
    //       categoryImage: "/uploads/categories/1666029256017-analgesics.jpeg",
    //       categoryId: "634d96c8fc01a2c1506ad743"),
    //   productShortDescription:
    //       "CODEINE (KOE deen) is a pain reliever, also called an opioid. It is used to treat mild to moderate pain.",
    //   productPrice: 500,
    //   productSalePrice: 250,
    //   productImage: "/uploads/products/1666069059982--codeine.png",
    //   productSKU: "123",
    //   productType: "simple",
    //   stockStatus: "IN",
    //   productId: "634e32436cd1f22d21316a8b",
    // ));
    return Container(
      color: const Color(0xffF4F7FA),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 16, top: 15),
              child: Text(
                "Top 10 products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: _productsList(ref),
        )
      ]),
    );
  }

  Widget _productsList(WidgetRef ref) {
    final products = ref.watch(
      homeProductProvider(
        ProductFilterModel(
          paginationModel: PaginationModel(page: 1, pageSize: 10),
        ),
      ),
    );
    return products.when(
      data: (list) {
        return _buildProductList(list!);
      },
      error: (_, __) {
        return const Center(child: Text("ERR"));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return Container(
        height: 200,
        alignment: Alignment.centerLeft,
        child: ListView.builder(
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
            }));
  }
}
