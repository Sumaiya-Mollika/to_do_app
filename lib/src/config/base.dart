import 'package:get/get.dart';
import 'package:to_do_app/src/controller/todo-controller.dart';

mixin Base {
  final todoC = Get.put(TaskController());
}
