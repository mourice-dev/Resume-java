-- ResumeForge PostgreSQL Schema (3NF Compliant)
-- Database Name: resume_db

-- 1. Users Table
-- Roles: ADMIN, USER, MANAGER
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Resumes Table
-- Status: DRAFT, SUBMITTED, APPROVED
CREATE TABLE IF NOT EXISTS resumes (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(200) NOT NULL,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    summary TEXT,
    linkedin VARCHAR(255),
    website VARCHAR(255),
    template VARCHAR(50) DEFAULT 'modern',
    status VARCHAR(20) DEFAULT 'DRAFT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Education Table
CREATE TABLE IF NOT EXISTS education (
    id SERIAL PRIMARY KEY,
    resume_id INTEGER REFERENCES resumes(id) ON DELETE CASCADE,
    institution VARCHAR(200) NOT NULL,
    degree VARCHAR(100),
    field_of_study VARCHAR(100),
    start_date VARCHAR(50),
    end_date VARCHAR(50),
    gpa VARCHAR(10),
    description TEXT
);

-- 4. Experience Table
CREATE TABLE IF NOT EXISTS experience (
    id SERIAL PRIMARY KEY,
    resume_id INTEGER REFERENCES resumes(id) ON DELETE CASCADE,
    company VARCHAR(200) NOT NULL,
    position VARCHAR(100),
    start_date VARCHAR(50),
    end_date VARCHAR(50),
    description TEXT
);

-- 5. Skills Table
CREATE TABLE IF NOT EXISTS skills (
    id SERIAL PRIMARY KEY,
    resume_id INTEGER REFERENCES resumes(id) ON DELETE CASCADE,
    skill_name VARCHAR(100) NOT NULL,
    proficiency VARCHAR(50) DEFAULT 'Intermediate'
);

-- 6. Projects Table
CREATE TABLE IF NOT EXISTS projects (
    id SERIAL PRIMARY KEY,
    resume_id INTEGER REFERENCES resumes(id) ON DELETE CASCADE,
    project_name VARCHAR(200) NOT NULL,
    description TEXT,
    technologies VARCHAR(255),
    url VARCHAR(255)
);

-- Trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_resumes_updated_at BEFORE UPDATE ON resumes FOR EACH ROW EXECUTE PROCEDURE update_updated_at_column();

-- Sample Data Insertion
-- Password for all: password123 (hashed in typical apps, raw for demo)
INSERT INTO users (full_name, email, password, role) VALUES 
('System Admin', 'admin@resumeforge.com', 'admin123', 'ADMIN'),
('Nshuti Maurice', 'nshutikope@gmail.com', 'maurice123', 'USER'),
('Manager Jeanne', 'jeanne@company.rw', 'manager123', 'MANAGER');

INSERT INTO resumes (user_id, title, full_name, email, phone, address, summary, template, status) VALUES 
(2, 'Senior Software Engineer', 'Nshuti Maurice', 'nshutikope@gmail.com', '+250788123456', 'Kigali, Rwanda', 'Experienced developer specializing in Java and React.', 'modern', 'APPROVED');

INSERT INTO education (resume_id, institution, degree, field_of_study, start_date, end_date, gpa) VALUES 
(1, 'University of Rwanda', 'Bachelor of Science', 'Computer Engineering', '2018', '2022', '3.8');

INSERT INTO experience (resume_id, company, position, start_date, end_date, description) VALUES 
(1, 'Irembo Ltd', 'Software Engineer', '2022', 'Present', 'Working on government digital services.');

INSERT INTO skills (resume_id, skill_name, proficiency) VALUES 
(1, 'Java', 'Expert'),
(1, 'PostgreSQL', 'Advanced'),
(1, 'React', 'Advanced');

INSERT INTO projects (resume_id, project_name, description, technologies, url) VALUES 
(1, 'ResumeForge', 'A high-fidelity resume builder system.', 'Java, React, PostgreSQL', 'https://github.com/nshuti/resumeforge');
