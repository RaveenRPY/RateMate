import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyling {
  static TextStyle thin14Grey() {
    return GoogleFonts.poppins(color: Colors.grey, fontSize: 14);
  }
  static TextStyle medium14White() {
    return GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white);
  }
  static TextStyle medium16White() {
    return GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white);
  }
  static TextStyle bold16White() {
    return GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white);
  }
  static TextStyle bold20White() {
    return GoogleFonts.orbit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  }
  static TextStyle medium30White() {
    return GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white, fontStyle: FontStyle.italic);
  }
}
