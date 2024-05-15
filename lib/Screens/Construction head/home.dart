import 'dart:developer';

import 'package:employer_v1/Screens/Construction%20head/headContractPage.dart';
import 'package:employer_v1/Screens/Construction%20head/headPaymentPage.dart';
import 'package:employer_v1/Screens/Construction%20head/headWorkerSearch.dart';
import 'package:employer_v1/Screens/Employer/attandance.dart';
import 'package:employer_v1/Screens/Employer/contractPage.dart';
import 'package:employer_v1/Screens/Employer/employeeListPage.dart';
import 'package:employer_v1/Screens/Employer/freelancer_search.dart';
import 'package:employer_v1/Screens/Employer/newContractPage.dart';
import 'package:employer_v1/Screens/Employer/profile.dart';
import 'package:employer_v1/Services/firebase_database.dart';
import 'package:employer_v1/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConstructionHeadHomePage extends StatelessWidget {
  String type;
  ConstructionHeadHomePage({super.key, required this.type});

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

    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          type,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: mediaquery.size.height,
        width: mediaquery.size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => ProfileScreen(email: email)));
            //   },
            //   child: Container(
            //     height: 80,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         border: Border.all(color: Colors.white, width: 2),
            //         borderRadius: BorderRadius.circular(15)),
            //     child: const Center(
            //       child: Text(
            //         'Profile',
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             letterSpacing: 2),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => ContractPage(email: email)));
            //   },
            //   child: Container(
            //     height: 80,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         border: Border.all(color: Colors.white, width: 2),
            //         borderRadius: BorderRadius.circular(15)),
            //     child: const Center(
            //       child: Text(
            //         'Work Details',
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             letterSpacing: 2),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HeadContractorContractPage()));
              },
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    'Contracts',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ConstructionHeadWorkerSearch()));
              },
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    'Worker Search',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HeadPaymentPage()));
              },
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    'Payment',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                signOut();
              },
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
