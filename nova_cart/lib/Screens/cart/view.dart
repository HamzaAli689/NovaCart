import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/Appcolors.dart';
import '../checkout/checkout_screen.dart';
import 'logic.dart';

class CartView extends StatelessWidget {
  final bool isDarkMode;
  const CartView({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartLogic controller = Get.put(CartLogic());

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
          "Your Cart",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 80,
                  color: AppColors.textSecondary.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Your Cart is Empty",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // --- Cart Items List ---
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
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
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            color: isDarkMode ? AppColors.darkBackground : const Color(0xFFF0EBE6),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(item.image, fit: BoxFit.contain),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Obx(() => SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      value: item.isSelected.value,
                                      activeColor: AppColors.secondaryOrange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      onChanged: (val) => controller.toggleSelection(index),
                                    ),
                                  )),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.price,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColors.priceText,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Size: ${item.size} | Color: ${item.color}",
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () => controller.decreaseQuantity(index),
                                          child: const Icon(Icons.remove, size: 14, color: AppColors.textSecondary),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Obx(() => Text(
                                            "${item.quantity.value}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                                            ),
                                          )),
                                        ),
                                        GestureDetector(
                                          onTap: () => controller.increaseQuantity(index),
                                          child: const Icon(Icons.add, size: 14, color: AppColors.textSecondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // --- Bottom Summary & Checkout Section ---
            Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Product price", style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      Obx(() => Text(
                        "\$ ${controller.totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                        ),
                      )),
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: AppColors.success,
                        ),
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
                      Obx(() => Text(
                        "\$ ${controller.totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => CheckoutScreen());
                        Get.snackbar(
                          "Checkout",
                          "Proceeding to checkout successfully!",
                          backgroundColor: AppColors.secondaryOrange,
                          colorText: Colors.white,
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
                      child: const Text(
                        "Proceed to checkout",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}