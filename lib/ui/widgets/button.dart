import 'package:agendados/ui/theme.dart';
import 'package:flutter/material.dart';

// Clase MyButton que representa un botón personalizado en la aplicación
class MyButton extends StatelessWidget {
  // Variables que representan el texto y la función del botón
  final String label;
  final Function() onTap;

  // Constructor que inicializa las variables
  const MyButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Devuelve un GestureDetector que detecta el toque en el botón
    return GestureDetector(
      // Llama a la función onTap cuando se detecta un toque en el botón
      onTap: onTap,
      // Devuelve un Container que representa el botón
      child: Container(
        // Establece el ancho y la altura del botón
        width: 100,
        height: 60,
        // Establece el borde y el fondo del botón
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr,
        ),
        // Devuelve un Center que contiene el texto del botón
        child: Center(
          // Devuelve el texto del botón
          child: Text(
            // Establece el texto del botón
            label,
            // Establece el estilo del texto del botón
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}