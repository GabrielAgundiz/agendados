// Importación de paquetes y servicios necesarios
import 'package:agendados/controllers/task_controller.dart';
import 'package:agendados/models/task.dart';
import 'package:agendados/services/notification_services.dart';
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

  // Variable que almacena la instancia de NotifyHelper
  var notifyHelper;

  // Método que se llama cuando se inicializa el widget
  @override
  void initState() {
    super.initState();
    // Inicializa la instancia de NotifyHelper
    notifyHelper = NotifyHelper();
    // Inicializa las notificaciones
    notifyHelper.initializeNotification();
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
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];
              print(task.toJson());
              if (task.repeat == 'Daily') {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (task.repeat == 'Weekly') {
                // Ajusta el formato de la fecha según el formato de tus fechas
                DateFormat dateFormat = DateFormat("MM/dd/yyyy");

                // Usa directamente el valor de `task.date` y `_selectedDate`
                String taskDateString = task.date.toString();
                String currentDateString =
                    DateFormat('MM/dd/yyyy').format(_selectedDate);

                DateTime taskDate = dateFormat.parse(taskDateString);
                DateTime currentDate = dateFormat.parse(currentDateString);

                DateTime adjustedCurrentDate = currentDate.add(Duration(
                    days: 7 *
                        ((currentDate.weekday - taskDate.weekday + 7) % 7)));

                if (adjustedCurrentDate.year == currentDate.year &&
                    adjustedCurrentDate.month == currentDate.month &&
                    adjustedCurrentDate.day == currentDate.day) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, task);
                              },
                              child: TaskTile(task),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
              if (task.repeat == 'Monthly') {
                // Ajusta el formato de la fecha según el formato de tus fechas
                DateFormat dateFormat = DateFormat("MM/dd/yyyy");

                // Usa directamente el valor de `task.date` y `_selectedDate`
                String taskDateString = task.date.toString();
                String currentDateString =
                    DateFormat('MM/dd/yyyy').format(_selectedDate);

                DateTime taskDate = dateFormat.parse(taskDateString);
                DateTime currentDate = dateFormat.parse(currentDateString);

                // Verifica si el día del mes y el mes son iguales
                if (taskDate.day == currentDate.day) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, task);
                              },
                              child: TaskTile(task),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.31,
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
            ),
            const Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Task Completed",
                    onTap: () {
                      _taskController.markTaskCompleted(task.id!);
                      Get.back();
                    },
                    clr: primaryClr,
                    context: context,
                  ),
            const SizedBox(
              height: 10,
            ),
            _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);
                Get.back();
                Get.snackbar("Deleted", "Task was deleted successfully",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                    colorText: greenClr,
                    icon: const Icon(
                      Icons.delete_outline,
                      color: greenClr,
                    ));
              },
              clr: Colors.red[400]!,
              context: context,
            ),
            const SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              clr: Colors.red[400]!,
              isClose: true,
              context: context,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClose == true
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(
          label,
          style:
              isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
        )),
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
          backgroundImage: AssetImage("images/profile.png"),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
