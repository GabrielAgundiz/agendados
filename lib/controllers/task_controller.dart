import 'package:agendados/db/db_helper.dart';
import 'package:agendados/models/task.dart';
import 'package:get/get.dart';

// Clase TaskController que extiende de GetxController
class TaskController extends GetxController {
  
  // Método que se llama cuando el controlador está listo
  @override
  void onReady(){
    super.onReady();
    // No hace nada en este caso, pero se puede utilizar para inicializar algo cuando el controlador esté listo
  }

  var taskList = <Task>[].obs;

  // Método que agrega una tarea a la base de datos
  Future<int> addTask({Task? task}) async {
    // Llama al método insert de DBHelper y pasa la tarea como parámetro
    // El método insert devuelve el ID de la tarea insertada
    return await DBHelper.insert(task);
  }

  void getTasks() async{
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task){
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }

}