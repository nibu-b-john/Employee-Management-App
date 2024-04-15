import 'dart:developer';

import 'package:employer_v1/Screens/Employee/Widgets/EmployeePaymentContractWidget.dart';
import 'package:employer_v1/Screens/Employer/Widgets/contractWidget.dart';
import 'package:employer_v1/Screens/Employer/Widgets/paymentContractWidget.dart';
import 'package:employer_v1/Screens/Employer/attandance.dart';
import 'package:employer_v1/Screens/Employer/employeeListPage.dart';
import 'package:employer_v1/Screens/Employer/newContractPage.dart';
import 'package:employer_v1/Screens/loginPage.dart';
import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';

class EmployeePaymentPage extends StatefulWidget {
  String email;
  EmployeePaymentPage({super.key, required this.email});

  @override
  State<EmployeePaymentPage> createState() => _EmployeePaymentPageState();
}

class _EmployeePaymentPageState extends State<EmployeePaymentPage> {
  List datalist = [];
  bool Loading = true;
  final database = DatabaseService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database.getParticularContracts(widget.email).then((value) => {
          setState(
            () {
              datalist = value;
              Loading = false;
            },
          )
        });
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return RefreshIndicator(
      displacement: 100,
      backgroundColor: Colors.white,
      color: Theme.of(context).colorScheme.primary,
      strokeWidth: 4,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));
        database.getContracts(widget.email).then((value) => {
              setState(
                () {
                  datalist = value;
                  Loading = false;
                },
              )
            });
      },
      child: Scaffold(
        body: Loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                        ),
                        // Positioned(
                        //   top: 0,
                        //   child: Align(
                        //       alignment: Alignment.topLeft,
                        //       child: IconButton(
                        //           onPressed: () {
                        //             Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) =>
                        //                         AttandanceScreen()));
                        //           },
                        //           icon: Icon(
                        //             Icons.class_,
                        //             color: Colors.white,
                        //             size: 30,
                        //           ))),
                        // ),
                        const Positioned(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Select a Contract',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 23),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   child: Align(
                        //       alignment: Alignment.topRight,
                        //       child: IconButton(
                        //           onPressed: () {
                        //             Navigator.pushReplacement(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) => LoginPage()));
                        //           },
                        //           icon: Icon(
                        //             Icons.exit_to_app,
                        //             color: Colors.white,
                        //             size: 30,
                        //           ))),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return EmployeePaymentContractWidget(
                            contractDetails: datalist[index],
                            email: widget.email,
                          );
                        },
                        itemCount: datalist.length,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
