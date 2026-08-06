import 'package:flutter/material.dart';

class AppColors {
  // --- Base Palette ---
  static const Color primaryNavy = Color(0xFF0F172A);
  static const Color secondaryOrange = Color(0xFFF97316);
  static const Color accentAmber = Color(0xFFFBBF24);

  // --- Backgrounds & Surfaces ---
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color darkBackground = Color(0xFF020617);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkSurface = Color(0xFF0F172A);

  // --- Text Colors ---
  static const Color textPrimaryLight = Color(0xFF1E293B);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF64748B);

  // --- Functional Colors ---
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color wishlistActive = Color(0xFFF43F5E);
  static const Color ratingStar = Color(0xFFFBBF24);

  // --- Navigation & Icons ---
  static const Color navSelected = Color(0xFFF97316);
  static const Color navUnselected = Color(0xFF94A3B8);
  static const Color iconActive = Color(0xFFF97316);
  static const Color iconInactive = Color(0xFF94A3B8);

  // --- Product Specific ---
  static const Color priceText = Color(0xFFF97316);
  static const Color discountText = Color(0xFF22C55E);

  // --- Gradients ---
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFF97316), Color(0xFFFBBF24)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // --- Dimensions & Radii ---
  static const double radiusButton = 18.0;
  static const double radiusCard = 20.0;
}