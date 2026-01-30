# Tharad Tech – Flutter Developer Technical Task

## 📌 Objective
This project is a Flutter application developed as a technical task for **Tharad Tech**.  
The app demonstrates authentication, profile management, local caching, offline support, and dynamic multi-language switching using modern Flutter best practices.

---

## 🛠️ Features

### 🔐 Authentication
- Login, Register and OTP
- Authentication using REST API and upload image file
- Securely cache authentication token using local NoSQL storage (get_storage)
- Persistent login using cached token

<p align="center">
  <img src="https://github.com/user-attachments/assets/5c1772c6-1e1e-44e1-91e0-fc7172fb2dc7" width="250" />
  <img src="https://github.com/user-attachments/assets/7b53a2fb-15b7-428e-ab80-84c816277068" width="250" />
</p>

---

### 👤 Profile Management
- Fetch user profile data after successful login
- Display user information (name, email, profile image, etc.)
- Update profile details via API
- Upload profile image
- Cache profile data for offline access
- Automatically refresh cache after profile update


<p align="center">
  <img src="https://github.com/user-attachments/assets/dc516dcc-ab14-4c53-ab7f-5d22a6b9324e" width="250" />
  <img src="https://github.com/user-attachments/assets/22139c72-0143-4e01-9735-66104a5e738b" width="250" />
  <img src="https://github.com/user-attachments/assets/eec70d8c-917e-42e5-bac8-babed401878a" width="250" />
</p>
---

### 💾 Caching & Offline Support
- Cache authentication token
- Cache profile data locally
- Enable offline viewing of cached profile data
- Sync cache after successful API updates

---

### 🌍 Multi-Language Support
- Dynamic language switching
- App language changes without restarting the app
- Localization-ready structure

---

## 🧰 Tech Stack

| Technology | Usage |
|----------|------|
| **Flutter** | Application development |
| **Dio** | REST API integration |
| **Cubit (Bloc)** | State management |
| **GetStorage** | Local caching |
| **image_picker** | Camera & gallery image selection |
| **easy_localization** | Multi-language support |

---

