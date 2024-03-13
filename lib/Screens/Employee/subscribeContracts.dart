import 'dart:developer';

import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';

class SubscribeToContracts extends StatefulWidget {
  String email;
  SubscribeToContracts({super.key, required this.email});

  @override
  State<SubscribeToContracts> createState() => _SubscribeToContractsState();
}

class _SubscribeToContractsState extends State<SubscribeToContracts> {
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

  final _form = GlobalKey<FormState>();
  final _searchcontroller = TextEditingController();
  final database = DatabaseService();
  void onSubmit() {
    database
        .updateEmployeesContract(_searchcontroller.text, widget.email)
        .then((value) => showInSnackBar(value.toString()));
  }

// s5uVt
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        height: mediaquery.size.height,
        width: mediaquery.size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Search ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
                Icon(
                  Icons.search_rounded,
                  size: 35,
                  color: Colors.white,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _form,
              child: TextFormField(
                onChanged: (value) {},
                controller: _searchcontroller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Search field is empty';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.red, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.red, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.07),
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.white),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                onSubmit();
              },
              child: Container(
                width: 110,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Subscribe',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
