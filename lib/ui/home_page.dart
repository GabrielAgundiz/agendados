// Importación de paquetes y servicios necesarios
import 'package:agendados/services/notification_services.dart';
import 'package:agendados/services/theme_services.dart';
import 'package:agendados/ui/add_task_bar.dart';
import 'package:agendados/ui/theme.dart';
import 'package:agendados/ui/widgets/button.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
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
        ],
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
            _selectedDate = date;
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
              onTap: () => Get.to(const AddTaskPage()))
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
