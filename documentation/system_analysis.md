# System Analysis Document: ResumeForge

## 1. Functional Requirements
The system must allow users to:
- **RF1**: Register a new account and login securely.
- **RF2**: Create a resume using a multi-step form (Personal, Education, Experience, Skills, Projects, Review).
- **RF3**: View and search resumes on a dashboard by title, name, date, and time.
- **RF4**: Edit, delete, and duplicate existing resumes.
- **RF5**: Preview resumes in high-fidelity with professional themes.
- **RF6**: Download resumes as PDF and MS Word (DOCX).
- **RF7**: Manage role-based actions (Admin can oversee users; Users manage their own resumes).

## 2. Non-Functional Requirements
- **Performance**: Dashboard should load within 2 seconds for a typical user.
- **Security**: Passwords must be handled via secure fields; sessions must timeout after 30 minutes.
- **Usability**: UI must follow a consistent "Glassmorphism" theme and be responsive.
- **Reliability**: Database must ensure 3NF data integrity.
- **Availability**: Application should be hosted on Apache Tomcat with standard runtime metrics.

## 3. User Roles
The system implements Role-Based Access Control (RBAC):
- **User**: Standard account. Can create, edit, and manage their own resumes.
- **Manager**: Can view resumes across departments and approve/reject status.
- **Admin**: Full system access, including user management and system configuration.

## 4. Use Case Descriptions

### UC1: Create Resume
- **Actor**: User
- **Description**: User navigates through 6 steps to enter their details. In the final step, they review the summary and click "Create" to persist data.
- **Pre-condition**: User must be logged in.
- **Post-condition**: Resume is saved to the database with status 'DRAFT' or 'SUBMITTED'.

### UC2: Search Dashboard
- **Actor**: User, Manager, Admin
- **Description**: Actor uses text input, date picker, or time range to filter the list of resumes.
- **Pre-condition**: User must be on the dashboard page.
- **Post-condition**: Dashboard updates to display matching records.

### UC3: Export Resume
- **Actor**: User
- **Description**: User clicks "Download PDF" or "Download DOCX" on the preview page.
- **Pre-condition**: Resume must exist and be loaded in preview mode.
- **Post-condition**: A file is generated and downloaded to the local machine.
