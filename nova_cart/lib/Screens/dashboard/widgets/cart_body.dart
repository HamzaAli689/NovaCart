import 'package:flutter/material.dart';
import '../../../widgets/Appcolors.dart';

class CartBody extends StatelessWidget {
  final bool isDarkMode;
  const CartBody({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          "Cart Screen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDarkMode ? AppColors.textPrimaryDark : AppColors.primaryNavy),
        ),
      ),
    );
  }
}