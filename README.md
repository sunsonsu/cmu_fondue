# 🧀 CMU Fondue

<div align="center">

**ระบบแจ้งปัญหาภายในมหาวิทยาลัยเชียงใหม่**

*Problem Reporting System for Chiang Mai University*

[![Flutter](https://img.shields.io/badge/Flutter-3.10.7-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-Private-red)]()

</div>

---

## 📖 เกี่ยวกับโปรเจค

**CMU Fondue** คือแอปพลิเคชันมือถือสำหรับการแจ้งและติดตามปัญหาต่างๆ ภายในมหาวิทยาลัยเชียงใหม่ ช่วยให้นักศึกษาและบุคลากรสามารถรายงานปัญหา เช่น ความเสียหายของสิ่งของ ปัญหาสาธารณูปโภค และร่วมกันแก้ไขปัญหาได้อย่างรวดเร็วและมีประสิทธิภาพ

### ✨ ฟีเจอร์หลัก

- 📍 **ระบุตำแหน่งปัญหา** - ใช้ Google Maps เลือกตำแหน่งที่พบปัญหา
- 📸 **อัพโหลดรูปภาพ** - ถ่ายรูปหรือเลือกจากแกลเลอรี่
- 🏷️ **จัดหมวดหมู่** - แบ่งประเภทปัญหาตามลักษณะ
- 👍 **Upvote ปัญหา** - โหวตปัญหาที่สำคัญให้ได้รับความสนใจ
- 🔔 **ติดตามสถานะ** - ดูความคืบหน้าการแก้ไขปัญหา
- 👨‍💼 **ระบบ Admin** - จัดการและอัพเดทสถานะปัญหา
- 📊 **Dashboard สถิติ** - แสดงข้อมูลการแจ้งปัญหาแบบ real-time

---

<!-- ## 👥 ทีมพัฒนา

| ชื่อ | บทบาท | Email | GitHub |
|------|--------|-------|--------|
| **ชื่อสมาชิก 1** | Frontend Developer | member1@example.com | [@username1](https://github.com/username1) |
| **ชื่อสมาชิก 2** | Backend Developer | member2@example.com | [@username2](https://github.com/username2) |
| **ชื่อสมาชิก 3** | UI/UX Designer | member3@example.com | [@username3](https://github.com/username3) |
| **ชื่อสมาชิก 4** | Project Manager | member4@example.com | [@username4](https://github.com/username4) | -->

## 🛠️ Tech Stack

### Frontend
- **Flutter 3.10.7** - Cross-platform mobile framework
- **Dart** - Programming language
- **Provider** - State management
- **Google Maps Flutter** - Map integration

### Backend & Services
- **Firebase Authentication** - User authentication
- **Cloud Firestore** - NoSQL database
- **Firebase Storage** - Image storage
- **Firebase Data Connect** - GraphQL API

### Tools & Libraries
- **Geocoding** - Location services
- **Image Picker** - Photo selection
- **Flutter Launcher Icons** - App icon generation

---

## 📱 คู่มือการใช้งาน

### 🧑‍🎓 สำหรับผู้ใช้ทั่วไป (นักศึกษา/บุคลากร)

#### 1️⃣ การสมัครสมาชิกและเข้าสู่ระบบ

1. เปิดแอป **CMU Fondue**
2. คลิก **"สมัครสมาชิก"** (ครั้งแรก) หรือ **"เข้าสู่ระบบ"**
3. กรอก **อีเมล CMU** และรหัสผ่าน
4. คลิก **"ยืนยัน"**

#### 2️⃣ การแจ้งปัญหาใหม่

1. ที่หน้าแรก คลิกปุ่ม **"+"** (แจ้งปัญหา)
2. **เลือกประเภทปัญหา** (ไฟฟ้า, ประปา, ถนน, ฯลฯ)
3. **เลือกตำแหน่ง** บนแผนที่ หรือค้นหาสถานที่
4. **ถ่ายรูป** หรือเลือกรูปจากแกลเลอรี่
5. **กรอกรายละเอียด** ปัญหา
6. คลิก **"ส่งรายงาน"**

#### 3️⃣ การติดตามปัญหา

1. ไปที่แท็บ **"ประวัติ"**
2. ดูปัญหาที่คุณแจ้งทั้งหมด
3. คลิกเพื่อดูสถานะ:
   - 🟡 **รอดำเนินการ** - ยังไม่มีการรับเรื่อง
   - 🔵 **กำลังแก้ไข** - อยู่ระหว่างดำเนินการ
   - 🟢 **เสร็จสิ้น** - แก้ไขเรียบร้อย

#### 4️⃣ การ Upvote ปัญหา

1. เปิดหน้ารายละเอียดปัญหา
2. คลิกปุ่ม **👍 Upvote**
3. ปัญหาที่มี upvote สูงจะได้รับการแก้ไขเร็วขึ้น

---

### 👨‍💼 สำหรับ Admin/Staff

#### 1️⃣ เข้าสู่ระบบ Admin

1. เข้าสู่ระบบด้วยบัญชี **Staff/Admin**
2. ระบบจะแสดงหน้า **ภาพรวมระบบ** โดยอัตโนมัติ

#### 2️⃣ การจัดการปัญหา

1. ที่ **Dashboard** ดูสถิติและปัญหาทั้งหมด
2. กรองปัญหาตาม:
   - **สถานะ** (รอดำเนินการ, กำลังแก้ไข, เสร็จสิ้น)
   - **ประเภท** (ไฟฟ้า, ประปา, ถนน, ฯลฯ)
   - **พื้นที่** (คณะต่างๆ, อาคาร)

#### 3️⃣ อัพเดทสถานะปัญหา

1. คลิกที่ปัญหาที่ต้องการจัดการ
2. เปลี่ยนสถานะตาม flow:
   - **รับเรื่อง** → **กำลังแก้ไข** → **เสร็จสิ้น**
3. ระบบจะบันทึกเวลาที่อัพเดทสถานะ
4. อัพโหลดรูปภาพหลังแก้ไข (ถ้ามี)

#### 4️⃣ การลบปัญหา

1. เปิดหน้ารายละเอียดปัญหา
2. คลิก **"ลบปัญหา"**
3. ยืนยันการลบ
4. ระบบจะแสดงการแจ้งเตือนสำเร็จ/ไม่สำเร็จ

---

## 🚀 การติดตั้งและพัฒนา

### ข้อกำหนดเบื้องต้น

- Flutter SDK `3.10.7` หรือสูงกว่า
- Dart SDK `^3.10.7`
- Android Studio / Xcode (สำหรับ emulator)
- Firebase CLI
- Git

### การติดตั้ง

1. **Clone repository**
   ```bash
   git clone https://github.com/your-org/cmu_fondue.git
   cd cmu_fondue
   ```

2. **ติดตั้ง dependencies**
   ```bash
   flutter pub get
   ```

3. **ตั้งค่า Firebase**
   ```bash
   # ติดตั้ง Firebase CLI
   npm install -g firebase-tools
   
   # Login Firebase
   firebase login
   
   # เริ่ม emulators (สำหรับ development)
   cd dataconnect
   firebase emulators:start --project cmu-fondue
   ```

4. **Run แอพ**
   ```bash
   flutter run
   ```

### โครงสร้าง Project

```
cmu_fondue/
├── lib/
│   ├── application/        # UI Layer (Pages, Widgets, Providers)
│   │   ├── pages/         # หน้าจอต่างๆ
│   │   ├── widgets/       # Widget components
│   │   └── providers/     # State management
│   ├── data/              # Data Layer (API, Database)
│   │   └── repositories/  # Repository implementations
│   ├── domain/            # Domain Layer (Business Logic)
│   │   ├── entities/      # Business entities
│   │   ├── repositories/  # Repository interfaces
│   │   └── usecases/      # Use cases
│   └── main.dart          # Entry point
├── assets/                # รูปภาพและ resources
├── dataconnect/          # Firebase Data Connect (GraphQL)
├── android/              # Android specific files
├── ios/                  # iOS specific files
└── pubspec.yaml          # Dependencies
```

---

## 🏗️ สถาปัตยกรรม

โปรเจคนี้ใช้ **Clean Architecture** แบ่งเป็น 3 layers:

### 🏛️ Domain Layer
- **Entities** - โครงสร้างข้อมูลหลัก (Problem, User, Location)
- **Repositories** - Interface สำหรับการเข้าถึงข้อมูล
- **Use Cases** - Business logic (CreateProblem, UpdateStatus)

### 💾 Data Layer
- **Repository Implementations** - เชื่อมต่อ Firebase/API
- **Data Sources** - Remote (Firestore, Storage) / Local (Cache)

### 📱 Application Layer
- **Pages** - หน้าจอ UI ทั้งหมด
- **Widgets** - Components ที่ใช้ซ้ำได้
- **Providers** - State management ด้วย Provider pattern

---

