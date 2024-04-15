import 'dart:developer';

import 'package:employer_v1/Screens/Employee/Widgets/contractWidget.dart';
import 'package:employer_v1/Screens/Employee/subscribeContracts.dart';
import 'package:employer_v1/Screens/Employer/Widgets/contractWidget.dart';
import 'package:employer_v1/Screens/Employer/employeeListPage.dart';
import 'package:employer_v1/Screens/loginPage.dart';
import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';

class EmployeeContractPage extends StatefulWidget {
  String email;
  EmployeeContractPage({super.key, required this.email});

  @override
  State<EmployeeContractPage> createState() => _EmployeeContractPageState();
}

class _EmployeeContractPageState extends State<EmployeeContractPage> {
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
        database.getParticularContracts(widget.email).then((value) => {
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
                        const Positioned(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Contracts',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 23),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SubscribeToContracts(
                                              email: widget.email)));
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 27,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return EmployeeContractWidget(
                              email: widget.email,
                              contractDetails: datalist[index]);
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
