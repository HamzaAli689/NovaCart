# 🛒 NovaCart — Modern E-Commerce Mobile Application

**NovaCart** is a modern, feature-rich e-commerce mobile application built with **Flutter and Dart**, designed to provide a smooth, responsive, and user-friendly shopping experience.

The application combines a **modern dark navy & vibrant orange UI**, reactive state management, Firebase integration, local storage, wishlist and cart functionality, and a streamlined checkout experience.

---

## 📱 Overview

NovaCart is designed as a complete mobile shopping experience where users can:

* 🔐 Create an account and securely log in
* 🛍️ Browse products and categories
* 🔎 Explore products through a modern marketplace interface
* 
* ❤️ Add and manage products in their wishlist
* 🛒 Add products to the shopping cart
* ➕➖ Update product quantities
* 💰 View dynamically calculated cart totals
* 📦 Complete the checkout process
* 🌙 Switch between Dark Mode and Light Mode
* ☁️ Synchronize user and product data with Firebase

---

## ✨ Key Features

### 🔐 Authentication

* User Sign Up & Login
* Firebase Authentication
* Secure user session handling

### 🛍️ Product & Marketplace

* Dynamic product browsing
* Category-based product discovery
* Categories such as:

  * Electronics
  * Fashion
  * Shoes
  * Accessories
  * And more

### ❤️ Wishlist

* Add/remove products from wishlist
* Reactive wishlist updates
* Persistent local data handling

### 🛒 Shopping Cart

* Add and remove products
* Increase/decrease product quantity
* Dynamic subtotal calculation
* Shipping fee calculation
* Real-time total price updates

### 💳 Checkout

* Streamlined single-page checkout
* Shipping address management
* Payment method selection
* Order summary before checkout

### 🎨 Dynamic Theme

* Dark Mode
* Light Mode
* Theme-aware UI components
* Consistent color palettes across the application

### ⚡ State Management

* Reactive state management using **GetX**
* Efficient UI updates
* Centralized application state

### ☁️ Firebase Integration

* Firebase Authentication
* Cloud Firestore
* Firebase Storage
* Cloud-based data synchronization

### 📱 Responsive UI

* Modern mobile-first interface
* Reusable custom widgets
* Responsive layouts
* Glassmorphic UI elements
* Smooth and interactive components

---

## 🛠️ Tech Stack

| Technology           | Purpose                                |
| -------------------- | -------------------------------------- |
| **Flutter**          | Cross-platform application development |
| **Dart**             | Programming language                   |
| **GetX**             | State management & navigation          |
| **Firebase Auth**    | User authentication                    |
| **Cloud Firestore**  | Cloud database                         |
| **Firebase Storage** | Image/file storage                     |
| **Hive**             | Local data storage                     |
| **GetStorage**       | Lightweight local storage              |
| **Material Design**  | UI components                          |

---

## 🏗️ Architecture

NovaCart follows a **clean and modular project structure** to keep the codebase scalable, maintainable, and easy to extend.

```text
lib/
│
├── controllers/
│   ├── auth/
│   ├── cart/
│   ├── wishlist/
│   └── theme/
│
├── models/
│   ├── product_model.dart
│   ├── category_model.dart
│   └── user_model.dart
│
├── views/
│   ├── auth/
│   ├── onboarding/
│   ├── home/
│   ├── products/
│   ├── cart/
│   ├── wishlist/
│   └── checkout/
│
├── widgets/
│   ├── custom_cards/
│   ├── buttons/
│   └── common/
│
├── services/
│   ├── firebase/
│   └── storage/
│
├── routes/
│
├── themes/
│
└── main.dart
```

> **Note:** Adjust the folder names above according to the actual structure of your repository.

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/novacart.git
```

### 2. Navigate to the Project

```bash
cd novacart
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Configure Firebase

Connect the project with your Firebase project and configure:

* Firebase Authentication
* Cloud Firestore
* Firebase Storage

For Android, make sure your Firebase configuration file is correctly placed in the appropriate project directory.

### 5. Run the Application

```bash
flutter run
```

---

## 📦 Build Release APK

To generate a release APK:

```bash
flutter build apk --release
```

The generated APK can be found inside:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

## 📸 Screenshots

> Add your NovaCart application screenshots here to showcase the UI.

### Onboarding

*Add onboarding screenshots here.*

### Home & Categories

*Add home screen screenshots here.*

### Product Details

*Add product detail screenshots here.*

### Wishlist & Cart

*Add wishlist and cart screenshots here.*

### Checkout

*Add checkout screenshots here.*

---

## 🎯 Project Highlights

NovaCart demonstrates practical experience with:

* Flutter application development
* Dart programming
* GetX state management
* Firebase Authentication
* Cloud Firestore
* Firebase Storage
* Local data persistence
* Dynamic theme management
* Responsive UI development
* Reusable Flutter widgets
* E-commerce application architecture

---

## 🔮 Future Improvements

Planned improvements include:

* [ ] Online payment gateway integration
* [ ] Order tracking
* [ ] Push notifications
* [ ] Product search & advanced filtering
* [ ] Product reviews & ratings
* [ ] Admin dashboard
* [ ] Order history
* [ ] Firebase Cloud Messaging
* [ ] Improved product recommendation system

---

## 🤝 Contributing

Contributions, suggestions, and improvements are welcome.

If you would like to contribute:

```bash
git checkout -b feature/your-feature
```

Make your changes, commit them, and open a pull request.

---

## 👨‍💻 Developer

**Hamza Ali**

Flutter Developer | Mobile Application Developer

### Technologies

`Flutter` • `Dart` • `Firebase` • `GetX` • `Hive` • `REST APIs`

---

## ⭐ Support

If you find this project useful or interesting, consider giving the repository a ⭐ on GitHub.

---

**Built with ❤️ using Flutter & Dart**
