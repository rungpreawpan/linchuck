# 📱 Flutter Project

## 🛠 การติดตั้งและตั้งค่าระบบ
โครงการนี้เป็นแอปพลิเคชันที่พัฒนาด้วย **Flutter** ซึ่งต้องกำหนดค่า **BaseURL** ให้เหมาะสมกับแพลตฟอร์มที่ใช้งาน

---

## 🚀 1. การติดตั้ง Flutter และ Dependencies

### 1.1 ติดตั้ง Flutter SDK
หากยังไม่มี **Flutter SDK** สามารถติดตั้งได้ที่  
🔗 [Flutter Installation Guide](https://docs.flutter.dev/get-started/install)

### 1.2 ติดตั้ง Dependencies
หลังจาก Clone โปรเจกต์มาแล้ว ให้รันคำสั่ง
```bash
flutter pub get
```

## 🌍 2. การตั้งค่า BaseURL
เนื่องจากแอปพลิเคชันต้องเชื่อมต่อกับเซิร์ฟเวอร์ API จำเป็นต้องกำหนดค่า BaseURL ให้เหมาะสมกับแพลตฟอร์มที่ใช้งาน โดยสามารถแก้ไขได้ในไฟล์
📂 lib/constant/environment.dart

### 🔹 Android Emulator
ใน Android Emulator ไม่สามารถใช้ localhost ได้โดยตรงให้แก้ไขเป็นเลข IP Address
```dart
const String baseURL = "http://<IP Address>:3000/";
```

### 🔹 iOS Simulator
ใน iOS Simulator สามารถใช้ localhost ได้ตามปกติ
```dart
const String baseURL = "http://localhost:3000/";
```

### 🔹 อุปกรณ์จริง (Android / iOS)
หากใช้งานบนอุปกรณ์จริง ให้ใช้ IP Address ของเซิร์ฟเวอร์ในเครือข่ายเดียวกัน
```dart
const String baseURL = "http://<IP Address>:3000/";
```

## 🏃‍♂️ 3. การรันโปรเจกต์

### 3.1 รันแอปพลิเคชัน
ควรเลือก Emulator หรือ Device ที่เป็น Tablet 
```
flutter run
```

### 3.2 เปิดใช้งานเซิร์ฟเวอร์
ดาวน์โหลด API ได้ที่นี่
🔗 https://github.com/Natchaya-Yimtanom/linchuk-api
หลังจากดาวน์โหลดให้ install package และ run server
```
npm install
npm start
```

## 📬 ติดต่อผู้พัฒนา
หากพบปัญหาหรือมีข้อสงสัย สามารถติดต่อได้ที่
> 📧 Email: 2463110383@tni.ac.th สำหรับปัญหาด้านแอปพลิเคชัน
> 📧 Email: 2463110110@tni.ac.th สำหรับปัญหาด้าน API