import 'dart:convert';
import 'dart:developer';
import 'package:employer_v1/Screens/Employee/Widgets/employeePaymentWidget.dart';
import 'package:intl/intl.dart';
import 'package:employer_v1/Screens/Employee/Widgets/emplyeeAttendanceWidget.dart';
import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';

class HeadPaymentDetailPage extends StatefulWidget {
  Map<String, dynamic> contractDetails;
  String email;
  HeadPaymentDetailPage(
      {super.key, required this.contractDetails, required this.email});

  @override
  State<HeadPaymentDetailPage> createState() => _HeadPaymentDetailPageState();
}

class _HeadPaymentDetailPageState extends State<HeadPaymentDetailPage> {
  final database = DatabaseService();
  List employeeAttendance = [];
  List startDate = [];
  int totalDays = 0;
  dynamic val;
  List paidList = [];
  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.contractDetails.toString());
    database
        .getEmployeesContractAttendance(
            widget.contractDetails['Code'], widget.email)
        .then((value) => {
              // log(value[1].values.elementAt(0).toString()),
              // val =
              //     value[1].replaceAll(RegExp(r'[{}]'), '').split(RegExp(r':')),
              setState(() {
                startDate = value[0].split('/');
                totalDays = int.parse(value[2]);
                employeeAttendance = value[1].values.elementAt(0);
              }),
            })
        .catchError((e) => {log(e.toString())});

    widget.contractDetails['Paid'].forEach(
      (element) {
        if (element.keys.toList()[0] == widget.email) {
          paidList = element.values.toList()[0];
        }
      },
    );
    setState(() {
      count = paidList.length;
    });
  }

  List<String> status = [];
  @override
  Widget build(BuildContext context) {
    for (var element in employeeAttendance) {
      if (element) {
        if (count > 0) {
          count--;
          status.add('Paid');
        } else {
          status.add('Unpaid');
        }
      } else {
        status.add('Absent');
      }
    }

    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            )),
        title: const Text(
          'Your Payment Journey',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: status.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 0,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: status.length,
                      itemBuilder: (_, index) => Column(
                        children: [
                          EmployeePaymentWidget(
                            index: index,
                            count: count,
                            status: status,
                            absent: !employeeAttendance[index],
                            date: (DateTime(
                                    int.parse(startDate[2]),
                                    int.parse(startDate[1]),
                                    int.parse(startDate[0]))
                                .add(Duration(days: index))),
                          ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // child: Column(
              //   children: [
              // EmployeeAttendanceWidget(
              //   absent: true,
              //   date: "13-04-24",
              // ),
              //     SizedBox(
              //       height: 40,
              //     ),
              //     EmployeeAttendanceWidget(
              //       absent: false,
              //       date: "13-05-24",
              //     ),
              //   ],
              // ),
            ),
    );
  }
}
