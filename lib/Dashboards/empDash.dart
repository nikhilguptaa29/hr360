import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr360/Services/Firebase/attendanceServices.dart';
import 'package:hr360/Services/Firebase/authServices.dart';
import 'package:slider_button/slider_button.dart';

class EmpDash extends StatefulWidget {
  final String empId;
  final String empName;
  const EmpDash({super.key, required this.empId, required this.empName});

  @override
  State<EmpDash> createState() => _EmpDashState();
}

class _EmpDashState extends State<EmpDash> {
  final Authservices _authservices = Authservices();
  final Attendanceservices _attendanceservices = Attendanceservices();
  @override
  Widget build(BuildContext context) {
    final String empId = widget.empId;
    final String empName = widget.empName;
    bool isPresent;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hello , $empName ✌️",
                        style: GoogleFonts.manrope(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CircleAvatar(),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 11, 224, 58),
                          Colors.blueAccent,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: SliderButton(
                      action: () async => await _attendanceservices.checkIn(empId,empName),
                      icon: Icon(Icons.login),
                      backgroundColor: Colors.transparent,
                      buttonColor: Colors.white60,
                      label: Text(
                        "Check In",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      alignLabel: Alignment.center,
                      shimmer: true,
                      vibrationFlag: true,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 11, 224, 58),
                          Colors.blueAccent,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                    child: SliderButton(
                      action: () => _attendanceservices.checkOut(empId,empName),
                      icon: Icon(Icons.login),
                      backgroundColor: Colors.transparent,
                      buttonColor: Colors.white60,
                      label: Text(
                        "Check Out",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      alignLabel: Alignment.center,
                      shimmer: true,
                      vibrationFlag: true,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        // appBar: AppBar(
        //   title: Text("Employee"),
        //   centerTitle: true,
        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         _authservices.signOut();
        //         Navigator.pushReplacementNamed(context, '/login');
        //       },
        //       icon: Icon(Icons.power_settings_new),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
