import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage(Key? key, this.label) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[600] : Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
          color: Get.isDarkMode ? Colors.white : Colors.grey[600],
        ),
        title: Text(
          "Titulo Tarea",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode ? Colors.white : Colors.grey[400],
          ),
          child: Center(
            child: Text(
              "Descripcion",
              style: TextStyle(color: Get.isDarkMode?Colors.black: Colors.white,
              fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
