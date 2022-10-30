import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccine_app/api/api_service.dart';
import 'package:vaccine_app/models/cart_product.dart';

import '../state/cart_state.dart';

class CartNotifier extends StateNotifier<CartState> {
  final APIService _apiService;

  CartNotifier(this._apiService) : super(const CartState()) {
    getCartItems();
  }

  Future<void> getCartItems() async {
    state = state.copyWith(isLoading: true);
    final cartData = await _apiService.getCart();
    state = state.copyWith(cartModel: cartData);
    state = state.copyWith(isLoading: false);
  }

  Future<void> addCartItems(productId, qty) async {
    await _apiService.addCartItem(productId, qty);
    await getCartItems();
  }

  Future<void> removeCartItem(productId, qty) async {
    await _apiService.removeCartItem(productId, qty);
    var isCartItemExists = state.cartModel!.products
        .firstWhere((element) => element.product.productId == productId);

    var updatedItems = state.cartModel!;
    updatedItems.products.remove(isCartItemExists);
    state = state.copyWith(cartModel: updatedItems);
  }

  Future<void> updateQty(productId, qty, type) async {
    var cartItems = state.cartModel!.products
        .firstWhere((element) => element.product.productId == productId);

    var updatedItems = state.cartModel!;

    if (type == "-") {
      await _apiService.removeCartItem(productId, 1);

      if (cartItems.qty > 1) {
        CartProduct cartProduct = CartProduct(
          qty: cartItems.qty - 1,
          product: cartItems.product,
        );

        updatedItems.products.remove(cartItems);
        updatedItems.products.add(cartProduct);
      } else {
        updatedItems.products.remove(cartItems);
      }
    } else {
      await _apiService.addCartItem(productId, 1);

      CartProduct cartProduct =
          CartProduct(qty: cartItems.qty + 1, product: cartItems.product);

      updatedItems.products.remove(cartItems);
      updatedItems.products.add(cartProduct);
    }
    state = state.copyWith(cartModel: updatedItems);
  }
}
