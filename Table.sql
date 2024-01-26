-- patient table
CREATE TABLE patient (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE CHECK (date_of_birth < CURRENT_DATE),
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(255) UNIQUE,
    med_history TEXT,
    current_treatment TEXT
);


-- staff table
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    speciality TEXT,
    working_hours TEXT
);

-- department table
CREATE TABLE department (
    department_id INT PRIMARY KEY,
    department_name TEXT,
    department_head INT,
    FOREIGN KEY (department_head) REFERENCES staff(staff_id)
);

-- staff_department table
CREATE TABLE staff_department (
    staff_id INT,
    department_id INT,
    is_primary BOOLEAN,
    PRIMARY KEY (staff_id, department_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);


-- appointment table
CREATE TABLE appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT NOT NULL,
    doc_id INT NOT NULL,
    appointment_date DATE CHECK (appointment_date > CURRENT_DATE),
    appointment_time TIME CHECK (appointment_time > CURRENT_TIME),
    visit_purpose TEXT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doc_id) REFERENCES staff(staff_id),
    UNIQUE (doc_id, appointment_date, appointment_time)
);

-- inventory table
CREATE TABLE inventory (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(256),
    quantity INT CHECK (quantity > 0),
    reorder_level INT,
    max_capacity INT,
    CHECK (reorder_level > 0 AND reorder_level < max_capacity)
);

-- doc patient table
CREATE TABLE doc_patient (
    relationship_id INT PRIMARY KEY,
    patient_id INT,
    doc_id INT,
    FOREIGN KEY (doc_id) REFERENCES staff(staff_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);