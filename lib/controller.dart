import 'package:get/get.dart';

class Controller extends GetxController {
  var dragLevel = 0.5.obs;
  var selectedItem = (-1).obs;

  setDragLevel(newDragLevel) => dragLevel.value = newDragLevel;

  selectItem(int id) => selectedItem.value = id;
}

