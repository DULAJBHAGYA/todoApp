📝 **To-Do List App**

This is a simple To-Do List application built with **Flutter** for the front end, **Go** for the backend, and **PostgreSQL** for the database. The app allows users to register ✍️, log in 🔑, add tasks ➕, delete tasks ❌, update tasks 🔄, and view all the tasks they've entered 📋.

**Features**
User Registration/Login: Users can register an account and log in securely.
JWT Generation and Verification: JSON Web Tokens (JWT) are used for authentication. JWTs are generated upon successful login and verified for accessing protected routes.
Task Management: Users can perform CRUD operations on tasks, including adding, deleting, updating, and viewing tasks.
Secure Communication: Communication between the Flutter frontend and the Go backend is encrypted for security.
Error Handling: The app features robust error-handling mechanisms to provide users with meaningful feedback in case of failures.

#**Technologies Used**
**Flutter**: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
**Go**: A statically typed, compiled programming language designed for simplicity and efficiency.
**PostgreSQL**: An open-source relational database management system known for its reliability and robustness.
**JWT-Go**: A Go implementation of JSON Web Tokens.
**Dio**: A powerful Dart HTTP client for Flutter, which simplifies communication with the Go backend.

#**Getting Started**
Clone the Repository: git clone <repository-url>

Set Up the Backend:
Navigate to the backend directory.
Install dependencies: go mod tidy.
Start the server: go run main.go.

Set Up the Frontend:
Navigate to the frontend directory.
Install dependencies: flutter pub get.

Run the app: flutter run.

Access the App: Open the app on your device or simulator and start managing your to-do list!
