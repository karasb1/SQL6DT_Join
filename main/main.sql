create database Academy;
go
use Academy;


go
create table Teachers (
    Id int primary key identity,
    Name nvarchar(max) not null,
    Surname nvarchar(max) not null
);

go
create table Assistants (
    Id int primary key identity,
    TeacherId int not null,
    foreign key (TeacherId) references Teachers(Id)
);

go
create table Curators (
    Id int primary key identity,
    TeacherId int not null,
    foreign key (TeacherId) references Teachers(Id)
);

go
create table Deans (
    Id int primary key identity,
    TeacherId int not null,
    foreign key (TeacherId) references Teachers(Id)
);

go
create table Faculties (
    Id int primary key identity,
    Building int not null check (Building between 1 and 5),
    Name nvarchar(100) not null unique,
    DeanId int not null,
    foreign key (DeanId) references Deans(Id)
);

go
create table Heads (
    Id int primary key identity,
    TeacherId int not null,
    foreign key (TeacherId) references Teachers(Id)
);

go
create table Departments (
    Id int primary key identity,
    Building int not null check (Building between 1 and 5),
    Name nvarchar(100) not null unique,
    FacultyId int not null,
    HeadId int not null,
    foreign key (FacultyId) references Faculties(Id),
    foreign key (HeadId) references Heads(Id)
);

go
create table Groups (
    Id int primary key identity,
    Name nvarchar(10) not null unique,
    Year int not null check (Year between 1 and 5),
    DepartmentId int not null,
    foreign key (DepartmentId) references Departments(Id)
);

go
create table GroupsCurators (
    Id int primary key identity,
    CuratorId int not null,
    GroupId int not null,
    foreign key (CuratorId) references Curators(Id),
    foreign key (GroupId) references Groups(Id)
);

go
create table Subjects (
    Id int primary key identity,
    Name nvarchar(100) not null unique
);

go
create table Lectures (
    Id int primary key identity,
    SubjectId int not null,
    TeacherId int not null,
    foreign key (SubjectId) references Subjects(Id),
    foreign key (TeacherId) references Teachers(Id)
);

go
create table GroupsLectures (
    Id int primary key identity,
    GroupId int not null,
    LectureId int not null,
    foreign key (GroupId) references Groups(Id),
    foreign key (LectureId) references Lectures(Id)
);

go
create table LectureRooms (
    Id int primary key identity,
    Building int not null check (Building between 1 and 5),
    Name nvarchar(10) not null unique
);

go
create table Schedules (
    Id int primary key identity,
    Class int not null check (Class between 1 and 8),
    DayOfWeek int not null check (DayOfWeek between 1 and 7),
    Week int not null check (Week between 1 and 52),
    LectureId int not null,
    LectureRoomId int not null,
    foreign key (LectureId) references Lectures(Id),
    foreign key (LectureRoomId) references LectureRooms(Id)
);


go
insert into Teachers (Name, Surname) values
    ('Edward', 'Hopper'),
    ('Petr', 'Petrov'),
    ('Sidor', 'Sidorov'),
    ('Vasiliy', 'Vasiliev'),
    ('Nikolay', 'Nikolaev'),
    ('Alexey', 'Alexeev'),
    ('Sergey', 'Sergeev'),
    ('Alex', 'Carmack'),
    ('Andrey', 'Andreev'),
    ('Mikhail', 'Mikhailov');

go
insert into Assistants (TeacherId) values
    (1),
    (2),
    (3),
    (4);

go
insert into Curators (TeacherId) values
    (5),
    (6),
    (7);

go
insert into Deans (TeacherId) values
    (8),
    (9),
    (10);

go
insert into Faculties (Building, Name, DeanId) values
    (1, 'Mathematics', 1),
    (2, 'Physics', 2),
    (3, 'Chemistry', 3),
    (4, 'Biology', 1),
    (5, 'Computer Science', 2);

go
insert into Heads (TeacherId) values
    (1),
    (2),
    (3),
    (4),
    (5);

go
insert into Departments (Building, Name, FacultyId, HeadId) values
    (1, 'Algebra', 1, 1),
    (2, 'Theoretical Physics', 2, 2),
    (3, 'Organic Chemistry', 3, 3),
    (4, 'Software Development', 5, 4),
    (5, 'Department of Programming', 5, 5);

go
insert into Groups (Name, Year, DepartmentId) values
    ('M-101', 1, 1),
    ('F505', 1, 1),
    ('M-103', 1, 1),
    ('M-104', 1, 1),
    ('M-105', 1, 1),
    ('M-201', 2, 1),
    ('M-202', 2, 1),
    ('M-203', 2, 1),
    ('M-204', 2, 1),
    ('M-205', 2, 1),
    ('M-301', 3, 1),
    ('M-302', 3, 1),
    ('M-303', 3, 1),
    ('M-304', 3, 1),
    ('M-305', 3, 1),
    ('M-401', 4, 1),
    ('M-402', 4, 1),
    ('M-403', 4, 1),
    ('M-404', 4, 1),
    ('M-405', 4, 1),
    ('M-501', 5, 1),
    ('M-502', 5, 5),
    ('M-503', 5, 5),
    ('M-504', 5, 5),
    ('M-505', 5, 1);

go
insert into GroupsCurators (CuratorId, GroupId) values
    (1, 1),
    (2, 2),
    (3, 3),
    (1, 4),
    (2, 5),
    (3, 6),
    (1, 7),
    (2, 8),
    (3, 9),
    (1, 10),
    (2, 11),
    (3, 12),
    (1, 13),
    (2, 14),
    (3, 15),
    (1, 16),
    (2, 17),
    (3, 18),
    (1, 19),
    (2, 20),
    (3, 21),
    (1, 22),
    (2, 23),
    (3, 24),
    (1, 25);

go
insert into Subjects (Name) values
    ('Algebra'),
    ('Geometry'),
    ('Trigonometry'),
    ('Calculus'),
    ('Physics'),
    ('Chemistry'),
    ('Biology'),
    ('Zoology'),
    ('Programming'),
    ('Computer Science');

go
insert into Lectures (SubjectId, TeacherId) values
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 8),
    (10, 8);

go
insert into GroupsLectures (GroupId, LectureId) values
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10),
    (11, 1),
    (12, 2),
    (13, 3),
    (14, 4),
    (15, 5),
    (16, 6),
    (17, 7),
    (18, 8),
    (19, 9),
    (20, 10),
    (21, 1),
    (22, 9),
    (23, 10),
    (24, 9),
    (25, 10);

go
insert into LectureRooms (Building, Name) values
    (1, '101'),
    (1, 'A311'),
    (1, '103'),
    (1, 'A104'),
    (1, '105'),
    (2, '201'),
    (2, '202'),
    (2, '203'),
    (2, '204'),
    (2, '205'),
    (3, '301'),
    (3, '302'),
    (3, '303'),
    (3, '304'),
    (3, '305'),
    (4, '401'),
    (4, '402'),
    (4, '403'),
    (4, '404'),
    (4, '405'),
    (5, '501'),
    (5, '502'),
    (5, '503'),
    (5, '504'),
    (5, '505');

go
insert into Schedules (Class, DayOfWeek, Week, LectureId, LectureRoomId) values
    (1, 1, 1, 1, 1),
    (2, 2, 2, 2, 2),
    (3, 3, 3, 3, 3),
    (4, 4, 4, 4, 4),
    (5, 5, 5, 5, 5),
    (6, 6, 6, 6, 6),
    (7, 7, 7, 7, 7),
    (8, 1, 8, 8, 8),
    (1, 2, 9, 9, 9),
    (2, 3, 10, 10, 10),
    (3, 4, 11, 1, 11),
    (4, 5, 12, 2, 12),
    (5, 6, 13, 3, 13),
    (6, 7, 14, 4, 14),
    (7, 1, 15, 5, 15),
    (8, 2, 16, 6, 16),
    (1, 3, 17, 7, 17),
    (2, 4, 18, 8, 18),
    (3, 5, 19, 9, 19),
    (4, 6, 20, 10, 20),
    (5, 7, 21, 1, 21),
    (6, 1, 22, 2, 22),
    (7, 2, 23, 3, 23),
    (8, 3, 24, 4, 24),
    (1, 4, 25, 5, 25);


select LR.Name
from Lectures
join Teachers T on Lectures.TeacherId = T.Id
join Schedules S on Lectures.Id = S.LectureId
join LectureRooms LR on S.LectureRoomId = LR.Id
where T.Surname = 'Hopper' and T.Name = 'Edward';

select distinct T.Surname
from Assistants A
join GroupsCurators GC on A.Id = GC.CuratorId
join Groups G on GC.GroupId = G.Id
join Schedules S on G.Id = S.LectureId
join Lectures L on S.LectureId = L.Id
join Teachers T on L.TeacherId = T.Id
where G.Name = 'F505';

select S.Name
from Lectures L
join Teachers T on L.TeacherId = T.Id
join Subjects S on L.SubjectId = S.Id
join GroupsLectures GL on L.Id = GL.LectureId
join Groups G on GL.GroupId = G.Id
where T.Surname = 'Carmack' and T.Name = 'Alex' and G.Year = 5;

select distinct T.Surname
from Teachers T
join Lectures L on T.Id = L.TeacherId
join Schedules S on L.Id = S.LectureId
where S.DayOfWeek != 1;

select distinct LR.Name, LR.Building
from LectureRooms LR
join Schedules S on LR.Id = S.LectureRoomId
where not exists (
    select 1
    from Schedules S2
    where S2.LectureRoomId = LR.Id and S2.DayOfWeek = 3 and S2.Week = 2 and S2.Class = 3);

select T.Name + ' ' + T.Surname as FullName
from Teachers T
join Faculties F on T.Id = F.DeanId
join Departments D on F.Id = D.FacultyId
join Groups G on D.Id = G.DepartmentId
join GroupsCurators GC on G.Id = GC.GroupId
where F.Name = 'Computer Science' and D.Name = 'Software Development';

select F.Building
from Faculties F
join Departments D on F.Id = D.FacultyId
join LectureRooms LR on F.Building = LR.Building
join Schedules S on LR.Id = S.LectureRoomId
where F.Building = D.Building and F.Building = LR.Building;

select T.Name + ' ' + T.Surname as FullName
from Teachers T
join Deans D on T.Id = D.TeacherId
union
select T.Name + ' ' + T.Surname as FullName
from Teachers T
join Heads h on T.Id = H.TeacherId
union
select T.Name + ' ' + T.Surname as FullName
from Teachers T
where T.Id not in (select TeacherId from Deans) and T.Id not in (select TeacherId from Heads)
union
select T.Name + ' ' + T.Surname as FullName
from Teachers T
join Curators C on T.Id = C.TeacherId
union
select T.Name + ' ' + T.Surname as FullName
from Teachers T
join Assistants A on T.Id = A.TeacherId
order by FullName;

select distinct S.DayOfWeek
from Schedules S
join LectureRooms LR on S.LectureRoomId = LR.Id
where LR.Name in ('A311', 'A104') and LR.Building = 1;


drop database Academy;