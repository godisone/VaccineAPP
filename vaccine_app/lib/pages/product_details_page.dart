import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:vaccine_app/api/api_service.dart';
import 'package:vaccine_app/components/widget_col_exp.dart';
import 'package:vaccine_app/components/widget_custom_stepper.dart';
import 'package:vaccine_app/models/product.dart';
import 'package:vaccine_app/providers.dart';
import 'package:vaccine_app/widgets/widget_related_products.dart';

import '../config.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  int qty = 1;
  String productId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
      ),
      body: SingleChildScrollView(child: _productDetails(ref)),
    );
  }

  @override
  void didChangeDependencies() {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map;
    if (arguments != null) {
      productId = arguments["productId"];
      print(productId);
    }

    super.didChangeDependencies();
  }

  String getMyText(num value) {
    if (value != 0) {
      return "Add to Cart";
    } else {
      return "Out of stock";
    }
  }

  String isPresRequired(bool value) {
    if (value == true) {
      return "YES";
    } else {
      return "NO";
    }
  }

  String isPresListReq(bool value) {
    if (value == true) {
      return "List of pres : ";
    } else {
      return "";
    }
  }

  Color setColor(num value) {
    if (value != 0) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Currently Out of Stock'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  Widget _productDetails(WidgetRef ref) {
    final details = ref.watch(productDetailsProvider(productId));
    return details.when(
        data: (model) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _productDetailsUI(model!),
              RelatedProductsWidget(model.relatedProducts!),
              const SizedBox(
                height: 10,
              )
            ],
          );
        },
        error: (_, __) => const Center(child: Text("error")),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }

  Widget _productDetailsUI(Product model) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                model.fullImagePath,
                fit: BoxFit.fitHeight,
              ),
            ),
            Text(
              model.productName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      (model.calculateDiscount > 0)
                          ? "${Config.currency}${model.productPrice.toString()}"
                          : "",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        color: model.calculateDiscount > 0
                            ? Colors.red
                            : Colors.black,
                        decoration: model.productSalePrice > 0
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    Text(
                      (model.calculateDiscount > 0)
                          ? " ${Config.currency}${model.productSalePrice.toString()}"
                          : "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Text(
                      "SHARE",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    label: const Icon(
                      Icons.share,
                      color: Colors.black,
                      size: 20,
                    ))
              ],
            ),
            Text(
              "QTY Available: ${model.qtyAvailable}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "Availability: ${model.stockStatus}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Prescription Required: ${isPresRequired(model.isPresReq!)}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Center(
              child: (model.isPresReq!)
                  ? TextButton(
                      onPressed: () async {
                        print("button pressed");
                        APIService.pickimagefromgallery();
                      },
                      child: const Text(
                        "Upload Prescription",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ))
                  : null,
            ),
            Center(
              child: (model.isPresReq! && APIService.getImage(1) != null)
                  ? ObxValue((RxString rxString) {
                      return Container(
                          // height: MediaQuery.of(context).size.width,
                          // width: MediaQuery.of(context).size.width,
                          height: 100,
                          width: 100,
                          color: Colors.teal,
                          child: rxString.value.isEmpty
                              ? null
                              : Image.network(
                                  rxString.value,
                                  fit: BoxFit.contain,
                                ));
                    }, APIService.picture)
                  : null,
            ),
            //const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: (model.isPresReq! && APIService.getImage(1) != null)
                  ? Text(
                      isPresListReq(model.isPresReq!),
                      style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )
                  : null,
            ),
            //const Spacer(),
            ObxValue((RxList rxList) {
              return SizedBox(
                child: rxList.isEmpty
                    ? null
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: rxList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            leading: Text(
                              "${index + 1}.",
                              style: const TextStyle(fontSize: 16),
                            ),
                            title: Text(
                              rxList[index],
                              style: const TextStyle(fontSize: 16),
                            ),
                            onTap: () {
                              APIService.getImage(index);
                            },
                          );
                        }),
              );
            }, APIService.idList),

            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                "Product Code: ${model.productSKU}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomStepper(
                  lowerLimit: model.qtyAvailable! > 0 ? 1 : 0,
                  upperLimit: model.qtyAvailable as int,
                  stepValue: model.qtyAvailable! > 0 ? 1 : 0,
                  iconSize: 22.0,
                  value: qty,
                  onChanged: (value) {
                    qty = value["qty"];
                  },
                ),
                TextButton.icon(
                  onPressed: () {
                    if (model.qtyAvailable != 0) {
                      final cartViewModel =
                          ref.read(cartItemsProvider.notifier);
                      cartViewModel.addCartItems(model.productId, qty);
                    } else {
                      _showToast(context);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        setColor(model.qtyAvailable as num)),
                  ),
                  icon: const Icon(
                    Icons.shopping_basket,
                    color: Colors.white,
                  ),
                  label: Text(
                    getMyText(model.qtyAvailable as num),
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ColExpand(
              title: "SHORT DESCRIPTION",
              content: model.productShortDescription,
            )
          ],
        ));
  }
}
