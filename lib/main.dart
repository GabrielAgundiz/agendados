import 'package:agendados/db/db_helper.dart';
import 'package:agendados/services/notification_services.dart';
import 'package:agendados/ui/home_page.dart';
import 'package:agendados/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:agendados/services/theme_services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DBHelper.initDb();
  await NotifyHelper().initializeNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Agenda2',
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeService().theme,
        home: HomePage());
  }
}