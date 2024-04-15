import 'dart:developer';

import 'package:employer_v1/Screens/Construction%20head/headPaymentDetailPage.dart';
import 'package:employer_v1/Screens/Construction%20head/headPaymentPersonSelect.dart';
import 'package:employer_v1/Screens/Employee/employeePaymentDetailPage.dart';
import 'package:employer_v1/Screens/Employer/contractDetailPage.dart';
import 'package:employer_v1/Screens/Employer/employerPaymentDetailPage.dart';
import 'package:flutter/material.dart';

class HeadPaymentContractWidget extends StatelessWidget {
  Map<String, dynamic> contractDetails;
  HeadPaymentContractWidget({super.key, required this.contractDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HeadPaymentPersonSelectPage(
                        contractDetails: contractDetails)));
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
