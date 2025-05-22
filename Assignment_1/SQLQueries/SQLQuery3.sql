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
    DoctorID VARCHAR(50),
    DoctorName VARCHAR(100),
    Specialization VARCHAR(100),
    DoctorContact VARCHAR(50)
);

CREATE TABLE DimProcedure (
    ProcedureKey INT IDENTITY(1,1) PRIMARY KEY,
    ProcedureID VARCHAR(50),
    ProcedureName VARCHAR(100)
);

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,         -- Format: YYYYMMDD
    FullDate DATE NOT NULL,
    Day INT,
    Month INT,
    Year INT,
    Quarter INT,
    DayOfWeek INT,                   -- 1=Sunday, 7=Saturday
    DayName VARCHAR(10),
    MonthName VARCHAR(15),
    IsWeekend BIT
);

DECLARE @StartDate DATE = '2020-01-01';
DECLARE @EndDate DATE = '2030-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO DimDate (
        DateKey, FullDate, Day, Month, Year, Quarter, 
        DayOfWeek, DayName, MonthName, IsWeekend
    )
    VALUES (
        CONVERT(INT, FORMAT(@StartDate, 'yyyyMMdd')),
        @StartDate,
        DAY(@StartDate),
        MONTH(@StartDate),
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        DATEPART(WEEKDAY, @StartDate),
        DATENAME(WEEKDAY, @StartDate),
        DATENAME(MONTH, @StartDate),
        CASE WHEN DATENAME(WEEKDAY, @StartDate) IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END


CREATE TABLE FactAppointment (
    FactAppointmentID INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentID INT,
    PatientKey INT FOREIGN KEY REFERENCES DimPatient(PatientKey),
    DoctorKey INT FOREIGN KEY REFERENCES DimDoctor(DoctorKey),
    ProcedureKey INT FOREIGN KEY REFERENCES DimProcedure(ProcedureKey),
    DateID INT FOREIGN KEY REFERENCES DimDate(DateKey),
    Amount VARCHAR(50),
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

drop table DimProcedure
Select* from DimPatient
Select* from DimDoctor
Select* from DimProcedure
select* from DimDate
select* from FactAppointment

UPDATE FactAppointment
SET accm_txn_complete_time = NULL, txn_process_time_hours = NULL
WHERE FactAppointmentID = 24;
INSERT INTO FactAppointment (ProcedureKey, Amount, DateID, accm_txn_create_time, accm_txn_complete_time, txn_process_time_hours)

(1, 5000.00, '2025-04-27 10:00:00', NULL, NULL, 2),
(2, 12000.00, '2025-04-28 09:00:00', NULL, NULL, 0.5),
(3, 2500.00, '2025-04-29 14:00:00', NULL, NULL, 0.75),
(1, 4500.00, '2025-05-01 11:15:00', NULL, NULL, 1.5),
(2, 3200.00, '2025-05-02 09:30:00', NULL, NULL, 1.5),
(3, 6000.00, '2025-05-03 13:00:00', NULL, NULL, 2),
(1, 5300.00, '2025-05-04 10:30:00', NULL, NULL, 1.5),
(2, 4900.00, '2025-05-05 15:30:00', NULL, NULL, 1),
(3, 7200.00, '2025-05-06 08:45:00', NULL, NULL, 2),
(1, 3800.00, '2025-05-07 09:00:00', NULL, NULL, 1.25),
(2, 8600.00, '2025-05-08 14:15:00', NULL, NULL, 1.75),
(3, 4100.00, '2025-05-09 11:00:00', NULL, NULL, 1.25),
(1, 3000.00, '2025-05-10 13:45:00', NULL, NULL, 1),
(2, 9000.00, '2025-05-11 10:15:00', NULL, NULL, 1.5),
(3, 2300.00, '2025-05-12 16:00:00', NULL, NULL, 0.75),
(1, 7800.00, '2025-05-13 08:30:00', NULL, NULL, 2),
(2, 5600.00, '2025-05-14 12:00:00', NULL, NULL, 1.5),
(3, 6900.00, '2025-05-15 14:30:00', NULL, NULL, 2),
(1, 4700.00, '2025-05-16 09:45:00', NULL, NULL, 1.25),
(2, 8300.00, '2025-05-17 11:30:00', NULL, NULL, 1.75),
(3, 2100.00, '2025-05-18 13:00:00', NULL, NULL, 0.5),
(1, 5200.00, '2025-05-19 10:45:00', NULL, NULL, 1.5),
(2, 3500.00, '2025-05-20 09:15:00', NULL, NULL, 1),
(3, 6100.00, '2025-05-21 15:30:00', NULL, NULL, 2),
(1, 4300.00, '2025-05-22 08:00:00', NULL, NULL, 1),
(2, 7900.00, '2025-05-23 12:30:00', NULL, NULL, 1.5),
(3, 2800.00, '2025-05-24 14:45:00', NULL, NULL, 1),
(1, 6700.00, '2025-05-25 10:00:00', NULL, NULL, 1.75),
(2, 3700.00, '2025-05-26 09:30:00', NULL, NULL, 1.25),
(3, 4900.00, '2025-05-27 11:00:00', NULL, NULL, 1.5),
(1, 7600.00, '2025-05-28 13:15:00', NULL, NULL, 2),
(2, 4200.00, '2025-05-29 08:45:00', NULL, NULL, 1),
(3, 5800.00, '2025-05-30 15:00:00', NULL, NULL, 2),
(1, 3400.00, '2025-05-31 09:15:00', NULL, NULL, 1),
(2, 8200.00, '2025-06-01 11:30:00', NULL, NULL, 1.75),
(3, 3600.00, '2025-06-02 14:00:00', NULL, NULL, 1.25);
