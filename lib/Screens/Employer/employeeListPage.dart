import 'dart:developer';

import 'package:employer_v1/Services/firebase_database.dart';
import 'package:employer_v1/Widgets/businessCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../auth.dart';

class EmployeeListPage extends StatefulWidget {
  String code;
  bool all;
  EmployeeListPage({super.key, required this.code, this.all = false});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  bool Loading = true;
  List datalist = [];

  final database = DatabaseService();
  @override
  void initState() {
    if (widget.all) {
      database.getEmployeesWithEmployerName(widget.code).then((value) => {
            setState(
              () {
                datalist = value;
                Loading = false;
              },
            )
          });
    } else {
      database.getEmployeesWithCode(widget.code).then((value) => {
            setState(
              () {
                datalist = value;
                Loading = false;
              },
            )
          });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void showInSnackBar(String error) {
      var snackBar = SnackBar(
          content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            error,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Future<void> signOut() async {
      try {
        await Auth().signOut();
        Navigator.popAndPushNamed(context, '/login');
      } on FirebaseAuthException catch (e) {
        showInSnackBar(e.code);
      }
    }

    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Employees',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              height: mediaquery.size.height,
              width: mediaquery.size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              ),
              child: ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    BusinessCard(
                      name: widget.all
                          ? datalist[index]['name']
                          : datalist[1][index]['name'],
                      phone_number: widget.all
                          ? datalist[index]['phone-number']
                          : datalist[1][index]['phone-number'],
                      designation: widget.all
                          ? datalist[index]['designation']
                          : datalist[1][index]['designation'],
                      district: widget.all
                          ? datalist[index]['district']
                          : datalist[1][index]['district'],
                      company: widget.all
                          ? datalist[index]['company']
                          : datalist[1][index]['company'],
                      state: widget.all
                          ? datalist[index]['state']
                          : datalist[1][index]['state'],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                itemCount: widget.all ? datalist.length : datalist[1].length,
              )),
    );
  }
}
