import 'package:flutter/material.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:task_manager_live_app/UI/Screens/spashScreen.dart';
import 'package:task_manager_live_app/UI/controller/cancelled_task_controller.dart';
import 'package:task_manager_live_app/UI/controller/complited_task_controller.dart';
import 'package:task_manager_live_app/UI/controller/inProgress_task_controller.dart';
import 'package:task_manager_live_app/UI/controller/login_controller.dart';
import 'package:task_manager_live_app/UI/controller/newTaskController.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigationKey,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            )
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600
          ),
        ),
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10),
          )
        )
      ),
      initialBinding: ControllerBinder(),
    );
  }
}

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(LoginController());
    Get.put(NewTaskController());
    Get.put(InProgressTaskController());
    Get.put(ComplitedTaskController());
    Get.put(CancelledTaskController());
  }

}
