# 🏋️‍♂️ Fitness & Hydration App (Flutter)

A modern Flutter application focused on **hydration tracking, workout planning, and mood-based UI**, built with scalable architecture and clean state management.

---

## 📦 Dependencies Used

### 🔹 `flutter_screenutil`

* Used throughout the UI (`.w`, `.h`, `.sp`, `.r`) to make **sizes, paddings, and font sizes responsive**.
* Ensures the design closely matches the **Figma-like layout** across multiple screen sizes without manual `MediaQuery` calculations.

### 🔹 `go_router`

* Added for **declarative, URL-based routing** in Flutter.
* Currently **not actively used**, but included for **future navigation refactors** beyond the existing `BottomNavigationBar` and manual body switching.

### 🔹 `riverpod`

* Core Riverpod package providing **state management primitives**.
* Used indirectly via `flutter_riverpod` to model app-wide state such as:

  * Hydration state
  * Workout schedules

### 🔹 `flutter_riverpod`

* Flutter bindings for Riverpod, enabling:

  * `ConsumerWidget`
  * `ConsumerStatefulWidget`
  * `ref.watch` / `ref.read`
* Powers **global, reactive state** shared across:

  * Home Screen
  * Plan Screen
  * Calendar Bottom Sheet
* Manages hydration (dates, weeks, day/night) and training workflows.

### 🔹 `flutter_svg`

* Renders **SVG assets** for icons and illustrations (navigation icons, workout icons, mood assets).
* Keeps icons **sharp at any resolution** and aligned with the app’s vector-based design system.

---

## 🎨 App UI Preview

| Home                                                                                 | Plan                                                                                 |
| ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ |
| ![](https://github.com/user-attachments/assets/72f0a398-e651-434e-9480-62250bd03b9d) | ![](https://github.com/user-attachments/assets/177798af-73dd-4201-8e5b-430b304339da) |

| Workout                                                                              | Mood                                                                                 |
| ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ |
| ![](https://github.com/user-attachments/assets/1a9943d5-1ee9-498e-af67-af6e47d6af9d) | ![](https://github.com/user-attachments/assets/27728ea6-8a97-4f8d-b357-66cdc4b08d1d) |

| Calendar                                                                             | Hydration                                                                            |
| ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ |
| ![](https://github.com/user-attachments/assets/030980d9-14b1-423a-b18c-fb7cad511d75) | ![](https://github.com/user-attachments/assets/2dec3c7f-3f1e-462b-b0f4-afaf137a4525) |

| Progress                                                                             |
| ------------------------------------------------------------------------------------ |
| ![](https://github.com/user-attachments/assets/be914e3e-e1ad-45ff-90d6-0016a36ede28) |

---

## 🔄 Full App Flow (Video)

▶️ [Watch Full App Flow](https://github.com/user-attachments/assets/d3526c0f-4a3f-4e15-ac44-d37c2025d2cb)

---

## 📲 Download APK

⬇️ [Download Latest APK](https://drive.google.com/file/d/1TgsZ0BNqc6uQdeL4eE62RKB5AzhGA2QD/view?usp=sharing)

---

## 🧱 Architecture Highlights

* **Riverpod-based state management** (scalable and testable)
* **Responsive UI** using ScreenUtil
* **Separation of concerns** between UI, state, and logic
* **Reusable components** and consistent theming

---

## ✅ Notes

* UI is designed to closely match the provided designs.
* Navigation and routing are structured for easy future expansion.
* No unnecessary dependencies or over-engineering.

---

> Built with ❤️ using Flutter
