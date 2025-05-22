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

DROP TABLE FactAppointment
Select* from DimPatient
Select* from DimDoctor
Select* from DimProcedure
select* from DimDate
select* from FactAppointment

UPDATE FactAppointment
SET ProcedureKey = 1 , Amount = 5000.00 , DateID = 20200126, accm_txn_create_time ='2025-04-27 10:00:00'
WHERE FactAppointmentID = 1;

UPDATE FactAppointment SET ProcedureKey = 1, Amount = 5000.00, DateID = 20200101, accm_txn_create_time = '2025-04-27 10:00:00' WHERE FactAppointmentID = 1;
UPDATE FactAppointment SET ProcedureKey = 2, Amount = 5000.00, DateID = 20200102, accm_txn_create_time = '2025-04-27 11:00:00' WHERE FactAppointmentID = 2;
UPDATE FactAppointment SET ProcedureKey = 3, Amount = 5000.00, DateID = 20200103, accm_txn_create_time = '2025-04-27 12:00:00' WHERE FactAppointmentID = 3;
UPDATE FactAppointment SET ProcedureKey = 4, Amount = 5000.00, DateID = 20200104, accm_txn_create_time = '2025-04-27 13:00:00' WHERE FactAppointmentID = 4;
UPDATE FactAppointment SET ProcedureKey = 5, Amount = 5000.00, DateID = 20200105, accm_txn_create_time = '2025-04-27 14:00:00' WHERE FactAppointmentID = 5;
UPDATE FactAppointment SET ProcedureKey = 6, Amount = 5000.00, DateID = 20200106, accm_txn_create_time = '2025-04-27 15:00:00' WHERE FactAppointmentID = 6;
UPDATE FactAppointment SET ProcedureKey = 7, Amount = 5000.00, DateID = 20200107, accm_txn_create_time = '2025-04-27 16:00:00' WHERE FactAppointmentID = 7;
UPDATE FactAppointment SET ProcedureKey = 8, Amount = 5000.00, DateID = 20200108, accm_txn_create_time = '2025-04-27 17:00:00' WHERE FactAppointmentID = 8;
UPDATE FactAppointment SET ProcedureKey = 9, Amount = 5000.00, DateID = 20200109, accm_txn_create_time = '2025-04-27 18:00:00' WHERE FactAppointmentID = 9;
UPDATE FactAppointment SET ProcedureKey = 10, Amount = 5000.00, DateID = 20200110, accm_txn_create_time = '2025-04-27 19:00:00' WHERE FactAppointmentID = 10;
UPDATE FactAppointment SET ProcedureKey = 11, Amount = 5000.00, DateID = 20200111, accm_txn_create_time = '2025-04-27 20:00:00' WHERE FactAppointmentID = 11;
UPDATE FactAppointment SET ProcedureKey = 12, Amount = 5000.00, DateID = 20200112, accm_txn_create_time = '2025-04-27 21:00:00' WHERE FactAppointmentID = 12;
UPDATE FactAppointment SET ProcedureKey = 13, Amount = 5000.00, DateID = 20200113, accm_txn_create_time = '2025-04-27 22:00:00' WHERE FactAppointmentID = 13;
UPDATE FactAppointment SET ProcedureKey = 14, Amount = 5000.00, DateID = 20200114, accm_txn_create_time = '2025-04-27 23:00:00' WHERE FactAppointmentID = 14;
UPDATE FactAppointment SET ProcedureKey = 15, Amount = 5000.00, DateID = 20200115, accm_txn_create_time = '2025-04-28 00:00:00' WHERE FactAppointmentID = 15;
UPDATE FactAppointment SET ProcedureKey = 16, Amount = 5000.00, DateID = 20200116, accm_txn_create_time = '2025-04-28 01:00:00' WHERE FactAppointmentID = 16;
UPDATE FactAppointment SET ProcedureKey = 17, Amount = 5000.00, DateID = 20200117, accm_txn_create_time = '2025-04-28 02:00:00' WHERE FactAppointmentID = 17;
UPDATE FactAppointment SET ProcedureKey = 18, Amount = 5000.00, DateID = 20200118, accm_txn_create_time = '2025-04-28 03:00:00' WHERE FactAppointmentID = 18;
UPDATE FactAppointment SET ProcedureKey = 19, Amount = 5000.00, DateID = 20200119, accm_txn_create_time = '2025-04-28 04:00:00' WHERE FactAppointmentID = 19;
UPDATE FactAppointment SET ProcedureKey = 20, Amount = 5000.00, DateID = 20200120, accm_txn_create_time = '2025-04-28 05:00:00' WHERE FactAppointmentID = 20;
UPDATE FactAppointment SET ProcedureKey = 21, Amount = 5000.00, DateID = 20200121, accm_txn_create_time = '2025-04-28 06:00:00' WHERE FactAppointmentID = 21;
UPDATE FactAppointment SET ProcedureKey = 22, Amount = 5000.00, DateID = 20200122, accm_txn_create_time = '2025-04-28 07:00:00' WHERE FactAppointmentID = 22;
UPDATE FactAppointment SET ProcedureKey = 23, Amount = 5000.00, DateID = 20200123, accm_txn_create_time = '2025-04-28 08:00:00' WHERE FactAppointmentID = 23;
UPDATE FactAppointment SET ProcedureKey = 24, Amount = 5000.00, DateID = 20200124, accm_txn_create_time = '2025-04-28 09:00:00' WHERE FactAppointmentID = 24;
UPDATE FactAppointment SET ProcedureKey = 25, Amount = 5000.00, DateID = 20200125, accm_txn_create_time = '2025-04-28 10:00:00' WHERE FactAppointmentID = 25;
UPDATE FactAppointment SET ProcedureKey = 26, Amount = 5000.00, DateID = 20200126, accm_txn_create_time = '2025-04-28 11:00:00' WHERE FactAppointmentID = 26;
UPDATE FactAppointment SET ProcedureKey = 27, Amount = 5000.00, DateID = 20200127, accm_txn_create_time = '2025-04-28 12:00:00' WHERE FactAppointmentID = 27;
UPDATE FactAppointment SET ProcedureKey = 28, Amount = 5000.00, DateID = 20200128, accm_txn_create_time = '2025-04-28 13:00:00' WHERE FactAppointmentID = 28;
UPDATE FactAppointment SET ProcedureKey = 29, Amount = 5000.00, DateID = 20200129, accm_txn_create_time = '2025-04-28 14:00:00' WHERE FactAppointmentID = 29;
UPDATE FactAppointment SET ProcedureKey = 30, Amount = 5000.00, DateID = 20200130, accm_txn_create_time = '2025-04-28 15:00:00' WHERE FactAppointmentID = 30;
UPDATE FactAppointment SET ProcedureKey = 31, Amount = 5000.00, DateID = 20200131, accm_txn_create_time = '2025-04-28 16:00:00' WHERE FactAppointmentID = 31;
UPDATE FactAppointment SET ProcedureKey = 32, Amount = 5000.00, DateID = 20200201, accm_txn_create_time = '2025-04-28 17:00:00' WHERE FactAppointmentID = 32;
UPDATE FactAppointment SET ProcedureKey = 33, Amount = 5000.00, DateID = 20200202, accm_txn_create_time = '2025-04-28 18:00:00' WHERE FactAppointmentID = 33;
UPDATE FactAppointment SET ProcedureKey = 34, Amount = 5000.00, DateID = 20200203, accm_txn_create_time = '2025-04-28 19:00:00' WHERE FactAppointmentID = 34;
UPDATE FactAppointment SET ProcedureKey = 35, Amount = 5000.00, DateID = 20200204, accm_txn_create_time = '2025-04-28 20:00:00' WHERE FactAppointmentID = 35;
UPDATE FactAppointment SET ProcedureKey = 36, Amount = 5000.00, DateID = 20200205, accm_txn_create_time = '2025-04-28 21:00:00' WHERE FactAppointmentID = 36;
UPDATE FactAppointment SET ProcedureKey = 37, Amount = 5000.00, DateID = 20200206, accm_txn_create_time = '2025-04-28 22:00:00' WHERE FactAppointmentID = 37;
UPDATE FactAppointment SET ProcedureKey = 38, Amount = 5000.00, DateID = 20200207, accm_txn_create_time = '2025-04-28 23:00:00' WHERE FactAppointmentID = 38;
UPDATE FactAppointment SET ProcedureKey = 39, Amount = 5000.00, DateID = 20200208, accm_txn_create_time = '2025-04-29 00:00:00' WHERE FactAppointmentID = 39;
UPDATE FactAppointment SET ProcedureKey = 40, Amount = 5000.00, DateID = 20200209, accm_txn_create_time = '2025-04-29 01:00:00' WHERE FactAppointmentID = 40;
-- Continues up to 68...
UPDATE FactAppointment SET ProcedureKey = 41, Amount = 5000.00, DateID = 20200210, accm_txn_create_time = '2025-04-29 02:00:00' WHERE FactAppointmentID = 41;
UPDATE FactAppointment SET ProcedureKey = 42, Amount = 5000.00, DateID = 20200211, accm_txn_create_time = '2025-04-29 03:00:00' WHERE FactAppointmentID = 42;
UPDATE FactAppointment SET ProcedureKey = 43, Amount = 5000.00, DateID = 20200212, accm_txn_create_time = '2025-04-29 04:00:00' WHERE FactAppointmentID = 43;
UPDATE FactAppointment SET ProcedureKey = 44, Amount = 5000.00, DateID = 20200213, accm_txn_create_time = '2025-04-29 05:00:00' WHERE FactAppointmentID = 44;
UPDATE FactAppointment SET ProcedureKey = 45, Amount = 5000.00, DateID = 20200214, accm_txn_create_time = '2025-04-29 06:00:00' WHERE FactAppointmentID = 45;
UPDATE FactAppointment SET ProcedureKey = 46, Amount = 5000.00, DateID = 20200215, accm_txn_create_time = '2025-04-29 07:00:00' WHERE FactAppointmentID = 46;
UPDATE FactAppointment SET ProcedureKey = 47, Amount = 5000.00, DateID = 20200216, accm_txn_create_time = '2025-04-29 08:00:00' WHERE FactAppointmentID = 47;
UPDATE FactAppointment SET ProcedureKey = 48, Amount = 5000.00, DateID = 20200217, accm_txn_create_time = '2025-04-29 09:00:00' WHERE FactAppointmentID = 48;
UPDATE FactAppointment SET ProcedureKey = 49, Amount = 5000.00, DateID = 20200218, accm_txn_create_time = '2025-04-29 10:00:00' WHERE FactAppointmentID = 49;
UPDATE FactAppointment SET ProcedureKey = 50, Amount = 5000.00, DateID = 20200219, accm_txn_create_time = '2025-04-29 11:00:00' WHERE FactAppointmentID = 50;
UPDATE FactAppointment SET ProcedureKey = 51, Amount = 5000.00, DateID = 20200220, accm_txn_create_time = '2025-04-29 12:00:00' WHERE FactAppointmentID = 51;
UPDATE FactAppointment SET ProcedureKey = 52, Amount = 5000.00, DateID = 20200221, accm_txn_create_time = '2025-04-29 13:00:00' WHERE FactAppointmentID = 52;
UPDATE FactAppointment SET ProcedureKey = 53, Amount = 5000.00, DateID = 20200222, accm_txn_create_time = '2025-04-29 14:00:00' WHERE FactAppointmentID = 53;
UPDATE FactAppointment SET ProcedureKey = 54, Amount = 5000.00, DateID = 20200223, accm_txn_create_time = '2025-04-29 15:00:00' WHERE FactAppointmentID = 54;
UPDATE FactAppointment SET ProcedureKey = 55, Amount = 5000.00, DateID = 20200224, accm_txn_create_time = '2025-04-29 16:00:00' WHERE FactAppointmentID = 55;
UPDATE FactAppointment SET ProcedureKey = 56, Amount = 5000.00, DateID = 20200225, accm_txn_create_time = '2025-04-29 17:00:00' WHERE FactAppointmentID = 56;
UPDATE FactAppointment SET ProcedureKey = 57, Amount = 5000.00, DateID = 20200226, accm_txn_create_time = '2025-04-29 18:00:00' WHERE FactAppointmentID = 57;
UPDATE FactAppointment SET ProcedureKey = 58, Amount = 5000.00, DateID = 20200227, accm_txn_create_time = '2025-04-29 19:00:00' WHERE FactAppointmentID = 58;
UPDATE FactAppointment SET ProcedureKey = 59, Amount = 5000.00, DateID = 20200228, accm_txn_create_time = '2025-04-29 20:00:00' WHERE FactAppointmentID = 59;
UPDATE FactAppointment SET ProcedureKey = 60, Amount = 5000.00, DateID = 20200229, accm_txn_create_time = '2025-04-29 21:00:00' WHERE FactAppointmentID = 60;
UPDATE FactAppointment SET ProcedureKey = 61, Amount = 5000.00, DateID = 20200301, accm_txn_create_time = '2025-04-29 22:00:00' WHERE FactAppointmentID = 61;
UPDATE FactAppointment SET ProcedureKey = 62, Amount = 5000.00, DateID = 20200302, accm_txn_create_time = '2025-04-29 23:00:00' WHERE FactAppointmentID = 62;
UPDATE FactAppointment SET ProcedureKey = 63, Amount = 5000.00, DateID = 20200303, accm_txn_create_time = '2025-04-30 00:00:00' WHERE FactAppointmentID = 63;
UPDATE FactAppointment SET ProcedureKey = 64, Amount = 5000.00, DateID = 20200304, accm_txn_create_time = '2025-04-30 01:00:00' WHERE FactAppointmentID = 64;
UPDATE FactAppointment SET ProcedureKey = 65, Amount = 5000.00, DateID = 20200305, accm_txn_create_time = '2025-04-30 02:00:00' WHERE FactAppointmentID = 65;
UPDATE FactAppointment SET ProcedureKey = 66, Amount = 5000.00, DateID = 20200306, accm_txn_create_time = '2025-04-30 03:00:00' WHERE FactAppointmentID = 66;
UPDATE FactAppointment SET ProcedureKey = 67, Amount = 5000.00, DateID = 20200307, accm_txn_create_time = '2025-04-30 04:00:00' WHERE FactAppointmentID = 67;
UPDATE FactAppointment SET ProcedureKey = 68, Amount = 5000.00, DateID = 20200308, accm_txn_create_time = '2025-04-30 05:00:00' WHERE FactAppointmentID = 68;


