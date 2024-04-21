import 'dart:developer';

import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';

class EditingPage extends StatefulWidget {
  Map details;
  EditingPage({super.key, required this.details});

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  final _form = GlobalKey<FormState>();
  late TextEditingController _namecontroller;
  late TextEditingController _agecontroller = TextEditingController();
  late TextEditingController _phonenumbercontroller = TextEditingController();
  late TextEditingController _companycontroller = TextEditingController();
  final database = DatabaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _namecontroller = TextEditingController(text: widget.details['name']);
      _agecontroller = TextEditingController(text: widget.details['age']);
      _companycontroller =
          TextEditingController(text: widget.details['company']);
      _phonenumbercontroller =
          TextEditingController(text: widget.details['phone-number']);
    });
  }

  void onSubmit() {
    widget.details['name'] = _namecontroller.text;
    widget.details['age'] = _agecontroller.text;
    widget.details['phone-number'] = _phonenumbercontroller.text;
    widget.details['company'] = _companycontroller.text;

    database.updateEmployeeProfile(widget.details);
    showInSnackBar("Successfully added details");
    setState(() {
      _namecontroller = TextEditingController(text: widget.details['name']);
      _agecontroller = TextEditingController(text: widget.details['age']);
      _companycontroller =
          TextEditingController(text: widget.details['company']);
      _phonenumbercontroller =
          TextEditingController(text: widget.details['phone-number']);
    });
  }

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

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black87,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Details',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Form(
            key: _form,
            child: Container(
              width: mediaquery.size.width,
              height: mediaquery.size.height,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //**************Name*******************//
                      TextFormField(
                        onChanged: (value) {},
                        controller: _namecontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name field is empty!';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                        cursorColor: Theme.of(context).colorScheme.onPrimary,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.27),
                          hintText: widget.details['name'],
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: mediaquery.size.height * 0.04,
                      ),
                      //**************Age*******************//
                      TextFormField(
                        onChanged: (value) {},
                        controller: _agecontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Age field is empty!';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                        cursorColor: Theme.of(context).colorScheme.onPrimary,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.27),
                          hintText: widget.details['age'],
                          hintStyle: const TextStyle(color: Colors.white),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: mediaquery.size.height * 0.04,
                      ),

                      //**************Phone Number*******************//
                      TextFormField(
                        onChanged: (value) {},
                        controller: _phonenumbercontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Number Field is empty!';
                          } else if (value.length != 10) {
                            return 'Enter a 10 Digit Number!';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                        cursorColor: Theme.of(context).colorScheme.onPrimary,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.27),
                          hintText: widget.details['phone-number'],
                          hintStyle: const TextStyle(color: Colors.white),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: mediaquery.size.height * 0.04,
                      ),

                      //**************Company Name*******************//
                      TextFormField(
                        onChanged: (value) {},
                        controller: _companycontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Company Name Field is empty!';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                        cursorColor: Theme.of(context).colorScheme.onPrimary,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.27),
                          hintText: widget.details['company'],
                          hintStyle: const TextStyle(color: Colors.white),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: mediaquery.size.height * 0.04,
                      ),

                      OutlinedButton(
                        onPressed: () {
                          onSubmit();
                        },
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white)),
                        child: const Text(
                          'Update changes',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
