# 🛒 E-Commerce CartVerse App

A responsive **Flutter mobile application** converted from an existing e-commerce website. This app provides essential e-commerce functionalities using modern Flutter tools and state management, supporting localization, themes, and persistent user preferences.

---

## 🚀 Features

-  **Authentication** (Login & Register) via API endpoints  
-  **Orders** and **Wishlist** system tied to each user  
-  **Dark and Light Mode** toggle with saved preferences  
-  **Localization**: Arabic 🇸🇦 and English 🇺🇸 using `easy_localization`  
-  **Google Maps Integration** using `google_maps_flutter`  
-  **Permissions Handling** via `permission_handler`  
-  **HTTP Requests** for API communication using `http`  
-  **Persistent Storage** with `shared_preferences`  
-  **State Management** using `flutter_bloc`  

---

## 🎥 Demo Video

[Watch the demo here on Google Drive](https://drive.google.com/file/d/1gTkKZT7H-jHXk1M5I8hWwnCPu_z0N_0V/view?usp=sharing)


## 📱 Screenshots
- Forgot to capture this page in demo
<img src="\Screenshots\CartVerse_screenshot_YousraAmr.jpg" width="300"/>
---

## 🛠️ Technologies & Packages Used

| Purpose                 | Package Name           |
|------------------------|------------------------|
| API Requests           | [`http`](https://pub.dev/packages/http) |
| Persistent Storage     | [`shared_preferences`](https://pub.dev/packages/shared_preferences) |
| Google Maps Integration| [`google_maps_flutter`](https://pub.dev/packages/google_maps_flutter) |
| Permissions            | [`permission_handler`](https://pub.dev/packages/permission_handler) |
| State Management       | [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) |
| Localization           | [`easy_localization`](https://pub.dev/packages/easy_localization) |

---

## 📦 API Endpoints Used

- `POST /register` – Register a new user  
- `POST /login` – Authenticate existing user  
- `GET /orders` – Fetch user-specific orders  
- `GET /wishlist` – Fetch user-specific wishlist  

> All data is stored and retrieved based on user-specific credentials.

---

## 🌐 Localization

Supported languages:
- English 🇺🇸 (default)
- Arabic AR

Localization is saved per user using `shared_preferences`.

---

## 🎨 Theme Modes

- Light Mode  
- Dark Mode  

> The selected mode is saved per user and loaded on app launch.

---

## 📍 Google Maps

- Google Maps is displayed on a dedicated screen  
- Permissions for location are handled gracefully  
- Works on both Android and iOS (with proper API key setup)

---

## 🧪 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/ecommerce_flutter_app.git
cd cartverse
```
### 2. Install Dependencies
```bash
flutter pub get
```
### 3.Run the App
```bash
flutter run
```

## Contact
- Need help or have a question? Feel free to reach out!

-  Email: [![Yousra Amr](https://img.shields.io/badge/yousra%20amr-Contact-blue)](mailto:yousraamr000@gmail.com)
-  LinkedIn: [www.linkedin.com/in/yousra-amr-93a691279](https://www.linkedin.com/in/yousra-amr-93a691279)  
-  GitHub: [@yousraamr](https://github.com/yousraamr)
