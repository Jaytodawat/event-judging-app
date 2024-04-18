import 'package:flutter/material.dart';

import '../../domain/entities/Team.dart';
import '../../../constants.dart';

class CustomTextField extends StatelessWidget {
  final String parameter;
  final Team team;
  CustomTextField({super.key, required this.parameter, required this.team});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
        child: ReusableTextField(
      labelText: parameter,
      obsecureText: false,
      controller: controller,
    ));
  }
}

class ReusableTextField extends StatelessWidget {
  const ReusableTextField(
      {super.key,
      this.controller,
      required this.labelText,
      required this.obsecureText,
      this.icon});
  final String labelText;
  final bool obsecureText;
  final Icon? icon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        obscureText: obsecureText,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.circle_outlined,
            color: Colors.white,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)),
          contentPadding: EdgeInsets.zero,
          label: Text(
            labelText,
            style: const TextStyle(color: Colors.white),
          ),
        ),

      ),
    );
  }
}
//Color(0xFF1D1E33)

// decoration: InputDecoration(
// contentPadding:
// const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
// border: const OutlineInputBorder(
// borderRadius: BorderRadius.all(Radius.circular(10.0)),
// ),
// enabledBorder: const OutlineInputBorder(
// borderSide: BorderSide(color: Colors.black),
// borderRadius: BorderRadius.all(Radius.circular(10.0)),
// ),
// focusedBorder: const OutlineInputBorder(
// borderSide: BorderSide(
// color: Colors.black,
// ),
// borderRadius: BorderRadius.all(Radius.circular(10.0)),
// ),
// fillColor: Colors.white,
// filled: true,
// prefixIcon: icon,
// labelText: labelText,
// labelStyle: const TextStyle(color: Colors.black, fontSize: 13),
// ),
