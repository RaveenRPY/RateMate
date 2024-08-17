# RateMate - Currency Converter App


**A Flutter-based mobile app for real-time currency conversions.**

This document provides a comprehensive overview of the Currency Converter app, its features, architecture, and usage instructions.

### Overview

Built with Flutter, this app empowers users to convert currencies seamlessly using the Exchangerate-API. It offers dynamic handling of multiple conversions along with persistent storage for user preferences, ensuring a convenient and personalized experience.

### Features

- **Real-time Currency Conversion:** Stay updated with the latest exchange rates for accurate conversions.
- **Multiple Currency Conversions:** Add and remove target currencies as needed, fostering flexibility.
- **Offline Persistence:** User preferences are stored locally, guaranteeing seamless access upon app restart.
- **Interactive UI/UX:** We prioritize user experience with smooth animations and intuitive controls.

### Architecture

Employing the Clean Architecture approach, the project boasts a well-defined structure composed of three distinct layers:

**1. Presentation Layer:** 
  - Handles UI and interaction logic, leveraging Bloc for state management.

**2. Domain Layer:**
  - Encapsulates the core business logic and use cases, independent of the UI.

**3. Data Layer:**
  - Manages data sources, including API calls and local storage.

**Benefits of Clean Architecture:**

- **Separation of Concerns:** Ensures clear boundaries between UI, business logic, and data management, enhancing maintainability and testability.
- **Testability:** Streamlines unit testing of business logic, independent of the UI or external data sources.
- **Scalability:** Facilitates easy extension and modifications. New features can be integrated without impacting existing code.

### State Management

This app utilizes Bloc (Business Logic Component) for state management, offering:

- **Separation of Business Logic:** Distinct separation between business logic and UI, simplifying management and testing.
- **Reactive Programming:** Efficient management of state changes through reactive programming principles employed by Bloc.

### Setup Instructions

**Prerequisites:**

- **Flutter SDK:** Install Flutter on your development machine.
- **Dart SDK:** Included with Flutter, no separate installation required.

**1. Clone the Repository:**

```bash
git clone https://github.com/RaveenRPY/RateMate.git
cd RateMate
```

**2. Install Dependencies:**

```bash
flutter pub get
```

**3. Configure API Keys:**

Create a `.env` file in the root directory. Add your Exchangerate-API key:

```
EXCHANGERATE_API_KEY = c38048955022558f25e07968
``` 

### Running the App

To launch the app on an emulator or connected device:

```bash
flutter run
```

### Company Requirements

This project aligns perfectly with the following company requirements:

- **API Integration:** Employs the Exchangerate-API for currency conversions.
- **Architecture:** Implements Clean Architecture with Bloc for state management.
- **Input:**
    - Provides a TextField for user input amount.
    - Enables selection of the input currency.
- **Output:**
    - Displays the converted amount in chosen currencies.
    - Supports multiple target currencies with dynamic addition and removal.
- **Persistence:**
    - User preferences are saved locally using shared preferences.
    - Preferred currencies are readily available upon app restart.
- **Delete Functionality:**
    - Users can long-press to delete any of the preferred target currencies.

### Conclusion

This project serves as a prime example of a well-structured Flutter application that adheres to modern architectural principles and best practices. Clean Architecture and Bloc implementation contribute to a highly maintainable, scalable, and efficient app, proficiently handling user interactions and API calls. The user-centric interface ensures a smooth user experience, meeting all company criteria for a robust and efficient currency converter app.
