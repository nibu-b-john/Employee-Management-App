import 'dart:developer';
import 'package:employer_v1/Screens/Employee/contractPage.dart';
import 'package:employer_v1/Screens/Employee/homePage.dart';
import 'package:employer_v1/Screens/Employer/contractPage.dart';
import 'package:employer_v1/Screens/Employer/homePage.dart';
import 'package:employer_v1/Screens/Employer/newContractPage.dart';
import 'package:employer_v1/Screens/loginPage.dart';
import 'package:employer_v1/Screens/Employee/personalDetails.dart';
import 'package:employer_v1/Screens/registerPage.dart';
import 'package:employer_v1/notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  log("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().initNotification();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getToken().then((value) => log(value.toString()));
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      NotificationService().showNotification(
          title: message.notification!.title, body: message.notification!.body);
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            primary: Color(0xFF00294B),
            secondary: Color.fromARGB(255, 8, 8, 8)),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/register': ((context) => const RegisterPage()),
        '/login': ((context) => const LoginPage()),
        // '/employer-home': ((context) => ContractPage()),
        '/employee-home': ((context) => const EmployeeHomePage()),
        // '/new-contract': ((context) => const NewContract()),
        // '/home':
      },
    );
  }
}
