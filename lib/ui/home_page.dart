// Importación de paquetes y servicios necesarios
import 'package:agendados/controllers/task_controller.dart';
import 'package:agendados/models/task.dart';
import 'package:agendados/services/theme_services.dart';
import 'package:agendados/ui/add_task_bar.dart';
import 'package:agendados/ui/theme.dart';
import 'package:agendados/ui/widgets/button.dart';
import 'package:agendados/ui/widgets/task_tile.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// Clase HomePage que extiende de StatefulWidget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // Método que devuelve el estado de la página
  State<HomePage> createState() => _HomePageState();
}

// Clase _HomePageState que extiende de State<HomePage>
class _HomePageState extends State<HomePage> {
  // Variable que almacena la fecha seleccionada
  DateTime _selectedDate = DateTime.now();

  final _taskController = Get.put(TaskController());

  // Método que se llama cuando se inicializa el widget
  @override
  void initState() {
    super.initState();
  }

  // Método que construye la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    _taskController.getTasks();
    return Scaffold(
      // AppBar personalizado
      appBar: _appBar(),
      // Color de fondo de la pantalla
      backgroundColor: context.theme.backgroundColor,
      // Contenido de la pantalla
      body: Column(
        children: [
          // Espacio en blanco de 10 pixels
          const SizedBox(
            height: 10,
          ),
          // Barra de tareas
          _addTaskBar(),
          // Barra de fechas
          _addDateBar(),
          const SizedBox(
            height: 15,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    // Se crea un widget Expanded para ocupar el espacio disponible
    return Expanded(
      // Obx es un widget de GetX que permite la reactividad
      child: Obx(() {
        // ListView.builder crea una lista de elementos de forma dinámica
        return ListView.builder(
          itemCount:
              _taskController.taskList.length, // Número de tareas en la lista
          itemBuilder: (_, index) {
            Task task =
                _taskController.taskList[index]; // Se obtiene la tarea actual
            print(task
                .toJson()); // Se imprime la tarea en formato JSON para debug

            // Si la tarea se repite diariamente
            if (task.repeat == 'Daily') {
              // Se configura una animación para la lista
              return AnimationConfiguration.staggeredList(
                position: index, // Posición del elemento en la lista
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context,
                                task); // Muestra un BottomSheet al hacer tap
                          },
                          child: TaskTile(task,
                              _selectedDate), // Muestra la tarea en un TaskTile
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // Si la tarea se repite semanalmente
            if (task.repeat == 'Weekly') {
              // Se define el formato de fecha
              DateFormat dateFormat = DateFormat("MM/dd/yyyy");

              // Se convierte la fecha de la tarea y la fecha seleccionada a String
              String taskDateString = task.date.toString();
              String currentDateString =
                  DateFormat('MM/dd/yyyy').format(_selectedDate);

              // Se parsean las fechas de String a DateTime
              DateTime taskDate = dateFormat.parse(taskDateString);
              DateTime currentDate = dateFormat.parse(currentDateString);

              // Se ajusta la fecha actual a la siguiente ocurrencia semanal de la tarea
              DateTime adjustedCurrentDate = currentDate.add(Duration(
                  days:
                      7 * ((currentDate.weekday - taskDate.weekday + 7) % 7)));

              // Si la fecha ajustada coincide con la fecha actual
              if (adjustedCurrentDate.year == currentDate.year &&
                  adjustedCurrentDate.month == currentDate.month &&
                  adjustedCurrentDate.day == currentDate.day) {
                // Se configura una animación para la lista
                return AnimationConfiguration.staggeredList(
                  position: index, // Posición del elemento en la lista
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context,
                                  task); // Muestra un BottomSheet al hacer tap
                            },
                            child: TaskTile(task,
                                _selectedDate), // Muestra la tarea en un TaskTile
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }

            // Si la tarea se repite mensualmente
            if (task.repeat == 'Monthly') {
              // Se define el formato de fecha
              DateFormat dateFormat = DateFormat("MM/dd/yyyy");

              // Se convierte la fecha de la tarea y la fecha seleccionada a String
              String taskDateString = task.date.toString();
              String currentDateString =
                  DateFormat('MM/dd/yyyy').format(_selectedDate);

              // Se parsean las fechas de String a DateTime
              DateTime taskDate = dateFormat.parse(taskDateString);
              DateTime currentDate = dateFormat.parse(currentDateString);

              // Si el día del mes de la tarea coincide con el día del mes actual
              if (taskDate.day == currentDate.day) {
                // Se configura una animación para la lista
                return AnimationConfiguration.staggeredList(
                  position: index, // Posición del elemento en la lista
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context,
                                  task); // Muestra un BottomSheet al hacer tap
                            },
                            child: TaskTile(task,
                                _selectedDate), // Muestra la tarea en un TaskTile
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }

            // Si la fecha de la tarea coincide exactamente con la fecha seleccionada
            if (task.date == DateFormat.yMd().format(_selectedDate)) {
              // Se configura una animación para la lista
              return AnimationConfiguration.staggeredList(
                position: index, // Posición del elemento en la lista
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context,
                                task); // Muestra un BottomSheet al hacer tap
                          },
                          child: TaskTile(task,
                              _selectedDate), // Muestra la tarea en un TaskTile
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // Si no hay coincidencia, se devuelve un contenedor vacío
              return Container();
            }
          },
        );
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    // Muestra un BottomSheet en la parte inferior de la pantalla
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4), // Espaciado superior
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height *
                0.24 // Altura si la tarea está completada
            : MediaQuery.of(context).size.height *
                0.31, // Altura si la tarea no está completada
        color: Get.isDarkMode
            ? darkGreyClr
            : Colors.white, // Color según el modo (oscuro o claro)
        child: Column(
          children: [
            // Barra indicadora para arrastrar el BottomSheet
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
                color: Get.isDarkMode
                    ? Colors.grey[600]
                    : Colors.grey[300], // Color según el modo
              ),
            ),
            const Spacer(), // Espacio flexible
            // Verifica si la tarea está completada y si la fecha de completado es hoy
            task.isCompleted == 1 &&
                    task.completionDate ==
                        DateFormat('yyyy-MM-dd').format(DateTime.now())
                ? Container() // Si es así, no muestra el botón de "Task Completed"
                : _bottomSheetButton(
                    label: "Task Completed",
                    onTap: () {
                      _taskController.markTaskCompleted(
                          task.id!); // Marca la tarea como completada
                      Get.back(); // Cierra el BottomSheet
                    },
                    clr: primaryClr, // Color del botón
                    context: context,
                  ),
            const SizedBox(
              height: 10, // Espaciado entre botones
            ),
            // Botón para eliminar la tarea
            _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task); // Elimina la tarea
                Get.back(); // Cierra el BottomSheet
                // Muestra una notificación de que la tarea fue eliminada
                Get.snackbar("Deleted", "Task was deleted successfully",
                    snackPosition:
                        SnackPosition.BOTTOM, // Posición de la notificación
                    backgroundColor: Colors.white, // Color de fondo
                    colorText: greenClr, // Color del texto
                    icon: const Icon(
                      Icons.delete_outline, // Icono de la notificación
                      color: greenClr,
                    ));
              },
              clr: Colors.red[400]!, // Color del botón
              context: context,
            ),
            const SizedBox(
              height: 20, // Espaciado entre botones
            ),
            // Botón para cerrar el BottomSheet
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back(); // Cierra el BottomSheet
              },
              clr: Colors.red[400]!, // Color del botón
              isClose: true, // Indica que este botón es para cerrar
              context: context,
            ),
            const SizedBox(
              height: 10, // Espaciado final
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String label, // Etiqueta del botón
    required Function()?
        onTap, // Función que se ejecutará al presionar el botón
    required Color clr, // Color del botón
    bool isClose = false, // Indica si el botón es para cerrar
    required BuildContext context, // Contexto de la aplicación
  }) {
    return GestureDetector(
      onTap:
          onTap, // Se llama a la función pasada cuando el botón es presionado
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: 4), // Margen vertical del botón
        height: 55, // Altura del botón
        width: MediaQuery.of(context).size.width *
            0.9, // Ancho del botón como el 90% del ancho de la pantalla
        decoration: BoxDecoration(
          border: Border.all(
              width: 2, // Ancho del borde
              color: isClose == true // Si el botón es para cerrar
                  ? Get.isDarkMode // Dependiendo del modo (oscuro o claro)
                      ? Colors.grey[600]! // Color del borde en modo oscuro
                      : Colors.grey[300]! // Color del borde en modo claro
                  : clr // Si no es para cerrar, usa el color proporcionado
              ),
          borderRadius: BorderRadius.circular(20), // Bordes redondeados
          color: isClose == true ? Colors.transparent : clr, // Color de fondo
        ),
        child: Center(
          child: Text(
            label, // Texto del botón
            style: isClose // Si el botón es para cerrar
                ? titleStyle // Estilo del título
                : titleStyle.copyWith(
                    color: Colors
                        .white), // Estilo del título con color blanco para el texto
          ),
        ),
      ),
    );
  }

  // Método que devuelve la barra de fechas
  _addDateBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Container(
        child: DatePicker(
          // Fecha actual
          DateTime.now(),
          //Dimensiones
          height: 100,
          width: 80,
          // Fecha seleccionada inicialmente
          initialSelectedDate: DateTime.now(),
          // Color de selección
          selectionColor: primaryClr,
          // Color de texto seleccionado
          selectedTextColor: Colors.white,
          // Estilo de texto de fecha
          dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          // Estilo de texto de día
          dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          // Estilo de texto de mes
          monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          // Función que se llama cuando se cambia la fecha
          onDateChange: (date) {
            setState(() {
              _selectedDate = date;
            });
          },
        ),
      ),
    );
  }

  _addTaskBar() {
    // Devuelve un widget Padding que agrega un padding horizontal de 20 unidades a su hijo
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        // Alinea los hijos en la fila entre sí, dejando espacio entre ellos
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Columna que contiene dos Text widgets
          Column(
            // Alinea los hijos en la columna al inicio (izquierda)
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Muestra la fecha actual en formato "yyyy MMMM d"
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              // Muestra el texto "Today" con un estilo de título
              Text(
                "Today",
                style: headingStyle,
              ),
            ],
          ),
          // Botón personalizado que muestra el texto "+ Add Task"
          MyButton(
              label: "+ Add Task",
              // Cuando se presiona el botón, navega a la página AddTaskPage
              onTap: () async {
                await Get.to(AddTaskPage());
                _taskController.getTasks();
              }),
        ],
      ),
    );
  }

  _appBar() {
    // Devuelve un widget AppBar con las siguientes propiedades:
    // - elevation: 0 (no hay sombra)
    // - backgroundColor: el color de fondo actual del contexto
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        // Detecta el gesto de tocar el icono del menú
        onTap: () {
          // Cambia el tema entre claro y oscuro
          ThemeService().switchTheme();
          //   notifyHelper.displayNotification(
          //     title: "Tapped",
          //      body: "Notifies works"
          //     );
          // Muestra un snackbar en la parte inferior de la pantalla
          // con el mensaje "Theme Changed" y un ícono que indica
          // si se activó el tema claro o oscuro
          Get.isDarkMode
              ? Get.snackbar("Theme Changed", "Activated Light Theme",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.white,
                  colorText: pinkClr,
                  icon: const Icon(Icons.wb_sunny_outlined, color: pinkClr))
              : Get.snackbar("Theme Changed", "Activated Dark Theme",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.white,
                  colorText: pinkClr,
                  icon: const Icon(Icons.nightlight_outlined, color: pinkClr));
        },
        child: Icon(
          // Muestra un ícono diferente dependiendo del tema actual
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
          size: 20,
          // Cambia el color del ícono dependiendo del tema actual
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      // Muestra un CircleAvatar y un SizedBox a la derecha del AppBar
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage(
            "images/logoagenda.png",
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
