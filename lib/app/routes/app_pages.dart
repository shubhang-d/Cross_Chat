import 'package:get/get.dart';
import 'package:cross_chat_app/app/ui/pages/home/home_binding.dart'; // Change your_app_name
import 'package:cross_chat_app/app/ui/pages/home/home_page.dart';     // Change your_app_name
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}