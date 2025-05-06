import 'package:flutter/material.dart';
import 'package:hr360/Services/Firebase/authServices.dart';

class EmpDash extends StatefulWidget {
  const EmpDash({super.key});

  @override
  State<EmpDash> createState() => _EmpDashState();
}

class _EmpDashState extends State<EmpDash> {
  final Authservices _authservices = Authservices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _authservices.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }
}
