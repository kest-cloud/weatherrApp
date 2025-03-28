# weatherapp

📱 Project Name
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
    │   │   ├── constants/
    │   │   ├── networkhandler/
    │   │   └── utils/
    │   │
    │   ├── features/
    │   │   ├── dashboard/
    │   │   │   ├── data/
    │   │   │   │   ├── datasource/
    │   │   │   ├── domain/
    │   │   │   │   ├── entities/
    │   │   │   │   ├── repositories/
    │   │   │   └── presentation/
    │   │   │       ├── notifier/
    │   │   │       ├── view/
    │   │   │       └── widgets/
    │   │
    │   └── main.dart
    |   |
    │   ├── Test/
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
🔧 Configure your environment variables
🚀 Run the app with flutter run

📝 Development Notes

✅ Strictly follows clean architecture principles
🧩 Modular and scalable project structure
💉 Dependency injection with GetIt
🔒 Robust network layer with interceptors


Test
flutter test