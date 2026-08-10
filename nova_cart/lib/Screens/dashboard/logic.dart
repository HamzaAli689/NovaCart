import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardLogic extends GetxController {
  var currentIndex = 0.obs;
  var userName = 'Hamza'.obs;
  // Controller mein yeh add karein:
  var selectedAssetImage = 'Assets/images/products/O1.jpg'.obs;

  final List<String> availableImages = [
    'Assets/images/products/O1.jpg',
    'Assets/images/products/O2.jpg',
    'Assets/images/products/O3.jpg',
    'Assets/images/products/O4.jpg',
    'Assets/images/products/O5.jpg',
    'Assets/images/products/O6.jpg',
    'Assets/images/products/O7.jpg',
    'Assets/images/products/O8.jpg',
    'Assets/images/products/O9.jpg',
  ];

  // --- MULTI-VENDOR ROLE STATE ---
  var userRole = 'buyer'.obs; // 'buyer' or 'seller'

  final searchController = TextEditingController();
  var searchQuery = ''.obs;
  var selectedCategory = 'Fashion'.obs;
  var wishlistItems = <String>{}.obs;

  // --- SELLER ADMIN PANEL CONTROLLERS ---
  final storeNameController = TextEditingController();
  final storeDescController = TextEditingController();

  final productTitleController = TextEditingController();
  final productPriceController = TextEditingController();

  // FIX: Yeh string value leni chahiye, .obs yahan nahi aayega
  var productCategoryValue = 'Fashion'.obs;

  final box = GetStorage();

  var allProducts = <Map<String, dynamic>>[].obs;
  var myStoreProducts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
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

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void toggleWishlist(String productId) {
    if (wishlistItems.contains(productId)) {
      wishlistItems.remove(productId);
    } else {
      wishlistItems.add(productId);
    }
  }

  // --- FETCH PRODUCTS FROM FIREBASE FIRESTORE ---
  void fetchMarketplaceProducts() {
    // Realtime Firestore listener
    FirebaseFirestore.instance.collection('products').snapshots().listen((snapshot) {
      List<Map<String, dynamic>> fetchedList = snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id; // Assign document ID
        return data;
      }).toList();

      // Agar Firestore khali hai ya abhi data nahi aaya toh default dummy items dikha dein ta keh UI khali na lage
      if (fetchedList.isEmpty) {
        fetchedList = [
          {
            'id': '1',
            'title': 'Smart Watch Pro',
            'category': 'Fashion',
            'price': '\$120.00',
            'rating': '4.8',
            'image': 'Assets/images/O1.png',
            'storeName': 'TechGadgets Store',
          },
          {
            'id': '2',
            'title': 'Nike Air Runner',
            'category': 'Shoes',
            'price': '\$85.00',
            'rating': '4.9',
            'image': 'Assets/images/O2.png',
            'storeName': 'Sneaker Hub',
          },
        ];
      }
      allProducts.value = fetchedList;
    }, onError: (e) {
      // Fallback agar offline hon ya firebase error de
      allProducts.value = [
        {
          'id': '1',
          'title': 'Smart Watch Pro',
          'category': 'Fashion',
          'price': '\$120.00',
          'rating': '4.8',
          'image': 'Assets/images/O1.png',
          'storeName': 'TechGadgets Store',
        },
      ];
    });
  }

  // --- SELLER ACTION: CREATE STORE & ADD PRODUCT ---
// Product create karte waqt isay Firestore mein bhejhein:
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
      'image': selectedAssetImage.value, // Yahan asset path save ho raha hai
      'rating': '5.0',
      'timestamp': FieldValue.serverTimestamp(),
    });

    Get.snackbar("Success", "Product successfully listed!", backgroundColor: Colors.green, colorText: Colors.white);

    productTitleController.clear();
    productPriceController.clear();
  }

  List<Map<String, dynamic>> get filteredProducts {
    return allProducts.where((product) {
      bool matchesCategory = product['category'] == selectedCategory.value;
      bool matchesSearch = searchQuery.value.isEmpty ||
          product['title'].toString().toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  List<Map<String, dynamic>> get favoriteProducts {
    return allProducts.where((product) => wishlistItems.contains(product['id'])).toList();
  }
}