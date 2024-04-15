import 'package:employer_v1/Screens/Employer/orderConfirm.dart';
import 'package:flutter/material.dart';

class EmployerPaymentDetailPage extends StatefulWidget {
  Map<String, dynamic> contractDetails;
  EmployerPaymentDetailPage({super.key, required this.contractDetails});

  @override
  State<EmployerPaymentDetailPage> createState() =>
      _EmployePpaymenDdetailPageState();
}

class _EmployePpaymenDdetailPageState extends State<EmployerPaymentDetailPage> {
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 40,
          top: 10,
        ),
        height: mediaquery.size.height,
        width: mediaquery.size.width,
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
              width: double.infinity,
              height: mediaquery.size.height - 150,
              child: ListView.builder(
                  itemCount: widget.contractDetails['Attendance'].length,
                  itemBuilder: (_, index) => InkWell(
                        onTap: () => showDialog(
                            context: context,
                            builder: (ctx) => OrderConfirm(
                                ctx: ctx,
                                index: index,
                                contractDetails: widget.contractDetails,
                                email: widget
                                    .contractDetails['Attendance'][index].keys
                                    .toList()[0],
                                distance: 22.2,
                                text: "text",
                                price: 50)),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  widget
                                      .contractDetails['Attendance'][index].keys
                                      .toList()[0],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
