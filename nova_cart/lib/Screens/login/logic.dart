import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

import '../dashboard/view.dart';

class LoginLogic extends GetxController {
  // Text Editing Controllers for Login
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Loading state
  var isLoading = false.obs;

  // Password visibility toggle
  var obscurePassword = true.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final box = GetStorage();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Login Method
  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Basic Validations
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Firebase Sign In
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save login state in GetStorage
      box.write('isLoggedIn', true);
      box.write('userEmail', email);
      box.write('userName', userCredential.user?.displayName ?? 'User');

      isLoading.value = false;

      Get.snackbar(
        "Success",
        "Logged in successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to Home
      Get.offAll(DashboardPage());

    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String message = "An error occurred";
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is invalid.';
      }
      Get.snackbar(
        "Login Failed",
        message,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}