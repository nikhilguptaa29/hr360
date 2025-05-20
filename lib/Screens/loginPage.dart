import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hr360/Dashboards/empDash.dart';
import 'package:hr360/Screens/signupPage.dart';
import 'package:hr360/Services/Firebase/authServices.dart';
import 'package:hr360/Widgets/customWidgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isLoading = false;

  final Authservices _authservices = Authservices();
  void login() async {
    setState(() {
      isLoading = true;
    });

    // Call Login method from Auth Services....

    final user = await _authservices.login(
      email: emailController.text,
      password: passController.text,
    );
    setState(() {
      isLoading = false;
    });
    final result = await _authservices.fetchUserRole(user!.uid);
    final name = await _authservices.getUserName(user.uid);

    if (result == "HR" && kIsWeb) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Welcome HR")));
      Navigator.pushReplacementNamed(context, '/hr');
    } else if (result == "Employee") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmpDash(empId: user.uid, empName: name!),
        ),
      );
    } else if (result == "Manager") {
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text("Welcome HR")));
      Navigator.pushReplacementNamed(context, '/mngr');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              child: Column(
                children: [
                  Image.asset(
                    "Assets/Images/login.jpg",
                    width: MediaQuery.sizeOf(context).width / 3,
                  ),
                  Text(
                    "Login",
                    style: GoogleFonts.manrope(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomTextForm(
                    hntTxt: "E-Mail",
                    lblTxt: "E-Mail",
                    isPass: false,
                    controller: emailController,
                    icon: Icon(Icons.mail_lock_rounded),
                  ),
                  SizedBox(height: 10),
                  CustomTextForm(
                    hntTxt: "Password",
                    lblTxt: "Password",
                    isPass: true,
                    controller: passController,
                    icon: Icon(Icons.lock),
                  ),
                  SizedBox(height: 10),
                  CustButton(func: login, btnTxt: "Login"),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an Account ??"),
                        SizedBox(width: 5),
                        InkWell(
                          child: Text(
                            "Create an Account",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 51, 6, 231),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap:
                              () => Navigator.pushReplacementNamed(
                                context,
                                '/signup',
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
