import 'package:freezed_annotation/freezed_annotation.dart';

import 'cart_product.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';

@freezed
abstract class Cart with _$Cart {
  factory Cart({
    required String userId,
    required List<CartProduct> products,
    required String cartId,
  }) = _Cart;
  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}

extension CartExt on Cart {
  double get grandTotal {
    double total =
        products.map((e) => e.product.productPrice).fold(0, (p, d) => p + d);
    print(total);
    return total;
  }
}
