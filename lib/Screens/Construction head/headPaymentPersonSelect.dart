import 'package:employer_v1/Screens/Construction%20head/headPaymentDetailPage.dart';
import 'package:employer_v1/Screens/Employer/orderConfirm.dart';
import 'package:flutter/material.dart';

class HeadPaymentPersonSelectPage extends StatefulWidget {
  Map<String, dynamic> contractDetails;
  HeadPaymentPersonSelectPage({super.key, required this.contractDetails});

  @override
  State<HeadPaymentPersonSelectPage> createState() =>
      _EmployePpaymenDdetailPageState();
}

class _EmployePpaymenDdetailPageState
    extends State<HeadPaymentPersonSelectPage> {
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              child: Text(
                'Select the person',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            SizedBox(
              width: mediaquery.size.width,
              height: 350,
              child: ListView.builder(
                itemCount: widget.contractDetails['Attendance'].length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => HeadPaymentDetailPage(
                                contractDetails: widget.contractDetails,
                                email: widget
                                    .contractDetails['Attendance'][index].keys
                                    .toList()[0])));
                  },
                  child: Column(
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
                            widget.contractDetails['Attendance'][index].keys
                                .toList()[0],
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                // HeadPaymentDetailPage(
                //     contractDetails: widget.contractDetails,
                //     email: widget.contractDetails['Attendance'][index].keys
                //         .toList()[0])
              ),
            ),
          ],
        ),
      ),
    );
  }
}
