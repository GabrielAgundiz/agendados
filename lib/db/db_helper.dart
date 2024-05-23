import 'package:agendados/models/task.dart';
import 'package:sqflite/sqflite.dart';

// Clase DBHelper que se encarga de interactuar con la base de datos
class DBHelper {
  // Variable estática que almacena la instancia de la base de datos
  static Database? _db;

  // Versión de la base de datos
  static final int _version = 2;  // Incrementa la versión de la base de datos

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
              "color INTEGER, isCompleted INTEGER,"
              "completionDate STRING"
              ");");
        },
        // Callback que se llama cuando la base de datos necesita ser actualizada
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await db.execute("ALTER TABLE $_tableName ADD COLUMN completionDate STRING;");
          }
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

 // Consulta todas las filas de la tabla y devuelve una lista de mapas
static Future<List<Map<String, dynamic>>> query() async {
  // Ejecuta una consulta SELECT en la tabla y devuelve el resultado
  return await _db!.query(_tableName);
}

// Elimina una tarea específica de la tabla
static delete(Task task) async {
  // Ejecuta una instrucción DELETE en la tabla donde el id coincide con el de la tarea
  return await _db!.delete(
    _tableName, // Nombre de la tabla
    where: 'id=?', // Condición para identificar la fila a eliminar
    whereArgs: [task.id], // Argumento de la condición (id de la tarea)
  );
}

// Actualiza una fila específica de la tabla con los valores proporcionados
static Future<int> update(int id, Map<String, dynamic> values) async {
  // Ejecuta una instrucción UPDATE en la tabla
  return await _db!.update(
    _tableName, // Nombre de la tabla
    values, // Valores nuevos para actualizar la fila
    where: 'id = ?', // Condición para identificar la fila a actualizar
    whereArgs: [id], // Argumento de la condición (id de la fila a actualizar)
  );
}

}
