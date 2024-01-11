import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Uihelpers {
  static customtextfield(TextEditingController controller, String text,
      IconData icondata, bool tohide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: tohide,
        decoration: InputDecoration(
            hintText: text,
            suffixIcon: Icon(icondata),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  static customButton(VoidCallback voidCallback, String text) {
    return SizedBox(
        height: 50,
        width: 200,
        child: ElevatedButton(
            onPressed: () {
              voidCallback();
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            )));
  }

  static CustomAlertBox(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }
}
