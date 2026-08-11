import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/Appcolors.dart';
import '../logic.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isDarkMode;
  final DashboardLogic controller;

  const CategoryItem({Key? key, required this.title, required this.icon, required this.isDarkMode, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isSelected = controller.selectedCategory.value == title;
      return GestureDetector(
        onTap: () => controller.selectCategory(title),
        child: Container(
          width: 80,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondaryOrange : (isDarkMode ? AppColors.darkSurface : AppColors.lightSurface),
            borderRadius: BorderRadius.circular(AppColors.radiusCard),
            border: Border.all(color: isSelected ? AppColors.secondaryOrange : (isDarkMode ? Colors.white12 : Colors.black12)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: isSelected ? Colors.white.withOpacity(0.2) : AppColors.secondaryOrange, shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(color: isSelected ? Colors.white : (isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy), fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    });
  }
}