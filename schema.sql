CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    organisation_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    preferred_contact ENUM('post', 'email') NOT NULL
);

CREATE TABLE pool_members (
    pool_member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    work_address VARCHAR(255) NOT NULL,
    home_address VARCHAR(255) NOT NULL
);

CREATE TABLE skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL,
    skill_type VARCHAR(100) NOT NULL
);

CREATE TABLE pool_member_skills (
    pool_member_id INT NOT NULL,
    skill_id INT NOT NULL,
    experience_level ENUM('junior', 'mid', 'senior', 'expert') NOT NULL,
    PRIMARY KEY (pool_member_id, skill_id),
    FOREIGN KEY (pool_member_id) REFERENCES pool_members(pool_member_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    budget DECIMAL(10,2) NOT NULL,
    description TEXT NOT NULL,
    phase ENUM('design', 'development', 'testing', 'deployment') NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

CREATE TABLE project_required_skills (
    project_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (project_id, skill_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE project_assignments (
    pool_member_id INT NOT NULL,
    project_id INT NOT NULL,
    PRIMARY KEY (pool_member_id, project_id),
    FOREIGN KEY (pool_member_id) REFERENCES pool_members(pool_member_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);
