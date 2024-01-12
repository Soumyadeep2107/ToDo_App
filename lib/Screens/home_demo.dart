import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Controllers/list_controller.dart';
import 'package:todo_app/Screens/add_task.dart';
import 'package:todo_app/Screens/login_page.dart';

import 'description.dart';

class HomeDemo extends StatefulWidget {
  const HomeDemo({Key? key}) : super(key: key);

  @override
  State<HomeDemo> createState() => _HomeDemoState();
}

class _HomeDemoState extends State<HomeDemo> {
  final TaskController _taskController = Get.put(TaskController());
  String uid = '';

  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    uid = user!.uid;

    // Fetch tasks and update the GetX controller
    fetchTasks();
  }

  fetchTasks() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .get();

    final docs = snapshot.docs;
    final tasks = docs.map((doc) => doc.data()).toList();

    // Update the GetX controller with the fetched tasks
    _taskController.setTasks(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.to(const LoginPage());
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () {
            if (_taskController.tasks.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: _taskController.tasks.length,
                itemBuilder: (context, index) {
                  var time =
                      (_taskController.tasks[index]['timestamp'] as Timestamp)
                          .toDate();

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Description(
                            title: _taskController.tasks[index]['title'],
                            description: _taskController.tasks[index]
                                ['description'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  _taskController.tasks[index]['title'],
                                  style: GoogleFonts.roboto(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  DateFormat.yMd().add_jm().format(time),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: IconButton(
                              icon: const Icon(
                                Icons.delete,
                              ),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(uid)
                                    .collection('mytasks')
                                    .doc(_taskController.tasks[index]['time'])
                                    .delete();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddTask());
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
