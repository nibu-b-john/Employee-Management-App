import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeAttendanceWidget extends StatelessWidget {
  bool absent;
  DateTime date;
  EmployeeAttendanceWidget(
      {super.key, required this.absent, required this.date});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: absent ? Colors.red : Colors.green.shade700,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  absent ? 'Absent' : 'Present',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16),
                )
              ],
            )),
        Container(
          width: double.infinity,
          height: 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: absent ? Colors.red : Colors.green.shade700,
                  width: 2)),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical, //.horizontal
              child: Text(
                DateFormat("dd MMMM yy").format(date),
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
