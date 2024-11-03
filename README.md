# Todo App

This Todo App helps users keep track of all the tasks they need to complete. It provides a simple interface for creating, viewing, updating, and deleting tasks, with both offline and online capabilities depending on the branch.

## Table of Contents
- [Features](#features)
- [Project Structure](#project-structure)
- [Branches](#branches)
- [Installation](#installation)
- [Firebase Setup](#firebase-setup)
- [Usage](#usage)
- [Walkthrough Videos](#walkthrough-videos)
- [License](#license)

## Features
- **Task Management**: Users can add, delete, and mark tasks as completed.
- **Lazy Loading & Pagination**: Handles large sets of data efficiently by loading tasks incrementally.
- **Firebase Integration**: Supports individual user accounts with personalized task lists.
- **Cross-Platform**: Runs on both iOS and Android devices.

## Project Structure
The project follows a provider-based architecture for state management, ensuring clean and scalable code. Here's a quick overview:

```
├── lib
│   ├── Model
│   │   ├── Classes      # Defines the Todo model
│   │   └── Providers    # TodoProvider handles app state
│   ├── Screens          # UI screens such as MainTasksPage and NewTaskPage
│   └── CustomWidgets    # Reusable UI widgets
└── README.md
```

## Branches
### `main`
This is the primary branch containing a simple version of the app for managing a list of todos.

### `api-handling`
In this branch, the app demonstrates handling of paginated data from an API source with lazy loading as the user scrolls, providing an efficient way to manage large sets of tasks.

### `firebase`
In this branch, Firebase is integrated to provide user-specific task lists. Each user can:
- Create and view their own tasks.
- Mark tasks as done or delete them.
  
Firebase handles authentication and data storage, ensuring that each user has access only to their personal data.

## Installation
To run the app locally:

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/todo-app.git
    cd todo-app
    ```
2. Install dependencies:
    ```bash
    flutter pub get
    ```
3. Run the app:
    ```bash
    flutter run
    ```

## Firebase Setup
1. Set up a Firebase project in the [Firebase Console](https://firebase.google.com/).
2. Enable Firestore Database and Authentication (using Email/Password or Google Sign-In).
3. Update the Firestore Security Rules:
    ```plaintext
    service cloud.firestore {
      match /databases/{database}/documents {
        match /Todos/{todoId} {
          allow create, read, update, delete: if request.auth != null && request.auth.uid == resource.data.userId;
        }
        match /Users/{userId} {
          allow create, read, update: if request.auth != null && request.auth.uid == userId;
        }
      }
    }
    ```
4. Download `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) from your Firebase project and place them in the appropriate directories in your Flutter project.

## Usage
Once the app is running:
1. Create a new account or log in (if using Firebase).
2. Add, complete, or delete tasks from your list.
3. Switch branches to explore API-based pagination or Firebase integration.

## Walkthrough Videos

Here's a demonstration of the main features of each branch:

### API Handling Branch
In this branch, you can see how the app fetches tasks incrementally from an API source as you scroll, supporting lazy loading and pagination.

[API Handling Demo]

https://github.com/user-attachments/assets/b5c1e727-06dc-43ae-b8a7-f8ac28a621f5


### Firebase Branch
This walkthrough showcases the Firebase integration, where each user has a personal task list, and all data is securely stored and retrieved from Firebase.

[Firebase Integration Demo]

https://github.com/user-attachments/assets/20e15fb9-a91e-42fe-8dac-88797b02d1d9
