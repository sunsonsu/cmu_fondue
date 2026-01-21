# 🧀 CMU Fondue – Clean Architecture Overview

This project follows a **Clean Architecture–inspired structure** to keep the codebase scalable, testable, and easy to maintain. The architecture is divided into **three main layers**: **Domain**, **Data**, and **Application**.

---

## 🧱 1. Core Layers

### 🏛️ Domain Layer (The Heart)

The **Domain layer** is the most important part of the application. It is completely independent from UI frameworks, databases, or external libraries.

**Responsibilities**

* Contains **business logic** and rules
* Defines **what** the app can do, not **how** it does it

**Components**

* **Entities**
  Simple Dart classes that represent core data (e.g., `PokemonEntity`).

* **Repositories (Abstract)**
  Interfaces that define data operations without implementation details.

* **Use Cases**
  Command-like classes that represent specific business actions (e.g., `GetPokemonList`).

> ⚠️ **Note**
> Models related to **UI state** (such as `theme_selector_model.dart`) should belong to the **Application layer**, not the Domain layer. Use cases should focus only on business behavior.

---

### 💾 Data Layer (The Infrastructure)

The **Data layer** is responsible for handling external data sources such as APIs or local storage.

**Responsibilities**

* Fetch data from APIs or databases
* Convert raw data (JSON) into domain entities

**Components**

* **Repository Implementations (`_impl`)**
  Concrete classes that implement domain repository interfaces.

* **Remote / Local Data Sources**
  Uses libraries like `http` or `dio` to retrieve data.

This layer depends on the **Domain layer**, but never on the UI.

---

### 📱 Application Layer (The UI)

The **Application layer** is where users interact with the app.

**Responsibilities**

* Display data to the user
* Handle user interactions
* Manage UI state

**Components**

* **Pages**
  Full screens (e.g., `PokemonPage`).

* **Widgets**
  Reusable UI components (buttons, cards, list items).

This layer depends on **Domain use cases** to perform actions.

---

## 🔄 2. Implementation Workflow

To build a feature (for example, **Pokemon List**), follow these steps:

---

### 🅰️ Step A: Define the Domain

#### 1️⃣ Create the Entity

```dart
class PokemonEntity {
  final int id;
  final String name;
  final String imageUrl;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}
```

#### 2️⃣ Create the Repository Interface

```dart
abstract class PokemonRepository {
  Future<List<PokemonEntity>> getPokemons();
}
```

---

### 🅱️ Step B: Implement the Data Layer

Create a repository implementation that connects to an API and returns domain entities.

```dart
class PokemonRepositoryImpl implements PokemonRepository {
  @override
  Future<List<PokemonEntity>> getPokemons() async {
    // Call API using http or dio
    // Parse JSON
    // Map to PokemonEntity
  }
}
```

---

### 🅲 Step C: Build the UI

#### 🎨 Create a Widget

A reusable widget to display a single Pokémon.

```dart
class PokemonIconWidget extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonIconWidget({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(pokemon.imageUrl),
        Text(pokemon.name),
      ],
    );
  }
}
```

#### 📄 Create a Page

Use a `ListView` to display Pokémon data.

```dart
class PokemonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon List')),
      body: ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          return PokemonIconWidget(pokemon: pokemons[index]);
        },
      ),
    );
  }
}
```

---

## ✅ Benefits of This Architecture

* Clear separation of concerns
* Easy to test business logic
* Scales well for large applications
* UI can change without affecting core logic

---

✨ *This structure keeps CMU Fondue clean, maintainable, and future-proof.*
