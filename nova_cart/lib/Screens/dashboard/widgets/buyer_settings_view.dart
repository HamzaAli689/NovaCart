import 'package:flutter/material.dart';
import '../../../widgets/Appcolors.dart';

class BuyerSettingsView extends StatelessWidget {
  const BuyerSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(leading: const Icon(Icons.location_on_outlined, color: AppColors.secondaryOrange), title: const Text("Shipping Addresses"), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () {}),
        ListTile(leading: const Icon(Icons.payment_rounded, color: AppColors.secondaryOrange), title: const Text("Payment Methods"), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () {}),
        ListTile(leading: const Icon(Icons.history_rounded, color: AppColors.secondaryOrange), title: const Text("Order History"), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () {}),
      ],
    );
  }
}