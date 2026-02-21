# Final Project Report - ResumeForge

## 1. Abstract
ResumeForge is a comprehensive web-based Resume Builder application designed to help job seekers create professional, high-fidelity resumes with ease. The system features a multi-step intuitive form, advanced search capabilities, resume status tracking, and export options (PDF/DOCX). Built with Java, JSP, and PostgreSQL, the application follows the MVC architecture and incorporates modern UI/UX principles using Tailwind CSS and glassmorphism.

## 2. Introduction
In today's competitive job market, a well-formatted and professional resume is crucial. ResumeForge addresses the need for a tool that simplifies the resume creation process while ensuring high-quality output. The project focuses on data integrity, user-centered design, and robust security through role-based access control (RBAC).

## 3. System Analysis
The system was designed after a thorough analysis of functional and non-functional requirements.
- **Functional Requirements:** User authentication, Create/Read/Update/Delete (CRUD) operations for resumes, multi-section form (Education, Experience, Skills, Projects), advanced filtering, and document export.
- **Non-Functional Requirements:** Security (RBAC), Scalability (3NF Database), Performance (Optimized Queries), and Responsiveness (Tailwind CSS).
- **User Roles:** Admin (Full system access), Manager (Content management), User (Personal resume management).

## 4. System Design
### 4.1 Architecture
The application follows the **Model-View-Controller (MVC)** pattern:
- **Model:** Java POJOs (User, Resume, Education, etc.) representing data structures.
- **View:** Dynamic JSP pages with React-driven interactive components.
- **Controller:** Java Servlets handling business logic and routing.

### 4.2 Database Design
The database is normalized to **Third Normal Form (3NF)** to ensure data integrity and reduce redundancy.
- [schema.sql](file:///c:/Program%20Files/Apache%20Software%20Foundation/Tomcat%2010.1/webapps/Eresume/src/main/resources/schema.sql)

## 5. Implementation
### 5.1 Technology Stack
- **Backend:** Java 17+, JSP, Servlets, JDBC.
- **Frontend:** React (via CDN), Tailwind CSS, Glassmorphism design.
- **Database:** PostgreSQL.
- **Tools:** Maven, Tomcat 10.1, html2pdf.js.

### 5.2 Key Features
- **Multi-step Form:** A 6-step guided process including a final "Review & Submit" phase.
- **RBAC:** Secure login with distinct permissions for Admins and Users.
- **Advanced Search:** Real-time filtering of resumes by text, date, and time.
- **Premium UI:** High-fidelity aesthetics with animated gradients and glassmorphism.

## 6. Testing Evidence
### 6.1 Unit Testing
DAOs (ResumeDAO, UserDAO) were tested for CRUD operations and constraint compliance.
### 6.2 Integration Testing
Controllers were verified for correct session management and database interaction.
### 6.3 UI/UX Testing
The 6-step form was verified to ensure data persistence across steps and successful final submission. Export functionality (PDF) was tested for visual accuracy.

## 7. Deployment Requirements
- Apache Tomcat 10.1.x
- PostgreSQL 14+
- Java JDK 17+
- Proper environment variables for DB connection.

## 8. Conclusion
ResumeForge successfully fulfills all academic and functional requirements. It provides a robust, secure, and visually stunning solution for resume management. Future enhancements could include AI-powered resume enhancement and real-time template switching on the preview page.

---
**Author:** Nshutayezu
**Date:** February 21, 2026
