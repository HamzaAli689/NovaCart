import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/Appcolors.dart';
import '../dashboard/logic.dart';

class Seller_adminPage extends StatelessWidget {

  final DashboardLogic controller;
  final bool isDarkMode;

  const Seller_adminPage({Key? key, required this.controller, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
      appBar: AppBar(
        title: const Text("Seller Admin Panel", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.secondaryOrange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Store Management",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller.storeNameController,
                decoration: InputDecoration(
                  labelText: "Store Name",
                  hintText: "e.g., Hamza's Electronics",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppColors.radiusCard)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller.storeDescController,
                decoration: InputDecoration(
                  labelText: "Store Description",
                  hintText: "What type of products do you sell?",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppColors.radiusCard)),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              Text(
                "Add New Product to Marketplace",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller.productTitleController,
                decoration: InputDecoration(
                  labelText: "Product Title",
                  hintText: "e.g., Wireless Gaming Mouse",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppColors.radiusCard)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller.productPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Price (e.g. 45.00)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppColors.radiusCard)),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Select Product Image:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              TextField(
                controller: controller.productImageController,
                decoration: InputDecoration(
                  labelText: "Product Image URL",
                  hintText: "Paste image link (e.g., https://...)",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppColors.radiusCard)),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => DropdownButtonFormField<String>(
                value: controller.productCategoryValue.value.isEmpty ? null : controller.productCategoryValue.value,
                decoration: InputDecoration(
                  labelText: "Select Category",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppColors.radiusCard)),
                ),
                items: ['Fashion', 'Electronics', 'Shoes', 'Groceries', 'Beauty']
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) controller.productCategoryValue.value = val;
                },
              )),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryOrange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppColors.radiusCard)),
                  ),
                  onPressed: () => controller.createStoreAndAddProduct(),
                  child: const Text(
                    "Publish Product to Main Dashboard",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
