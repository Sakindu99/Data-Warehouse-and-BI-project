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

Select* from DimPatient
Select* from DimDoctor
Select* from DimProcedure
select* from DimDate
select* from FactAppointment

select D.Specialization, count(A.AppointmentID) as 'Number of appointments'
from FactAppointment A
JOIN DimDoctor D on A.DoctorKey = D.DoctorKey
GROUP BY D.Specialization

