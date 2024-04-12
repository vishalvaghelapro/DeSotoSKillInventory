USE [skills]
GO
/****** Object:  User [dhaval]    Script Date: 4/12/2024 7:03:41 PM ******/
CREATE USER [dhaval] FOR LOGIN [dhaval] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [NT AUTHORITY\LOCAL SERVICE]    Script Date: 4/12/2024 7:03:41 PM ******/
CREATE USER [NT AUTHORITY\LOCAL SERVICE] FOR LOGIN [NT AUTHORITY\LOCAL SERVICE] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 4/12/2024 7:03:41 PM ******/
CREATE USER [NT AUTHORITY\SYSTEM] FOR LOGIN [NT AUTHORITY\SYSTEM] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [userlocal]    Script Date: 4/12/2024 7:03:41 PM ******/
CREATE USER [userlocal] FOR LOGIN [userlocal] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [dhaval]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [dhaval]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [dhaval]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [dhaval]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [dhaval]
GO
ALTER ROLE [db_datareader] ADD MEMBER [dhaval]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [dhaval]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [dhaval]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [dhaval]
GO
ALTER ROLE [db_datareader] ADD MEMBER [NT AUTHORITY\LOCAL SERVICE]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [NT AUTHORITY\LOCAL SERVICE]
GO
ALTER ROLE [db_datareader] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO
/****** Object:  UserDefinedFunction [dbo].[f_split]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_split] (@String NVARCHAR(4000), @Delimiter NCHAR(1)) RETURNS TABLE
AS
RETURN
(
    WITH Split(stpos,endpos)
    AS(
        SELECT 0 AS stpos, CHARINDEX(@Delimiter,@String) AS endpos
        UNION ALL
        SELECT endpos+1, CHARINDEX(@Delimiter,@String,endpos+1)
            FROM Split
            WHERE endpos > 0
    )
    SELECT 'Id' = ROW_NUMBER() OVER (ORDER BY (SELECT 1)),
        'Data' = SUBSTRING(@String,stpos,COALESCE(NULLIF(endpos,0),LEN(@String)+1)-stpos)
    FROM Split
)
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Adminlogin]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Adminlogin](
	[Admin_id] [nvarchar](50) NULL,
	[Password] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentId] [int] NOT NULL,
	[DepartmentName] [nvarchar](20) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[Department] [nvarchar](max) NULL,
	[Roll] [varchar](20) NULL,
	[Password] [varchar](20) NULL,
	[Status] [varchar](20) NULL,
	[IsDelete] [nvarchar](20) NULL,
	[Email] [varchar](255) NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeesSkill]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeesSkill](
	[EmployeeSkillId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[SkillId] [int] NOT NULL,
	[ProficiencyLevel] [nvarchar](max) NOT NULL,
	[IsDelete] [nvarchar](20) NULL,
 CONSTRAINT [PK_EmployeesSkill] PRIMARY KEY CLUSTERED 
(
	[EmployeeSkillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Skill]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Skill](
	[SkillId] [int] IDENTITY(1,1) NOT NULL,
	[SkillName] [nvarchar](max) NOT NULL,
	[SkillDescription] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Skill] PRIMARY KEY CLUSTERED 
(
	[SkillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SkillCategories]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SkillCategories](
	[SkillCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](max) NOT NULL,
	[CategoryDescription] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_SkillCategories] PRIMARY KEY CLUSTERED 
(
	[SkillCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SkillCertifications]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SkillCertifications](
	[SkillCertificationId] [int] IDENTITY(1,1) NOT NULL,
	[CertificationName] [nvarchar](max) NOT NULL,
	[IssuingOrganization] [nvarchar](max) NOT NULL,
	[DateOfCertification] [datetime2](7) NOT NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_SkillCertifications] PRIMARY KEY CLUSTERED 
(
	[SkillCertificationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SkillTraining]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SkillTraining](
	[SkillTrainingId] [int] IDENTITY(1,1) NOT NULL,
	[TrainingName] [nvarchar](max) NOT NULL,
	[TrainingProvider] [nvarchar](max) NOT NULL,
	[DateOfTraining] [datetime2](7) NOT NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_SkillTraining] PRIMARY KEY CLUSTERED 
(
	[SkillTrainingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20231209163542_SkillEmp', N'7.0.14')
GO
INSERT [dbo].[Adminlogin] ([Admin_id], [Password]) VALUES (N'Vishal Vaghela', N'desoto@123')
GO
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName]) VALUES (1, N'DotNet')
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName]) VALUES (2, N'Power BI')
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName]) VALUES (3, N'Salesforce')
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName]) VALUES (4, N'QA')
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName]) VALUES (5, N'Manager')
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName]) VALUES (6, N'HR')
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName]) VALUES (7, N'CEO')
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName]) VALUES (8, N'CTO')
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName]) VALUES (9, N'Genral Manger')
INSERT [dbo].[Department] ([DepartmentId], [DepartmentName]) VALUES (10, N'Director')
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [Department], [Roll], [Password], [Status], [IsDelete], [Email]) VALUES (2679, N'Vishal', N'Vaghela', N'DotNet', N'Employee', N'MTExMTE=', NULL, N'N', N'vvaghela@desototechnologies.com')
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [Department], [Roll], [Password], [Status], [IsDelete], [Email]) VALUES (2680, N'Vishal', N'Vaghela', N'Director', N'Employee', N'MTExMQ==', NULL, N'N', N'vvaghelda@desototechnologies.com')
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [Department], [Roll], [Password], [Status], [IsDelete], [Email]) VALUES (2681, N'Nisarg', N'prajapati', N'DotNet', N'Admin', N'OTk5OQ==', NULL, N'N', N'nisarg@desototechnologies.com')
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [Department], [Roll], [Password], [Status], [IsDelete], [Email]) VALUES (2682, N'Varsha', N'Jha', N'DotNet', N'Employee', N'MTExMQ==', NULL, N'N', N'varsha@desototechnologies.com')
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [Department], [Roll], [Password], [Status], [IsDelete], [Email]) VALUES (2683, N'Vishal', N'Vaghela', N'CTO', N'Employee', N'MTExMQ==', NULL, N'N', N'vvaghela111@desototechnologies.com')
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [Department], [Roll], [Password], [Status], [IsDelete], [Email]) VALUES (2684, N'Vishal', N'Vaghela', N'CTO', N'Employee', N'MjIyMg==', NULL, N'N', N'vvaghela@desoto.com')
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [Department], [Roll], [Password], [Status], [IsDelete], [Email]) VALUES (2685, N'Vishal', N'Vaghela', N'CEO', N'Employee', N'MzMzMw==', NULL, N'N', N'vvaghela@desototechnologes.com')
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [Department], [Roll], [Password], [Status], [IsDelete], [Email]) VALUES (2686, N'Vishal', N'Vaghela', N'DotNet', N'Employee', N'MTEx', NULL, N'N', N'vaghela@desototechnologies.com')
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [Department], [Roll], [Password], [Status], [IsDelete], [Email]) VALUES (2687, N'Varsha', N'Jha', N'DotNet', N'Employee', N'MTEx', NULL, N'N', N'vjha@desototechnologies.com')
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [Department], [Roll], [Password], [Status], [IsDelete], [Email]) VALUES (2688, N'Vishal', N'Vaghela', N'Director', N'Admin', N'd3d3dw==', NULL, N'N', N'vvaghelda1@desototechnologies.com')
INSERT [dbo].[Employees] ([EmployeeId], [FirstName], [LastName], [Department], [Roll], [Password], [Status], [IsDelete], [Email]) VALUES (2689, N'jimmy', N'thakkar', N'Salesforce', N'Admin', N'MTExMQ==', NULL, N'N', N'jimmy@desototechnologies.com')
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[Skill] ON 

INSERT [dbo].[Skill] ([SkillId], [SkillName], [SkillDescription]) VALUES (1, N'Java', N'An object-oriented programming language used for developing web applications, enterprise applications, and mobile applications')
INSERT [dbo].[Skill] ([SkillId], [SkillName], [SkillDescription]) VALUES (2, N'Python', N'A general-purpose programming language used for web development, data science, and machine learning')
INSERT [dbo].[Skill] ([SkillId], [SkillName], [SkillDescription]) VALUES (3, N'JavaScript', N'A scripting language used to add interactivity to web pages')
INSERT [dbo].[Skill] ([SkillId], [SkillName], [SkillDescription]) VALUES (4, N'C++', N'A powerful programming language used for system programming, game development, and high-performance computing')
INSERT [dbo].[Skill] ([SkillId], [SkillName], [SkillDescription]) VALUES (5, N'C#', N'An object-oriented programming language used for developing Windows applications and web applications')
INSERT [dbo].[Skill] ([SkillId], [SkillName], [SkillDescription]) VALUES (6, N'SQL', N'A programming language used to manage and manipulate data in relational databases')
INSERT [dbo].[Skill] ([SkillId], [SkillName], [SkillDescription]) VALUES (7, N'HTML', N'The markup language used to create web pages')
INSERT [dbo].[Skill] ([SkillId], [SkillName], [SkillDescription]) VALUES (8, N'CSS', N'The style sheet language used to style web pages')
INSERT [dbo].[Skill] ([SkillId], [SkillName], [SkillDescription]) VALUES (11, N'Automation', N'Automation')
SET IDENTITY_INSERT [dbo].[Skill] OFF
GO
ALTER TABLE [dbo].[SkillCertifications]  WITH CHECK ADD  CONSTRAINT [FK_SkillCertifications_Employees_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SkillCertifications] CHECK CONSTRAINT [FK_SkillCertifications_Employees_EmployeeId]
GO
ALTER TABLE [dbo].[SkillTraining]  WITH CHECK ADD  CONSTRAINT [FK_SkillTraining_Employees_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SkillTraining] CHECK CONSTRAINT [FK_SkillTraining_Employees_EmployeeId]
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmp]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteEmp] (
  @EmployeeSkillId int
)
AS
BEGIN
  -- Update EmployeesSkill table with IsDelete flag
  UPDATE EmployeesSkill
  SET IsDelete = 'Y'
  WHERE EmployeeSkillId = @EmployeeSkillId;

  -- Get EmployeeId from the deleted skill record 
  DECLARE @EmployeeId int;
  SELECT @EmployeeId = EmployeeId
  FROM EmployeesSkill
  WHERE EmployeeSkillId = @EmployeeSkillId;

  -- Check if any skills remain for the employee (IsDelete != 'Y')
  IF NOT EXISTS (
    SELECT 1
    FROM EmployeesSkill
    WHERE EmployeeId = @EmployeeId
      AND IsDelete = 'N'
  )
  BEGIN
    -- Update Employees table with IsDelete flag
    UPDATE Employees
    SET IsDelete = 'Y'
    WHERE EmployeeId = @EmployeeId;
  END
END;
GO
/****** Object:  StoredProcedure [dbo].[EmpInfo]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[EmpInfo]
As
SELECT dbo.Employees.EmployeeId,dbo.Employees.FirstName, dbo.Employees.LastName, dbo.Employees.Email, dbo.Employees.Department, dbo.Skill.SkillName,dbo.Employees.Roll,dbo.Employees.Password, dbo.EmployeesSkill.ProficiencyLevel,dbo.EmployeesSkill.EmployeeSkillId
FROM dbo.Employees INNER JOIN
dbo.EmployeesSkill ON dbo.Employees.EmployeeId = dbo.EmployeesSkill.EmployeeId INNER JOIN
dbo.Skill ON dbo.EmployeesSkill.SkillId = dbo.Skill.SkillId
where dbo.EmployeesSkill.IsDelete='N';
GO
/****** Object:  StoredProcedure [dbo].[FInsertData]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[FInsertData]
@FirstName NVARCHAR(MAX),
@LastName NVARCHAR(MAX),
@Email NVARCHAR(MAX),
@Department NVARCHAR(MAX),
@Roll NVARCHAR(20),
@Password NVARCHAR(20),
@AllSkillId NVARCHAR(100),
@ProficiencyLevel NVARCHAR(MAX)
as
begin
insert into Employees(FirstName,LastName,Email,Department,Roll,[Password],IsDelete)values(@FirstName,@LastName,@Email,@Department,@Roll,@Password,'N')
declare @EmployeeId int = @@Identity
    BEGIN
	DECLARE @SkillId int;
    DECLARE @TotalSkill int = 0;

    -- Create a table variable to store the individual skill IDs
    DECLARE @SkillIds TABLE (SkillId int);

	WHILE CHARINDEX(',', @AllSkillId) > 0
    BEGIN
        SET @SkillId = SUBSTRING(@AllSkillId, 1, CHARINDEX(',', @AllSkillId) - 1);
        SET @AllSkillId = SUBSTRING(@AllSkillId, CHARINDEX(',', @AllSkillId) + 1, LEN(@AllSkillId));
        
        INSERT INTO EmployeesSkill(EmployeeId, SkillId, ProficiencyLevel, IsDelete) VALUES (@EmployeeId, @SkillId, @ProficiencyLevel, 'N')

      --  SET @AllSkillId = SUBSTRING(@AllSkillId, @Position + 1, LEN(@AllSkillId))
    END
	INSERT INTO EmployeesSkill(EmployeeId, SkillId, ProficiencyLevel, IsDelete) VALUES (@EmployeeId, @AllSkillId, @ProficiencyLevel, 'N')
END
END
GO
/****** Object:  StoredProcedure [dbo].[getByIdEd]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[getByIdEd]
(
	@EmployeeSkillId int
)
AS
SELECT 
	dbo.EmployeesSkill.EmployeeId,
	dbo.Employees.EmployeeId,
	dbo.Employees.FirstName, 
	dbo.Employees.LastName, 
	dbo.Employees.Email, 
	dbo.Employees.Department, 
	dbo.Skill.SkillId,
	dbo.Skill.SkillName,
	dbo.EmployeesSkill.ProficiencyLevel,
	dbo.EmployeesSkill.EmployeeSkillId
FROM dbo.Employees INNER JOIN
dbo.EmployeesSkill ON dbo.Employees.EmployeeId = dbo.EmployeesSkill.EmployeeId INNER JOIN
dbo.Skill ON dbo.EmployeesSkill.SkillId = dbo.Skill.SkillId
where EmployeesSkill.EmployeeSkillId=@EmployeeSkillId;
GO
/****** Object:  StoredProcedure [dbo].[GetDepartment]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetDepartment]
As
select DISTINCT DepartmentName from Department;
GO
/****** Object:  StoredProcedure [dbo].[GetSkill]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetSkill]
As
select DISTINCT SKillId,SkillName from Skill;
GO
/****** Object:  StoredProcedure [dbo].[GetSkillIds]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSkillIds]
    @AllSkillId varchar(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SkillId int;
    DECLARE @TotalSkill int = 0;

    -- Split the comma-separated string into a table
    DECLARE @SkillIdsTable TABLE (SkillId int);
    INSERT INTO @SkillIdsTable
        SELECT Value
        FROM STRING_SPLIT(@AllSkillId, ',');

    -- Iterate through the table and output each skill ID
    WHILE (SELECT COUNT(*) FROM @SkillIdsTable) > 0
    BEGIN
        SELECT TOP 1 @SkillId = SkillId FROM @SkillIdsTable;
        DELETE FROM @SkillIdsTable WHERE SkillId = @SkillId;

        SELECT @SkillId AS SkillId;  -- Output the current skill ID

        SET @TotalSkill = @TotalSkill + 1;
    END

    -- Output the total number of skills
    SELECT @TotalSkill AS TotalSkill;
END
GO
/****** Object:  StoredProcedure [dbo].[LoginSP]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[LoginSP]
@Email nvarchar(50) null,
@Password nvarchar(50) OUT,  -- Added 'OUT' keyword
@Roll nvarchar(50) Out,
@Isvalid bit Out
as
begin
  -- Set @Isvalid to check if a valid employee exists with matching email, password and not deleted
  Set @Isvalid =(Select Count(*) FROM Employees where Email = @Email and [Password]= @Password and [IsDelete] = 'N')

  -- If valid user found, set the role (@Roll) based on email and password
  if @Isvalid = 1
  Begin
    Set @Roll = (Select Roll FROM Employees where Email = @Email and [Password]= @Password and [IsDelete] = 'N')
  END
end
GO
/****** Object:  StoredProcedure [dbo].[ProcessSkillIds]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ProcessSkillIds] (@AllSkillId varchar(100))
AS
BEGIN
    DECLARE @SkillId int;
    DECLARE @TotalSkill int = 0;

    -- Create a table variable to store the individual skill IDs
    DECLARE @SkillIds TABLE (SkillId int);

    -- Split the comma-separated string into individual values
    WHILE CHARINDEX(',', @AllSkillId) > 0
    BEGIN
        SET @SkillId = SUBSTRING(@AllSkillId, 1, CHARINDEX(',', @AllSkillId) - 1);
        SET @AllSkillId = SUBSTRING(@AllSkillId, CHARINDEX(',', @AllSkillId) + 1, LEN(@AllSkillId));

        -- Insert each skill ID into the table variable
        INSERT INTO @SkillIds (SkillId)
        VALUES (@SkillId);
    END

    -- Insert the last remaining skill ID
    --INSERT INTO @SkillIds (SkillId) VALUES (@AllSkillId);

    -- Select the individual skill IDs from the table variable
    --SELECT SkillId FROM @SkillIds;

    -- Set the total skill count
    --SET @TotalSkill = @@ROWCOUNT;

    -- Output the total skill count
    --SELECT @TotalSkill AS TotalSkill;
END;
GO
/****** Object:  StoredProcedure [dbo].[Registration]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Registration]
(
    @FirstName NVARCHAR(MAX),
    @LastName NVARCHAR(MAX),
    @Email NVARCHAR(MAX),
    @Department NVARCHAR(MAX),
    @Roll NVARCHAR(20),
    @Password NVARCHAR(20)
)
AS
BEGIN
    DECLARE @ExistingEmailCount INT;

    -- Check for existing email with a single, efficient SELECT statement
    SELECT @ExistingEmailCount = COUNT(*)
    FROM Employees
    WHERE Email = @Email;

    IF @ExistingEmailCount > 0
    BEGIN
        RAISERROR ('Email "%1" already exists.', 16, 1, @Email);  -- Informative error message
        RETURN;  -- Terminate procedure execution
    END;

    -- Insert new employee using parameterized query for security
    INSERT INTO Employees (FirstName, LastName, Email, Department, Roll, [Password], IsDelete)
    VALUES (@FirstName, @LastName, @Email, @Department, @Roll, @Password, 'N');
END;

GO
/****** Object:  StoredProcedure [dbo].[UpdateData]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[UpdateData](
	@EmployeeSkillId int,
	@EmployeeId int,
    @FirstName nvarchar(Max),
    @LastName nvarchar(Max),
    @Email nvarchar(Max),
    @Department nvarchar(Max),
    @SkillId nvarchar(Max),
	@ProficiencyLevel nvarchar(Max)
)
As
Begin
	Update
		Employees
	Set
		FirstName=@FirstName,
		LastName=@LastName,
		Email=@Email,
		Department=@Department
	where EmployeeId=@EmployeeId
	update
		EmployeesSkill
	set
		EmployeeId=@EmployeeId,
		SkillId=@SkillId,
		ProficiencyLevel=@ProficiencyLevel
	where
		EmployeeSkillId=@EmployeeSkillId
End
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployeeStatusOnSkillDelete]    Script Date: 4/12/2024 7:03:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateEmployeeStatusOnSkillDelete] (
  @EmployeeSkillId int
)
AS
BEGIN
  -- Update EmployeesSkill table with IsDelete flag
  UPDATE EmployeesSkill
  SET IsDelete = 'Y'
  WHERE EmployeeSkillId = @EmployeeSkillId;

  -- Get EmployeeId from the deleted skill record 
  DECLARE @EmployeeId int;
  SELECT @EmployeeId = EmployeeId
  FROM EmployeesSkill
  WHERE EmployeeSkillId = @EmployeeSkillId;

  -- Check if any skills remain for the employee (IsDelete != 'Y')
  IF NOT EXISTS (
    SELECT 1
    FROM EmployeesSkill
    WHERE EmployeeId = @EmployeeId
      AND IsDelete = 'N'
  )
  BEGIN
    -- Update Employees table with IsDelete flag
    UPDATE Employees
    SET IsDelete = 'Y'
    WHERE EmployeeId = @EmployeeId;
  END
END;
GO
