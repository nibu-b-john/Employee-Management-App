import 'dart:developer';

import 'package:employer_v1/Services/firebase_database.dart';
import 'package:employer_v1/Widgets/businessCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../auth.dart';

class EmployerHomePage extends StatefulWidget {
  const EmployerHomePage({super.key});

  @override
  State<EmployerHomePage> createState() => _EmployerHomePageState();
}

class _EmployerHomePageState extends State<EmployerHomePage> {
  bool Loading = true;
  List datalist = [];

  @override
  void initState() {
    final database = DatabaseService();
    database.getEmployees().then((value) => {
          setState(
            () {
              datalist = value;
              Loading = false;
            },
          )
        });
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
            style: TextStyle(color: Colors.white),
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

    log(datalist.toString());
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Loading
            ? Center(child: CircularProgressIndicator())
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
                  itemBuilder: (context, index) => BusinessCard(
                    name: datalist[index]['name'],
                    phone_number: datalist[index]['phone-number'],
                    designation: datalist[index]['designation'],
                    district: datalist[index]['district'],
                    company: datalist[index]['company'],
                    state: datalist[index]['state'],
                  ),
                  itemCount: datalist.length,
                )),
      ),
    );
  }
}
