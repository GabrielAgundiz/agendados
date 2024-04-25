import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import "package:get/get.dart";

// Clase ThemeService que se encarga de gestionar el tema de la aplicación
class ThemeService {
  // Variable privada que representa el almacenamiento local con GetStorage
  final _box = GetStorage();
  // Variable privada que representa la clave en el almacenamiento local
  final _key = 'isDarkMode';

  // Método privado que guarda el tema en el almacenamiento local
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  // Método privado que carga el tema desde el almacenamiento local
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  // Propiedad pública que devuelve el tema actual en función del valor almacenado en el almacenamiento local
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  // Método público que cambia el tema y guarda el nuevo tema en el almacenamiento local
  void switchTheme() {
    // Cambia el tema de la aplicación con Get.changeThemeMode
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    // Guarda el nuevo tema en el almacenamiento local con _saveThemeToBox
    _saveThemeToBox(!_loadThemeFromBox());
  }
}