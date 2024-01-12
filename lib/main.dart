import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/Screens/add_task.dart';
import 'package:todo_app/Screens/home_demo.dart';
import 'package:todo_app/Screens/home_page.dart';
import 'package:todo_app/Screens/login_page.dart';
import 'package:todo_app/Screens/otp_screen.dart';
import 'package:todo_app/Screens/phoneauth.dart';
import 'package:todo_app/Screens/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      getPages: [
        GetPage(name: "/login", page: () => const LoginPage()),
        GetPage(name: "/signUp", page: () => const SignUp()),
        GetPage(name: "/addTask", page: () => const AddTask()),
        GetPage(name: "/HomePage", page: () => const Home()),
        GetPage(name: "/PhoneAuth", page: () => const PhoneAuth()),
        GetPage(
            name: '/otpScreen',
            page: () => OTPscreen(
                  verificationId: '',
                )),
        GetPage(name: '/Demo', page: () => const HomeDemo())
      ],
    );
  }
}
