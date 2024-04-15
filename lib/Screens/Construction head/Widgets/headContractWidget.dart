import 'package:employer_v1/Screens/Construction%20head/headContractsDetailPage.dart';
import 'package:employer_v1/Screens/Employer/contractDetailPage.dart';
import 'package:flutter/material.dart';

class HeadContractWidget extends StatelessWidget {
  Map<String, dynamic> contractDetails;
  HeadContractWidget({super.key, required this.contractDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HeadContractDetailPage(
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
