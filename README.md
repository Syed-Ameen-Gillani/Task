**Dependencies used:**
flutter_screenutil:
Used throughout UI (.w, .h, .sp, .r) to make sizes, paddings, and font sizes responsive across different screen resolutions.
This ensures the design matches the provided Figma-like layout on multiple device sizes without manual media query math.

go_router:
Included for declarative, URL-based routing and navigation in Flutter.
It is not currently used in the codebase, but is likely intended for future navigation refactors beyond the current BottomNavigationBar + manual body switching.

riverpod:
Base Riverpod package that provides the core provider and state management primitives.
Used indirectly via flutter_riverpod to model app state like HydrationState and the training WorkoutNotifier.

flutter_riverpod:
Flutter bindings for Riverpod, giving access to ConsumerWidget, ConsumerStatefulWidget, and ref.watch/read.
Powers global, reactive state for hydration (dates, week, day/night) and workouts, shared between Home, Plan, and the calendar bottom sheet.

flutter_svg:
Renders SVG assets for icons and illustrations (e.g., nav icons, workout icons, mood assets where SVG is used).
This lets the app keep icons sharp at any resolution and match the design system’s vector icon set.

**App UI:**

![WhatsApp Image 2026-01-06 at 5 53 38 PM](https://github.com/user-attachments/assets/72f0a398-e651-434e-9480-62250bd03b9d)
![WhatsApp Image 2026-01-06 at 5 53 36 PM](https://github.com/user-attachments/assets/177798af-73dd-4201-8e5b-430b304339da)
![WhatsApp Image 2026-01-06 at 5 53 37 PM (2)](https://github.com/user-attachments/assets/1a9943d5-1ee9-498e-af67-af6e47d6af9d)
![WhatsApp Image 2026-01-06 at 5 53 37 PM](https://github.com/user-attachments/assets/27728ea6-8a97-4f8d-b357-66cdc4b08d1d)
![WhatsApp Image 2026-01-06 at 5 53 37 PM (1)](https://github.com/user-attachments/assets/030980d9-14b1-423a-b18c-fb7cad511d75)
![WhatsApp Image 2026-01-06 at 5 53 36 PM (2)](https://github.com/user-attachments/assets/2dec3c7f-3f1e-462b-b0f4-afaf137a4525)
![WhatsApp Image 2026-01-06 at 5 53 36 PM (1)](https://github.com/user-attachments/assets/be914e3e-e1ad-45ff-90d6-0016a36ede28)

**Full App Flow:**
https://github.com/user-attachments/assets/d3526c0f-4a3f-4e15-ac44-d37c2025d2cb

**Download Apk**: https://drive.google.com/file/d/1TgsZ0BNqc6uQdeL4eE62RKB5AzhGA2QD/view?usp=sharing
