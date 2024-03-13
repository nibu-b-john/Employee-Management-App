import 'package:flutter/material.dart';

class EmployeeAttendanceWidget extends StatelessWidget {
  int number;
  EmployeeAttendanceWidget({super.key, required this.number});

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
              'Employee $number',
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
