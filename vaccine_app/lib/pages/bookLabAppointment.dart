import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LabAppointment extends ConsumerStatefulWidget {
  const LabAppointment({Key? key}) : super(key: key);

  @override
  _LabAppointmentState createState() => _LabAppointmentState();
}

class _LabAppointmentState extends ConsumerState<LabAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Lab Appointment'),
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
