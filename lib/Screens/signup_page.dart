import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Models/uihelpers.dart';
import 'package:todo_app/Screens/home_demo.dart';
import 'package:todo_app/Screens/home_page.dart';
import 'package:todo_app/Screens/login_page.dart';
import 'package:todo_app/Screens/phoneauth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signUp(String email, String password) async {
    if (email == "" && password == "") {
      Uihelpers.CustomAlertBox(context, "Enter Required Fields");
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Get.to(const HomeDemo());
          return null;
        });
      } on FirebaseException catch (ex) {
        return Uihelpers.CustomAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "USER SIGN-UP",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Uihelpers.customtextfield(
            emailController, "Enter Email", Icons.mail, false),
        Uihelpers.customtextfield(
            passwordController, "Enter Password", Icons.password, true),
        const SizedBox(height: 20),
        Uihelpers.customButton(() {
          signUp(emailController.text.toString(),
              passwordController.text.toString());
        }, "SignUp"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account?",
              style: TextStyle(fontSize: 16),
            ),
            TextButton(
                onPressed: () {
                  Get.to(const LoginPage());
                },
                child: const Text("Login",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)))
          ],
        )
      ]),
    );
  }
}
