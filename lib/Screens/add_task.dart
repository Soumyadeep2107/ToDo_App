import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/Screens/home_demo.dart';
import 'package:todo_app/Screens/home_page.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  addtasktofirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    String uid = user!.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(time.toString())
        .set({
      'title': titleController.text,
      'description': descriptionController.text,
      'time': time.toString(),
      'timestamp': time
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Task')),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      labelText: 'Enter Title', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                child: TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      labelText: 'Enter Description',
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.purple.shade100;
                      }
                      return Theme.of(context).primaryColor;
                    })),
                    child: Text(
                      'Add Task',
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                    onPressed: () {
                      addtasktofirebase();
                      Get.to(const HomeDemo());
                    },
                  ))
            ],
          )),
    );
  }
}
