import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hr360/Services/Firebase/authServices.dart';
import 'package:hr360/Widgets/customWidgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String? selectedValue;

  // Creating the instance of AuthServices

  final Authservices _authservices = Authservices();

  void _signup() async {
    // Now Call signup method from AuthServices

    User? result = await _authservices.signup(
      name: nameController.text,
      email: emailController.text,
      password: passController.text,
      role: selectedValue!,
    );
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Registered Successfully... You can now login into the system",
          ),
        ),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Signup Failed... $result"),
          duration: Duration(seconds: 10),
        ),
      );
    }
  }

  // TextEditingController roleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<String> role = ['HR', 'Employee', 'Manager'];

    final EdgeInsets dropDownPadding = EdgeInsets.symmetric(
      horizontal: 40,
      vertical: 10,
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Image.asset(
                    "Assets/Images/signup.jpg",
                    height: MediaQuery.sizeOf(context).height / 3,
                  ),
                ),
                CustomTextForm(
                  hntTxt: "Name",
                  lblTxt: "Name",
                  icon: Icon(Icons.person),
                  isPass: false,
                  controller: nameController,
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  hntTxt: "E-Mail",
                  lblTxt: "E-Mail",
                  icon: Icon(Icons.person),
                  isPass: false,
                  controller: emailController,
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  hntTxt: "Password",
                  lblTxt: "Password",
                  icon: Icon(Icons.person),
                  isPass: true,
                  controller: passController,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: dropDownPadding,
                  child: DropdownButtonFormField(
                    hint: Text("Select Access Level"),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 88, 60, 244),
                          width: 1,
                        ),
                      ),
                    ),
                    value: selectedValue,
                    items:
                        role.map((role) {
                          return DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value!;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                CustButton(func: _signup, btnTxt: "Sign Up"),
                // Sized
                Padding(
                  padding: const EdgeInsets.only(right: 35.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Already have an Account !!"),
                      SizedBox(width: 10),
                      InkWell(
                        child: Text(
                          "Login here",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 51, 6, 231),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap:
                            () => Navigator.pushReplacementNamed(
                              context,
                              '/login',
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
    );
  }
}
