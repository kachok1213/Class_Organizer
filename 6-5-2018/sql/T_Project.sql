/*
Use Master
GO
Drop Database Project
GO
*/

go

CREATE DATABASE Project  
ON (NAME = 'Project_Data', 
    FILENAME = 'C:\attend_proj\sql\T_Project_Data.MDF' , 
    SIZE = 10, 
    FILEGROWTH = 30%) 
LOG ON (NAME = 'Project_Log', 
        FILENAME = 'C:\attend_proj\sql\T_Project_Log.LDF' ,
        SIZE = 10, 
        FILEGROWTH = 30%)
COLLATE Hebrew_CI_AS
GO




Use Project
GO

CREATE TABLE Roles (
	RoleID int identity(1,1) NOT NULL PRIMARY KEY,
	RoleName nvarchar(15) NOT NULL
)

CREATE TABLE StatusLectures (
	StatusID int identity(1,1) NOT NULL PRIMARY KEY,
	StatusName nvarchar(15) NOT NULL
)

CREATE TABLE Users (
	UserID int identity(1,1) NOT NULL PRIMARY KEY,
	Pass varchar(max) NOT NULL,
	RoleID int NOT NULL FOREIGN KEY REFERENCES Roles(RoleID)
);

CREATE TABLE Lecturers (
	LecturerID int NOT NULL PRIMARY KEY,
	UserID int NOT NULL FOREIGN KEY REFERENCES Users(UserID),
	FirstName nvarchar(35) NOT NULL,
	LastName nvarchar(35),
	Email varchar(100) NOT NULL,
	Picture varchar(max)
);

CREATE TABLE Departments (
	DepartmentID int identity(1,1) NOT NULL PRIMARY KEY,
	DepartmentName nvarchar(50) NOT NULL
);

CREATE TABLE Students (
	StudentID int NOT NULL PRIMARY KEY,
	UserID int NOT NULL FOREIGN KEY REFERENCES Users(UserID),
	DepartmentID int NOT NULL FOREIGN KEY REFERENCES Departments(DepartmentID),
	FirstName nvarchar(35) NOT NULL,
	LastName nvarchar(35),
	Email varchar(100) NOT NULL,
	Picture varchar(max)
);

CREATE TABLE Courses (
	CourseID int identity(1,1) NOT NULL PRIMARY KEY,
	CourseName nvarchar(50) NOT NULL,
	OpenDate date NOT NULL,
	EndDate date NOT NULL
);

CREATE TABLE Courses_In_Departments (
	CourseID int NOT NULL FOREIGN KEY REFERENCES Courses(CourseID),
	DepartmentID int NOT NULL FOREIGN KEY REFERENCES Departments(DepartmentID)
	PRIMARY KEY (CourseID,DepartmentID)
);

CREATE TABLE Lecturers_In_Courses (
	CourseID int NOT NULL FOREIGN KEY REFERENCES Courses(CourseID),
	LecturerID int NOT NULL FOREIGN KEY REFERENCES Lecturers(LecturerID)
	PRIMARY KEY (CourseID,LecturerID)
);

CREATE TABLE Weekdays_List (
	WeekDayNumber int NOT NULL PRIMARY KEY,
	WeekDayName nvarchar(10)
);

CREATE TABLE Classes (
	ClassID int identity(1,1) NOT NULL PRIMARY KEY,
	ClassName nvarchar(30) NOT NULL
);

CREATE TABLE Courses_In_Times (
	CourseID int NOT NULL FOREIGN KEY REFERENCES Courses(CourseID),
	DepartmentID int NOT NULL FOREIGN KEY REFERENCES Departments(DepartmentID),
	LecturerID int NOT NULL FOREIGN KEY REFERENCES Lecturers(LecturerID),
	WeekDayNumber int NOT NULL FOREIGN KEY REFERENCES Weekdays_List(WeekDayNumber),
	ClassID int NOT NULL FOREIGN KEY REFERENCES Classes(ClassID),
	BeginHour time NOT NULL,
	EndHour time NOT NULL
);

CREATE TABLE Statuses (
	StatusID int identity(1,1) NOT NULL PRIMARY KEY,
	StatusName nvarchar(10) NOT NULL
);



CREATE TABLE Forms (
	FormID int identity(1,1) NOT NULL PRIMARY KEY,
	Picture varchar(max) NOT NULL
);

CREATE TABLE Forms_Of_Students (
	FormID int NOT NULL FOREIGN KEY REFERENCES Forms(FormID),
	StudentID int NOT NULL FOREIGN KEY REFERENCES Students(StudentID)
	PRIMARY KEY (FormID)
);

CREATE TABLE Lectures (
	LectureID int identity(1,1) NOT NULL PRIMARY KEY,
	CourseID int NOT NULL FOREIGN KEY REFERENCES Courses(CourseID),
	DepartmentID int NOT NULL FOREIGN KEY REFERENCES Departments(DepartmentID),
	LecturerID int NOT NULL FOREIGN KEY REFERENCES Lecturers(LecturerID),
	ClassID int NOT NULL FOREIGN KEY REFERENCES Classes(ClassID),
	LectureDate date NOT NULL,
	BeginHour time NOT NULL,
	EndHour time NOT NULL,
	isActive bit,
	TimeStarted varchar(30)
);

CREATE TABLE Students_In_Lectures (
	LectureID int NOT NULL FOREIGN KEY REFERENCES Lectures(LectureID),
	StudentID int NOT NULL FOREIGN KEY REFERENCES Students(StudentID),
	StatusID int NOT NULL FOREIGN KEY REFERENCES Statuses(StatusID)
	PRIMARY KEY (LectureID,StudentID)
);

GO


Set DateFormat dmy
GO


INSERT [dbo].[Roles] (RoleName) Values ('Lecturers')
INSERT [dbo].[Roles] (RoleName) Values ('Student')
GO


INSERT [dbo].[Users] (Pass, RoleID) Values ('123',1)
INSERT [dbo].[Users] (Pass, RoleID) Values ('123',1)
INSERT [dbo].[Users] (Pass, RoleID) Values ('123',1)
INSERT [dbo].[Users] (Pass, RoleID) Values ('123',1)
INSERT [dbo].[Users] (Pass, RoleID) Values ('123',2)
INSERT [dbo].[Users] (Pass, RoleID) Values ('123',2)
INSERT [dbo].[Users] (Pass, RoleID) Values ('123',2)
INSERT [dbo].[Users] (Pass, RoleID) Values ('123',2)
GO

 
INSERT [dbo].[StatusLectures] (StatusName) Values (N'התקיים')
INSERT [dbo].[StatusLectures] (StatusName) Values (N'טרם')
INSERT [dbo].[StatusLectures] (StatusName) Values (N'מצב נוכחות פעיל')
INSERT [dbo].[StatusLectures] (StatusName) Values (N'מצב נוכחות נגמר')
GO

INSERT [dbo].[Statuses] (StatusName) Values (N'נייטרלי')
INSERT [dbo].[Statuses] (StatusName) Values (N'נכח')
INSERT [dbo].[Statuses] (StatusName) Values (N'נעדר')
INSERT [dbo].[Statuses] (StatusName) Values (N'איחר')
INSERT [dbo].[Statuses] (StatusName) Values (N'הוצדק')
GO

INSERT [dbo].[Departments] (DepartmentName) Values (N'הנדסת תוכנה')
INSERT [dbo].[Departments] (DepartmentName) Values (N'הנדסת חשמל')
GO

INSERT [dbo].[Weekdays_List] (WeekDayNumber, WeekDayName) Values (1,N'ראשון')
INSERT [dbo].[Weekdays_List] (WeekDayNumber, WeekDayName) Values (2,N'שני')
INSERT [dbo].[Weekdays_List] (WeekDayNumber, WeekDayName) Values (3,N'שלישי')
INSERT [dbo].[Weekdays_List] (WeekDayNumber, WeekDayName) Values (4,N'רביעי')
INSERT [dbo].[Weekdays_List] (WeekDayNumber, WeekDayName) Values (5,N'חמישי')
INSERT [dbo].[Weekdays_List] (WeekDayNumber, WeekDayName) Values (6,N'שישי')
INSERT [dbo].[Weekdays_List] (WeekDayNumber, WeekDayName) Values (7,N'שבת')
GO

INSERT [dbo].[Lecturers] (LecturerID, UserID, FirstName, LastName, Email, Picture) Values (111,2,'nir',null,'fsd@gmail.com',null)
INSERT [dbo].[Lecturers] (LecturerID, UserID, FirstName, LastName, Email, Picture) Values (222,3,'innes',null,'fsd"@gmail.com',null)
INSERT [dbo].[Lecturers] (LecturerID, UserID, FirstName, LastName, Email, Picture) Values (333,4,'ruti',null,'fsd"@gmail.com',null)
INSERT [dbo].[Lecturers] (LecturerID, UserID, FirstName, LastName, Email, Picture) Values (444,5,'zeev',null,'fsd"@gmail.com',null)
GO

INSERT [dbo].[Courses] (CourseName, OpenDate, EndDate) Values ('C','2018-01-01','2019-01-01') -- innes תוכנה
INSERT [dbo].[Courses] (CourseName, OpenDate, EndDate) Values ('C#','2018-01-01','2019-01-01') -- nir תוכנה
INSERT [dbo].[Courses] (CourseName, OpenDate, EndDate) Values ('Assembly','2018-01-01','2019-01-01') -- nir תוכנה
INSERT [dbo].[Courses] (CourseName, OpenDate, EndDate) Values ('Power','2018-01-01','2019-01-01') -- ruti חשמל
GO

INSERT [dbo].[Courses_In_Departments] (CourseID, DepartmentID) Values (1,1) -- סי תוכנה
INSERT [dbo].[Courses_In_Departments] (CourseID, DepartmentID) Values (1,2) -- סי חשמל
INSERT [dbo].[Courses_In_Departments] (CourseID, DepartmentID) Values (2,1) -- סי שארפ תוכנה
INSERT [dbo].[Courses_In_Departments] (CourseID, DepartmentID) Values (3,1) -- אסמבלי תוכנה
INSERT [dbo].[Courses_In_Departments] (CourseID, DepartmentID) Values (4,2) -- כח חשמל
GO

INSERT [dbo].[Lecturers_In_Courses] (CourseID, LecturerID) Values (1,111) -- איינס סי
INSERT [dbo].[Lecturers_In_Courses] (CourseID, LecturerID) Values (1,222) -- זאב סי
INSERT [dbo].[Lecturers_In_Courses] (CourseID, LecturerID) Values (2,333) -- ניר סי שארפ
INSERT [dbo].[Lecturers_In_Courses] (CourseID, LecturerID) Values (3,444) -- איינס אסמבלי

GO

INSERT [dbo].[Classes] (ClassName) Values (N'חרוב')
INSERT [dbo].[Classes] (ClassName) Values (N'אלון')
INSERT [dbo].[Classes] (ClassName) Values (N'מעבדה')
INSERT [dbo].[Classes] (ClassName) Values (N'נובל')
GO

INSERT [dbo].[Students] (StudentID, UserID, DepartmentID, FirstName, LastName, Email, Picture) Values (666,6,1,'yochai',null,'fsd"@gmail.com',null) -- תוכנה
INSERT [dbo].[Students] (StudentID, UserID, DepartmentID, FirstName, LastName, Email, Picture) Values (777,7,1,'sharon',null,'fsd"@gmail.com',null) -- תוכנה
INSERT [dbo].[Students] (StudentID, UserID, DepartmentID, FirstName, LastName, Email, Picture) Values (888,8,2,'michal',null,'fsd"@gmail.com',null) -- חשמל
GO

INSERT [dbo].[Forms] (Picture) Values ('1')
INSERT [dbo].[Forms] (Picture) Values ('2')
INSERT [dbo].[Forms] (Picture) Values ('3')
INSERT [dbo].[Forms] (Picture) Values ('4')
INSERT [dbo].[Forms] (Picture) Values ('5')
GO

INSERT [dbo].[Forms_Of_Students] (StudentID, FormID) Values (666,1)
INSERT [dbo].[Forms_Of_Students] (StudentID, FormID) Values (666,2)
INSERT [dbo].[Forms_Of_Students] (StudentID, FormID) Values (777,3)
INSERT [dbo].[Forms_Of_Students] (StudentID, FormID) Values (777,4)
INSERT [dbo].[Forms_Of_Students] (StudentID, FormID) Values (777,5)
GO



--------------------------------- הוסף סטודנט למערכת

CREATE PROC AddStudent
@StudentID int,
@Pass varchar(max),
@DepartmentID int,
@FirstName nvarchar(35),
@LastName nvarchar(35),
@Email varchar(100),
@Picture varchar(max)
AS
BEGIN
	INSERT [dbo].[Users] (Pass, RoleID) Values (@Pass,3)
	INSERT [dbo].[Students] (StudentID, UserID, DepartmentID, FirstName, LastName, Email, Picture) Values (@StudentID,SCOPE_IDENTITY(),@DepartmentID,@FirstName,@LastName,@Email,@Picture)
	IF (@@ROWCOUNT=0) -- אם הפקודה הקודמת נכשלה
	BEGIN
		DELETE FROM [dbo].[Users] WHERE [UserID] = SCOPE_IDENTITY()
	END
END

GO
--------------------------------- הוסף מרצה למערכת

CREATE PROC AddLecturers
@LecturerID int,
@Pass varchar(max),
@FirstName nvarchar(35),
@LastName nvarchar(35),
@Email varchar(100),
@Picture varchar(max)
AS
BEGIN
	INSERT [dbo].[Users] (Pass, RoleID) Values (@Pass,2)
	INSERT [dbo].[Lecturers] (LecturerID, UserID, FirstName, LastName, Email, Picture) Values (@LecturerID,SCOPE_IDENTITY(),@FirstName,@LastName,@Email,@Picture)
	IF (@@ROWCOUNT=0) -- אם הפקודה הקודמת נכשלה
	BEGIN
		DELETE FROM [dbo].[Users] WHERE [UserID] = SCOPE_IDENTITY()
	END
END

GO

--------------------------------- הוסף מגמה

CREATE PROC AddDepartment
@DepartmentName nvarchar(50)
AS
BEGIN
	INSERT [dbo].[Departments] (DepartmentName) Values (@DepartmentName)
END

GO



--------------------------------- הוסף אישור

CREATE PROC AddForm
@Picture varchar(max)
AS
BEGIN
	INSERT [dbo].[Forms] (Picture) Values (@Picture)
END

GO
--------------------------------- הגדר אישור לסטודנט

CREATE PROC FormOfStudent
@FormID int,
@StudentID int
AS
BEGIN
	INSERT [dbo].[Forms_Of_Students] (FormID, StudentID) Values (@FormID,@StudentID)
END

GO
--------------------------------- הוסף סטודנטים להרצאות לפי מגמה והרצאה

CREATE PROC AddStudentsToLecturesByDepartment
@DepartmentID int,
@LectureID int
AS
BEGIN
	DECLARE @User_Index int = 1
	DECLARE @User_Length int = (SELECT COUNT(UserID) FROM dbo.Users)
	WHILE (@User_Index <= @User_Length)
	BEGIN
		IF EXISTS (SELECT dbo.Students.UserID FROM dbo.Students INNER JOIN dbo.Departments ON dbo.Students.DepartmentID = dbo.Departments.DepartmentID
				   WHERE (dbo.Students.UserID = @User_Index) AND (dbo.Departments.DepartmentID = @DepartmentID))
		BEGIN
			DECLARE @StudentID int = (SELECT dbo.Students.StudentID FROM dbo.Students INNER JOIN dbo.Departments ON dbo.Students.DepartmentID = dbo.Departments.DepartmentID
							           WHERE (dbo.Students.UserID = @User_Index) AND (dbo.Departments.DepartmentID = @DepartmentID))
			INSERT [dbo].[Students_In_Lectures] (LectureID, StudentID, StatusID) Values (@LectureID,@StudentID,1)
		END
		SET @User_Index = @User_Index + 1
	END
END
GO
--------------------------------- הוסף הרצאות לפי הזמנים של הקורס

CREATE PROC AddLecturesByCourse
@CourseID int,
@DepartmentID int,
@LecturerID int,
@WeekDayNumber int,
@ClassID int,
@BeginHour time,
@EndHour time
AS
BEGIN
	DECLARE @OpenDate date = (SELECT OpenDate FROM dbo.Courses WHERE (CourseID = @CourseID))
	DECLARE @EndDate date = (SELECT EndDate FROM dbo.Courses WHERE (CourseID = @CourseID))
	WHILE (@OpenDate <= @EndDate)
	BEGIN	
		IF (DATEPART(WEEKDAY,@OpenDate) = @WeekDayNumber)
		BEGIN
			INSERT [dbo].[Lectures] (CourseID, ClassID, DepartmentID, LecturerID, LectureDate, BeginHour, EndHour, isActive) Values (@CourseID,@ClassID,@DepartmentID,@LecturerID,@OpenDate,@BeginHour,@EndHour, 1)
			DECLARE @LectureID INT = SCOPE_IDENTITY()
			EXEC AddStudentsToLecturesByDepartment @DepartmentID, @LectureID
		END
		SELECT @OpenDate = DATEADD(day, 1, @OpenDate)
	END
END
GO
--------------------------------- הגדר זמנים לקורס

CREATE PROC AddTimesToCourse
@CourseID int,
@DepartmentID int,
@LecturerID int,
@WeekDayNumber int,
@ClassID int,
@BeginHour_Chosen time,
@EndHour_Chosen time
AS
BEGIN
	DECLARE @BeginHour time
	DECLARE @EndHour time
	DECLARE @IsValid bit = 1
	DECLARE @Course_Index int = (SELECT TOP (1) CourseID FROM dbo.Courses)
	DECLARE @Course_Last_ID int = (SELECT TOP (1) CourseID FROM dbo.Courses ORDER BY CourseID DESC)
	-- בודק אם הקורס שבחרת תפוס בשעות שבחרת
	IF EXISTS (SELECT CourseID FROM dbo.Courses_In_Times WHERE (CourseID = @CourseID) AND (WeekDayNumber = @WeekDayNumber) AND (DepartmentID = @DepartmentID) AND NOT((@BeginHour_Chosen < BeginHour AND @EndHour_Chosen < EndHour) OR (@BeginHour_Chosen >= EndHour AND @EndHour_Chosen >= EndHour)))
	BEGIN
		SET @IsValid = 0
		PRINT 'קורס תפוס'
	END
	IF (@EndHour_Chosen <= @BeginHour_Chosen)
	BEGIN
		SET @IsValid = 0
		PRINT 'שעת ההתחלה חייבת להיות קטנה יותר משעת הסיום'
	END
	IF (DATEDIFF(MINUTE, @BeginHour_Chosen, @EndHour_Chosen) < 45)
	BEGIN
		SET @IsValid = 0
		PRINT 'כל שיעור חייב להמשך לפחות 45 דקות'
	END
	IF NOT EXISTS (SELECT CourseID FROM dbo.Courses_In_Departments WHERE (CourseID = @CourseID) AND (DepartmentID = @DepartmentID))
	BEGIN
		SET @IsValid = 0
		PRINT 'הקורס לא קיים במגמה'
	END
	IF NOT EXISTS (SELECT CourseID FROM dbo.Lecturers_In_Courses WHERE (LecturerID = @LecturerID) AND (CourseID = @CourseID))
	BEGIN
		SET @IsValid = 0
		PRINT 'המרצה לא מלמד את הקורס'
	END
	IF (@IsValid = 1)
	BEGIN
		WHILE (@Course_Index <= @Course_Last_ID)
		BEGIN
			-- עובר על כל הקורסים ובודק שאין קורס כלשהו בכיתה שבחרת בשעות שבחרת
			IF EXISTS (SELECT CourseID FROM dbo.Courses_In_Times WHERE (ClassID = @ClassID) AND (WeekDayNumber = @WeekDayNumber) AND (CourseID = @Course_Index) AND (NOT((@BeginHour_Chosen < BeginHour AND @EndHour_Chosen < EndHour) OR (@BeginHour_Chosen >= EndHour AND @EndHour_Chosen >= EndHour)))) -- אם מצא שהבניין שבחרת בזמן שבחרת הוא תפוס
			BEGIN
				SET @IsValid = 0
				PRINT N'הכיתה תפוסה'
				BREAK
			END
			-- עובר על כל הקורסים ובודק שאין מגמה תפוסה בשעות שבחרת
			IF EXISTS (SELECT CourseID FROM dbo.Courses_In_Times WHERE (DepartmentID = @DepartmentID) AND (CourseID = @Course_Index) AND (WeekDayNumber = @WeekDayNumber) AND (NOT((@BeginHour_Chosen < BeginHour AND @EndHour_Chosen < EndHour) OR (@BeginHour_Chosen >= EndHour AND @EndHour_Chosen >= EndHour))))
			BEGIN
				SET @IsValid = 0
				PRINT N'המגמה תפוסה'
				BREAK
			END
			-- עובר על כל הקורסים ובודק שאין מרצה עסוק בשעות שבחרת
			IF EXISTS (SELECT CourseID FROM dbo.Courses_In_Times WHERE (LecturerID = @LecturerID) AND (CourseID = @Course_Index) AND (WeekDayNumber = @WeekDayNumber) AND (NOT((@BeginHour_Chosen < BeginHour AND @EndHour_Chosen < EndHour) OR (@BeginHour_Chosen >= EndHour AND @EndHour_Chosen >= EndHour))))
			BEGIN
				SET @IsValid = 0
				PRINT 'המרצה עסוק'
				BREAK
			END
			SET @Course_Index = @Course_Index + 1
		END
	END
	IF (@IsValid = 1) -- אם מצא שחוקי
	BEGIN
		INSERT [dbo].[Courses_In_Times] (CourseID, DepartmentID, LecturerID, WeekDayNumber, ClassID, BeginHour, EndHour) Values (@CourseID,@DepartmentID,@LecturerID,@WeekDayNumber,@ClassID,@BeginHour_Chosen,@EndHour_Chosen)
		IF (@@ROWCOUNT != 0) -- אם הפקודה הקודמת הצליחה
		BEGIN
			EXEC AddLecturesByCourse @CourseID,@DepartmentID,@LecturerID,@WeekDayNumber,@ClassID,@BeginHour_Chosen,@EndHour_Chosen
		END
	END
END
GO

--@CourseID int,
--@Department_ID int,
--@LecturerID int,
--@Week_Day int,
--@ClassID int,
--@BeginHour_Chosen time,
--@EndHour_Chosen time

EXEC AddTimesToCourse 1,1,111,1,1,'15:00','17:00'
GO

CREATE PROC GetStudent
@StudentID int,
@Pass varchar(max)
AS
BEGIN
	SELECT dbo.Users.UserID, dbo.Users.Pass, dbo.Roles.*, dbo.Students.StudentID, dbo.Departments.*, dbo.Students.FirstName, dbo.Students.LastName, dbo.Students.Email, dbo.Students.Picture
	FROM dbo.Users INNER JOIN dbo.Students ON dbo.Users.UserID = dbo.Students.UserID INNER JOIN dbo.Roles ON dbo.Users.RoleID = dbo.Roles.RoleID INNER JOIN dbo.Departments ON dbo.Students.DepartmentID = dbo.Departments.DepartmentID
	WHERE (dbo.Students.StudentID = @StudentID) AND (dbo.Users.Pass = @Pass)
END
GO

exec GetStudent 666,'123'
GO

CREATE PROC GetLecturer
@LecturerID int,
@Pass varchar(max)
AS
BEGIN
	SELECT dbo.Users.UserID, dbo.Users.Pass, dbo.Roles.*, dbo.Lecturers.LecturerID, dbo.Lecturers.FirstName, dbo.Lecturers.LastName, dbo.Lecturers.Email, dbo.Lecturers.Picture
	FROM dbo.Users INNER JOIN dbo.Roles ON dbo.Users.RoleID = dbo.Roles.RoleID INNER JOIN dbo.Lecturers ON dbo.Users.UserID = dbo.Lecturers.UserID
	WHERE (dbo.Lecturers.LecturerID = @LecturerID) AND (dbo.Users.Pass = @Pass)
END
GO

exec GetLecturer 111,'123'
GO


create PROC GetAllLecturers
AS
BEGIN
SELECT        dbo.Lecturers.LecturerID, dbo.Users.Pass, dbo.Lecturers.FirstName, dbo.Lecturers.LastName, dbo.Lecturers.Email, dbo.Lecturers.Picture, dbo.Users.RoleID
FROM            dbo.Users INNER JOIN
                         dbo.Lecturers ON dbo.Users.UserID = dbo.Lecturers.UserID
END
GO

EXEC GetAllLecturers
go


create PROC GetAllStudents
AS
BEGIN
	SELECT        dbo.Students.StudentID, dbo.Users.Pass, dbo.Students.FirstName, dbo.Students.LastName, dbo.Students.Email, dbo.Students.Picture, dbo.Users.RoleID
FROM            dbo.Users INNER JOIN
                         dbo.Students ON dbo.Users.UserID = dbo.Students.UserID
END
GO

EXEC GetAllStudents
go

CREATE PROC GetLecturesByStudentAndDate
@date date,
@StudentID int
as
SELECT        TOP (100) PERCENT dbo.Lectures.LectureID, dbo.Departments.DepartmentID, dbo.Departments.DepartmentName, dbo.Courses.CourseID, dbo.Courses.CourseName, dbo.Courses.OpenDate, dbo.Courses.EndDate, 
                         dbo.Classes.ClassID, dbo.Classes.ClassName, dbo.Lectures.LectureDate, dbo.Lectures.BeginHour, dbo.Lectures.EndHour, dbo.Lecturers.LecturerID, dbo.Lecturers.FirstName, dbo.Lecturers.LastName, dbo.Statuses.StatusID, 
                         dbo.Statuses.StatusName
FROM            dbo.Students_In_Lectures INNER JOIN
                         dbo.Lectures ON dbo.Students_In_Lectures.LectureID = dbo.Lectures.LectureID INNER JOIN
                         dbo.Courses ON dbo.Lectures.CourseID = dbo.Courses.CourseID INNER JOIN
                         dbo.Departments ON dbo.Lectures.DepartmentID = dbo.Departments.DepartmentID INNER JOIN
                         dbo.Classes ON dbo.Lectures.ClassID = dbo.Classes.ClassID INNER JOIN
                         dbo.Lecturers ON dbo.Lectures.LecturerID = dbo.Lecturers.LecturerID INNER JOIN
                         dbo.Statuses ON dbo.Students_In_Lectures.StatusID = dbo.Statuses.StatusID
WHERE        (dbo.Lectures.LectureDate = @date) AND (dbo.Students_In_Lectures.StudentID = @StudentID)
ORDER BY dbo.Lectures.BeginHour
go

exec GetLecturesByStudentAndDate '28/4/2018', 666
go

CREATE proc GetCurrentLectureByStudent
@StudentID int
as
	DECLARE @timenow time = (CONVERT (TIME, GETDATE()))
	DECLARE @datenow date = (CONVERT (date, GETDATE()))
SELECT        TOP (1) dbo.Lectures.LectureID, dbo.Courses.CourseName, dbo.Lectures.BeginHour, dbo.Lectures.EndHour, dbo.Classes.ClassName, dbo.Lecturers.FirstName, dbo.Lecturers.LastName, dbo.Classes.ClassID, 
                         dbo.Departments.DepartmentID, dbo.Departments.DepartmentName, dbo.Courses.CourseID, dbo.Courses.OpenDate, dbo.Courses.EndDate, dbo.Students_In_Lectures.StatusID, dbo.Lectures.LectureDate, 
                         dbo.Lecturers.LecturerID, dbo.Statuses.StatusName
FROM            dbo.Students_In_Lectures INNER JOIN
                         dbo.Lectures ON dbo.Students_In_Lectures.LectureID = dbo.Lectures.LectureID INNER JOIN
                         dbo.Courses ON dbo.Lectures.CourseID = dbo.Courses.CourseID INNER JOIN
                         dbo.Classes ON dbo.Lectures.ClassID = dbo.Classes.ClassID INNER JOIN
                         dbo.Lecturers ON dbo.Lectures.LecturerID = dbo.Lecturers.LecturerID INNER JOIN
                         dbo.Departments ON dbo.Lectures.DepartmentID = dbo.Departments.DepartmentID INNER JOIN
                         dbo.Statuses ON dbo.Students_In_Lectures.StatusID = dbo.Statuses.StatusID
WHERE        (dbo.Lectures.LectureDate = @datenow) AND (dbo.Students_In_Lectures.StudentID = @StudentID) AND (dbo.Lectures.EndHour > @timenow)
go

exec GetCurrentLectureByStudent 666
go


CREATE PROC CoursesOnSpecDateForSpecLecturer
@date date,
@LecturerID int
as
SELECT        dbo.Lectures.LectureDate, dbo.Courses.CourseName, dbo.Lecturers_In_Courses.LecturerID, dbo.Lectures.BeginHour, dbo.Lectures.EndHour, dbo.Classes.ClassName, dbo.Courses.OpenDate, dbo.Courses.EndDate, 
                         dbo.Lectures.LectureID, dbo.Classes.ClassID, dbo.Departments.DepartmentName, dbo.Departments.DepartmentID, dbo.Lecturers_In_Courses.CourseID
FROM            dbo.Courses INNER JOIN
                         dbo.Lecturers_In_Courses ON dbo.Courses.CourseID = dbo.Lecturers_In_Courses.CourseID INNER JOIN
                         dbo.Lectures ON dbo.Courses.CourseID = dbo.Lectures.CourseID INNER JOIN
                         dbo.Classes ON dbo.Lectures.ClassID = dbo.Classes.ClassID INNER JOIN
                         dbo.Departments ON dbo.Lectures.DepartmentID = dbo.Departments.DepartmentID
WHERE        (dbo.Lectures.LectureDate = @date) AND (dbo.Lecturers_In_Courses.LecturerID = @LecturerID)
go

exec CoursesOnSpecDateForSpecLecturer '27/4/2018',111
go

create proc NextCourseForSpecLecturer
@date date ,
@LecturerID int,
@time time 
as
SELECT        TOP (1) dbo.Lectures.LectureDate, dbo.Courses.CourseName, dbo.Lecturers_In_Courses.LecturerID, dbo.Lectures.BeginHour, dbo.Lectures.EndHour, dbo.Courses.CourseID, dbo.Lectures.LectureID, dbo.Lectures.DepartmentID, 
                         dbo.Courses.OpenDate, dbo.Courses.EndDate, dbo.Departments.DepartmentName, dbo.Classes.ClassName, dbo.Classes.ClassID, dbo.Lectures.TimeStarted, dbo.Lectures.isActive
FROM            dbo.Courses INNER JOIN
                         dbo.Lecturers_In_Courses ON dbo.Courses.CourseID = dbo.Lecturers_In_Courses.CourseID INNER JOIN
                         dbo.Lectures ON dbo.Courses.CourseID = dbo.Lectures.CourseID INNER JOIN
                         dbo.Classes ON dbo.Lectures.ClassID = dbo.Classes.ClassID INNER JOIN
                         dbo.Departments ON dbo.Lectures.DepartmentID = dbo.Departments.DepartmentID
WHERE        (dbo.Lectures.LectureDate = @date) AND (dbo.Lecturers_In_Courses.LecturerID = @LecturerID) AND (dbo.Lectures.EndHour > @time)
go

exec NextCourseForSpecLecturer '06/5/2018', 111 ,'14:59'
go

CREATE PROC ChangeStudentStatusToPresent
@StudentID int,
@LectureID int
AS
BEGIN
	UPDATE [dbo].[Students_In_Lectures] SET StatusID = (SELECT StatusID FROM dbo.Statuses WHERE (StatusName = N'נכח')) WHERE (StudentID = @StudentID) AND (LectureID = @LectureID)
END
go

exec ChangeStudentStatusToPresent 666, 10
go

CREATE PROC ChangeStudentStatusToLate
@StudentID int,
@LectureID int
AS
BEGIN
	UPDATE [dbo].[Students_In_Lectures] SET StatusID = (SELECT StatusID FROM dbo.Statuses WHERE (StatusName = N'איחר')) WHERE (StudentID = @StudentID) AND (LectureID = @LectureID)
END
go

exec ChangeStudentStatusToLate 666, 10
go


ALTER proc AllStudentsOnSpecLectur
@LectureID int
as
SELECT        dbo.Lectures.LectureID, dbo.Students_In_Lectures.StudentID, dbo.Students.FirstName, dbo.Students.LastName, dbo.Students.Picture, dbo.Roles.RoleID, dbo.Roles.RoleName, dbo.Students.Email, 
                         dbo.Departments.DepartmentID, dbo.Departments.DepartmentName, dbo.Users.UserID, dbo.Users.Pass
FROM            dbo.Lectures INNER JOIN
                         dbo.Students_In_Lectures ON dbo.Lectures.LectureID = dbo.Students_In_Lectures.LectureID INNER JOIN
                         dbo.Students ON dbo.Students_In_Lectures.StudentID = dbo.Students.StudentID INNER JOIN
                         dbo.Departments ON dbo.Lectures.DepartmentID = dbo.Departments.DepartmentID AND dbo.Students.DepartmentID = dbo.Departments.DepartmentID INNER JOIN
                         dbo.Users ON dbo.Students.UserID = dbo.Users.UserID INNER JOIN
                         dbo.Roles ON dbo.Users.RoleID = dbo.Roles.RoleID
WHERE        (dbo.Lectures.LectureID = 1)
go  

exec AllStudentsOnSpecLectur 10
go

CREATE PROC StartTimer
@TimeStarted varchar(30),
@LectureID int
AS
BEGIN
	UPDATE [dbo].[Lectures] SET TimeStarted=@TimeStarted WHERE LectureID=@LectureID
END
GO

EXEC StartTimeStarted '12:22', 1
GO

create PROC Delete_Lecture
@LectureID int
AS
BEGIN
UPDATE  dbo.Lectures
SET isActive = 0
WHERE(LectureID = @LectureID)
END
GO

exec Delete_Lecture 5
go