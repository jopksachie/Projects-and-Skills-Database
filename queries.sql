---------------------------------------------------------
-- INSERTS FOR CLIENTS
---------------------------------------------------------
INSERT INTO clients (organisation_name, first_name, last_name, email, address, preferred_contact)
VALUES 
('TechNova Ltd', 'Sarah', 'Williams', 'sarah.williams@technova.com', '12 Innovation Way, Birmingham', 'email'),
('GreenScape Solutions', 'Mark', 'Turner', 'mark.turner@greenscape.co.uk', '88 Meadow Road, Manchester', 'post'),
('BrightFuture Education', 'Emily', 'Clark', 'emily.clark@brightfuture.org', '5 Learning Lane, London', 'email');

---------------------------------------------------------
-- INSERTS FOR POOL MEMBERS
---------------------------------------------------------
INSERT INTO pool_members (first_name, last_name, email, phone, work_address, home_address)
VALUES
('James', 'Miller', 'james.miller@example.com', '07123456789', 'Tech Park, Birmingham', '22 Oak Street, Birmingham'),
('Laura', 'Smith', 'laura.smith@example.com', '07987654321', 'Innovation Hub, Manchester', '14 Pine Road, Manchester'),
('Daniel', 'Brown', 'daniel.brown@example.com', '07711223344', 'Digital Centre, London', '9 Maple Avenue, London');

---------------------------------------------------------
-- INSERTS FOR SKILLS
---------------------------------------------------------
INSERT INTO skills (skill_name, skill_type)
VALUES
('Java', 'Backend'),
('Python', 'Backend'),
('HTML', 'Frontend'),
('CSS', 'Frontend'),
('JavaScript', 'Frontend'),
('SQL', 'Database'),
('AWS', 'Cloud');

---------------------------------------------------------
-- INSERTS FOR POOL MEMBER SKILLS
---------------------------------------------------------
INSERT INTO pool_member_skills (pool_member_id, skill_id, experience_level)
VALUES
(1, 1, 'senior'),   -- James knows Java
(1, 6, 'mid'),      -- James knows SQL
(2, 3, 'senior'),   -- Laura knows HTML
(2, 4, 'senior'),   -- Laura knows CSS
(2, 5, 'mid'),      -- Laura knows JavaScript
(3, 2, 'expert'),   -- Daniel knows Python
(3, 7, 'mid');      -- Daniel knows AWS

---------------------------------------------------------
-- INSERTS FOR PROJECTS
---------------------------------------------------------
INSERT INTO projects (client_id, title, start_date, end_date, budget, description, phase)
VALUES
(1, 'E-Commerce Platform', '2024-01-10', '2024-06-30', 50000.00, 'Build a full online shopping system', 'development'),
(2, 'Garden Planner App', '2024-02-15', '2024-05-20', 20000.00, 'Mobile app for garden layout planning', 'design'),
(3, 'Learning Portal', '2024-03-01', '2024-09-01', 75000.00, 'Online education and training portal', 'testing');

---------------------------------------------------------
-- INSERTS FOR PROJECT REQUIRED SKILLS
---------------------------------------------------------
INSERT INTO project_required_skills (project_id, skill_id)
VALUES
(1, 1),  -- Java
(1, 6),  -- SQL
(1, 5),  -- JavaScript
(2, 3),  -- HTML
(2, 4),  -- CSS
(3, 2),  -- Python
(3, 7);  -- AWS

---------------------------------------------------------
-- INSERTS FOR PROJECT ASSIGNMENTS
---------------------------------------------------------
INSERT INTO project_assignments (pool_member_id, project_id)
VALUES
(1, 1),  -- James on E-Commerce Platform
(2, 2),  -- Laura on Garden Planner App
(3, 3);  -- Daniel on Learning Portal

---------------------------------------------------------
-- REQUIRED QUERY: Pool members who match ALL required 
-- skills for project 1
---------------------------------------------------------
SELECT 
    pm.pool_member_id, 
    pm.first_name, 
    pm.last_name
FROM pool_members pm
JOIN pool_member_skills pms 
    ON pm.pool_member_id = pms.pool_member_id
WHERE pms.skill_id IN (
    SELECT skill_id 
    FROM project_required_skills 
    WHERE project_id = 1
)
GROUP BY pm.pool_member_id
HAVING COUNT(DISTINCT pms.skill_id) = (
    SELECT COUNT(*) 
    FROM project_required_skills 
    WHERE project_id = 1
);

---------------------------------------------------------
-- REPORT QUERY 1: List all pool members with their skills
---------------------------------------------------------
SELECT 
    pm.first_name, 
    pm.last_name, 
    s.skill_name, 
    pms.experience_level
FROM pool_members pm
JOIN pool_member_skills pms 
    ON pm.pool_member_id = pms.pool_member_id
JOIN skills s 
    ON pms.skill_id = s.skill_id
ORDER BY 
    pm.last_name, 
    s.skill_name;

---------------------------------------------------------
-- REPORT QUERY 2: Count projects per client
---------------------------------------------------------
SELECT 
    c.organisation_name, 
    COUNT(p.project_id) AS total_projects
FROM clients c
LEFT JOIN projects p 
    ON c.client_id = p.client_id
GROUP BY c.client_id
ORDER BY total_projects DESC;
