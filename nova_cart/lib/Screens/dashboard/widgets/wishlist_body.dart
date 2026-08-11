import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/Appcolors.dart';
import '../logic.dart';

class WishlistBody extends StatelessWidget {
  final DashboardLogic controller;
  final bool isDarkMode;

  const WishlistBody({Key? key, required this.controller, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Wishlist",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                final favs = controller.favoriteProducts;
                if (favs.isEmpty) {
                  return const Center(child: Text("Your wishlist is empty!", style: TextStyle(color: Colors.grey, fontSize: 16)));
                }
                return ListView.builder(
                  itemCount: favs.length,
                  itemBuilder: (context, index) {
                    final item = favs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
                        borderRadius: BorderRadius.circular(AppColors.radiusCard),
                        border: Border.all(color: isDarkMode ? Colors.white12 : Colors.black12),
                      ),
                      child: ListTile(
                        leading: Image.asset(item['image'] ?? 'Assets/images/O1.png', width: 40, fit: BoxFit.contain),
                        title: Text(item['title'], style: TextStyle(color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy, fontWeight: FontWeight.bold)),
                        subtitle: Text(item['price'], style: const TextStyle(color: AppColors.secondaryOrange, fontWeight: FontWeight.w600)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                          onPressed: () => controller.toggleWishlist(item['id']),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}