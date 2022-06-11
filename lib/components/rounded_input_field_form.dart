import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedInputFieldForm extends StatelessWidget {
  final String hintText;
  final TextStyle valueStyle;
  final TextEditingController controller;
  RoundedInputFieldForm({
    Key? key,
    required this.hintText,
    required this.valueStyle,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // TextFieldContainer(
        //   child:
        TextField(
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFfcabaa), width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFfcabaa), width: 2),
        ),
        hintText: hintText,
        // hintStyle: const TextStyle(
        //   color: Color(0xFF2F2F2F),
        //   fontWeight: FontWeight.w300,
        //   fontSize: 14,
        //   letterSpacing: -0.2,
        //   height: 2,
        // ),
        border: InputBorder.none,
      ),
      style: GoogleFonts.poppins(
        fontSize: 14,
      ),
      controller: controller,
    );
    // );
  }
}
