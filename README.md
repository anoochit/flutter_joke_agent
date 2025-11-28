# Flutter Joke Agent

A **Flutter** application that showcases an AI-powered joke‑telling agent built with the **Agent Development Kit (ADK)**. The app demonstrates how to integrate a large‑language‑model (LLM) agent into a mobile UI, allowing users to request jokes and receive witty responses in real time.

## 📦 Project Structure

```text
flutter_joke_agent/
├─ backend/                  # ADK backend source code
├─ mobile/                   # Mobile app source code
└─ README.md                # 📄 This file
```

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** – [Installation Guide](https://flutter.dev/docs/get-started/install)
- **Dart** – bundled with Flutter
- **Python** – for running ADK backend locally
- An **ADK API key** – obtain from the ADK portal

### Installation

```bash
# Clone the repository
git clone https://github.com/anoochit/flutter_joke_agent.git
cd flutter_joke_agent

# Install Flutter dependencies
flutter pub get
```

### Running the App

```bash
# Launch on an emulator or connected device
flutter run
```

### 🐋 Docker Compose

To run the application using Docker Compose:

1.  **Build and Start Services:**
    Navigate to the project root directory and run:
    ```bash
    docker-compose up --build
    ```
    This command will build the Docker images for both the backend and frontend services (if not already built) and then start the containers.

2.  **Access the Application:**
    *   **Frontend (Flutter Web):** Open your web browser and navigate to `http://localhost`.
    *   **Backend (ADK Agent):** The backend service will be accessible at `http://localhost:8000`. This is primarily for internal communication with the frontend.


The UI will display a simple chat‑like interface. Type a request such as *"Tell me a joke about cats"* and the agent will reply with a freshly generated joke.

## 🛠️ Development

### Updating the Agent Configuration

The LLM agent lives in `backend/joke_agent/agent.dart`. To change the system prompt, model, or other parameters, edit the `LlmAgent` instantiation:

```dart
final agent = LlmAgent(
  name: "joke_bot",
  systemPrompt: "You are a witty joke‑telling assistant...",
  // other ADK options …texts 
);
```

### Running ADK Locally (Optional)

If you prefer a local ADK server for faster iteration:

```bash
# Install ADK CLI (if not already installed)
pip install google-adk

# Start the ADK backend
adk serve --port 8000
```

Update the endpoint in `agent.dart` accordingly.

## 📚 Documentation & Resources

- **ADK Docs** – <https://google.github.io/adk-docs/>
- **Flutter Docs** – <https://flutter.dev/docs>
- **Dart Packages** – <https://pub.dev>

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/awesome-feature`)
3. Commit your changes
4. Open a PR against `main`

## 📄 License

This project is licensed under the **MIT License** – see the `LICENSE` file for details.

*Happy coding and may the jokes be ever in your favor!*
