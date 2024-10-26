# Expense Manager

A modern, intuitive expense tracking application built with Flutter that helps users manage their daily transactions and visualize spending patterns.

## Features

- 📱 Responsive design that works in both portrait and landscape modes
- 📊 Visual charts to analyze weekly spending patterns
- 💰 Track daily transactions with title, amount, and date
- 🗑️ Easy deletion of transactions
- 📅 Weekly expense visualization
- 🎨 Custom theme with beautiful UI elements

## Project Structure
```
expense_manager/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── transaction.dart
│   └── widgets/
│       ├── chart.dart
│       ├── chart_bar.dart
│       ├── new_transaction.dart
│       └── transaction_list.dart
├── assets/
├── pubspec.yaml
└── pubspec.lock
```

## Getting Started

### 1. Create a new Flutter project
```bash
flutter create expense_manager
```

### 2. Replace the contents of your project
- Delete the existing `lib` folder in your project
- Copy the `lib` folder from this repository to your project
- Copy the `assets` folder to your project root
- Replace your `pubspec.yaml` with the one from this repository

### 3. Install dependencies
```bash
flutter pub get
```

### 4. Run the app
```bash
flutter run
```

## Dependencies
Please ensure your `pubspec.yaml` has the following dependencies:
```yaml
dependencies:
  flutter:
    sdk: flutter
```

## Assets
The project uses the following assets:
- Font: 'Baloo Bhai 2'

Make sure the assets are properly referenced in your `pubspec.yaml`:
```yaml
fonts:
  - family: Baloo Bhai 2
    fonts:
      - asset: assets/fonts/BalooBhai2-Regular.ttf
```

## Features in Detail

### Transaction Management
- Add new transactions with title, amount, and date
- Delete existing transactions with a simple tap
- Scrollable list of all transactions

### Visual Analytics
- Weekly spending chart
- Visual representation of daily expenses
- Responsive chart sizing based on screen orientation

### Responsive Design
- Portrait mode: Vertical layout with chart and transaction list
- Landscape mode: Tabbed interface with dedicated views for chart and transactions
- Adaptive layout based on screen dimensions


Made with ❤️ using Flutter by Umair