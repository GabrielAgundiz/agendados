import 'package:agendados/models/task.dart';
import 'package:sqflite/sqflite.dart';

// Clase DBHelper que se encarga de interactuar con la base de datos
class DBHelper {
  // Variable estática que almacena la instancia de la base de datos
  static Database? _db;

  // Versión de la base de datos
  static final int _version = 1;

  // Nombre de la tabla que se va a crear en la base de datos
  static final String _tableName = "tasks";

  // Método que inicializa la base de datos
  static Future<void> initDb() async {
    // Si la base de datos ya está inicializada, no hace nada
    if (_db != null) {
      return;
    }
    try {
      // Obtiene la ruta del directorio de bases de datos
      String _path = await getDatabasesPath() + 'tasks.db';

      // Abre la base de datos en la ruta especificada
      _db = await openDatabase(
        _path,
        version: _version,
        // Callback que se llama cuando se crea la base de datos por primera vez
        onCreate: (db, version) {
          print("Creating a new one'");
          // Crea la tabla "tasks" con las columnas especificadas
          return db.execute("CREATE TABLE $_tableName("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "title STRING, note TEXT, date STRING,"
              "startTime STRING, endTime STRING,"
              "remind INTEGER, repeat STRING,"
              "color INTEGER, isCompleted INTEGER"
              ");");
        },
      );
    } catch (e) {
      // Captura cualquier error que ocurra durante la inicialización de la base de datos
      print(e);
    }
  }

  // Método que inserta una tarea en la base de datos
  static Future<int> insert(Task? task) async {
    // Inserta la tarea en la tabla "tasks" y devuelve el ID de la tarea insertada
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
    UPDATE tasks 
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  }
}
