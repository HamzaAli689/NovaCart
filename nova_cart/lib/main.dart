import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nova_cart/Screens/Splash%20Screen/Splash%20Screen.dart';
import 'package:nova_cart/widgets/Appcolors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase & Local Storage
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NovaCart',
      debugShowCheckedModeBanner: false,

      // --- Light Theme Configuration ---
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primaryNavy,
        scaffoldBackgroundColor: AppColors.lightBackground,
        useMaterial3: true,
      ),

      // --- Dark Theme Configuration ---
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.secondaryOrange,
        scaffoldBackgroundColor: AppColors.darkBackground,
        useMaterial3: true,
      ),

      // Follow system theme automatically (User can toggle later via Get.changeThemeMode)
      themeMode: ThemeMode.system,

      home: const SplashScreen(),
    );
  }
}