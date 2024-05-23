import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

// Clase NotifyHelper que gestiona las notificaciones locales en la aplicación
class NotifyHelper {
  // Instancia de FlutterLocalNotificationsPlugin para manejar las notificaciones
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Método para inicializar las notificaciones y configurar la zona horaria
  initializeNotification() async {
    tz.initializeTimeZones(); // Inicializa las zonas horarias
    final AndroidInitializationSettings initializationSettingsAndroid =
         AndroidInitializationSettings("appicon"); // Configuración para Android

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid); // Configuración general

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,// onSelectNotification: selectNotification,
    ); // Inicializa el plugin de notificaciones locales
  }

  // Método que se ejecuta cuando se selecciona una notificación
  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload'); // Imprime el payload de la notificación
    } else {
      print("Notification Done"); // Imprime un mensaje si no hay payload
    }
    Get.to(() => Container( // Navega a una pantalla vacía
          color: Colors.white,
        ));
  }

  // Método que se ejecuta cuando se recibe una notificación local
  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    Get.dialog(const Text("Welcome")); // Muestra un diálogo con un mensaje de bienvenida
  }

  // Método para mostrar una notificación
  displayNotification({required String title, required String body}) async {
    print("doing test"); // Imprime un mensaje de prueba
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'com.example.agendados.channel_id', 'Agendados Notifications',
        importance: Importance.max, // Prioridad máxima para la notificación
        priority: Priority.high, // Prioridad alta para la notificación
        icon: 'appicon', // Icono de la notificación
        sound: RawResourceAndroidNotificationSound('raw/default_sound.mp3')); // Sonido de la notificación

    var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    // Aquí se debería llamar a show() con los detalles de la notificación, pero falta en el código proporcionado
    await flutterLocalNotificationsPlugin.show(
      0, title, body, platformChannelSpecifics, payload: 'default_sound'
    );
  }

  // Método para programar una notificación
  scheduledNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0, // ID de la notificación
        'scheduled title', // Título de la notificación
        'theme changes 5 seconds ago', // Cuerpo de la notificación
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), // Fecha y hora programada para la notificación
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name')), // Detalles de la notificación para Android
        androidAllowWhileIdle: true, // Permite que la notificación se muestre incluso cuando la app está inactiva
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: DateTimeComponents.time,
            payload: ""
            ); // Interpretación de la fecha de la notificación
  }
}