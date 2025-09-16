## ☕ Ahwa Manager

**Ahwa Manager** is a Flutter-based coffee shop order management system designed to streamline order handling and reporting.  
It is built with a strong focus on clean architecture, leveraging **Object-Oriented Programming (OOP)** and adhering to the **SOLID principles** to ensure scalability, maintainability, and clean code practices.

---

## 🧠 Project Architecture & Code Design

This project was built using **Flutter (Dart)** with a strong focus on **Object-Oriented Programming (OOP)** principles and adherence to the **SOLID design principles** to ensure clean, maintainable, and scalable code.

---

### ⚙️ Object-Oriented Programming (OOP)

The application follows a clear object-oriented structure to model the business domain (orders, drinks, services) and separate responsibilities:

- **Classes & Objects:**  
  Core entities like `Order`, `Drink`, and `OrderService` are implemented as dedicated classes, encapsulating both data and behavior.

- **Encapsulation:**  
  Data is kept private inside classes, and access is provided only through well-defined public methods. This protects the integrity of the data and reduces coupling.

- **Inheritance:**  
  Common functionality is abstracted into base classes and extended by specialized subclasses, reducing duplication and improving reusability.

- **Polymorphism:**  
  Interfaces and abstract classes are used to allow different implementations to be substituted interchangeably without affecting the rest of the system.

---

### 🧩 SOLID Principles

The codebase was designed following the **SOLID principles** to achieve flexibility and maintainability:

- **Single Responsibility Principle (SRP):**  
  Each class has one clearly defined responsibility. For example, data models only hold and validate data, while services handle business logic.

- **Open/Closed Principle (OCP):**  
  The system is open to extension but closed to modification. New features (e.g., new drink types) can be added without altering existing core logic.

- **Liskov Substitution Principle (LSP):**  
  Subclasses can replace their base classes without breaking the application. This ensures that derived classes conform to the expected behavior of their parents.

- **Interface Segregation Principle (ISP):**  
  Interfaces are small and focused, ensuring that classes only implement what they actually need rather than being forced to implement unused methods.

- **Dependency Inversion Principle (DIP):**  
  High-level modules depend on abstractions rather than concrete implementations. This decouples components and makes the system easier to test and extend.

---

### 🧩 Project Structure

- **Models** — Define the core data structures (e.g., `Order`, `Drink`).  
- **Services** — Contain the business logic (e.g., `OrderService` manages all order operations).  
- **Screens & Widgets** — Handle the presentation layer (decoupled from business logic).  

This layered structure supports scalability and future feature additions without breaking existing code.

---

## 🚀 Getting Started

1. Clone this repository  
2. Run `flutter pub get`  
3. Launch the app with `flutter run`

---


## <img width="480" height="1019" alt="image" src="https://github.com/user-attachments/assets/b6770757-b6d5-45aa-a3af-0fab9eff6d1c" />
## <img width="480" height="1019" alt="image" src="https://github.com/user-attachments/assets/b9d8488d-cc8d-4d00-b242-077d0b42efbf" />
## <img width="480" height="1019" alt="image" src="https://github.com/user-attachments/assets/6e4311ee-a568-4519-bda8-a21f405235a7" />




