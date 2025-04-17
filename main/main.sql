create database Hospital;
go
use Hospital;


go
create table Departments (
    Id int primary key identity(1,1) not null,
    Building int not null check (Building between 1 and 5),
    Financing money not null check (Financing >= 0) default 0,
    Name nvarchar(100) not null unique
);

go
create table Diseases (
    Id int primary key identity(1,1) not null,
    Name nvarchar(100) not null unique
);

go
create table Doctors (
    Id int primary key identity(1,1) not null,
    Name nvarchar(max) not null,
    Salary money not null check (Salary > 0),
    Surname nvarchar(max) not null
);

go
create table Examinations (
    Id int primary key identity(1,1) not null,
    Name nvarchar(100) not null unique
);

go
create table Wards (
    Id int primary key identity(1,1) not null,
    Name nvarchar(20) not null unique,
    Places int not null check (Places >= 1),
    DepartmentId int not null foreign key references Departments(Id)
);

go
create table DoctorsExaminations (
    Id int primary key identity(1,1) not null,
    Date date not null default getdate(),
    DiseaseId int not null foreign key references Diseases(Id),
    DoctorId int not null foreign key references Doctors(Id),
    ExaminationId int not null foreign key references Examinations(Id),
    WardId int not null foreign key references Wards(Id)
);

go
create table Interns (
    Id int primary key identity(1,1) not null,
    DoctorId int not null foreign key references Doctors(Id)
);

go
create table Professors (
    Id int primary key identity(1,1) not null,
    DoctorId int not null foreign key references Doctors(Id)
);


go
insert into Departments (Building, Financing, Name) values
    (1, 25000, 'Cardiology'),
    (2, 15000, 'Physiotherapy'),
    (3, 20000, 'Oncology'),
    (4, 25000, 'Pediatrics'),
    (5, 30000, 'Ophthalmology'),
    (1, 25000, 'Neurology');

go
insert into Diseases (Name) values
    ('Cancer'),
    ('Flu'),
    ('Fracture'),
    ('Pneumonia'),
    ('Tuberculosis');

go
insert into Doctors (Name, Salary, Surname) values
    ('John', 5000, 'Doe'),
    ('Jane', 6000, 'Boe'),
    ('Jack', 7000, 'Coe'),
    ('Jill', 8000, 'Noe'),
    ('Jim', 9000, 'Poe'),
    ('Jenny', 1000, 'Moe');

go
insert into Examinations (Name) values
    ('Blood test'),
    ('MRI'),
    ('X-ray');

go
insert into Wards (Name, Places, DepartmentId) values
    ('A', 10, 1),
    ('B', 15, 2),
    ('C', 20, 3),
    ('D', 25, 4),
    ('E', 30, 5);

go
insert into DoctorsExaminations (Date, DiseaseId, DoctorId, ExaminationId, WardId) values
    ('2025-04-16', 1, 1, 1, 1),
    ('2025-04-12', 1, 4, 1, 1),
    ('2025-01-02', 2, 2, 2, 2),
    ('2025-01-03', 3, 3, 3, 3),
    ('2025-01-04', 4, 4, 1, 4),
    ('2025-02-20', 1, 5, 2, 5);

go
insert into Interns (DoctorId) values
    (1),
    (2);

go
insert into Professors (DoctorId) values
    (3),
    (4),
    (5);


select D.Name, D.Places
from Wards D
join Departments D2 on D.DepartmentId = D2.Id
where D2.Building = 5 and D.Places >= 5 and exists (select 1 from Wards where DepartmentId = D2.Id and Places > 15);

select D.Name
from Departments D
join DoctorsExaminations DE on D.Id = DE.WardId
where DE.Date >= dateadd(day, -7, getdate())

select D.Name
from Diseases D
where not exists (select 1 from DoctorsExaminations DE where DE.DiseaseId = D.Id)

select D.Name, D.Surname
from Doctors D
where not exists (select 1 from DoctorsExaminations DE where DE.DoctorId = D.Id)

select D.Name
from Departments D
where not exists (select 1 from DoctorsExaminations DE where DE.WardId = D.Id)

select D.Surname
from Doctors D
join Interns I on D.Id = I.DoctorId
group by D.Surname
having count(D.Surname) > 0

select D.Surname
from Doctors D
join Interns I on D.Id = I.DoctorId
where D.Salary > (select max(Salary) from Doctors where Id != D.Id)

select D.Name
from Wards D
where D.Places > (select max(Places) from Wards where DepartmentId = 3)

select D.Surname
from Doctors D
join DoctorsExaminations DE on D.Id = DE.DoctorId
join Departments D2 on DE.WardId = D2.Id
where D2.Name in ('Ophthalmology', 'Physiotherapy')

select D.Name
from Departments D
where exists (select 1 from Interns I where I.DoctorId = D.Id) and exists (select 1 from Professors P where P.DoctorId = D.Id)

select D.Name, D2.Name
from Doctors D
join DoctorsExaminations DE on D.Id = DE.DoctorId
join Departments D2 on DE.WardId = D2.Id
where D2.Financing > 20000

select D.Name
from Departments D
join DoctorsExaminations DE on D.Id = DE.WardId
join Doctors D2 on DE.DoctorId = D2.Id
where D2.Salary = (select max(Salary) from Doctors)

select D.Name, count(DE.Id) as Count
from Diseases D
join DoctorsExaminations DE on D.Id = DE.DiseaseId
group by D.Name
having count(DE.Id) > 0


drop database Hospital;
