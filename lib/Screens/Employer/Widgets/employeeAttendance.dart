import 'package:flutter/material.dart';

class EmployeeAttendanceWidget extends StatelessWidget {
  String employee;
  EmployeeAttendanceWidget({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Center(
            child: Text(
              employee,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
