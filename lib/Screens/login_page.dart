import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Models/uihelpers.dart';
import 'package:todo_app/Screens/home_demo.dart';
import 'package:todo_app/Screens/home_page.dart';
import 'package:todo_app/Screens/phoneauth.dart';
import 'package:todo_app/Screens/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  login(String email, String password) async {
    if (email == "" && password == "") {
      return Uihelpers.CustomAlertBox(context, "Enter User Credentials");
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Get.to(const HomeDemo());
          return null;
        });
      } on FirebaseAuthException catch (ex) {
        return Uihelpers.CustomAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "USER LOGIN",
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
          login(emailController.text.toString(),
              passwordController.text.toString());
        }, "Login"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "New User?",
              style: TextStyle(fontSize: 16),
            ),
            TextButton(
                onPressed: () {
                  Get.to(const SignUp());
                },
                child: const Text("Sign Up",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)))
          ],
        )
      ]),
    );
  }
}
