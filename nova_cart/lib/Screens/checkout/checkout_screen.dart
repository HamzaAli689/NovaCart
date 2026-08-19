import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/Appcolors.dart';
import '../cart/logic.dart'; // Apni CartLogic wali file yahan import karein

class CheckoutScreen extends StatelessWidget {
  final bool isDarkMode;
  const CheckoutScreen({Key? key, this.isDarkMode = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CartLogic ko find karein jo pehle se CartView mein put hai
    final CartLogic cartController = Get.find<CartLogic>();

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                size: 16,
                color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
              ),
            ),
          ),
        ),
        title: Text(
          "Checkout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. SHIPPING ADDRESS SECTION ---
            Text(
              "Shipping Address",
              style: TextStyle(
                color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(AppColors.radiusCard),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryOrange.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.location_on_rounded, color: AppColors.secondaryOrange, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Home Address",
                          style: TextStyle(
                            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Street 4, Near City Park, Main Boulevard, Lahore",
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Change",
                      style: TextStyle(color: AppColors.secondaryOrange, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- 2. PAYMENT METHOD SECTION ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment Method",
                  style: TextStyle(
                    color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Add new +",
                    style: TextStyle(color: AppColors.secondaryOrange, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Glassmorphic / Styled Credit Card
            Container(
              height: 180,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.secondaryOrange, AppColors.primaryNavy],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppColors.radiusCard),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryOrange.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "NovaCard Pay",
                        style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1.5),
                      ),
                      Text(
                        "VISA",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  Text(
                    "4364   1345   8932   8378",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CARDHOLDER NAME", style: TextStyle(color: Colors.white60, fontSize: 8)),
                          SizedBox(height: 2),
                          Text("Hamza Ali", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("VALID THRU", style: TextStyle(color: Colors.white60, fontSize: 8)),
                          SizedBox(height: 2),
                          Text("05/28", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- 3. ORDER SUMMARY SECTION (Dynamic based on CartLogic) ---
            Text(
              "Order Summary",
              style: TextStyle(
                color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: BorderRadius.circular(AppColors.radiusCard),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Obx(() => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Product price", style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      Text(
                        "\$ ${cartController.totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(color: isDarkMode ? Colors.white12 : Colors.grey.withOpacity(0.2)),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping", style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      Text(
                        "Freeship",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.success),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(color: isDarkMode ? Colors.white12 : Colors.grey.withOpacity(0.2)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                        ),
                      ),
                      Text(
                        "\$ ${cartController.totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      // --- 4. BOTTOM FIXED PAY BUTTON ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: Obx(() => ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                backgroundColor: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                titleStyle: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy),
                middleTextStyle: const TextStyle(color: AppColors.textSecondary),
                title: "Success!",
                middleText: "Your order has been placed successfully.",
                textConfirm: "OK",
                confirmTextColor: Colors.white,
                buttonColor: AppColors.secondaryOrange,
                onConfirm: () {
                  cartController.cartItems.clear(); // Order ke baad cart clear kar dein
                  Get.back(); // Close dialog
                  Get.back(); // Return to cart/home
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2B2B2B),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppColors.radiusButton),
              ),
              elevation: 0,
            ),
            child: Text(
              "Pay \$ ${cartController.totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )),
        ),
      ),
    );
  }
}