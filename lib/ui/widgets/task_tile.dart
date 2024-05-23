import 'package:agendados/models/task.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agendados/ui/theme.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final Task? task;
  final DateTime selectedDate;

  TaskTile(this.task, this.selectedDate);

  // Verifica si la tarea está completada en la fecha seleccionada
  bool isTaskCompletedOnSelectedDate(Task task, DateTime selectedDate) {
    String selected = DateFormat('yyyy-MM-dd').format(selectedDate);
    return task.isCompleted == 1 && task.completionDate == selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20), // Padding horizontal
      width: MediaQuery.of(context).size.width, // Ancho del contenedor
      margin: const EdgeInsets.only(bottom: 12), // Margen inferior
      child: Container(
        padding: const EdgeInsets.all(16), // Padding interno
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // Bordes redondeados
          color: _getBGClr(task?.color ?? 0), // Color de fondo según el color de la tarea
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda
                children: [
                  // Título de la tarea
                  Text(
                    task?.title ?? "",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 235, 235, 235),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12), // Espaciado entre elementos
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // Alineación al centro verticalmente
                    children: [
                      Icon(
                        Icons.access_time_rounded, // Icono de tiempo
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const SizedBox(width: 4), // Espaciado entre icono y texto
                      // Horario de la tarea
                      Text(
                        "${task!.startTime} - ${task!.endTime}",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(fontSize: 13, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12), // Espaciado entre elementos
                  // Nota de la tarea
                  Text(
                    task?.note ?? "",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10), // Margen horizontal
              height: 60, // Altura del contenedor
              width: 0.5, // Ancho del contenedor
              color: Colors.grey[200]!.withOpacity(0.7), // Color de fondo con opacidad
            ),
            RotatedBox(
              quarterTurns: 3, // Rota el texto 90 grados
              child: Text(
                isTaskCompletedOnSelectedDate(task!, selectedDate) ? "COMPLETED" : "TO DO", // Texto según el estado de la tarea
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Obtiene el color de fondo según el número de color
  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      case 3:
        return greenClr;
      default:
        return bluishClr;
    }
  }
}
