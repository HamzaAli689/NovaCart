import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../dashboard/view.dart';

class RegisterLogic extends GetxController {
// Text Editing Controllers for Signup
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Loading state
  var isLoading = false.obs;

  // Password visibility toggle
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final box = GetStorage();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Signup Method
  void signUp() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Basic Validations
    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill in all fields",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        "Error",
        "Password must be at least 6 characters long",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Firebase Create User
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await userCredential.user?.updateDisplayName(name);

      // Save login state in GetStorage
      box.write('isLoggedIn', true);
      box.write('userEmail', email);
      box.write('userName', name);

      isLoading.value = false;

      Get.snackbar(
        "Success",
        "Account created successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to Home (or Main Wrapper)
      Get.offAll(DashboardPage());

    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      String message = "An error occurred";
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is invalid.';
      }
      Get.snackbar(
        "Signup Failed",
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
