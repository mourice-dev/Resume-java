# System Design Document: ResumeForge

## 1. System Architecture (MVC)
ResumeForge follows the **Model-View-Controller (MVC)** architectural pattern to ensure separation of concerns and maintainability.

```mermaid
graph TD
    User((User/Client)) -->|HTTP Requests| View[JSP Views]
    View -->|Form Submission/Actions| Controller[Servlets]
    Controller -->|Data Logic| DAO[Data Access Objects]
    DAO -->|SQL Queries| DB[(PostgreSQL Database)]
    DB -->|Result Sets| DAO
    DAO -->|Java Objects| Controller
    Controller -->|Model Attributes| View
    View -->|HTML/CSS/JS| User
```

## 2. Use Case Diagram
Visualizes the interactions between actors and system functionalities.

```mermaid
useCaseDiagram
    actor User
    actor Admin
    actor Manager
    
    package ResumeForge {
        usecase "Login" as UC1
        usecase "Manage Resumes" as UC2
        usecase "Search Dashboard" as UC3
        usecase "Export PDF/DOCX" as UC4
        usecase "Manage Users" as UC5
        usecase "Approve Resumes" as UC6
    }
    
    User --> UC1
    User --> UC2
    User --> UC3
    User --> UC4
    
    Manager --> UC1
    Manager --> UC3
    Manager --> UC6
    
    Admin --> UC1
    Admin --> UC5
    Admin --> UC2
```

## 3. Class Diagram
Key models and their relationships.

```mermaid
classDiagram
    class User {
        +int id
        +String fullName
        +String email
        +String role
        +getters/setters()
    }
    class Resume {
        +int id
        +int userId
        +String title
        +String status
        +getters/setters()
    }
    class Education {
        +int id
        +int resumeId
        +String institution
        +getters/setters()
    }
    class Experience {
        +int id
        +int resumeId
        +String company
        +getters/setters()
    }
    
    User "1" -- "0..*" Resume
    Resume "1" -- "0..*" Education
    Resume "1" -- "0..*" Experience
    Resume "1" -- "0..*" Skill
    Resume "1" -- "0..*" Project
```

## 4. Sequence Diagram (Create Resume)
Illustration of the process flow for creating a new resume.

```mermaid
sequenceDiagram
    participant U as User
    participant V as ResumeForm.jsp
    participant C as ResumeFormController
    participant D as ResumeDAO
    participant DB as Database
    
    U->>V: Enters Data (Steps 1-5)
    U->>V: Reviews & Submits (Step 6)
    V->>C: POST /resume-form
    C->>D: saveResume(resume)
    D->>DB: INSERT INTO resumes (...)
    DB-->>D: Generated ID
    D-->>C: Success
    C->>V: Redirect to Dashboard/Preview
```

## 5. Database ER Diagram
Entity-Relationship model for the PostgreSQL schema.

```mermaid
erDiagram
    USERS ||--o{ RESUMES : creates
    RESUMES ||--o{ EDUCATION : contains
    RESUMES ||--o{ EXPERIENCE : contains
    RESUMES ||--o{ SKILLS : contains
    RESUMES ||--o{ PROJECTS : contains
    
    USERS {
        int id PK
        string full_name
        string email UK
        string role
    }
    RESUMES {
        int id PK
        int user_id FK
        string title
        string status
    }
    EDUCATION {
        int id PK
        int resume_id FK
        string institution
    }
```
