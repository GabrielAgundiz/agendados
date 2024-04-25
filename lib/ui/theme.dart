import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Define colores personalizados que se utilizarán en la aplicación
const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color greenClr = Color.fromARGB(255, 64, 180, 93);
const Color white = Colors.white;
const Color primaryClr = bluishClr; // Establece el color primario de la aplicación
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = Color(0xFF424242); // Color para los headers en modo oscuro

// Clase Themes que contiene los temas de la aplicación
class Themes {
  // Tema claro
  static final light = ThemeData(
    useMaterial3: false, // Indica si se utiliza Material Design 3
    backgroundColor: Colors.white, // Color de fondo para el tema claro
    primaryColor: primaryClr, // Color primario para el tema claro
    brightness: Brightness.light, // Brillo del tema claro
  );
  
  // Tema oscuro
  static final dark = ThemeData(
    useMaterial3: false, // Indica si se utiliza Material Design 3
    backgroundColor: darkGreyClr, // Color de fondo para el tema oscuro
    primaryColor: darkGreyClr, // Color primario para el tema oscuro
    brightness: Brightness.dark, // Brillo del tema oscuro
  );
}

// Función que devuelve el estilo de texto para los subtítulos
TextStyle get subHeadingStyle { 
  return GoogleFonts.lato( // Tipografia del texto para los subtítulos
      textStyle: const TextStyle(
    fontSize: 24, // Tamano del texto para los subtítulos
    fontWeight: FontWeight.bold, // Grosor del texto para los subtítulos
    color: Colors.grey, // Color del texto para los subtítulos
  ));
}

// Función que devuelve el estilo de texto para los títulos principales
TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  ));
}

// Función que devuelve el estilo de texto para los títulos
TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ));
}

// Función que devuelve el estilo de texto para los subtítulos
TextStyle get subtitleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.grey, // Color del texto para los subtítulos
  ));
}