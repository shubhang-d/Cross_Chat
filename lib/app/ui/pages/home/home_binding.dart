import 'package:cross_chat_app/app/controllers/settings_controller.dart';
import 'package:cross_chat_app/app/services/database_service.dart'; // Import
import 'package:get/get.dart';
import 'package:cross_chat_app/app/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    // Register the service *before* the controller that uses it.
    Get.lazyPut<DatabaseService>(() => MockDatabaseService());
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}