import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hr360/Dashboards/empDash.dart';
import 'package:hr360/Dashboards/hrDash.dart';
import 'package:hr360/Dashboards/mngrDash.dart';
import 'package:hr360/Screens/loginPage.dart';
import 'package:hr360/Screens/signupPage.dart';
import 'package:hr360/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/hr': (context) => HrDash(),
        '/emp': (context) => EmpDash(),
        '/mngr': (context) => ManagerDash(),
      },
      initialRoute: '/login',
    );
  }
}
