import 'dart:developer';
import 'dart:math';

import 'package:employer_v1/Screens/Construction%20head/headWorkerAttendanceSearch.dart';
import 'package:employer_v1/Screens/Employer/Widgets/cardWidget.dart';
import 'package:employer_v1/Screens/Employer/attandance.dart';
import 'package:employer_v1/Screens/Employer/employeeListPage.dart';
import 'package:flutter/material.dart';

class ContractDetailPage extends StatelessWidget {
  Map<String, dynamic> contractDetails;
  ContractDetailPage({super.key, required this.contractDetails});

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text(
                              "CODE",
                              textAlign: TextAlign.center,
                            ),
                            titleTextStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: const RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                )),
                            content: Text(
                              contractDetails['Code'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  letterSpacing: 3,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                            ),
                          ));
                },
                icon: const Icon(
                  Icons.person_add_alt,
                  color: Colors.white,
                )),
          )
        ],
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          contractDetails['Contract-Name'],
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 40,
          top: 90,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardWidget(
                  title: 'Employer',
                  description:
                      contractDetails['Employer'].split('@')[0].toUpperCase()),
              const SizedBox(
                height: 40,
              ),
              CardWidget(
                  title: 'Job-Titles',
                  description: contractDetails['Job-Titles']),
              const SizedBox(
                height: 40,
              ),
              CardWidget(
                  title: 'Hourly-Rate',
                  description: "Rs. ${contractDetails['Hourly-Rate']}/hr"),
              const SizedBox(
                height: 40,
              ),
              CardWidget(
                  title: 'Start-Date',
                  description: contractDetails['Start-Date']),
              const SizedBox(
                height: 40,
              ),
              CardWidget(
                  title: 'End-Date', description: contractDetails['End-Date']),
              const SizedBox(
                height: 40,
              ),
              CardWidget(
                title: 'Description',
                description: contractDetails['Description'],
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmployeeListPage(
                                code: contractDetails['Code'],
                              )));
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      'See all Employees',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => AttandanceScreen(
                  //               email: contractDetails['Employer'],
                  //               code: contractDetails['Code'],
                  //             )));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ConstructionHeadWorkerAttendanceSearch(
                                  code: contractDetails['Code'],
                                  email: contractDetails['Employer'],
                                  employees: contractDetails['Employees'],
                                  isHead: false)));
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      'Attendance',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
