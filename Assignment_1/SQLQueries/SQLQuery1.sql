CREATE TABLE DimPatient (
    PatientKey INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(100),
    IsCurrent BIT,
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE DimDoctor (
    DoctorKey INT IDENTITY(1,1) PRIMARY KEY,
    DoctorID INT,
    DoctorName VARCHAR(100),
    Specialization VARCHAR(100),
    DoctorContact VARCHAR(15)
);

CREATE TABLE DimProcedure (
    ProcedureKey INT IDENTITY(1,1) PRIMARY KEY,
    ProcedureID INT,
    ProcedureName VARCHAR(100)
);

CREATE TABLE DimDate (
    DateID INT IDENTITY(1,1) PRIMARY KEY,
    FullDate DATE,
    Day INT,
    Month INT,
    Year INT,
    Quarter INT
);

CREATE TABLE FactAppointment (
    FactAppointmentID INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentID INT,
    PatientKey INT FOREIGN KEY REFERENCES DimPatient(PatientKey),
    DoctorKey INT FOREIGN KEY REFERENCES DimDoctor(DoctorKey),
    ProcedureKey INT FOREIGN KEY REFERENCES DimProcedure(ProcedureKey),
    DateID INT FOREIGN KEY REFERENCES DimDate(DateID),
    Amount DECIMAL(10,2),
    accm_txn_create_time DATETIME,
    accm_txn_complete_time DATETIME,
    txn_process_time_hours INT
);

INSERT INTO FactAppointment
(AppointmentID, PatientKey, DoctorKey, ProcedureKey, DateID, Amount, accm_txn_create_time, accm_txn_complete_time, txn_process_time_hours)
VALUES
(1001, 1, 4, 4, 1, 5000.00, '2025-04-27 10:00:00', NULL, NULL),
(1002, 2, 3, 5, 2, 12000.00, '2025-04-28 09:00:00', NULL, NULL),
(1003, 3, 5, 6, 3, 2500.00, '2025-04-29 14:00:00', NULL, NULL);

INSERT INTO DimPatient (PatientID, FirstName, LastName, Email, IsCurrent, StartDate, EndDate)
VALUES
(101, 'John', 'Doe', 'john.doe@example.com', 1, '2025-01-01', NULL),
(102, 'Ayesha', 'Perera', 'ayesha.perera@example.com', 1, '2025-02-01', NULL),
(103, 'Nimal', 'Fernando', 'nimal.fernando@example.com', 1, '2025-03-01', NULL);

INSERT INTO DimDoctor (DoctorID, DoctorName, Specialization, DoctorContact)
VALUES
(201, 'Dr. Sunil Silva', 'Cardiology', '0771234567'),
(202, 'Dr. Kamal Jayasinghe', 'Neurology', '0777654321');

INSERT INTO DimProcedure (ProcedureID, ProcedureName)
VALUES
(301, 'ECG'),
(302, 'MRI Scan'),
(303, 'Blood Test');

INSERT INTO DimDate (FullDate, Day, Month, Year, Quarter)
VALUES
('2025-04-27', 27, 4, 2025, 2),
('2025-04-28', 28, 4, 2025, 2),
('2025-04-29', 29, 4, 2025, 2);

INSERT INTO FactAppointment
(AppointmentID, PatientKey, DoctorKey, ProcedureKey, DateID, Amount, accm_txn_create_time, accm_txn_complete_time, txn_process_time_hours)
VALUES
(1001, 1, 4, 4, 1, 5000.00, '2025-04-27 10:00:00', NULL, NULL),
(1002, 2, 3, 5, 2, 12000.00, '2025-04-28 09:00:00', NULL, NULL),
(1003, 3, 5, 6, 3, 2500.00, '2025-04-29 14:00:00', NULL, NULL);

UPDATE FactAppointment
SET
    accm_txn_complete_time = '2025-04-29 18:00:00',
    txn_process_time_hours = DATEDIFF(HOUR, accm_txn_create_time, '2025-04-29 18:00:00')
WHERE AppointmentID = 1001;

select * from DimPatient
select * from DimDoctor
select * from DimDate
select * from DimProcedure
select * from FactAppointment

select D.Specialization, count(A.appointmentID)
from FactAppointment A
JOIN DimDoctor D on A.DoctorKey = D.DoctorKey
GROUP BY D.Specialization


CREATE TABLE Staging_Patient (
    PatientKey INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(100),
    IsCurrent BIT,
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE Staging_Doctor (
    DoctorKey INT IDENTITY(1,1) PRIMARY KEY,
    DoctorID INT,
    DoctorName VARCHAR(100),
    Specialization VARCHAR(100),
    DoctorContact VARCHAR(15)
);

CREATE TABLE Staging_MedicalProcedure (
    ProcedureKey INT IDENTITY(1,1) PRIMARY KEY,
    ProcedureID INT,
    ProcedureName VARCHAR(100)
);

CREATE TABLE Staging_Billing (
    InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    ProcedureID INT,
    Date DATE,
    BillingAmount DECIMAL(10,2),
	AppointmentCount INT
);

CREATE TABLE Staging_Appointment (
    FactAppointmentID INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentID INT,
    PatientKey INT FOREIGN KEY REFERENCES DimPatient(PatientKey),
    DoctorKey INT FOREIGN KEY REFERENCES DimDoctor(DoctorKey),
    ProcedureKey INT FOREIGN KEY REFERENCES DimProcedure(ProcedureKey),
    DateID INT FOREIGN KEY REFERENCES DimDate(DateID),
    Amount DECIMAL(10,2),
    accm_txn_create_time DATETIME,
    accm_txn_complete_time DATETIME,
    txn_process_time_hours INT
);
