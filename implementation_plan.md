# Product Requirements Document (PRD) - AI Comedy Club (MVP)

## 1. Executive Summary
A simple Flutter mobile application that interfaces with an AI Agent (built with ADK) to tell jokes based on user input. The goal is to demonstrate the integration between a mobile frontend and an agentic backend.

## 2. Features (MVP)
*   **Joker Agent:** A single AI persona specialized in telling jokes.
*   **Topic Selection:** User can type a topic (e.g., "Programmers", "Traffic", "Cats").
*   **Chat Interface:** Simple message bubble UI to display the user's request and the agent's joke.
*   **Regenerate:** Button to ask for another joke on the same topic.

## 3. Technical Architecture
*   **Frontend:** Flutter (Android/iOS).
*   **Backend Wrapper:** Python (FastAPI) acting as a gateway.
*   **Agent Service:** Google ADK API Server hosting the Agent.
*   **AI Engine:** Gemini via Vertex AI / Google AI Studio.

---

# Development Plan (Quick Win)

## Phase 1: Backend (The Brain)
**Goal:** Create a running API that returns a joke.
1.  **Setup Project:** Initialize Python environment and install dependencies (`google-genai-agent-kit`, `fastapi`, `uvicorn`, `requests`).
2.  **Build Agent:** Create `agent.py` using ADK to define the "Comedian" persona.
3.  **Run Agent Server:** Use `adk api_server` to expose the agent on a local port (e.g., 8080).
4.  **Create Wrapper API:** Create `main.py` (FastAPI) on port 8000 to receive requests from Flutter and forward them to the Agent Server.
5.  **Test:** Verify the flow: `Client -> Wrapper (8000) -> Agent (8080) -> Client`.

## Phase 2: Frontend (The Face)
**Goal:** Create the mobile app interface.
1.  **Setup Flutter:** `flutter create ai_comedy_club`.
2.  **UI Implementation:**
    *   Text Input Field for topic.
    *   "Tell me a joke" button.
    *   Display area for the result.
3.  **API Integration:** Use `http` package to call the Backend API.
4.  **State Management:** Simple `setState` to handle loading states and displaying the joke.

## Phase 3: Polish & Run
1.  **Error Handling:** Handle network errors or API timeouts.
2.  **Run Locally:** Run the backend on localhost and connect the Flutter emulator (using `10.0.2.2` for Android).

---

# Checklist & Git Commit Strategy

## Phase 1: Backend (The Brain)
- [ ] **Setup Project Structure**
  - Initialize git repository
  - Create virtual environment and `requirements.txt`
  - *Commit:* `chore(backend): init project structure and dependencies`
- [ ] **Implement ADK Agent**
  - Create `agent.py` with basic configuration
  - Define system instructions for "Comedian" persona
  - *Commit:* `feat(backend): implement basic comedian agent using ADK`
- [ ] **Create API Endpoint**
  - Setup FastAPI app in `main.py`
  - Create `POST /joke` endpoint connecting to the agent
  - *Commit:* `feat(backend): add POST /joke endpoint`

## Phase 2: Frontend (The Face)
- [ ] **Initialize Flutter App**
  - Create new Flutter project
  - Clean up default boilerplate code
  - *Commit:* `chore(mobile): init flutter project`
- [ ] **Build UI Components**
  - Create input field and submit button
  - Create display area for jokes
  - *Commit:* `feat(mobile): implement chat interface UI`
- [ ] **Integrate API**
  - Implement HTTP service to call backend
  - Connect UI to the service
  - *Commit:* `feat(mobile): integrate joke api with UI`

## Phase 3: Integration & Polish
- [ ] **Final Testing & Fixes**
  - Verify end-to-end flow
  - Handle loading states and errors
  - *Commit:* `fix(app): handle loading states and api errors`

