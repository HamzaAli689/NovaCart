import 'package:get/get.dart';

class ProductDetailLogic extends GetxController {
  // Selected options state
  var selectedColorIndex = 0.obs;
  var selectedSizeIndex = 2.obs; // Default 'L' selected
  var isFavorite = false.obs;

  // Section Expansion states (jaise image d9.PNG mein expanded hain)
  var isDescriptionExpanded = true.obs;
  var isReviewsExpanded = true.obs;
  var isSimilarExpanded = true.obs;

  void changeColor(int index) {
    selectedColorIndex.value = index;
  }

  void changeSize(int index) {
    selectedSizeIndex.value = index;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void toggleDescription() {
    isDescriptionExpanded.value = !isDescriptionExpanded.value;
  }

  void toggleReviews() {
    isReviewsExpanded.value = !isReviewsExpanded.value;
  }

  void toggleSimilar() {
    isSimilarExpanded.value = !isSimilarExpanded.value;
  }
}