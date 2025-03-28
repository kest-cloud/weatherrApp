# weatherapp

📱 Project Name : Weather App

🌟 Project Overview
This Flutter application is developed using clean architecture principles, focusing on separation of concerns and maintainability.

🚀 Project Setup
Initial Project Creation

    flutter create weatherapp
    cd weatherapp

📂 Project Structure

    project_root/
    │
    ├── lib/
    │   ├── core/
    │   │   ├── assets/
    │   │   ├── di-manual/
    |   |   ├── networkhandler/
    │   │   └── utils/
    │   │
    │   ├── features/
    │   │   ├── dashboard/
    │   │   │   ├── data/
    │   │   │   │   ├── datasource/
    │   │   │   |   ├── domain/
    │   │   │   │     ├── entities/
    │   │   │   │     ├── repositories/
    │   │   │   └── presentation/
    │   │   │       ├── notifier/
    │   │   │       ├── view/
    │   │   │       └── widgets/
    │   │
    │   └── main.dart
    |   |
    │   ├── test/
    |
    ├── pubspec.yaml
    └── README.md

📦 Dependency Management
Used Packages

State Management: GetIt for Dependency Injection and Bloc for Data Notifier
Networking: dio (HTTP requests)


🧰 Core Functionality
The core/ directory contains:

Common utilities
Shared constants
Base classes
Utility functions

🏗️ Feature Implementation
Each feature follows clean architecture:

data/: Data sources, models, repositories
domain/: Business logic, entities, use cases
presentation/: UI components, state management


🏁 Getting Started

🔽 Clone the repository
📦 Run flutter pub get
🔧 Configure your environment variables (I will share my .env)
 .env --- https://drive.google.com/file/d/1pTND7I0DPsCMFr56u5228i4XNM1l-gBg/view?usp=sharing
🚀 Run the app with flutter run

📝 Development Notes

✅ Strictly follows clean architecture principles
🧩 Modular and scalable project structure
💉 Dependency injection with GetIt
🔒 Robust network layer with interceptors


Test
flutter test


Flutter 3.27.4 • channel stable • https://github.com/flutter/flutter.git
Framework • revision d8a9f9a52e (8 weeks ago) • 2025-01-31 16:07:18 -0500
Engine • revision 82bd5b7209
Tools • Dart 3.6.2 • DevTools 2.40.3