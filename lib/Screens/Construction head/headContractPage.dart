import 'dart:developer';

import 'package:employer_v1/Screens/Construction%20head/Widgets/headContractWidget.dart';
import 'package:employer_v1/Screens/Employee/subscribeContracts.dart';
import 'package:employer_v1/Screens/Employer/Widgets/contractWidget.dart';
import 'package:employer_v1/Screens/Employer/employeeListPage.dart';
import 'package:employer_v1/Screens/loginPage.dart';
import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';

class HeadContractorContractPage extends StatefulWidget {
  HeadContractorContractPage({super.key});

  @override
  State<HeadContractorContractPage> createState() =>
      _HeadContractorContractPageState();
}

class _HeadContractorContractPageState
    extends State<HeadContractorContractPage> {
  List datalist = [];
  bool Loading = true;
  final database = DatabaseService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database.getAllContracts().then((value) => {
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
        database.getAllContracts().then((value) => {
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
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return HeadContractWidget(
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
