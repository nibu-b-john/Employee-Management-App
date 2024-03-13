import 'dart:developer';

import 'package:employer_v1/Services/firebase_database.dart';
import 'package:employer_v1/Widgets/businessCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../auth.dart';

class EmployerHomePage extends StatefulWidget {
  String code;
  EmployerHomePage({super.key, required this.code});

  @override
  State<EmployerHomePage> createState() => _EmployerHomePageState();
}

class _EmployerHomePageState extends State<EmployerHomePage> {
  bool Loading = true;
  List datalist = [];

  final database = DatabaseService();
  @override
  void initState() {
    database.getEmployees(widget.code).then((value) => {
          log(value.toString()),
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
                      name: datalist[index]['name'],
                      phone_number: datalist[index]['phone-number'],
                      designation: datalist[index]['designation'],
                      district: datalist[index]['district'],
                      company: datalist[index]['company'],
                      state: datalist[index]['state'],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                itemCount: datalist.length,
              )),
    );
  }
}
