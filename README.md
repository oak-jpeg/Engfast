# 📱 EngFast - Vocabulary Flashcard & Quiz App

EngFast คือแอปฝึกคำศัพท์ภาษาอังกฤษแบบรวดเร็ว 🚀  
เน้นทั้งการท่องจำและการทำ Quiz เพื่อทบทวนในรูปแบบที่สนุกและใช้งานง่าย ✨

---

## ✨ ฟีเจอร์หลัก

- 🔤 Flashcard คำศัพท์ พร้อมแปลไทย
- 🧠 โหมด Quiz แบบสุ่มตัวเลือก
- 🎯 แสดงผลคะแนนหลังทำเสร็จ
- 📊 บันทึกคะแนนล่าสุดด้วย SharedPreferences
- 🌈 UI สวยงาม รองรับทั้ง iOS และ Android

---

## 📸 Screenshots

### iOS

| หน้า Home | แสดงคำแปล | โหมด Quiz |
|-----------|------------|------------|
| ![](assets/screen_ios/ios_homepage.png) | ![](assets/screen_ios/ios_translate.png) | ![](assets/screen_ios/ios_quiz.png) |

| ตอบถูก | ตอบผิด | สรุปผล |
|--------|--------|--------|
| ![](assets/screen_ios/ios_ture.png) | ![](assets/screen_ios/ios_false.png) | ![](assets/screen_ios/ios_result.png) |

---

### Android  
📌 *กำลังอัปโหลดภาพ Android...* (เก็บไว้ใน `assets/screen_android/`)

---

## 🚀 วิธีติดตั้งและรันแอป

1. คลอน repo นี้:
```bash
git clone https://github.com/your-username/engfast.git
cd engfast
```

2. ติดตั้ง package ที่จำเป็น:
```bash
flutter pub get
```

3. รันบน Emulator หรือ Device จริง:
```bash
flutter run
```

---

## 🛠 เทคโนโลยีที่ใช้

- Flutter 3+
- Dart
- Google Fonts
- Shared Preferences
- Material 3

---

## 📁 โครงสร้างไฟล์ที่เกี่ยวข้องกับภาพ

```
assets/
├── screen_ios/
│   ├── ios_homepage.png
│   ├── ios_translate.png
│   ├── ios_quiz.png
│   ├── ios_ture.png
│   ├── ios_false.png
│   └── ios_result.png
├── screen_android/
│   └── (รออัปโหลด)
```

> อย่าลืมเพิ่มใน `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/screen_ios/
    - assets/screen_android/
```

---

## 🙌 ขอบคุณที่ใช้งาน EngFast!
แอปดี ๆ สำหรับทุกคนที่อยากเก่งอังกฤษแบบเร็วไว 🔥

---

หากคุณชอบโปรเจกต์นี้ อย่าลืม ⭐ Star บน GitHub นะครับ 😊