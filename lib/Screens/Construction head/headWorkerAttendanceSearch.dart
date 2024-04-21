import 'package:employer_v1/Screens/Construction%20head/headAttendance.dart';
import 'package:employer_v1/Screens/Employee/employeeAttendance.dart';
import 'package:employer_v1/Screens/Employee/employeeProfile.dart';
import 'package:employer_v1/Screens/Employer/attandance.dart';
import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as l;

class ConstructionHeadWorkerAttendanceSearch extends StatefulWidget {
  String code;
  String email;
  List employees;
  bool isHead;
  ConstructionHeadWorkerAttendanceSearch({
    Key? key,
    required this.code,
    required this.email,
    required this.employees,
    required this.isHead,
  }) : super(key: key);

  @override
  _ConstructionHeadWorkerAttendanceSearchState createState() =>
      _ConstructionHeadWorkerAttendanceSearchState();
}

class _ConstructionHeadWorkerAttendanceSearchState
    extends State<ConstructionHeadWorkerAttendanceSearch> {
  final database = DatabaseService();
  List<Map<String, dynamic>> _foundUsers = [];
  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _queryUsers = [];
  List<Map<String, dynamic>> _queryUsersAll = [];

  bool loading = true;
  @override
  initState() {
    List hello = widget.employees;
    database.getAllEmployeeDetails().then((value) => {
          if (value.length != 0)
            {
              _allUsers = value,
              _foundUsers = _allUsers,
              for (int i = 0; i < _foundUsers.length; i++)
                {
                  if (hello.contains(_foundUsers[i]['email']))
                    {_queryUsers.add(_foundUsers[i])}
                },
              setState(() {
                loading = false;
              })
            }
        });
    _queryUsersAll = _queryUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _queryUsersAll;
      setState(() {
        _queryUsers = results;
      });
    } else {
      results = _queryUsersAll
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      setState(() {
        _queryUsers = results;
      });
      // we use the toLowerCase() method to make it case-insensitive
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: Container(
              height: mediaquery.size.height,
              width: mediaquery.size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) => _runFilter(value),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "Search",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                      )),
                  Expanded(
                    child: _queryUsers.isNotEmpty
                        ? ListView.builder(
                            itemCount: _queryUsers.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => widget.isHead
                                            ? AttandanceScreen(
                                                email: _queryUsers[index]
                                                    ['email'],
                                                code: widget.code,
                                              )
                                            : HeadAttendance(
                                                code: widget.code,
                                                email: _queryUsers[index]
                                                    ['email'],
                                              )));
                              },
                              child: Card(
                                // shape: RoundedRectangleBorder(
                                //   borderRadius: BorderRadius.circular(15),
                                //   side: new BorderSide(
                                //       color: Colors.white, width: 2.0),
                                // ),
                                borderOnForeground: true,
                                key: UniqueKey(),
                                color: Theme.of(context).colorScheme.primary,
                                elevation: 4,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  leading: Text(
                                    _queryUsers[index]["name"][0].toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                  title: Text(_queryUsers[index]['name'],
                                      style: TextStyle(color: Colors.white)),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${_queryUsers[index]["age"].toString()} years old',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text(
                                          '+91 ${_queryUsers[index]["phone-number"].toString()}',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text(
                                          '${_queryUsers[index]["email"].toString()}',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Text(
                            'No results found',
                            style: TextStyle(fontSize: 24),
                          ),
                  ),
                ],
              ),
            ),
          );
  }
}
