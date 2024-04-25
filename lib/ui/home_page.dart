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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          _addTaskBar(),
          _addDateBar(),
        ],
      ),
    );
  }

  _addDateBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Container(
        child: DatePicker(
          DateTime.now(),
          height: 100,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryClr,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          onDateChange: (date) {
            _selectedDate = date;
          },
        ),
      ),
    );
  }

  _addTaskBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              ),
            ],
          ),
          MyButton(
              label: "+ Add Task", onTap: () => Get.to(const AddTaskPage()))
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();

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
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_outlined,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
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
