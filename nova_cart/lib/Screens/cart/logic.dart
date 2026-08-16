import 'package:get/get.dart';

class CartItem {
  final String id;
  final String title;
  final String price;
  final double rawPrice;
  final String size;
  final String color;
  final String image;
  var quantity = 1.obs;
  var isSelected = true.obs;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.rawPrice,
    required this.size,
    required this.color,
    required this.image,
  });
}

class CartLogic extends GetxController {
  // Ab cart initially empty ya dynamic items ke sath shuru ho sakti hai
  var cartItems = <CartItem>[].obs;

  // --- Dynamic Add to Cart Function ---
  void addToCart({
    required String title,
    required String price,
    required double rawPrice,
    required String size,
    required String color,
    required String image,
  }) {
    // Check karein agar same product pehle se cart mein mojood hai (with same size & color)
    int existingIndex = cartItems.indexWhere(
          (item) => item.title == title && item.size == size && item.color == color,
    );

    if (existingIndex != -1) {
      // Agar pehle se hai toh quantity barha dein
      cartItems[existingIndex].quantity.value++;
    } else {
      // Naya item add kar dein
      cartItems.add(
        CartItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          price: price,
          rawPrice: rawPrice,
          size: size,
          color: color,
          image: image,
        ),
      );
    }
  }

  // Quantity Increment
  void increaseQuantity(int index) {
    cartItems[index].quantity.value++;
  }

  // Quantity Decrement
  void decreaseQuantity(int index) {
    if (cartItems[index].quantity.value > 1) {
      cartItems[index].quantity.value--;
    }
  }

  // Toggle Checkbox Selection
  void toggleSelection(int index) {
    cartItems[index].isSelected.value = !cartItems[index].isSelected.value;
  }

  // Calculate Total Product Price for selected items
  double get totalPrice {
    double total = 0.0;
    for (var item in cartItems) {
      if (item.isSelected.value) {
        total += item.rawPrice * item.quantity.value;
      }
    }
    return total;
  }
}