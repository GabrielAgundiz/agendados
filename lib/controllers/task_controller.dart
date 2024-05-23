import 'package:agendados/db/db_helper.dart';
import 'package:agendados/models/task.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';  // Importa la librería intl para trabajar con fechas

// Clase TaskController que extiende de GetxController
class TaskController extends GetxController {
  
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id) async {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    await DBHelper.update(id, {
      'isCompleted': 1,
      'completionDate': formattedDate
    });
    getTasks();
  }
}
