import 'package:get/get.dart';
import 'package:cross_chat_app/app/controllers/home_controller.dart'; // Change your_app_name

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}