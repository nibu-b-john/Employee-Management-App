import 'dart:developer';

import 'package:employer_v1/Screens/Employee/employeePaymentDetailPage.dart';
import 'package:employer_v1/Screens/Employer/contractDetailPage.dart';
import 'package:employer_v1/Screens/Employer/employerPaymentDetailPage.dart';
import 'package:flutter/material.dart';

class EmployeePaymentContractWidget extends StatelessWidget {
  Map<String, dynamic> contractDetails;
  String email;
  EmployeePaymentContractWidget(
      {super.key, required this.contractDetails, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EmployeePaymentDetailPage(
                        email: email, contractDetails: contractDetails)));
          },
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                border: Border.all(color: Colors.white, width: 2)),
            child: Center(
              child: Text(
                contractDetails['Contract-Name'],
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
