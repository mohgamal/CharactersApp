# CharactersApp


### Technologies & Libraries

- **SwiftUI**: Used for the character detail view.
- **UIKit**: Used for the character list view with a `UITableView`.
- **Combine**: Used for binding the `ViewModel` to the SwiftUI views.
- **Coordinator Pattern**: Used for managing navigation.
- **SDWebImageSwiftUI**: Used for asynchronously loading and caching images.

## Installation

1. Clone the repository:

    ```bash
    git clone git@github.com:mohgamal/CharactersApp.git
    cd character-list-app
    ```

2. Open the project in Xcode:

    ```bash
    open CharacterListApp.xcodeproj
    ```

3. Install dependencies if needed (e.g., `SDWebImage`). You can add this through Swift Package Manager.

4. Build and run the project in Xcode.

## Usage

1. Launch the app.
2. The app will display a list of characters fetched from the public API.
3. Tap on any character to navigate to the details page, which displays additional information about the character in a SwiftUI view.

## Coordinator

The app uses a **Coordinator** to handle navigation logic, decoupling it from the view controllers.

- The `CharactersCoordinator` is responsible for:
  - Presenting the `CharacterListViewController` with the list of characters.
  - Navigating to the `CharacterDetailView` when a character is selected from the list.

## ViewModel

The **ViewModel** is responsible for handling the data fetching and processing logic, such as:

- Fetching characters from the API.
- Managing pagination.
- Exposing the data to the views.

## SwiftUI Integration

The **character detail view** is built using **SwiftUI**, while the rest of the app uses UIKit. Navigation between UIKit and SwiftUI is done using `UIHostingController`.

## API

This app uses the [Rick and Morty API](https://rickandmortyapi.com/documentation).

## Future Improvements

- Add error handling for network requests.
- Implement loading states in the UI.
- Add unit tests for ViewModel and Coordinator.
- Extend pagination for more characters.

## Contributing

Feel free to submit a pull request or open an issue if you find a bug or have suggestions for improvements!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
