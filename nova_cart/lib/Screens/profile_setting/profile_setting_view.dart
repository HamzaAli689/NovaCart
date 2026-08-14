import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/Appcolors.dart';
import '../dashboard/logic.dart';

class ProfileSettingView extends StatelessWidget {
  final DashboardLogic controller;
  final bool isDarkMode;

  const ProfileSettingView({Key? key, required this.controller, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isDarkMode ? Colors.white24 : Colors.grey.withOpacity(0.2)),
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 16,
              color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
            ),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Profile Setting",
          style: TextStyle(
            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- 1. Profile Picture (Permanent for now, Storage will be added later) ---
              Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.secondaryOrange, width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('Assets/images/O1.png'),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryNavy,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36.0),

              // --- 2. First Name & Last Name Fields ---
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: "First Name",
                      hint: "Hamza",
                      isDarkMode: isDarkMode,
                      controller: controller.firstNameController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: "Last Name",
                      hint: "Ali",
                      isDarkMode: isDarkMode,
                      controller: controller.lastNameController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // --- 3. Email Field (Permanent / Read-Only) ---
              _buildTextField(
                label: "Email (Permanent)",
                hint: "hamza.ali@gmail.com",
                isDarkMode: isDarkMode,
                controller: controller.emailController,
                readOnly: true, // Email change nahi ho sake gi
              ),
              const SizedBox(height: 20),

              // --- 4. Gender Dropdown & Phone Number Fields ---
              Row(
                children: [
                  // Gender Dropdown
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Obx(() => DropdownButtonFormField<String>(
                          value: controller.selectedGender.value,
                          dropdownColor: isDarkMode ? AppColors.darkSurface : Colors.white,
                          style: TextStyle(
                            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.secondaryOrange, width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          items: controller.genderOptions.map((String gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.selectedGender.value = newValue;
                            }
                          },
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Phone Field (Editable for future updates)
                  Expanded(
                    child: _buildTextField(
                      label: "Phone",
                      hint: "(+92) 3001234567",
                      isDarkMode: isDarkMode,
                      keyboardType: TextInputType.phone,
                      controller: controller.phoneController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // --- 5. Save Changes Button ---
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNavy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => controller.updateProfileDetails(),
                  child: const Text(
                    "Save change",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Text Fields
  Widget _buildTextField({
    required String label,
    required String hint,
    required bool isDarkMode,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          style: TextStyle(
            color: readOnly
                ? Colors.grey
                : (isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 14),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: readOnly ? Colors.grey.withOpacity(0.3) : AppColors.secondaryOrange,
                width: readOnly ? 1 : 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ],
    );
  }
}