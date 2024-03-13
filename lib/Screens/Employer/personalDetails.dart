import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';

class PersonalDetailsEmployer extends StatefulWidget {
  String email;
  String dropdownvalue;
  PersonalDetailsEmployer(
      {super.key, required this.email, required this.dropdownvalue});

  @override
  State<PersonalDetailsEmployer> createState() =>
      _PersonalDetailsEmployerState();
}

class _PersonalDetailsEmployerState extends State<PersonalDetailsEmployer> {
  final _form = GlobalKey<FormState>();
  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _phonenumbercontroller = TextEditingController();
  final _companycontroller = TextEditingController();
  final database = DatabaseService();
  void onSubmit() {
    final validate = _form.currentState!.validate();
    if (!validate) {
      return;
    }
    database.addEmployer(
        widget.email,
        widget.dropdownvalue,
        _namecontroller.text,
        _agecontroller.text,
        _phonenumbercontroller.text,
        _companycontroller.text);
    showInSnackBar("Successfully added details");
    Navigator.popAndPushNamed(context, '/login');
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
                          hintText: 'Name',
                          hintStyle: const TextStyle(color: Colors.white),
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
                          hintText: 'Age',
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
                          hintText: 'Phone Number',
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
                          hintText: 'Company',
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
                          'Submit',
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
