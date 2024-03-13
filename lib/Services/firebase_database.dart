import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;

  void addEmployee(
    String email,
    String type,
    String name,
    String age,
    String blood_group,
    String phone_number,
    String adhaar_number,
    String address,
    String company,
    String district,
    String state,
    String designation,
  ) {
    final data = {
      "name": name,
      "email": email,
      "type": type,
      "age": age,
      "blood-group": blood_group,
      "phone-number": phone_number,
      "adhaar-number": adhaar_number,
      "address": address,
      "company": company,
      "district": district,
      "state": state,
      "designation": designation,
    };
    db.collection("Users").add({
      "name": name,
      "email": email,
      "type": type,
    }).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));

    db.collection("Employee").add(data).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));
  }

  void addEmployer(
    String email,
    String type,
    String name,
    String age,
    String phone_number,
    String company,
  ) {
    final data = {
      "name": name,
      "email": email,
      "type": type,
      "age": age,
      "phone-number": phone_number,
      "company": company,
    };
    db.collection("Users").add({
      "name": name,
      "email": email,
      "type": type,
    }).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));

    db.collection("Employer").add(data).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));
  }

  Future<String> findEmail(String email) async {
    final result =
        await db.collection("Users").where("email", isEqualTo: email).get();
    if (result.docs.isEmpty) {
      return "Not found";
    } else {
      return result.docs.first.data()['type'];
    }
  }

  Future<List> getEmployees(String code) async {
    List employeeList = [];
    final querySnapshot =
        await db.collection("Contract").where("Code", isEqualTo: code).get();

    final dataList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    print(dataList[0]['Employees']);

    for (var employee in dataList[0]['Employees']) {
      final querySnapshot1 = await db
          .collection("Employee")
          .where("email", isEqualTo: employee)
          .get();
      final dataList1 = querySnapshot1.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      employeeList.addAll(dataList1);
    }

    return employeeList;
  }

  // Future<void> addEmployees() async {
  //   db.collection("users").doc("frank").update(data)
  //   }

  //********************Contracts*******************//

  Future<List> getParticularContracts(String email) async {
    final querySnapshot = await db
        .collection("Contract")
        .where("Employees", arrayContains: email)
        .get();

    final dataList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    return dataList;
  }

  Future<List> getParticularContractsWithCode(String email, String code) async {
    final querySnapshot = await db
        .collection("Contract")
        .where("Code", isEqualTo: code)
        .where("Employees", arrayContains: email)
        .get();

    final dataList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    print(dataList);
    return dataList;
  }

  Future<String> updateEmployeesContract(String code, String email) async {
    List selectedContracts = await getParticularContractsWithCode(email, code);
    print(selectedContracts);
    if (selectedContracts.isEmpty) {
      final querySnapshot =
          await db.collection("Contract").where("Code", isEqualTo: code).get();
      String docId;
      List<Set> dataList = querySnapshot.docs
          .map((doc) => {docId = doc.id, doc.data()} as Set)
          .toList();

      List employees = dataList[0].elementAt(1)['Employees'] as List;
      employees.add(email);

      db
          .collection("Contract")
          .doc(dataList[0].elementAt(0))
          .update({"Employees": employees});
      return "Successfully subscribed to contract!";
    } else {
      // if(selectedContracts[0]['Code']==code){

      // return "You are already subscribed to contract!";
      // }
      return "You are already subscribed to contract!";
    }
  }

  Future<List> getContracts(String email) async {
    final querySnapshot = await db
        .collection("Contract")
        .where("Employer", isEqualTo: email)
        .get();

    final dataList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    return dataList;
  }

  String chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  void createContract(
      String email,
      String contractName,
      String jobTitles,
      String startDate,
      String endDate,
      String hourlyRate,
      String benefits,
      String description) {
    Random rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    final contractDetails = {
      "Employer": email,
      "Contract-Name": contractName,
      "Job-Titles": jobTitles,
      "Start-Date": startDate,
      "End-Date": endDate,
      "Hourly-Rate": hourlyRate,
      "Benefits": benefits,
      "Description": description,
      "Code": getRandomString(5),
      "Employees": []
    };

    db.collection("Contract").add(contractDetails).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));
  }
}
