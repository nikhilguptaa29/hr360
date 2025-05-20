import 'package:flutter/material.dart';

class HrDash extends StatefulWidget {
  const HrDash({super.key});

  @override
  State<HrDash> createState() => _HrDashState();
}

class _HrDashState extends State<HrDash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 3, 42, 109),
                child: Column(
                  children: [
                    DrawerHeader(
                      // padding: EdgeInsets.all(40.0),
                      child: Image.asset("Assets/Images/emp1.jpg"),
                    ),
                    ListTile(
                      leading: Image.asset(
                        "Assets/Images/dashboard.png",
                        width: MediaQuery.sizeOf(context).width / 10,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(flex: 8, child: Container(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
