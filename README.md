# cmu_fondue

1. The Core Layers
Your structure follows a three-layer pattern: Domain, Data, and Application.

🏛️ Domain Layer (The Heart)
This layer is independent of any other layer. It contains the business logic.

Entities: Simple classes representing your core data (e.g., a Pokemon class).

Repositories (Abstract): Interfaces that define what the data layer should do, without saying how it does it.

Usecases: Specific business rules (e.g., GetPokemonList).

Note: In your screenshot, theme_selector_model.dart is inside usecases. Usually, models related to UI state belong in application, while usecases should be command-like classes (e.g., FetchPokemon).

💾 Data Layer (The Infrastructure)
This layer is responsible for fetching data from the internet or a local database.

Repositories Implementation (_impl): This is where you actually write the code to call an API (like using http or dio) and return the data defined by the Domain's interface.

📱 Application Layer (The UI)
This layer is what the user sees and interacts with.

Pages: The full screens of your app.

Widgets: Small, reusable components (buttons, list tiles).

2. Implementation Workflow
To build a feature (like a Pokemon List) using this structure, follow this order:

Step A: Define the Domain
Create the Entity: Write pokemon_entity.dart with basic properties (id, name, imageUrl).

Create the Repository Interface: Define an abstract class in pokemon_repo.dart.

Dart

abstract class PokemonRepository {
  Future<List<PokemonEntity>> getPokemons();
}
Step B: Implement the Data Layer
Create the Implementation: In pokemon_repo_impl.dart, extend the domain repository. This is where you'd use a package like http to fetch JSON and convert it into your entities.

Step C: Build the UI
Create the Widget: Build a PokemonIconWidget to show a single Pokemon.

Create the Page: In pokemon_page.dart, use a ListView (calling your pokemon_list.dart widget) to display the data.