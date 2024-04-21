import 'dart:math';
import 'dart:developer' as l;
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

  void updateEmployeeProfile(Map data) async {
    final querySnapshot = await db
        .collection("Employee")
        .where("email", isEqualTo: data['email'])
        .get();
    String docId = querySnapshot.docs.first.id.toString();
    await db.collection("Employee").doc(docId).update({
      "name": data['name'],
      "age": data['age'],
      "company": data['company'],
      "phone-number": data['phone-number'],
    });
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

  Future<List> getEmployeesWithCode(String code) async {
    List employeeList = [];
    final querySnapshot =
        await db.collection("Contract").where("Code", isEqualTo: code).get();

    final dataList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

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

    return [
      dataList[0]['Attendance'].length != 0
          ? dataList[0]['Attendance'][0].values.first.length.toString()
          : "0",
      employeeList,
      dataList[0]['End-Date']
    ];
  }

  Future<List<Map<String, dynamic>>> getAllEmployeeDetails() async {
    try {
      final querySnapshot = await db
          .collection("Employee")
          .where("type", isEqualTo: "Employee")
          .get();
      final dataList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return dataList;
    } catch (e) {
      return [];
    }
  }

  Future<List> getEmployeesWithEmployerName(String email) async {
    List employeeList = [];
    final querySnapshot = await db
        .collection("Contract")
        .where("Employer", isEqualTo: email)
        .get();

    final dataList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    print(dataList);
    // print(dataList[0]['Employees']);
    for (var contract in dataList) {
      for (var employee in contract['Employees']) {
        final querySnapshot1 = await db
            .collection("Employee")
            .where("email", isEqualTo: employee)
            .get();
        final dataList1 = querySnapshot1.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        employeeList.addAll(dataList1);
      }
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

  Future<List> getAllContracts() async {
    final querySnapshot = await db.collection("Contract").get();

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

    return dataList;
  }

  Future<String?> updateEmployeesContract(String code, String email) async {
    List selectedContracts = await getParticularContractsWithCode(email, code);

    if (selectedContracts.isEmpty) {
      try {
        final querySnapshot = await db
            .collection("Contract")
            .where("Code", isEqualTo: code)
            .get();
        String docId;
        List<Set> dataList = querySnapshot.docs
            .map((doc) => {docId = doc.id, doc.data()} as Set)
            .toList();

        List employees = dataList[0].elementAt(1)['Employees'] as List;
        List attendance = dataList[0].elementAt(1)['Attendance'] as List;
        List paidDays = dataList[0].elementAt(1)['Paid'] as List;
        bool flag = true;
        bool flag2 = true;
        // l.log(dataList[0].elementAt(1)['Attendance'].toString());
        employees.add(email);

        db
            .collection("Contract")
            .doc(dataList[0].elementAt(0))
            .update({"Employees": employees});
        for (var element in attendance) {
          var mail = element as Map<String, dynamic>;

          if (mail.keys.contains(email)) {
            flag = false;
          }
        }
        for (var element in paidDays) {
          var mail = element as Map<String, dynamic>;

          if (mail.keys.contains(email)) {
            flag2 = false;
          }
        }
        if (flag) {
          db.collection("Contract").doc(dataList[0].elementAt(0)).update({
            "Attendance": [
              ...attendance,
              {email: []}
            ]
          });
        }
        if (flag2) {
          db.collection("Contract").doc(dataList[0].elementAt(0)).update({
            "Paid": [
              ...paidDays,
              {email: []}
            ]
          });
        }
        return "Successfully subscribed to contract!";
      } catch (e) {
        l.log(e.toString());
        return null;
      }
    } else {
      // if(selectedContracts[0]['Code']==code){

      // return "You are already subscribed to contract!";
      // }
      return "You are already subscribed to contract!";
    }
  }

  Future<dynamic> getEmployeesContractAttendance(
      String code, String email) async {
    List selectedContracts = await getParticularContractsWithCode(email, code);

    if (selectedContracts.isNotEmpty) {
      final querySnapshot =
          await db.collection("Contract").where("Code", isEqualTo: code).get();
      String docId;
      List<Set> dataList = querySnapshot.docs
          .map((doc) => {docId = doc.id, doc.data()} as Set)
          .toList();

      List attendances = dataList[0].elementAt(1)['Attendance'] as List;
      List markedAttendance = [];
      for (var emp in attendances) {
        var employee = emp as Map<String, dynamic>;
        if (employee.keys.first == email) {
          return [
            dataList[0].elementAt(1)['Start-Date'],
            employee,
            dataList[0].elementAt(1)['End-Date']
          ];
        }
      }
      return null;
      // db
      //     .collection("Contract")
      //     .doc(dataList[0].elementAt(0))
      //     .update({"Attendance": markedAttendance});
      // return markedAttendance.toString();
    } else {
      // if(selectedContracts[0]['Code']==code){

      // return "You are already subscribed to contract!";
      // }
      // return "You are already subscribed to contract!";
      return null;
    }
  }

  Future<String> updateEmployeesContractAttendance(
      String code, String email, bool att) async {
    List selectedContracts = await getParticularContractsWithCode(email, code);

    if (selectedContracts.isNotEmpty) {
      final querySnapshot =
          await db.collection("Contract").where("Code", isEqualTo: code).get();
      String docId;
      List<Set> dataList = querySnapshot.docs
          .map((doc) => {docId = doc.id, doc.data()} as Set)
          .toList();

      List attendances = dataList[0].elementAt(1)['Attendance'] as List;
      List markedAttendance = [];
      for (var emp in attendances) {
        var employee = emp as Map<String, dynamic>;
        if (employee.keys.first == email) {
          // markedAttendance = employee.values.first as List;
          markedAttendance.add({
            employee.keys.first: [...employee.values.first, att]
          });
        } else {
          markedAttendance.add(employee);
        }
      }

      db
          .collection("Contract")
          .doc(dataList[0].elementAt(0))
          .update({"Attendance": markedAttendance});
      return markedAttendance.toString();
    } else {
      // if(selectedContracts[0]['Code']==code){

      // return "You are already subscribed to contract!";
      // }
      return "You are already subscribed to contract!";
    }
  }

  Future<String> updateEmployeesContractPayment(
      String code, String email, List<bool> att) async {
    List selectedContracts = await getParticularContractsWithCode(email, code);
    if (selectedContracts.isNotEmpty) {
      final querySnapshot =
          await db.collection("Contract").where("Code", isEqualTo: code).get();
      String docId;
      List<Set> dataList = querySnapshot.docs
          .map((doc) => {docId = doc.id, doc.data()} as Set)
          .toList();
      List attendances = dataList[0].elementAt(1)['Paid'] as List;
      List markedAttendance = [];
      l.log(attendances.toString());
      for (var emp in attendances) {
        var employee = emp as Map<String, dynamic>;
        l.log('message');
        if (employee.keys.first == email) {
          // markedAttendance = employee.values.first as List;
          markedAttendance.add({
            employee.keys.first: [...employee.values.first, ...att]
          });
        } else {
          markedAttendance.add(employee);
        }
      }

      db
          .collection("Contract")
          .doc(dataList[0].elementAt(0))
          .update({"Paid": markedAttendance});
      return markedAttendance.toString();
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

  Future<String?> getTotalNumberOfWorkingDays(String code) async {
    try {
      final querySnapshot =
          await db.collection("Contract").where("Code", isEqualTo: code).get();
      final dataList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return dataList[0]['End-Date'].toString();
    } catch (e) {
      return null;
    }
  }

  Future<List> getEmployerDetails(String email) async {
    final querySnapshot =
        await db.collection("Employer").where("email", isEqualTo: email).get();

    final dataList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    return dataList;
  }

  Future<List> getEmployeeDetails(String email) async {
    final querySnapshot =
        await db.collection("Employee").where("email", isEqualTo: email).get();

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
      String dd,
      String mm,
      String yy,
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
      "Start-Date": "${dd}/${mm}/${yy}",
      "End-Date": endDate,
      "Hourly-Rate": hourlyRate,
      "Benefits": benefits,
      "Description": description,
      "Code": getRandomString(5),
      "Employees": [],
      "Attendance": [],
      "Paid": []
    };

    db.collection("Contract").add(contractDetails).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));
  }
}
