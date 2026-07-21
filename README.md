# BookStore

A modern iOS Book Store application built with SwiftUI, featuring a modular Clean Architecture, an XCFramework-based networking layer, local persistence via SwiftData, and a complete Swift Testing unit test suite.

---

## Documentation

- [Architecture & Design Decisions](BookStore%20—%20Architecture%20%26%20Design%20Decisions.pdf) — Clean Architecture layers, MVVM pattern, key design decisions, and testing strategy.

---

## Requirements

| Tool | Version |
|---|---|
| Xcode | 16.0 or later |
| iOS Deployment Target | 17.0 |
| CocoaPods | 1.13 or later |
| Swift | 6.0 or later |

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/danielcano75/BookStore.git
cd BookStore
```

### 2. Install dependencies

This project uses [CocoaPods](https://cocoapods.org) for dependency management.

```bash
pod install
```

> **Important:** Always use `BookStore.xcworkspace` to open the project — not `BookStore.xcodeproj`. CocoaPods generates the workspace and it is required to resolve the pod dependencies.

### 3. Open the workspace

```bash
open BookStore.xcworkspace
```

Or open it directly from Finder / Xcode's "Open…" dialog.

### 4. Build and run

1. Select the **BookStore** scheme from the scheme picker.
2. Choose a simulator or connected device running **iOS 17.0 or later**.
3. Press **⌘R** (or **Product → Run**).

---

## Project Structure

```
BookStore/
├── App/                    # App entry point and configuration
├── Domain/
│   ├── Conversor/          # Entity ↔ Model converters
│   └── UseCase/            # One use case per operation
├── Repository/             # BooksRepository (SwiftData + Service)
├── Services/               # BooksService (networking)
└── Modules/                # SwiftUI screens and ViewModels
    ├── Books/
    ├── BookDetail/
    ├── Favorites/
    ├── ShoppingCart/
    └── Components/         # Shared reusable SwiftUI views

BookStoreTests/
├── Mocks/                  # ServiceMocks, RepositoryMocks, UseCaseMocks
├── Service/
├── Repository/
├── UseCase/
├── Conversor/
└── ViewModel/
```

---

## Dependencies

Managed via CocoaPods (`Podfile`):

| Pod | Version | Purpose |
|---|---|---|
| `Networking` | ~> 1.0 | HTTP client (`APIClientProtocol`) |
| `DataStorage` | ~> 1.0 | SwiftData abstraction (`StorageRepositoryProtocol`) |

Pod specs are sourced from a private spec repository: `https://github.com/danielcano75/Specs.git`
