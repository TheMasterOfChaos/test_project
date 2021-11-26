import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test_project/controller.dart';


class SelectPage extends StatelessWidget {
  final int _currentId;

  int _checkNumber(String s) {
    int i = int.tryParse(s) ?? -1;

    return i;
  }

  SelectPage(this._currentId);

  @override
  Widget build(BuildContext context) {
    Controller c = Get.find();
    TextEditingController textEditingController =
    TextEditingController(text: _currentId.toString());

    return Scaffold(
        body: SafeArea(
          child: Column(children: [
            TextField(
              onSubmitted: (s) {
                c.selectedItem(_checkNumber(s));
                Get.back(result: _checkNumber(textEditingController.text));
              },
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
                hintText: 'Номер элемента',
              ),
              keyboardType: TextInputType.number,
              autofocus: true,
              controller: textEditingController,
            ),
            MaterialButton(
                child: const Text('сохранить'),
                onPressed: () {
                  c.selectItem(_checkNumber(textEditingController.text));
                  Get.back(result: _checkNumber(textEditingController.text));
                })
          ]),
        ));
  }
}
