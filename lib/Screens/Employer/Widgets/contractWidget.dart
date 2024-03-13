import 'package:employer_v1/Screens/Employer/contractDetailPage.dart';
import 'package:flutter/material.dart';

class ContractWidget extends StatelessWidget {
  Map<String, dynamic> contractDetails;
  ContractWidget({super.key, required this.contractDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ContractDetailPage(contractDetails: contractDetails)));
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
