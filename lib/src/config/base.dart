import 'package:get/get.dart';
import 'package:to_do_app/src/controller/task-controller.dart';

mixin Base {
  final taskC = Get.put(TaskController());
 
}
