import 'package:agendados/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Clase MyInputField que representa un campo de entrada personalizado en la aplicación
class MyInputField extends StatelessWidget {
  // Variables que representan el título, el hint, el controlador y el widget del campo de entrada
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  // Constructor que inicializa las variables
  const MyInputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Devuelve un Container que representa el campo de entrada
    return Container(
      // Devuelve un Padding que agrega espacio alrededor del campo de entrada
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          // Establece la alineación del eje cruzado del campo de entrada
          crossAxisAlignment: CrossAxisAlignment.start,
          // Devuelve una lista de widgets que representan los elementos del campo de entrada
          children: [
            // Devuelve el título del campo de entrada
            Text(
              title,
              style: titleStyle,
            ),
            // Devuelve un Padding que agrega espacio alrededor del campo de entrada
            Padding(
              padding: const EdgeInsets.only(top: 8),
              // Devuelve un Container que representa el borde y el fondo del campo de entrada
              child: Container(
                // Establece la altura del campo de entrada
                height: 52,
                // Establece el borde y el fondo del campo de entrada
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                // Devuelve un Padding que agrega espacio alrededor del campo de entrada
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  // Devuelve un Row que contiene el campo de entrada y el widget opcional
                  child: Row(
                    children: [
                      // Devuelve un Expanded que contiene el campo de entrada
                      Expanded(
                        child: TextFormField(
                          // Establece si el campo de entrada es de solo lectura o no
                          readOnly: widget == null ? false : true,
                          // Establece si el campo de entrada está enfocado o no
                          autofocus: false,
                          // Establece el color del cursor del campo de entrada
                          cursorColor: Get.isDarkMode
                              ? Colors.grey[100]
                              : Colors.grey[700],
                          // Establece el controlador del campo de entrada
                          controller: controller,
                          // Establece el estilo del texto del campo de entrada
                          style: subtitleStyle,
                          // Establece la decoración del campo de entrada
                          decoration: InputDecoration(
                            // Establece el hint del campo de entrada
                            hintText: hint,
                            // Establece el estilo del hint del campo de entrada
                            hintStyle: subtitleStyle,
                            // Establece el borde habilitado del campo de entrada
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: context.theme.backgroundColor,
                                width: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Devuelve el widget opcional del campo de entrada
                      widget == null
                          ? Container()
                          : Container(
                              child: widget,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
