import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";

const Color primaryColor = Color(0xFF4e5ae8);
const Color cardColor = Color(0xFFFFB746);

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 28, 28, 28),
  ));
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 190, 188, 188),
  ));
}
