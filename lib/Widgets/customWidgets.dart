import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hntTxt;
  final String lblTxt;
  final EdgeInsets customPadding = EdgeInsets.symmetric(
    horizontal: 40,
    vertical: 5,
  );
  final Radius custRadius = Radius.circular(20);
  final Color borderClr = const Color.fromARGB(255, 88, 60, 244);
  final Color errClr = Colors.red;
  final Icon icon;
  final IconButton? icnBtn;
  final bool isPass;
  final TextEditingController controller;

  CustomTextForm({
    super.key,
    required this.hntTxt,
    required this.lblTxt,
    required this.icon,
    this.icnBtn,
    required this.isPass,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customPadding,
      child: TextFormField(
        controller: controller,
        obscureText: isPass,
        decoration: InputDecoration(
          hintText: hntTxt,
          labelText: lblTxt,
          prefixIcon: icon,
          suffixIcon: icnBtn,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(topLeft: custRadius),
            borderSide: BorderSide(color: borderClr, width: 1.0),
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.only(topLeft: custRadius),
          //   borderSide: BorderSide(
          //     color: borderClr,
          //     width: 1.0,
          //   ),
          // ),
          // disabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.only(topLeft: custRadius),
          //   borderSide: BorderSide(
          //     color: borderClr,
          //     width: 1.0,
          //   ),
          // ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.only(topLeft: custRadius),
            borderSide: BorderSide(color: errClr, width: 1.0),
          ),
        ),
      ),
    );
  }
}

class CustButton extends StatelessWidget {
  final Function() func;
  final String btnTxt;
  final Color btnClr = Colors.blueAccent;
  final Color btnTxtClr = Colors.white;
  final EdgeInsets btnPadding = EdgeInsets.symmetric(
    horizontal: 40,
    vertical: 10,
  );

  CustButton({super.key, required this.func, required this.btnTxt});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: func,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(btnClr),
        foregroundColor: WidgetStatePropertyAll(btnTxtClr),
        padding: WidgetStatePropertyAll(btnPadding),
      ),
      child: Text(btnTxt),
    );
  }
}
