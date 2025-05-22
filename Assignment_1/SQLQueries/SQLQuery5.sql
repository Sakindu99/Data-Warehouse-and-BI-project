CREATE TABLE Stg_Patient (
    PatientID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE Stg_MedicalProcedure (
    ProcedureID VARCHAR(50),
    ProcedureName VARCHAR(100),
    AppointmentID VARCHAR(50)
);

CREATE TABLE Stg_Doctor (
    DoctorID VARCHAR(50),
    DoctorName VARCHAR(100),
    Specialization VARCHAR(100),
    DoctorContact VARCHAR(50)
);

CREATE TABLE Stg_Billing (
    InvoiceID VARCHAR(50),
    PatientID INT,
    Items VARCHAR(100),
    Amount VARCHAR(50)
);

CREATE TABLE Stg_Appointment (
    AppointmentID VARCHAR(50),
    Date DATE,
    Time VARCHAR(50),
    PatientID INT,
    DoctorID VARCHAR(50)
);

select * from Stg_Billing
select * from Stg_MedicalProcedure
select * from Stg_Appointment
select * from Stg_Doctor
select * from Stg_Patient