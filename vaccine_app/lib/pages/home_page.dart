import 'package:flutter/material.dart';
import 'package:vaccine_app/widgets/widget_home_categories.dart';
import 'package:vaccine_app/widgets/widget_home_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          HomeCategoriesWidget(),
          HomeProductWidget(),

          // ProductCard(
          //   model: model,
          // )
        ],
      ),
    );
  }
}
