import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;

  void addUser(
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
    db.collection("Users").add(data).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));
  }

  Future<String> findEmail(String email) async {
    final result =
        await db.collection("Users").where("email", isEqualTo: email).get();
    log(result.docs.toString());
    if (result.docs.isEmpty) {
      return "Not found";
    } else {
      return result.docs.first.data()['type'];
    }
  }

  Future<List> getEmployees() async {
    final querySnapshot =
        await db.collection("Users").where("type", isEqualTo: "Employee").get();

    final dataList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    return dataList;
  }
}
