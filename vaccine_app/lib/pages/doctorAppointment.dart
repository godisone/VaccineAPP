import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorAppointment extends ConsumerStatefulWidget {
  const DoctorAppointment({Key? key}) : super(key: key);

  @override
  _DoctorAppointmentState createState() => _DoctorAppointmentState();
}

class _DoctorAppointmentState extends ConsumerState<DoctorAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Doctor Appointment'),
        ),
        bottomNavigationBar: _checkoutButtonNavbar(),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Flexible(
              flex: 1,
              child: Center(
                child: Text(
                  "UNDER CONSTRUCTION",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        )));
  }
}

class _checkoutButtonNavbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SizedBox();
  }
}
