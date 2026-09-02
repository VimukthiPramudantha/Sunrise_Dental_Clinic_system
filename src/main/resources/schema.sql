

CREATE DATABASE IF NOT EXISTS sunrise_dental;
USE sunrise_dental;

CREATE TABLE IF NOT EXISTS users (
    user_id       INT AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name     VARCHAR(100) NOT NULL,
    role          ENUM('ADMIN', 'RECEPTIONIST', 'DENTIST') NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS patients (
    patient_id   INT AUTO_INCREMENT PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    address      TEXT         NOT NULL,
    phone_number VARCHAR(20)  NOT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS appointments (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    appointment_no   VARCHAR(20)  NULL UNIQUE,
    patient_id       INT          NOT NULL,
    dentist_id       INT          NOT NULL,
    treatment_type   VARCHAR(100) NOT NULL,
    appointment_date DATE         NOT NULL,
    time_slot        VARCHAR(50)  NOT NULL,
    status           ENUM('PENDING', 'CONFIRMED', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING',
    created_at       TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_appointment_dentist FOREIGN KEY (dentist_id) REFERENCES users(user_id)       ON DELETE RESTRICT
);


INSERT IGNORE INTO users (username, password_hash, full_name, role)
VALUES ('admin', '$2a$10$7QJ8z1z1z1z1z1z1z1z1zOExampleHashReplaceThisWithReal', 'System Administrator', 'ADMIN');
