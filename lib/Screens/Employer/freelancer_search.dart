import 'package:employer_v1/Services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as l;

class FreelancerSearch extends StatefulWidget {
  const FreelancerSearch({Key? key}) : super(key: key);

  @override
  _FreelancerSearchState createState() => _FreelancerSearchState();
}

class _FreelancerSearchState extends State<FreelancerSearch> {
  final database = DatabaseService();
  List<Map<String, dynamic>> _foundUsers = [];
  List<Map<String, dynamic>> _allUsers = [];
  bool loading = true;
  @override
  initState() {
    database.getAllEmployeeDetails().then((value) => {
          l.log(value.toString()),
          if (value.length != 0)
            {
              setState(() {
                _allUsers = value;
                _foundUsers = _allUsers;
                loading = false;
              })
            }
        });

    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
      setState(() {
        _foundUsers = results;
      });
    } else {
      results = _allUsers
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      setState(() {
        _foundUsers = results;
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
                    child: _foundUsers.isNotEmpty
                        ? ListView.builder(
                            itemCount: _foundUsers.length,
                            itemBuilder: (context, index) => Card(
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(15),
                              //   side: new BorderSide(
                              //       color: Colors.white, width: 2.0),
                              // ),
                              borderOnForeground: true,
                              key: UniqueKey(),
                              color: Theme.of(context).colorScheme.primary,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading: Text(
                                  _foundUsers[index]["name"][0].toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                                title: Text(_foundUsers[index]['name'],
                                    style: TextStyle(color: Colors.white)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${_foundUsers[index]["age"].toString()} years old',
                                        style: TextStyle(color: Colors.white)),
                                    Text(
                                        '+91 ${_foundUsers[index]["phone-number"].toString()}',
                                        style: TextStyle(color: Colors.white)),
                                    Text(
                                        '${_foundUsers[index]["email"].toString()}',
                                        style: TextStyle(color: Colors.white)),
                                  ],
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
