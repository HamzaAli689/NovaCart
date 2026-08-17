import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/Appcolors.dart'; // Aapke path ke mutabiq
import '../cart/logic.dart';
import 'logic.dart';

class ProductDetailView extends StatelessWidget {
  final bool isDarkMode;
  final String productName;
  final String productPrice;
  final String productImage;
  const ProductDetailView({
    Key? key,
    required this.isDarkMode,
    required this.productName,
    required this.productPrice,
    required this.productImage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductDetailLogic controller = Get.put(ProductDetailLogic());

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      body: Stack(
        children: [
          // --- Top Background & Image Section ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.48,
            child: Container(
              color: isDarkMode ? AppColors.darkSurface : const Color(0xFFF0EBE6),
              child: Stack(
                children: [
                  // Circular background shape behind model
                  Positioned(
                    top: 60,
                    left: MediaQuery.of(context).size.width * 0.15,
                    right: MediaQuery.of(context).size.width * 0.15,
                    child: Container(
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ),
                  // Model Image
                  Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    bottom: 20,
                    child: Image.asset(
                      productImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // App Bar Icons (Back & Favorite)
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back Button
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              padding: const EdgeInsets.all(10),
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
                                size: 18,
                                color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                              ),
                            ),
                          ),
                          // Favorite Button
                          Obx(() => GestureDetector(
                            onTap: controller.toggleFavorite,
                            child: Container(
                              padding: const EdgeInsets.all(10),
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
                                controller.isFavorite.value ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                size: 20,
                                color: controller.isFavorite.value ? AppColors.wishlistActive : (isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                  // Carousel dots
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildDot(isActive: true),
                        _buildDot(isActive: false),
                        _buildDot(isActive: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Bottom Content Sheet ---
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.42,
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppColors.radiusCard),
                  topRight: Radius.circular(AppColors.radiusCard),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppColors.radiusCard),
                  topRight: Radius.circular(AppColors.radiusCard),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title & Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                            ),
                          ),
                          Text(
                            productPrice,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.priceText, // AppColors price color
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Ratings
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (index) => const Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: AppColors.ratingStar,
                            )),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "(83)",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Color and Size Selector Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Color Selector
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Color", style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  _buildColorOption(0, const Color(0xFFE4C5B1), controller),
                                  const SizedBox(width: 10),
                                  _buildColorOption(1, Colors.black, controller),
                                  const SizedBox(width: 10),
                                  _buildColorOption(2, const Color(0xFFE87471), controller),
                                ],
                              ),
                            ],
                          ),
                          // Size Selector
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Size", style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  _buildSizeOption(0, "S", controller, isDarkMode),
                                  const SizedBox(width: 8),
                                  _buildSizeOption(1, "M", controller, isDarkMode),
                                  const SizedBox(width: 8),
                                  _buildSizeOption(2, "L", controller, isDarkMode),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Divider(color: isDarkMode ? Colors.white12 : Colors.grey.withOpacity(0.1)),

                      // --- Description Section ---
                      Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Description",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                              ),
                            ),
                            trailing: Icon(
                              controller.isDescriptionExpanded.value
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                            ),
                            onTap: controller.toggleDescription,
                          ),
                          if (controller.isDescriptionExpanded.value) ...[
                            const Text(
                              "Sportwear is no longer under culture, it is no longer indie or cobbled together as it once was. Sport is fashion today. The top is oversized in fit and style, may need to size down. Read more",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ],
                      )),
                      Divider(color: isDarkMode ? Colors.white12 : Colors.grey.withOpacity(0.1)),

                      // --- Reviews Section ---
                      Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Reviews",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                              ),
                            ),
                            trailing: Icon(
                              controller.isReviewsExpanded.value
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                            ),
                            onTap: controller.toggleReviews,
                          ),
                          if (controller.isReviewsExpanded.value) ...[
                            Row(
                              children: [
                                Text(
                                  "4.9",
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("OUT OF 5", style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.star_rounded, size: 16, color: AppColors.ratingStar),
                                        Icon(Icons.star_rounded, size: 16, color: AppColors.ratingStar),
                                        Icon(Icons.star_rounded, size: 16, color: AppColors.ratingStar),
                                        Icon(Icons.star_rounded, size: 16, color: AppColors.ratingStar),
                                        Icon(Icons.star_rounded, size: 16, color: AppColors.ratingStar),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildReviewItem(
                              name: "Jennifer Rose",
                              time: "5m ago",
                              comment: "I love it. Awesome customer service! Helped me out with adding an additional item to my order. Thanks again!",
                              isDarkMode: isDarkMode,
                            ),
                            const SizedBox(height: 12),
                            _buildReviewItem(
                              name: "Kelly Rihana",
                              time: "5m ago",
                              comment: "I'm very happy with order. It was delivered on and good quality. Recommended!",
                              isDarkMode: isDarkMode,
                            ),
                          ],
                        ],
                      )),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // --- Bottom Fixed Add To Cart Button ---
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ElevatedButton(
                // ProductDetailView ke andar ElevatedButton ka onPressed event:
                onPressed: () {
                  // Controller get karein
                  final CartLogic cartLogic = Get.put(CartLogic());

                  // Selected color aur size ki string nikalne ka logic (agar index use ho rahe hain)
                  String selectedColorName = controller.selectedColorIndex.value == 0
                      ? "Cream"
                      : controller.selectedColorIndex.value == 1 ? "Black" : "Red";

                  String selectedSizeName = controller.selectedSizeIndex.value == 0
                      ? "S"
                      : controller.selectedSizeIndex.value == 1 ? "M" : "L";

                  // Raw price nikalne ke liye string parse karein (misal "\$ 80.00" se double 80.0)
                  double parsedPrice = double.tryParse(productPrice.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;

                  // Cart mein add karein
                  cartLogic.addToCart(
                    title: productName,
                    price: productPrice,
                    rawPrice: parsedPrice,
                    size: selectedSizeName,
                    color: selectedColorName,
                    image: productImage,
                  );

                  Get.snackbar(
                    "Success",
                    "$productName added to cart!",
                    backgroundColor: AppColors.secondaryOrange,
                    colorText: Colors.white,
                  );
                },
                style: ElevatedButton.styleFrom(
                  // Yahan par humne color change kiya hai
                  backgroundColor: AppColors.secondaryOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppColors.radiusButton),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Add To Cart",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: isActive ? 8 : 6,
      height: isActive ? 8 : 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.black87 : Colors.black26,
      ),
    );
  }

  Widget _buildColorOption(int index, Color color, ProductDetailLogic controller) {
    return Obx(() {
      bool isSelected = controller.selectedColorIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeColor(index),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? AppColors.secondaryOrange : Colors.transparent,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 12,
            backgroundColor: color,
          ),
        ),
      );
    });
  }

  Widget _buildSizeOption(int index, String sizeLabel, ProductDetailLogic controller, bool isDarkMode) {
    return Obx(() {
      bool isSelected = controller.selectedSizeIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeSize(index),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? AppColors.secondaryOrange : (isDarkMode ? AppColors.darkBackground : const Color(0xFFF2F2F2)),
          ),
          child: Center(
            child: Text(
              sizeLabel,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildReviewItem({required String name, required String time, required String comment, required bool isDarkMode}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage('Assets/images/O1.png'),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy,
                    ),
                  ),
                ],
              ),
              Text(time, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 6),
          const Row(
            children: [
              Icon(Icons.star_rounded, size: 14, color: AppColors.ratingStar),
              Icon(Icons.star_rounded, size: 14, color: AppColors.ratingStar),
              Icon(Icons.star_rounded, size: 14, color: AppColors.ratingStar),
              Icon(Icons.star_rounded, size: 14, color: AppColors.ratingStar),
              Icon(Icons.star_rounded, size: 14, color: AppColors.ratingStar),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            comment,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}