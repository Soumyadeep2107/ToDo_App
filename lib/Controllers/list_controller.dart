import 'package:get/get.dart';

class TaskController extends GetxController {
  RxList<Map<String, dynamic>> tasks = <Map<String, dynamic>>[].obs;

  void setTasks(List<Map<String, dynamic>> newTasks) {
    tasks.assignAll(newTasks);
  }
}
