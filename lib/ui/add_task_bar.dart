import 'package:agendados/controllers/task_controller.dart';
import 'package:agendados/models/task.dart';
import 'package:agendados/ui/theme.dart';
import 'package:agendados/ui/widgets/button.dart';
import 'package:agendados/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Define una clase para la página de agregar tareas
class AddTaskPage extends StatefulWidget {
  // Constructor de la clase
  const AddTaskPage({super.key});

  // Sobreescribe el método createState para devolver el estado de la página
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

// Define el estado de la página AddTaskPage
class _AddTaskPageState extends State<AddTaskPage> {
  // Instancia de TaskController para manejar operaciones relacionadas con tareas
  final TaskController _taskController = Get.put(TaskController());

  // Controladores de TextEditing para campos de entrada de título y notas
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  // Fecha seleccionada por el usuario, inicializada con la fecha actual
  DateTime _selectedDate = DateTime.now();

  // Tiempos de inicio y finalización de la tarea, inicializados con la hora actual
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = "11:59 PM";

  // Valor seleccionado por el usuario para el recordatorio
  int _selectedRemind = 5;

  // Lista de opciones de recordatorio en minutos
  List<int> remindList = [
    5,
    10,
    15,
    20,
    60,
  ];

  // Valor seleccionado por el usuario para la repetición de la tarea
  String _selectedRepeat = "None";

  // Lista de opciones de repetición
  List<String> repeatList = [
    "None",
    "Daily",
    "Weekly",
    "Monthly",
  ];

  // Valor seleccionado por el usuario para el color de la tarea
  int _selectedColor = 0;

  // Sobreescribe el método build para construir la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Color de fondo de la pantalla
      backgroundColor: context.theme.backgroundColor,
      // Barra de aplicación personalizada
      appBar: _appBar(context),
      // Cuerpo de la pantalla
      body: Container(
        // Contenedor que permite el desplazamiento del contenido
        child: SingleChildScrollView(
          // Padding para dar espacio al contenido
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            // Columna para organizar los widgets de manera vertical
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // Título de la pantalla
                  "Add Task",
                  // Estilo del texto
                  style: headingStyle,
                ),
                MyInputField(
                  // Campo de entrada etiquetado con título "Title"
                  title: "Title",
                  // Valor inicial del campo de entrada
                  hint: "Enter title here",
                  // Controlador del campo de entrada
                  controller: _titleController,
                ),
                MyInputField(
                  // Campo de entrada etiquetado con título "Note"
                  title: "Note",
                  // Valor inicial del campo de entrada
                  hint: "Enter notes here",
                  // Controlador del campo de entrada
                  controller: _noteController,
                ),
                MyInputField(
                  // Campo de entrada etiquetado con título "Date"
                  title: "Date",
                  // Valor inicial del campo de entrada
                  hint: DateFormat.yMd().format(_selectedDate),
                  // Widget interior del campo de entrada
                  widget: IconButton(
                    // Botón de icono que se muestra en el campo de entrada
                    onPressed: () {
                      // Función que se ejecuta cuando se presiona el botón
                      _getDateFromUser();
                    },
                    // Icono que se muestra en el botón
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      // Color del icono
                      color: Colors.grey,
                    ),
                  ),
                ),
                Row(
                  // Fila que contiene dos campos de entrada con etiquetas
                  children: [
                    Expanded(
                      // Expanded para que el campo de entrada ocupe todo el espacio disponible
                      child: MyInputField(
                        // Título que se muestra en la etiqueta del campo de entrada
                        title: "Start Time",
                        // Valor inicial del campo de entrada
                        hint: _startTime,
                        // Widget interior del campo de entrada
                        widget: IconButton(
                          // Botón de icono que se muestra en el campo de entrada
                          onPressed: () {
                            // Función que se ejecuta cuando se presiona el botón
                            _getTimeFromUser(isStartTime: true);
                          },
                          icon: const Icon(
                            // Icono que se muestra en el botón
                            Icons.access_time_outlined,
                            // Color del icono
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      // Espacio entre los dos campos de entrada
                      width: 12,
                    ),
                    Expanded(
                      // Expanded para que el campo de entrada ocupe todo el espacio disponible
                      child: MyInputField(
                        // Título que se muestra en la etiqueta del campo de entrada
                        title: "End Time",
                        // Valor inicial del campo de entrada
                        hint: _endTime,
                        // Widget interior del campo de entrada
                        widget: IconButton(
                          // Botón de icono que se muestra en el campo de entrada
                          onPressed: () {
                            // Función que se ejecuta cuando se presiona el botón
                            _getTimeFromUser(isStartTime: false);
                          },
                          icon: const Icon(
                            // Icono que se muestra en el botón
                            Icons.access_time_outlined,
                            // Color del icono
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                MyInputField(
                  // Título que se muestra en la etiqueta del campo de entrada
                  title: "Remind",
                  // Valor inicial del DropdownButton
                  hint: "$_selectedRemind minutes early",
                  // Widget interior del campo de entrada
                  widget: DropdownButton<String>(
                    // Icono que se muestra en el DropdownButton
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    // Tamaño del icono
                    iconSize: 32,
                    // Sombra del DropdownButton
                    elevation: 4,
                    // Estilo del texto del DropdownButton
                    style: subtitleStyle,
                    // Elimina la línea de subrayado debajo del DropdownButton
                    underline: Container(
                      height: 0,
                    ),
                    // Función que se ejecuta cuando se selecciona un nuevo valor en el DropdownButton
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRemind = int.parse(newValue!);
                      });
                    },
                    // Lista de elementos que se muestran en el DropdownButton
                    items:
                        remindList.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                        // Valor del elemento
                        value: value.toString(),
                        // Texto que se muestra en el elemento
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ),
                MyInputField(
                  // Título que se muestra en la etiqueta del campo de entrada
                  title: "Repeat",
                  // Valor inicial del DropdownButton
                  hint: _selectedRepeat,
                  // Widget interior del campo de entrada
                  widget: DropdownButton<String>(
                    // Icono que se muestra en el DropdownButton
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    // Tamaño del icono
                    iconSize: 32,
                    // Sombra del DropdownButton
                    elevation: 4,
                    // Estilo del texto del DropdownButton
                    style: subtitleStyle,
                    // Elimina la línea de subrayado debajo del DropdownButton
                    underline: Container(
                      height: 0,
                    ),
                    // Función que se ejecuta cuando se selecciona un nuevo valor en el DropdownButton
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                    // Lista de elementos que se muestran en el DropdownButton
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        // Valor del elemento
                        value: value,
                        // Texto que se muestra en el elemento
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  // Alinear los widgets hijos en el eje principal (horizontal) con un espacio entre ellos
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Alinear los widgets hijos en el eje secundario (vertical) al centro
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // Lista de widgets que se van a mostrar dentro del Row
                  children: [
                    // Llama a la función _colorPallete() que devuelve un widget Column
                    // con una selección de colores para la tarea
                    _colorPallete(),
                    // Crea un botón personalizado utilizando el widget MyButton
                    MyButton(
                      // Etiqueta que se muestra en el botón
                      label: "Create Task",
                      // Función que se ejecuta cuando el botón es presionado
                      onTap: () => _validateDate(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Valida que los campos de título y nota no estén vacíos y agrega la tarea a la base de datos
  _validateDate() {
    // Verifica que los campos de título y nota no estén vacíos
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      // Agrega la tarea a la base de datos y regresa a la pantalla anterior
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      // Si alguno de los campos está vacío, muestra un snackbar con un mensaje de error
      Get.snackbar("Required", "All fields are required!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: pinkClr,
          icon: const Icon(Icons.warning_amber_rounded));
    }
  }

  // Agrega una nueva tarea a la base de datos
  _addTaskToDb() async {
    // Crea una nueva instancia de la clase Task con los datos ingresados por el usuario
    Task newTask = Task(
      note: _noteController.text,
      title: _titleController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _startTime,
      endTime: _endTime,
      remind: _selectedRemind,
      repeat: _selectedRepeat,
      color: _selectedColor,
      isCompleted: 0,
    );
    // Agrega la nueva tarea a la base de datos y guarda el ID de la tarea en la variable value
    int value = await _taskController.addTask(task: newTask);
    // Imprime el ID de la tarea en la consola
    print("My id is " + "$value");
  }

// Devuelve un widget Column que contiene un título y un Wrap con 4 CircleAvatar widgets
  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Muestra el título "Color"
        Text(
          "Color",
          style: titleStyle,
        ),
        const SizedBox(
          height: 8,
        ),
        // Muestra un Wrap con 4 CircleAvatar widgets
        Wrap(
          children: List<Widget>.generate(4, (int index) {
            return GestureDetector(
              // Detecta el gesto de tocar un CircleAvatar
              onTap: () {
                setState(() {
                  // Actualiza la variable _selectedColor con el índice del CircleAvatar seleccionado
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  // Establece el radio del CircleAvatar en 14
                  radius: 14,
                  // Establece el color de fondo del CircleAvatar dependiendo del índice
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : index == 2
                              ? yellowClr
                              : greenClr,
                  // Si el CircleAvatar seleccionado es el actual, muestra un ícono de check
                  child: _selectedColor == index
                      ? const Icon(Icons.done, color: Colors.white, size: 16)
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

// Devuelve un widget AppBar con las siguientes propiedades:
// - elevation: 0 (no hay sombra)
// - backgroundColor: el color de fondo actual del contexto
  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        // Detecta el gesto de tocar el botón de retroceso
        onTap: () {
          // Vuelve a la pantalla anterior
          Get.back();
        },
        child: Icon(
          // Muestra el ícono de flecha hacia atrás
          Icons.arrow_back_ios,
          size: 20,
          // Cambia el color del ícono dependiendo del tema actual
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      // Muestra un CircleAvatar y un SizedBox a la derecha del AppBar
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("images/profile.png"),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

// Solicita al usuario que seleccione una fecha y la guarda en la variable _selectedDate
  _getDateFromUser() async {
    // Muestra el cuadro de diálogo del selector de fecha
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (_pickerDate != null) {
      // Si el usuario selecciona una fecha válida, actualiza la variable _selectedDate
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("Invalid date");
    }
  }

// Solicita al usuario que seleccione una hora y la guarda en la variable correspondiente
  _getTimeFromUser({required bool isStartTime}) async {
    // Muestra el cuadro de diálogo del selector de tiempo
    TimeOfDay? pickedTime = await _showTimePicker();
    if (pickedTime == null) {
      // Si el usuario cancela la selección, imprime un mensaje en la consola
      print("Time cancelled");
    } else {
      // Formatea la hora seleccionada en formato "HH:mm"
      String _formattedTime = "${pickedTime.hour}:${pickedTime.minute}";
      if (isStartTime) {
        // Si se está seleccionando la hora de inicio, actualiza la variable _startTime
        setState(() {
          _startTime = _formattedTime;
        });
      } else {
        // Si se está seleccionando la hora de fin, actualiza la variable _endTime
        setState(() {
          _endTime = _formattedTime;
        });
      }
    }
  }

// Muestra el cuadro de diálogo del selector de tiempo
  Future<TimeOfDay?> _showTimePicker() {
    // Devuelve el resultado de mostrar el selector de tiempo
    return showTimePicker(
      // Establece el modo de entrada inicial en modo de entrada manual
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      // Establece la hora inicial en la hora actual (si se está seleccionando la hora de inicio)
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }
}
