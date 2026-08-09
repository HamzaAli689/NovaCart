import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardLogic extends GetxController {
  // Bottom Navigation Index
  var currentIndex = 0.obs;

  // User Name state
  var userName = 'Hamza'.obs;

  // Search Text Controller
  final searchController = TextEditingController();
  var searchQuery = ''.obs;

  // Selected Category State
  var selectedCategory = 'Fashion'.obs;

  // Wishlist Product IDs
  var wishlistItems = <String>{}.obs;

  final box = GetStorage();

  // Sample Products List
  final List<Map<String, dynamic>> allProducts = [
    {
      'id': '1',
      'title': 'Smart Watch Pro',
      'category': 'Fashion',
      'price': '\$120.00',
      'rating': '4.8',
      'image': 'Assets/images/O1.png',
    },
    {
      'id': '2',
      'title': 'Nike Air Runner',
      'category': 'Shoes',
      'price': '\$85.00',
      'rating': '4.9',
      'image': 'Assets/images/O2.png',
    },
    {
      'id': '3',
      'title': 'Wireless Headphones',
      'category': 'Electronics',
      'price': '\$95.00',
      'rating': '4.7',
      'image': 'Assets/images/O1.png',
    },
    {
      'id': '4',
      'title': 'Casual Denim Jacket',
      'category': 'Fashion',
      'price': '\$60.00',
      'rating': '4.6',
      'image': 'Assets/images/O2.png',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    searchController.addListener(() {
      searchQuery.value = searchController.text.trim();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void loadUserData() {
    String? storedName = box.read('userName');
    if (storedName != null && storedName.isNotEmpty) {
      userName.value = storedName;
    }
  }

  // Tab switching method
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void toggleWishlist(String productId) {
    if (wishlistItems.contains(productId)) {
      wishlistItems.remove(productId);
      Get.snackbar("Removed", "Item removed from wishlist", snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1));
    } else {
      wishlistItems.add(productId);
      Get.snackbar("Added", "Item added to wishlist", snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1));
    }
  }

  List<Map<String, dynamic>> get filteredProducts {
    return allProducts.where((product) {
      bool matchesCategory = product['category'] == selectedCategory.value;
      bool matchesSearch = searchQuery.value.isEmpty ||
          product['title'].toString().toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  // Wishlist products get karne ke liye getter
  List<Map<String, dynamic>> get favoriteProducts {
    return allProducts.where((product) => wishlistItems.contains(product['id'])).toList();
  }
}