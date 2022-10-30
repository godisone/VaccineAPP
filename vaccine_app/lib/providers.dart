import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccine_app/application/notifier/cart_notifier.dart';
import 'package:vaccine_app/application/notifier/product_filter_notifier.dart';
import 'package:vaccine_app/application/notifier/products_notifier.dart';
import 'package:vaccine_app/application/state/cart_state.dart';
import 'package:vaccine_app/application/state/product_state.dart';
import 'package:vaccine_app/models/product.dart';

import '../api/api_service.dart';
import '../models/category.dart';
import '../models/pagination.dart';
import 'models/product_filter.dart';

final categoriesProvider =
    FutureProvider.family<List<Category>?, PaginationModel>(
  (ref, paginationModel) {
    final apiRepository = ref.watch(apiService);

    return apiRepository.getCategories(
      paginationModel.page,
      paginationModel.pageSize,
    );
  },
);

final homeProductProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
  (ref, productFilterModel) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getProducts(productFilterModel);
  },
);

final productsFilterProvider =
    StateNotifierProvider<ProductFilterNotfier, ProductFilterModel>(
  (ref) => ProductFilterNotfier(),
);

final productsNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductsState>(
  (ref) => ProductNotifier(
    ref.watch(apiService),
    ref.watch(productsFilterProvider),
  ),
);

final productDetailsProvider = FutureProvider.family<Product?, String>(
  (ref, productId) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getProductDetails(productId);
  },
);

final relatedProductsProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
        (ref, productFilterModel) {
  final apiRepository = ref.watch(apiService);
  return apiRepository.getProducts(productFilterModel);
});

final cartItemsProvider = StateNotifierProvider<CartNotifier, CartState>(
  (ref) => CartNotifier(
    ref.watch(apiService),
  ),
);
