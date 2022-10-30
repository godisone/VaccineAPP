import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vaccine_app/pages/dashboard_page.dart';
import 'package:vaccine_app/pages/home_page.dart';
import 'package:vaccine_app/pages/login_page.dart';
import 'package:vaccine_app/pages/product_details_page.dart';
import 'package:vaccine_app/pages/products_page.dart';
import 'package:vaccine_app/pages/register_page.dart';
import 'package:vaccine_app/utils/shared_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Widget _defaultHome = const LoginPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get result of the login function.
  bool result = await SharedService.isLoggedIn();

  if (result) {
    _defaultHome = const DashboardPage();
  }
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        navigatorKey: navigatorKey,
        //home: const RegisterPage(),
        routes: <String, WidgetBuilder>{
          '/': (context) => _defaultHome,
          '/login': (BuildContext context) => const LoginPage(),
          '/home': (BuildContext context) => const HomePage(),
          '/register': (BuildContext context) => const RegisterPage(),
          '/products': (BuildContext context) => const ProductsPage(),
          '/product-details': (BuildContext context) =>
              const ProductDetailsPage(),
        });
  }
}
