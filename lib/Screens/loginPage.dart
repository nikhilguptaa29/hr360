import 'package:flutter/material.dart';
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

    String? result = await _authservices.login(
      email: emailController.text,
      password: passController.text,
    );
    setState(() {
      isLoading = false;
    });

    if (result == "HR") {
      ScaffoldMessenger.of(
        context, 
      ).showSnackBar(SnackBar(content: Text("Welcome HR")));
      Navigator.pushReplacementNamed(context, '/hr');
    }
    else if (result == "Employee") {
      Navigator.pushReplacementNamed(context, '/emp');
    }
    else if (result == "Manager") {
      ScaffoldMessenger.of(
        context, 
      ).showSnackBar(SnackBar(content: Text("Welcome HR")));
      Navigator.pushReplacementNamed(context, '/mngr');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              child: Column(
                children: [
                  Image.asset("Assets/Images/login.jpg"),
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
                      mainAxisAlignment: MainAxisAlignment.end,
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
