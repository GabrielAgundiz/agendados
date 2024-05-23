import 'package:agendados/db/db_helper.dart';
import 'package:agendados/services/notification_services.dart';
import 'package:agendados/ui/home_page.dart';
import 'package:agendados/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:agendados/services/theme_services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

// Función principal que se ejecuta cuando se inicia la aplicación
Future<void> main() async {
  // Asegura que los widgets estén inicializados antes de ejecutar cualquier código asíncrono
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa el almacenamiento local con GetStorage
  await GetStorage.init();

  // Inicializa la base de datos con DBHelper
  await DBHelper.initDb();

  // Llama al método `runApp` y pasa la instancia de MyApp
  runApp(const MyApp());
}

// Clase MyApp que extiende de StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Método que construye el widget de la aplicación
  @override
  Widget build(BuildContext context) {
  
    return GetMaterialApp(
        title: 'Agenda2',
        // Oculta el banner de depuración
        debugShowCheckedModeBanner: false,
        // Establece el tema ligero
        theme: Themes.light,
        // Establece el tema oscuro
        darkTheme: Themes.dark,
        // Establece el tema actual en función del tema seleccionado en ThemeService
        themeMode: ThemeService().theme,
        // Establece la página de inicio en HomePage
        home: HomePage());
  }


}


