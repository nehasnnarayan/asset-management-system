-- ============================================
-- AssetTrack Pro - PostgreSQL Database Dump
-- ============================================

-- Drop tables if exist (for reusability)
DROP TABLE IF EXISTS asset_maintenance_logs;
DROP TABLE IF EXISTS asset_assignments;
DROP TABLE IF EXISTS assets;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS hr_admins;

-- ============================================
-- 1. Departments Table
-- ============================================

CREATE TABLE departments (
    department_id BIGSERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    department_code VARCHAR(20) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 2. Employees Table
-- ============================================

CREATE TABLE employees (
    employee_id BIGSERIAL PRIMARY KEY,
    employee_code VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    email VARCHAR(150) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    department_id BIGINT,
    designation VARCHAR(100),
    employment_status VARCHAR(50) DEFAULT 'ACTIVE',
    date_of_joining DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 3. HR Admins Table
-- ============================================

CREATE TABLE hr_admins (
    hr_admin_id BIGSERIAL PRIMARY KEY,
    admin_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(50) DEFAULT 'HR_ADMIN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 4. Assets Table
-- ============================================

CREATE TABLE assets (
    asset_id BIGSERIAL PRIMARY KEY,
    asset_code VARCHAR(100) UNIQUE NOT NULL,
    asset_name VARCHAR(150) NOT NULL,
    asset_category VARCHAR(100),
    purchase_date DATE,
    purchase_cost NUMERIC(12,2),
    asset_status VARCHAR(50) DEFAULT 'AVAILABLE',
    asset_condition VARCHAR(50) DEFAULT 'GOOD',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 5. Asset Assignments Table
-- ============================================

CREATE TABLE asset_assignments (
    assignment_id BIGSERIAL PRIMARY KEY,
    asset_id BIGINT NOT NULL,
    employee_id BIGINT NOT NULL,
    assigned_by_hr_id BIGINT,
    assignment_date DATE NOT NULL,
    return_date DATE,
    assignment_status VARCHAR(50) DEFAULT 'ASSIGNED',
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 6. Asset Maintenance Logs
-- ============================================

CREATE TABLE asset_maintenance_logs (
    maintenance_id BIGSERIAL PRIMARY KEY,
    asset_id BIGINT NOT NULL,
    maintenance_type VARCHAR(100),
    maintenance_description TEXT,
    maintenance_cost NUMERIC(12,2),
    maintenance_date DATE,
    performed_by VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- INDEXES FOR PERFORMANCE (Industrial Grade)
-- ============================================

CREATE INDEX idx_employees_department_id ON employees(department_id);
CREATE INDEX idx_asset_assignments_employee_id ON asset_assignments(employee_id);
CREATE INDEX idx_asset_assignments_asset_id ON asset_assignments(asset_id);
CREATE INDEX idx_assets_asset_status ON assets(asset_status);

-- ============================================
-- DUMMY DATA INSERTION
-- ============================================

-- Departments
INSERT INTO departments (department_name, department_code) VALUES
('Human Resources', 'HR'),
('Engineering', 'ENG'),
('Finance', 'FIN'),
('Operations', 'OPS');

-- HR Admin
INSERT INTO hr_admins (admin_name, email, phone_number) VALUES
('Neha HR', 'hr@company.com', '9999999999');

-- Sample Employees
INSERT INTO employees (employee_code, first_name, last_name, email, department_id, designation, date_of_joining)
VALUES
('EMP001', 'Rahul', 'Sharma', 'rahul@company.com', 2, 'Software Engineer', '2022-01-10'),
('EMP002', 'Priya', 'Verma', 'priya@company.com', 3, 'Accountant', '2021-05-15'),
('EMP003', 'Amit', 'Kumar', 'amit@company.com', 4, 'Operations Manager', '2020-08-20');

-- Sample Assets
INSERT INTO assets (asset_code, asset_name, asset_category, purchase_date, purchase_cost)
VALUES
('AST001', 'Dell Laptop', 'Electronics', '2023-01-01', 75000),
('AST002', 'HP Laptop', 'Electronics', '2023-02-10', 70000),
('AST003', 'Office Chair', 'Furniture', '2022-12-15', 8000);

-- Sample Assignment
INSERT INTO asset_assignments (asset_id, employee_id, assigned_by_hr_id, assignment_date)
VALUES
(1, 1, 1, '2024-01-01');

