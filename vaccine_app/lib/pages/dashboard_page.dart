import 'package:flutter/material.dart';
import 'package:vaccine_app/pages/bookLabAppointment.dart';
import 'package:vaccine_app/pages/cart_page.dart';
import 'package:vaccine_app/pages/home_page.dart';

import 'doctorAppointment.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Widget> widgetList = const [
    HomePage(),
    const CartPage(),
    HomePage(),
    HomePage(),
    DoctorAppointment(),
    LabAppointment(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: index,
        onTap: (_index) {
          setState(() {
            index = _index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: "Store"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: "My Account"),
          BottomNavigationBarItem(
              icon: Icon(Icons.app_registration),
              label: "Book Doctot Appointment"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: "Book Lab Appointment"),
        ],
      ),
      body: widgetList[index],
    );
  }
}
