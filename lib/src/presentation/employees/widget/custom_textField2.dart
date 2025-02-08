import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextField2 extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CustomTextField2({
    super.key,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: GoogleFonts.tomorrow(
          color: Colors.white30,
        ),
        labelStyle: GoogleFonts.tomorrow(
          color: Colors.white60,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: const Color(0xff171717),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.white60,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.white60,
          ),
        ),
      ),
      style: GoogleFonts.tomorrow(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
