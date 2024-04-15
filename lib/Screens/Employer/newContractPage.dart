import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';

class NewContract extends StatefulWidget {
  String email;
  NewContract({super.key, required this.email});

  @override
  State<NewContract> createState() => _NewContractState();
}

class _NewContractState extends State<NewContract> {
  final _form = GlobalKey<FormState>();
  final _namecontroller = TextEditingController();
  final _jobtitlecontroller = TextEditingController();
  final _startdatecontroller = TextEditingController();
  final _enddatecontroller = TextEditingController();
  final _hourlyratecontroller = TextEditingController();
  final _benefitscontroller = TextEditingController();
  final _descriptioncontroller = TextEditingController();
  final ddController = TextEditingController();
  final mmController = TextEditingController();
  final yyController = TextEditingController();

  final database = DatabaseService();
  void onSubmit() {
    final validate = _form.currentState!.validate();
    if (!validate) {
      return;
    }

    database.createContract(
        widget.email,
        _namecontroller.text,
        _jobtitlecontroller.text,
        ddController.text,
        mmController.text,
        yyController.text,
        _enddatecontroller.text,
        _hourlyratecontroller.text,
        _benefitscontroller.text,
        _descriptioncontroller.text);
    showInSnackBar("Contract successfully generated");
    Navigator.pop(context);
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
    Size size = MediaQuery.of(context).size;
    Widget _textField({first, last, size, boxController}) {
      return SizedBox(
        height: size.height * 0.0625,
        width: size.width * 0.1715,
        child: TextField(
          controller: boxController,
          autofocus: true,
          onChanged: (value) {
            if (value.isEmpty && first == true) {
              FocusScope.of(context).unfocus();
            }
            if (value.length == 4 && last == true) {
              FocusScope.of(context).unfocus();
            }

            if (value.length == 2 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && last == false && first == false) {
              FocusScope.of(context).previousFocus();
            }
            if (value.isEmpty && last == true) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          keyboardType: TextInputType.number,
          maxLength: 4,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.3),
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
      );
    }

    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            )),
        centerTitle: true,
        title: const Text(
          'New Contract',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Form(
          key: _form,
          child: Container(
            width: mediaquery.size.width,
            height: mediaquery.size.height,
            padding: EdgeInsets.only(top: 90, left: 20, right: 20, bottom: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary
              ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
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
                          hintText: 'Contract Name',
                          hintStyle: const TextStyle(color: Colors.white),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),

                      SizedBox(
                        height: mediaquery.size.height * 0.04,
                      ),
                      //**************Job titles*******************//
                      TextFormField(
                        onChanged: (value) {},
                        controller: _jobtitlecontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Job Title Field is empty!';
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
                          hintText: 'Job Title',
                          hintStyle: const TextStyle(color: Colors.white),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),

                      SizedBox(
                        height: mediaquery.size.height * 0.04,
                      ),
                      //**************Start Date*******************//
                      // TextFormField(
                      //   onChanged: (value) {},
                      //   controller: _startdatecontroller,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Date field is empty!';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      //   keyboardType: TextInputType.datetime,
                      //   style: TextStyle(
                      //       color: Theme.of(context).colorScheme.onPrimary),
                      //   cursorColor: Theme.of(context).colorScheme.onPrimary,
                      //   autocorrect: false,
                      //   textInputAction: TextInputAction.next,
                      //   decoration: InputDecoration(
                      //     errorBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //       borderSide:
                      //           const BorderSide(color: Colors.red, width: 1.0),
                      //     ),
                      //     focusedErrorBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //       borderSide:
                      //           const BorderSide(color: Colors.red, width: 1.0),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //       borderSide: const BorderSide(
                      //           color: Colors.grey, width: 0.0),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //       borderSide: const BorderSide(
                      //           color: Colors.grey, width: 0.0),
                      //     ),
                      //     filled: true,
                      //     fillColor: Colors.white.withOpacity(0.27),
                      //     hintText: 'Start Date',
                      //     hintStyle: const TextStyle(color: Colors.white),
                      //     contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 10.0, horizontal: 20.0),
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date:',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          _textField(
                              first: true,
                              last: false,
                              size: size,
                              boxController: ddController),
                          SizedBox(
                            width: 10,
                          ),
                          _textField(
                              first: false,
                              last: false,
                              size: size,
                              boxController: mmController),
                          SizedBox(
                            width: 10,
                          ),
                          _textField(
                              first: false,
                              last: true,
                              size: size,
                              boxController: yyController),
                        ],
                      ),
                      SizedBox(
                        height: mediaquery.size.height * 0.04,
                      ),
                      //**************End Date*******************//
                      TextFormField(
                        onChanged: (value) {},
                        controller: _enddatecontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Date field is empty!';
                          } else if (value.contains(RegExp(r'[a-z]')) ||
                              value.contains(RegExp(r'[A-Z]'))) {
                            return 'Enter a Number';
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
                          hintText: 'Number of Days',
                          hintStyle: const TextStyle(color: Colors.white),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),

                      SizedBox(
                        height: mediaquery.size.height * 0.04,
                      ),
                      //**************Hourly rate*******************//
                      TextFormField(
                        onChanged: (value) {},
                        controller: _hourlyratecontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Hourly rate field is empty!';
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
                          hintText: 'Hourly Rate',
                          hintStyle: const TextStyle(color: Colors.white),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),

                      SizedBox(
                        height: mediaquery.size.height * 0.04,
                      ),
                      //**************Benefits*******************//
                      TextFormField(
                        onChanged: (value) {},
                        controller: _benefitscontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Benefits field is empty!';
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
                          hintText: 'Benefits',
                          hintStyle: const TextStyle(color: Colors.white),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),

                      SizedBox(
                        height: mediaquery.size.height * 0.04,
                      ),
                      //**************description*******************//
                      TextFormField(
                        onChanged: (value) {},
                        controller: _descriptioncontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Description field is empty!';
                          } else {
                            return null;
                          }
                        },
                        maxLines: 5,
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
                          hintText: 'Description',
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
                          'Generate',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
