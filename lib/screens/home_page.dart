import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:test_project/controller.dart';

import 'select_page.dart';

class HomePage extends StatelessWidget {
  final Controller c = Get.put(Controller());
  ScrollController elementListScrollController = ScrollController();

  selectElement(int id) async {
    int i = await Get.to(() => SelectPage(id));
    if (-1 < i && i < 10) {
      elementListScrollController.animateTo(i * 116,
          duration: const Duration(seconds: 1), curve: Curves.ease);
    } else {
      elementListScrollController.animateTo(0,
          duration: const Duration(seconds: 1), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: buildBottomSheet(),
        body: Obx(() => Transform.rotate(
            angle: (c.dragLevel.value - 0.5) * 6.28,
            child: SvgPicture.asset(
              'assets/circle.svg',
              width: 300,
              height: 300,
            ))));
  }

  NotificationListener<DraggableScrollableNotification> buildBottomSheet() {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        c.setDragLevel(notification.extent);
        if (notification.extent == 1) {
          Get.snackbar(
            "Конец",
            "Дальше крутить не получится",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blueGrey,
          );
        }
        return true;
      },
      child: DraggableScrollableSheet(
        initialChildSize: c.dragLevel.value,
        minChildSize: 0.5,
        maxChildSize: 1,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
              width: context.width,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0)),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 30,
                          width: 150,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 30,
                          width: 200,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 30,
                          width: 300,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                        ),
                      ),
                      SizedBox(
                        height: 116,
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          controller: elementListScrollController,
                          itemBuilder: (context, id) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                    () {
                                  return GestureDetector(
                                      onTap: () => selectElement(id),
                                      child: Container(
                                          child: Center(child: Text('$id')),
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: id == c.selectedItem.value
                                                  ? Colors.red
                                                  : Colors.white,
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(20.0)))));
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                controller: scrollController,
              ));
        },
      ),
    );
  }
}
