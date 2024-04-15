import 'package:employer_v1/Screens/Employer/Widgets/employeeAttendance.dart';
import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as l;

class AttandanceScreen extends StatefulWidget {
  String email;
  String code;
  AttandanceScreen({super.key, required this.email, required this.code});

  @override
  State<AttandanceScreen> createState() => _AttandanceScreenState();
}

class _AttandanceScreenState extends State<AttandanceScreen> {
  final database = DatabaseService();
  bool loading = true;
  List<String> employeeList = [];
  List<String> attendanceChecker = [];
  String currentDay = '0';
  String endDate = '0';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    database.getEmployeesWithCode(widget.code).then((employees) => {
          for (var employee in employees[1])
            {employeeList.add(employee['email'])},
          setState(() {
            currentDay = employees[0];
            loading = false;
            endDate = employees[2];
          })
        });

    database
        .getTotalNumberOfWorkingDays(widget.code)
        .then((value) => {if (value != null) l.log(value)});
  }

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
    return loading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 25),
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    "Day " + (int.parse(currentDay) + 1).toString(),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ],
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    employeeList.length == attendanceChecker.length ||
                            attendanceChecker.length == 0
                        ? Navigator.pop(context)
                        : showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text(
                                    "Alert",
                                    textAlign: TextAlign.center,
                                  ),
                                  titleTextStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white, width: 2),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      )),
                                  content: Text(
                                    'Day $currentDay attendance is pending, please complete it before moving forward.',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ));
                    ;
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  )),
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                "Attendance",
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
                child: int.parse(currentDay) == int.parse(endDate)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Contract period is over.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              'Try creating a new contract.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => Dismissible(
                            secondaryBackground: Padding(
                              padding: EdgeInsets.only(
                                bottom: 20.0,
                              ),
                              child: Container(
                                color: Colors.red,
                                padding: const EdgeInsets.only(
                                  right: 20.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(
                                      Icons.thumb_down,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            background: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20.0,
                              ),
                              child: Container(
                                color: Colors.green,
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.thumb_up,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              database
                                  .updateEmployeesContractAttendance(
                                      widget.code,
                                      employeeList[index],
                                      direction.name == "startToEnd"
                                          ? true
                                          : false)
                                  .then((value) => {l.log(value.toString())});
                              showInSnackBar(
                                  "${employeeList[index].split('@')[0]} was marked as  ${direction.name == "startToEnd" ? "present" : "absent"}");
                              // setState(() {
                              attendanceChecker.add(employeeList[index]);
                              if (attendanceChecker.length ==
                                  employeeList.length) {
                                Navigator.pop(context);
                              }
                              // });
                            },
                            child: EmployeeAttendanceWidget(
                                employee: employeeList[index])),
                        itemCount: employeeList.length,
                      )),
          );
  }
}
