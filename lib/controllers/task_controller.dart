import 'package:agendados/db/db_helper.dart';
import 'package:agendados/models/task.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Importa la librería intl para trabajar con fechas

// Clase TaskController que extiende de GetxController
class TaskController extends GetxController {

  @override
  void onReady() {
    super.onReady(); // Llama al método onReady de la clase padre
  }

  // Lista observable de tareas
  var taskList = <Task>[].obs;

  // Método para agregar una tarea a la base de datos
  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task); // Inserta la tarea en la base de datos
  }

  // Método para obtener todas las tareas de la base de datos
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query(); // Consulta todas las tareas
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList()); // Asigna las tareas a la lista observable
  }

  // Método para eliminar una tarea de la base de datos
  void delete(Task task) {
    DBHelper.delete(task); // Elimina la tarea de la base de datos
    getTasks(); // Actualiza la lista de tareas
  }

  // Método para marcar una tarea como completada
  void markTaskCompleted(int id) async {
    DateTime currentDate = DateTime.now(); // Obtiene la fecha actual
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate); // Formatea la fecha actual
    await DBHelper.update(id, {
      'isCompleted': 1, // Marca la tarea como completada
      'completionDate': formattedDate // Guarda la fecha de completado
    });
    getTasks(); // Actualiza la lista de tareas
  }
}
