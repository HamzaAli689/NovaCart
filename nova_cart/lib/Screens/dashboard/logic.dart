import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardLogic extends GetxController {
  var currentIndex = 0.obs;
  var userName = 'Hamza'.obs;

// 1. Default category 'All' set karein
  var selectedCategory = 'All'.obs;

  // --- MULTI-VENDOR ROLE STATE ---
  var userRole = 'buyer'.obs; // 'buyer' or 'seller'
  final TextEditingController productImageController = TextEditingController();
  final searchController = TextEditingController();
  var searchQuery = ''.obs;

  // --- SELLER ADMIN PANEL CONTROLLERS ---
  final storeNameController = TextEditingController();
  final storeDescController = TextEditingController();

  final productTitleController = TextEditingController();
  final productPriceController = TextEditingController();

  // Text Editing Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController(text: "hamza.ali@gmail.com");
  final TextEditingController phoneController = TextEditingController();

  var userEmail = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Wishlist products ki list (Proper Map list)
  final RxList<Map<String, dynamic>> wishlistProducts = <Map<String, dynamic>>[].obs;

  // Reactive Gender Dropdown Value
  final RxString selectedGender = 'Male'.obs;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  var productCategoryValue = 'Fashion'.obs;

  final box = GetStorage();

  // Marketplace Products List (Map format for seamless UI integration)
  var allProducts = <Map<String, dynamic>>[].obs;
  var myStoreProducts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    fetchUserEmail();
    fetchMarketplaceProducts();
    searchController.addListener(() {
      searchQuery.value = searchController.text.trim();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    storeNameController.dispose();
    storeDescController.dispose();
    productTitleController.dispose();
    productPriceController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    productImageController.dispose();
    super.onClose();
  }

  void loadUserData() {
    String? storedName = box.read('userName');
    if (storedName != null && storedName.isNotEmpty) {
      userName.value = storedName;
    }
    String? storedRole = box.read('userRole');
    if (storedRole != null) {
      userRole.value = storedRole;
    }
  }

  // Firebase se current logged-in user ki email lene ka function
  void fetchUserEmail() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null && currentUser.email != null) {
      userEmail.value = currentUser.email!;
    } else {
      userEmail.value = "hamza.ali@gmail.com";
    }
  }

  // --- SWITCH ROLE (Buyer <-> Seller) ---
  void toggleUserRole(bool isSeller) {
    userRole.value = isSeller ? 'seller' : 'buyer';
    box.write('userRole', userRole.value);

    if (isSeller) {
      Get.snackbar("Seller Mode", "Welcome to your Admin Panel!", backgroundColor: Colors.orange, colorText: Colors.white);
    } else {
      Get.snackbar("Buyer Mode", "Switched back to shopping view.", backgroundColor: Colors.blue, colorText: Colors.white);
    }
  }

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

  // Method to change category
  void filterByCategory(String category) {
    selectedCategory.value = category;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  // Getter for Featured Products (Horizontal Scroll - taking first few items)
  List<Map<String, dynamic>> get featuredProducts {
    return allProducts.take(4).toList();
  }

  // Getter for Filtered Products based on selected category & search query
  List<Map<String, dynamic>> get filteredProducts {
    return allProducts.where((product) {
      // Agar 'All' selected hai, to saari products dikhayein
      bool matchesCategory = (selectedCategory.value == 'All') ||
          (product['category'] == selectedCategory.value);

      bool matchesSearch = searchQuery.value.isEmpty ||
          product['title'].toString().toLowerCase().contains(searchQuery.value.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  // Product ko wishlist mein add ya remove karne ka function
  void toggleWishlist(Map<String, dynamic> product) {
    bool isAlreadyInWishlist = wishlistProducts.any((item) => item['title'] == product['title']);

    if (isAlreadyInWishlist) {
      wishlistProducts.removeWhere((item) => item['title'] == product['title']);
      Get.snackbar("Removed", "Product removed from Wishlist", snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1));
    } else {
      wishlistProducts.add(product);
      Get.snackbar("Success", "Product added to Wishlist", snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1));
    }
  }

  // Check karne ke liye ke product favorite hai ya nahi
  bool isFavorite(Map<String, dynamic> product) {
    return wishlistProducts.any((item) => item['title'] == product['title']);
  }

  // --- FETCH PRODUCTS FROM FIREBASE FIRESTORE ---
  void fetchMarketplaceProducts() {
    FirebaseFirestore.instance.collection('products').snapshots().listen((snapshot) {
      List<Map<String, dynamic>> fetchedList = snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      if (fetchedList.isEmpty) {
        fetchedList = [
          {
            'id': '1',
            'title': 'Digital Watch',
            'category': 'Fashion',
            'price': '\$120.00',
            'rating': '4.8',
            'image': 'Assets/images/products/watch.png',
            'storeName': 'TechGadgets Store',
          },
          {
            'id': '1',
            'title': 'Mobile Charger',
            'category': 'Electronics',
            'price': '\$120.00',
            'rating': '4.8',
            'image': 'Assets/images/products/charger.png',
            'storeName': 'TechGadgets Store',
          },
          {
            'id': '1',
            'title': 'Power Bank',
            'category': 'Electronics',
            'price': '\$120.00',
            'rating': '4.8',
            'image': 'Assets/images/products/powerbank.png',
            'storeName': 'TechGadgets Store',
          },
          {
            'id': '1',
            'title': 'Camera Pro',
            'category': 'Electronics',
            'price': '\$120.00',
            'rating': '4.8',
            'image': 'Assets/images/products/camera.png',
            'storeName': 'TechGadgets Store',
          },
          {
            'id': '1',
            'title': 'Track Suit for Men',
            'category': 'Fashion',
            'price': '\$120.00',
            'rating': '4.8',
            'image': 'Assets/images/products/tracksuit.png',
            'storeName': 'Ali Brand',
          },
          {
            'id': '2',
            'title': 'Nike Air Runner',
            'category': 'Shoes',
            'price': '\$85.00',
            'rating': '4.9',
            'image': 'Assets/images/products/shoes1.png',
            'storeName': 'Sneaker Hub',
          },
          {
            'id': '2',
            'title': 'Nike Air Runner',
            'category': 'Shoes',
            'price': '\$85.00',
            'rating': '4.9',
            'image': 'Assets/images/products/shoes2.png',
            'storeName': 'Sneaker Hub',
          },
          {
            'id': '1',
            'title': 'T-Shirt for Men',
            'category': 'Fashion',
            'price': '\$120.00',
            'rating': '4.8',
            'image': 'Assets/images/products/shirt1.png',
            'storeName': 'Ali Brand',
          },
          {
            'id': '1',
            'title': 'T-Shirt for Men',
            'category': 'Fashion',
            'price': '\$150.00',
            'rating': '4.8',
            'image': 'Assets/images/products/shirt2.png',
            'storeName': 'Ali Brand',
          },
          {
            'id': '1',
            'title': 'Air-Buds',
            'category': 'Electronics',
            'price': '\$120.00',
            'rating': '4.8',
            'image': 'Assets/images/products/airbuds.png',
            'storeName': 'TechGadgets Store',
          },
        ];
      }
      allProducts.value = fetchedList;
    }, onError: (e) {
      allProducts.value = [
        {
          'id': '1',
          'title': 'Smart Watch Pro',
          'category': 'Fashion',
          'price': '\$120.00',
          'rating': '4.8',
          'image': 'Assets/images/products/watch.png',
          'storeName': 'TechGadgets Store',
        },
      ];
    });
  }

  // --- SELLER ACTION: CREATE STORE & ADD PRODUCT ---
  void createStoreAndAddProduct() {
    if (storeNameController.text.isEmpty || productTitleController.text.isEmpty || productPriceController.text.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    FirebaseFirestore.instance.collection('products').add({
      'title': productTitleController.text.trim(),
      'price': '\$${productPriceController.text.trim()}',
      'category': productCategoryValue.value,
      'storeName': storeNameController.text.trim(),
      'sellerName': userName.value,
      'image': productImageController.text.trim().isNotEmpty
          ? productImageController.text.trim()
          : 'Assets/images/O1.png',
      'rating': '5.0',
      'timestamp': FieldValue.serverTimestamp(),
    });

    Get.snackbar("Success", "Product successfully listed!", backgroundColor: Colors.green, colorText: Colors.white);

    productTitleController.clear();
    productPriceController.clear();
    productImageController.clear();
  }

  Future<void> updateProfileDetails() async {
    try {
      if (firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty) {
        userName.value = "${firstNameController.text} ${lastNameController.text}";
        box.write('userName', userName.value);
      }

      Get.back();
      Get.snackbar(
        "Success",
        "Profile updated successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }

  // --- CART & CHECKOUT CALCULATIONS ---

// Cart ki items ka total subtotal nikalne ke liye
  double get cartSubtotal {
    return wishlistProducts.fold(0.0, (sum, item) {
      // Price string (e.g. "$120.00") ko double mein convert karna
      String priceStr = item['price'].toString().replaceAll('\$', '').trim();
      double price = double.tryParse(priceStr) ?? 0.0;
      return sum + price;
    });
  }

// Fixed shipping fee (Aap apni marzi se change kar sakte hain)
  double get shippingFee => 5.0;

// Total amount (Subtotal + Shipping)
  double get cartTotalAmount {
    // Agar cart khali hai to total 0, warna subtotal + shipping
    if (wishlistProducts.isEmpty) return 0.0;
    return cartSubtotal + shippingFee;
  }
}