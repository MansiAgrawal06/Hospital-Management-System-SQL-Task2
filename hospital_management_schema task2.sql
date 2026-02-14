CREATE DATABASE HospitalDB;
USE HospitalDB;
CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
INSERT INTO Departments (department_name)
VALUES 
('Cardiology'),
('Neurology'),
('Orthopedics');

CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15),
    department_id INT,
    FOREIGN KEY (department_id) 
    REFERENCES Departments(department_id)
    ON DELETE SET NULL
);
INSERT INTO Doctors (name, specialization, phone, department_id)
VALUES
('Dr. Sharma', 'Cardiologist', '9456463210', 1),
('Dr. Mehta', 'Neurologist', '9877643211', 2),
('Dr. Singh', 'Orthopedic', '9865738291', 3);

CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    patient_id VARCHAR(100),
    gender VARCHAR(10),
    date_of_birth DATE,
    phone VARCHAR(15),
    address VARCHAR(200)
);
INSERT INTO Patients (name,  patient_id, gender, date_of_birth, phone, address)
VALUES
('Riya Singh', '1' 'Female', '2000-05-12', '9876500000', 'Aligarh'),
('Sarah Khan', '2', 'Female', '2008-07-22', '9856765661', 'Jaipur'),
('Aman Verma', '3' , 'Male', '1998-03-22', '9876511111', 'Delhi'),
('Yashi Verma', '4' , 'Female', '2003-03-22', '9878761121', 'Mathura'),
('Yash Sharma', '4' , 'Female', '2003-03-22', '9878761121');

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME NOT NULL,
    status VARCHAR(50),
    FOREIGN KEY (patient_id) 
    REFERENCES Patients(patient_id)
    ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) 
    REFERENCES Doctors(doctor_id)
    ON DELETE CASCADE
);
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status)
VALUES
(1, 1, '2026-02-10 10:30:00', 'Completed'),
(2, 2, '2026-02-12 12:00:00', 'Scheduled'),
(3, 3, '2026-03-17 14:00:00', 'Scheduled');

CREATE TABLE Treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE,
    diagnosis VARCHAR(255),
    prescription TEXT,
    treatment_cost DECIMAL(10,2),
    FOREIGN KEY (appointment_id) 
    REFERENCES Appointments(appointment_id)
    ON DELETE CASCADE
);
INSERT INTO Treatments (appointment_id, diagnosis, prescription, treatment_cost)
VALUES
(1, 'Heart Pain', 'Medicine A - 5 days', 2000.00);

CREATE TABLE Bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    total_amount DECIMAL(10,2),
    bill_date DATE,
    payment_status VARCHAR(50),
    FOREIGN KEY (patient_id) 
    REFERENCES Patients(patient_id)
    ON DELETE CASCADE
);
INSERT INTO Bills (patient_id, total_amount, bill_date, payment_status)
VALUES
(1, 2000.00, '2026-02-10', 'Paid');

-- Update single row
UPDATE Patients
SET phone = '9999999999'
WHERE patient_id = 2;


-- Delete specific patient
DELETE FROM Patients
WHERE patient_id = 4;

-- Find patients with NULL phone numbers
SELECT * FROM Patients
WHERE phone IS NULL;

INSERT INTO Bills (patient_id, total_amount, bill_date, payment_status)
SELECT patient_id, 1500.00, CURDATE(), 'Pending'
FROM Patients
WHERE patient_id = 1;

START TRANSACTION;

DELETE FROM Patients WHERE patient_id = 3;

ROLLBACK;



