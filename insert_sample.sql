-- =============================================
-- Resume Builder System — Sample Data (PostgreSQL)
-- Rwanda-based Professional Profiles
-- Run AFTER db_setup.sql:
--   psql -U postgres -d resume_db -f insert_sample.sql
-- =============================================

-- =============================================
-- Create sample users and insert all data
-- =============================================

-- User 1: Jean Claude Mugabo
WITH user1 AS (
    INSERT INTO users (full_name, email, password) VALUES
    ('Jean Claude Mugabo', 'jcmugabo@gmail.com', 'password123')
    RETURNING id
),
-- Resume 1: Software Engineer
resume1 AS (
    INSERT INTO resumes (user_id, title, full_name, email, phone, address, summary, linkedin, website, template)
    SELECT id, 'Full Stack Software Engineer', 'Jean Claude Mugabo', 'jcmugabo@gmail.com', '+250 788 123 456', 'Kigali, Gasabo District, Rwanda',
    'Passionate Full Stack Developer with 4+ years of experience building scalable web applications for fintech and e-government platforms. Skilled in Java, Spring Boot, React, and cloud deployment. Active contributor to Kigali''s tech community and a mentor at kLab.',
    'linkedin.com/in/jcmugabo', 'jcmugabo.dev', 'modern'
    FROM user1
    RETURNING id
),
-- Education for Resume 1
edu1 AS (
    INSERT INTO education (resume_id, institution, degree, field_of_study, start_date, end_date, gpa, description)
    SELECT id, 'University of Rwanda - College of Science and Technology', 'Bachelor of Science', 'Computer Science', '2016', '2020', '3.7',
    'Graduated with First Class Honours. Led the university coding club and participated in national hackathons.'
    FROM resume1
),
edu1b AS (
    INSERT INTO education (resume_id, institution, degree, field_of_study, start_date, end_date, gpa, description)
    SELECT id, 'African Leadership University', 'Certificate', 'Entrepreneurial Leadership', '2020', '2021', '',
    'Completed an intensive leadership program focused on building tech ventures in Africa.'
    FROM resume1
),
-- Experience for Resume 1
exp1a AS (
    INSERT INTO experience (resume_id, company, position, start_date, end_date, current_job, description)
    SELECT id, 'Irembo Ltd', 'Senior Software Developer', '2022', 'Present', TRUE,
    'Building and maintaining Rwanda''s e-government platform serving 5M+ citizens. Developed microservices for online permit applications, civil registration, and payment processing. Reduced API response time by 35%.'
    FROM resume1
),
exp1b AS (
    INSERT INTO experience (resume_id, company, position, start_date, end_date, current_job, description)
    SELECT id, 'Andela Rwanda', 'Software Engineer', '2020', '2022', FALSE,
    'Worked with global clients to build scalable SaaS applications. Collaborated in agile teams across 3 time zones. Specialized in backend Java services and REST API design.'
    FROM resume1
),
exp1c AS (
    INSERT INTO experience (resume_id, company, position, start_date, end_date, current_job, description)
    SELECT id, 'kLab Rwanda', 'Junior Developer & Community Mentor', '2019', '2020', FALSE,
    'Developed internal tools for the innovation hub. Mentored 15+ aspiring developers through coding bootcamps and workshops.'
    FROM resume1
),
-- Skills for Resume 1
skills1 AS (
    INSERT INTO skills (resume_id, skill_name, proficiency)
    SELECT id, unnest(ARRAY['Java','Spring Boot','React','MySQL','Docker','AWS','Git & CI/CD','Kinyarwanda','English','French']),
           unnest(ARRAY['Expert','Expert','Advanced','Advanced','Intermediate','Intermediate','Advanced','Expert','Advanced','Intermediate'])
    FROM resume1
),
-- Projects for Resume 1
proj1 AS (
    INSERT INTO projects (resume_id, project_name, description, technologies, url)
    SELECT id, 'Irembo Gov Services Portal',
    'Led development of the citizen-facing portal enabling Rwandans to apply for government services online — including birth certificates, driving permits, and business registration.',
    'Java, Spring Boot, React, PostgreSQL, Docker', 'https://irembo.gov.rw'
    FROM resume1
),
proj1b AS (
    INSERT INTO projects (resume_id, project_name, description, technologies, url)
    SELECT id, 'MoMo Pay Integration Library',
    'Built an open-source Java SDK for integrating MTN Mobile Money payments into web and mobile applications.',
    'Java, REST API, MTN MoMo API', 'https://github.com/jcmugabo/momo-java-sdk'
    FROM resume1
),
proj1c AS (
    INSERT INTO projects (resume_id, project_name, description, technologies, url)
    SELECT id, 'Kigali Smart Parking',
    'Developed a real-time parking management system for Kigali City, allowing drivers to find and reserve parking spots via a mobile-friendly web app.',
    'React, Node.js, Google Maps API, Firebase', 'https://github.com/jcmugabo/smart-parking'
    FROM resume1
)
SELECT 1;

-- =============================================
-- Resume 2: Jean Claude — Data Analyst
-- =============================================
WITH user1_id AS (
    SELECT id FROM users WHERE email = 'jcmugabo@gmail.com'
),
resume2 AS (
    INSERT INTO resumes (user_id, title, full_name, email, phone, address, summary, linkedin, website, template)
    SELECT id, 'Data Analyst & Business Intelligence', 'Jean Claude Mugabo', 'jcmugabo@gmail.com', '+250 788 123 456', 'Kigali, Nyarugenge District, Rwanda',
    'Data-driven analyst with expertise in transforming raw data into actionable business insights. Experienced with Python, SQL, Power BI, and Tableau. Passionate about using data to drive development outcomes in East Africa.',
    'linkedin.com/in/jcmugabo', 'jcmugabo.dev', 'classic'
    FROM user1_id
    RETURNING id
),
edu2 AS (
    INSERT INTO education (resume_id, institution, degree, field_of_study, start_date, end_date, gpa, description)
    SELECT id, 'University of Rwanda - College of Science and Technology', 'Bachelor of Science', 'Applied Statistics', '2016', '2020', '3.5',
    'Specialized in data modeling and statistical inference. Thesis on mobile money transaction pattern analysis.'
    FROM resume2
),
exp2a AS (
    INSERT INTO experience (resume_id, company, position, start_date, end_date, current_job, description)
    SELECT id, 'Bank of Kigali', 'Data Analyst', '2021', 'Present', TRUE,
    'Analyze customer transaction data to detect fraud patterns and improve credit scoring models. Built automated reporting dashboards that reduced manual reporting by 60%.'
    FROM resume2
),
exp2b AS (
    INSERT INTO experience (resume_id, company, position, start_date, end_date, current_job, description)
    SELECT id, 'NISR (National Institute of Statistics of Rwanda)', 'Statistical Intern', '2020', '2021', FALSE,
    'Assisted in processing national census data. Created data visualizations for public health and economic indicators.'
    FROM resume2
),
skills2 AS (
    INSERT INTO skills (resume_id, skill_name, proficiency)
    SELECT id, unnest(ARRAY['Python','SQL','Power BI','Tableau','Excel','R']),
           unnest(ARRAY['Advanced','Expert','Advanced','Intermediate','Expert','Intermediate'])
    FROM resume2
),
proj2a AS (
    INSERT INTO projects (resume_id, project_name, description, technologies, url)
    SELECT id, 'Mobile Money Fraud Detection',
    'Developed a machine learning model to detect anomalous MTN MoMo transactions, achieving 92% accuracy on test data.',
    'Python, Scikit-learn, Pandas, MySQL', ''
    FROM resume2
),
proj2b AS (
    INSERT INTO projects (resume_id, project_name, description, technologies, url)
    SELECT id, 'Rwanda Economic Dashboard',
    'Interactive dashboard showing key economic indicators (GDP, inflation, trade balance) from NISR open data.',
    'Power BI, Python, REST API', ''
    FROM resume2
)
SELECT 1;

-- =============================================
-- User 2: Marie Claire Uwimana
-- =============================================
WITH user2 AS (
    INSERT INTO users (full_name, email, password) VALUES
    ('Marie Claire Uwimana', 'mcuwimana@gmail.com', 'password123')
    RETURNING id
),
resume3 AS (
    INSERT INTO resumes (user_id, title, full_name, email, phone, address, summary, linkedin, website, template)
    SELECT id, 'Project Manager — ICT & Development', 'Marie Claire Uwimana', 'mcuwimana@gmail.com', '+250 722 987 654', 'Kigali, Kicukiro District, Rwanda',
    'Certified PMP with 6+ years of experience managing ICT and international development projects across Rwanda and the East African Community. Expert in agile methodologies, stakeholder engagement, and digital transformation initiatives.',
    'linkedin.com/in/mcuwimana', '', 'modern'
    FROM user2
    RETURNING id
),
edu3a AS (
    INSERT INTO education (resume_id, institution, degree, field_of_study, start_date, end_date, gpa, description)
    SELECT id, 'Carnegie Mellon University Africa', 'Master of Science', 'Information Technology', '2018', '2020', '3.9',
    'Focused on IT project management and digital innovation for African markets. Capstone project on Smart City infrastructure for Kigali.'
    FROM resume3
),
edu3b AS (
    INSERT INTO education (resume_id, institution, degree, field_of_study, start_date, end_date, gpa, description)
    SELECT id, 'University of Rwanda - College of Business and Economics', 'Bachelor of Business Administration', 'Management', '2013', '2017', '3.6',
    'Graduated top 5% of class. President of the Women in Business student society.'
    FROM resume3
),
exp3a AS (
    INSERT INTO experience (resume_id, company, position, start_date, end_date, current_job, description)
    SELECT id, 'Rwanda Information Society Authority (RISA)', 'Senior Project Manager', '2022', 'Present', TRUE,
    'Managing Rwanda''s Smart Kigali initiative — coordinating IoT infrastructure deployment, digital literacy programs, and open data portals. Budget oversight of $3.2M across 4 project streams.'
    FROM resume3
),
exp3b AS (
    INSERT INTO experience (resume_id, company, position, start_date, end_date, current_job, description)
    SELECT id, 'UNDP Rwanda', 'ICT4D Project Coordinator', '2020', '2022', FALSE,
    'Coordinated digital inclusion programs reaching 50,000+ rural Rwandans. Managed partnerships with MTN, Airtel, and local NGOs for community technology centres.'
    FROM resume3
),
exp3c AS (
    INSERT INTO experience (resume_id, company, position, start_date, end_date, current_job, description)
    SELECT id, 'BK TecHouse', 'Business Analyst', '2017', '2018', FALSE,
    'Conducted requirements analysis for fintech products. Facilitated workshops between technical teams and business stakeholders.'
    FROM resume3
),
skills3 AS (
    INSERT INTO skills (resume_id, skill_name, proficiency)
    SELECT id, unnest(ARRAY['Project Management (PMP)','Agile / Scrum','Stakeholder Management','JIRA & Confluence','Microsoft Project','Data Analysis','Kinyarwanda','English','French','Swahili']),
           unnest(ARRAY['Expert','Expert','Expert','Advanced','Advanced','Intermediate','Expert','Expert','Advanced','Intermediate'])
    FROM resume3
),
proj3a AS (
    INSERT INTO projects (resume_id, project_name, description, technologies, url)
    SELECT id, 'Smart Kigali Initiative',
    'Led the rollout of IoT sensors for traffic management and waste collection across Kigali. Reduced average commute time by 20% through data-driven traffic light optimization.',
    'IoT, Azure, Power BI, GIS', 'https://smartkigali.rw'
    FROM resume3
),
proj3b AS (
    INSERT INTO projects (resume_id, project_name, description, technologies, url)
    SELECT id, 'Digital Literacy for Rural Rwanda',
    'Trained 50,000+ citizens in basic digital skills through community centres. Established 120 public WiFi hotspots in partnership with telecom providers.',
    'LMS, Mobile Training Apps', ''
    FROM resume3
),
proj3c AS (
    INSERT INTO projects (resume_id, project_name, description, technologies, url)
    SELECT id, 'EAC Trade Portal',
    'Managed the development of an online trade facilitation portal for the East African Community, streamlining cross-border customs processes.',
    'Java, Angular, PostgreSQL, AWS', 'https://trade.eac.int'
    FROM resume3
)
SELECT 1;

-- =============================================
-- Sample data loaded successfully!
-- Users: jcmugabo@gmail.com / password123
--        mcuwimana@gmail.com / password123
-- =============================================
