import 'package:employer_v1/Screens/Employer/Widgets/employeeAttendance.dart';
import 'package:flutter/material.dart';

class AttandanceScreen extends StatelessWidget {
  const AttandanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void showInSnackBar(String error) {
      var snackBar = SnackBar(
          duration: Duration(milliseconds: 500),
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

    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          " Attendance",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 40,
            top: 10,
          ),
          height: mediaquery.size.height,
          width: mediaquery.size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          ),
          child: ListView.builder(
            itemBuilder: (context, index) => Dismissible(
                key: Key((index + 1).toString()),
                onDismissed: (direction) {
                  showInSnackBar("Employee ${index + 1} was marked as absent");
                },
                child: EmployeeAttendanceWidget(number: index + 1)),
            itemCount: 20,
          )),
    );
  }
}
