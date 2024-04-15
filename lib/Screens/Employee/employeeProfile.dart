import 'dart:developer';

import 'package:employer_v1/Screens/Employer/Widgets/cardWidget.dart';
import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';

class EmployeeProfileScreen extends StatefulWidget {
  String email;
  EmployeeProfileScreen({super.key, required this.email});

  @override
  State<EmployeeProfileScreen> createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  List datalist = [];
  bool Loading = true;
  final database = DatabaseService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database.getEmployeeDetails(widget.email).then((value) => {
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
    return Scaffold(
      body: Loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: mediaquery.size.height,
              width: mediaquery.size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              ),
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white, width: 3)),
                      child: const CircleAvatar(
                        radius: 100, //we give the image a radius of 50
                        backgroundImage: NetworkImage(
                            'https://webstockreview.net/images/male-clipart-professional-man-3.jpg'),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CardWidget(title: 'Name', description: datalist[0]['name']),
                    const SizedBox(
                      height: 40,
                    ),
                    CardWidget(title: 'Age', description: datalist[0]['age']),
                    const SizedBox(
                      height: 40,
                    ),
                    CardWidget(
                        title: 'Ph:', description: datalist[0]['phone-number']),
                    const SizedBox(
                      height: 40,
                    ),
                    CardWidget(
                        title: 'Company', description: datalist[0]['company']),
                    const SizedBox(
                      height: 40,
                    ),
                    CardWidget(
                        title: 'Email', description: datalist[0]['email']),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
