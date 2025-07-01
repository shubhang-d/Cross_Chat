import 'package:cross_chat_app/app/controllers/settings_controller.dart'; // Import
import 'package:get/get.dart';
import 'package:cross_chat_app/app/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    // Add the SettingsController to the dependencies
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}