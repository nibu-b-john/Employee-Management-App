import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:employer_v1/Screens/Employee/Widgets/emplyeeAttendanceWidget.dart';
import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';

class EmployeeAttendance extends StatefulWidget {
  String code;
  String email;
  EmployeeAttendance({super.key, required this.code, required this.email});

  @override
  State<EmployeeAttendance> createState() => _EmployeeAttendanceState();
}

class _EmployeeAttendanceState extends State<EmployeeAttendance> {
  final database = DatabaseService();
  List employeeAttendance = [];
  List startDate = [];
  int totalDays = 0;
  dynamic val;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database
        .getEmployeesContractAttendance(widget.code, widget.email)
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
  }

  @override
  Widget build(BuildContext context) {
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
          'Your Attendance',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
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
                itemCount: employeeAttendance.length,
                itemBuilder: (_, index) => Column(
                  children: [
                    EmployeeAttendanceWidget(
                      absent: !employeeAttendance[index],
                      date: (DateTime(int.parse(startDate[2]),
                              int.parse(startDate[1]), int.parse(startDate[0]))
                          .add(Duration(days: index))),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: 195,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Attendance details",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 4, 30, 52),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    height: 170,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white, width: 2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total number of days: $totalDays ",
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Number of days present: ${(employeeAttendance.where((e) => e == true)).length}",
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Number of days absent:  ${(employeeAttendance.where((e) => e == false)).length}",
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Days remaining: ${totalDays - employeeAttendance.length}",
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Percentage:  ${(((employeeAttendance.where((e) => e == true)).length / employeeAttendance.length) * 100).toStringAsFixed(2)}%",
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
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
