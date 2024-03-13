import 'dart:developer';
import 'package:employer_v1/Screens/Employee/personalDetails.dart';
import 'package:employer_v1/Screens/Employer/personalDetails.dart';
import 'package:employer_v1/Services/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  late String errormessage;
  void Validate() {
    final validate = _form.currentState!.validate();
    if (!validate) {
      return;
    }
  }

  void onSubmit(email, password) {
    final validate = _form.currentState!.validate();
    if (!validate) {
      return;
    }
    if (dropdownvalue != 'Employer' && dropdownvalue != 'Employee') {
      showInSnackBar("Choose a valid type!");
      return;
    }
    createUserWithEmailAndPassword(email, password);
    _emailcontroller.clear();
    _passwordController.clear();
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    final database = DatabaseService();
    try {
      await Auth()
          .createUserWithEmailAndPassword(email: email, password: password);
      if (dropdownvalue == "Employer") {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PersonalDetailsEmployer(
                  email: email, dropdownvalue: dropdownvalue.toString())),
        );
      } else if (dropdownvalue == "Employee") {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PersonalDetailsEmployee(
                  email: email, dropdownvalue: dropdownvalue.toString())),
        );
      }
    } on FirebaseAuthException catch (e) {
      showInSnackBar(e.code);
    }
  }

  bool changeIcon = true;
  final _form = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordController = TextEditingController();
  String? dropdownvalue;

  var items = ['Employer', 'Employee'];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    var mediaquery = MediaQuery.of(context);
    return Scaffold(
        body: Stack(children: [
      Container(
        height: mediaquery.size.height,
        width: mediaquery.size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
      ),
      Form(
        key: _form,
        child: Positioned(
          // left: _mediaquery.size.width / 5,
          top: mediaquery.size.width * 0.2,
          child: SizedBox(
            width: mediaquery.size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: mediaquery.size.width * 0.5,
                  height: mediaquery.size.width * 0.6,
                ),
                const Text('Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gulzar')),
                SizedBox(
                  height: mediaquery.size.height * 0.04,
                ),
                SizedBox(
                  width: mediaquery.size.width * 0.8,
                  child: TextFormField(
                    onChanged: (value) {
                      Validate();
                    },
                    controller: _emailcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid email';
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
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.27),
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Colors.white),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaquery.size.height * 0.03,
                ),
                SizedBox(
                  width: mediaquery.size.width * 0.8,
                  child: Stack(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          Validate();
                        },
                        enableSuggestions: false,
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid password';
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
                        obscureText: changeIcon ? true : false,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            fontSize: 10,
                          ),
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
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.white),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                      Positioned(
                          right: mediaquery.size.width * 0.01,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                changeIcon = !changeIcon;
                              });
                            },
                            icon: Icon(
                              changeIcon
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                              size: 22,
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: mediaquery.size.height * 0.03,
                ),
                Container(
                  width: mediaquery.size.width * 0.8,
                  height: 50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0),
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white.withOpacity(0.27),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: const Text(
                        'Type',
                        style: TextStyle(color: Colors.white),
                      ),
                      dropdownColor: Colors.black87,
                      value: dropdownvalue,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaquery.size.height * 0.03,
                ),
                OutlinedButton(
                  onPressed: () {
                    onSubmit(_emailcontroller.text, _passwordController.text);
                  },
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white)),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaquery.size.height * 0.04,
                ),
                const Text(
                  'Already registered, login below!',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
                SizedBox(
                  height: mediaquery.size.height * 0.001,
                ),
                TextButton(
                  onPressed: () {
                    onSubmit(_emailcontroller.text, _passwordController.text);
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]));
  }
}
