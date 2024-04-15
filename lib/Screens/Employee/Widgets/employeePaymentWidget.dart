import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeePaymentWidget extends StatefulWidget {
  bool absent;
  DateTime date;
  int index;
  int count;
  List<String> status;
  EmployeePaymentWidget(
      {super.key,
      required this.absent,
      required this.date,
      required this.index,
      required this.count,
      required this.status});

  @override
  State<EmployeePaymentWidget> createState() => _EmployeePaymentWidgetState();
}

class _EmployeePaymentWidgetState extends State<EmployeePaymentWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: widget.absent
                  ? Colors.red
                  : widget.status[widget.index] == 'Paid'
                      ? Colors.green.shade700
                      : Colors.yellow.shade700,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.status[widget.index],
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
                  color: widget.absent
                      ? Colors.red
                      : widget.status[widget.index] == 'Paid'
                          ? Colors.green.shade700
                          : Colors.yellow.shade700,
                  width: 2)),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical, //.horizontal
              child: Text(
                DateFormat("dd MMMM yy").format(widget.date),
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
