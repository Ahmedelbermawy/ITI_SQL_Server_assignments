USE [master]
GO
/****** Object:  Database [ITI_new]    Script Date: 7/16/2023 1:00:45 PM ******/
CREATE DATABASE [ITI_new]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ITI', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ITI_new.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ITI_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ITI_new_log.ldf' , SIZE = 7616KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ITI_new] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ITI_new].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ITI_new] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ITI_new] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ITI_new] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ITI_new] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ITI_new] SET ARITHABORT OFF 
GO
ALTER DATABASE [ITI_new] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ITI_new] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ITI_new] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ITI_new] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ITI_new] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ITI_new] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ITI_new] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ITI_new] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ITI_new] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ITI_new] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ITI_new] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ITI_new] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ITI_new] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ITI_new] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ITI_new] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ITI_new] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ITI_new] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ITI_new] SET RECOVERY FULL 
GO
ALTER DATABASE [ITI_new] SET  MULTI_USER 
GO
ALTER DATABASE [ITI_new] SET PAGE_VERIFY NONE  
GO
ALTER DATABASE [ITI_new] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ITI_new] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ITI_new] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ITI_new] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ITI_new] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ITI_new', N'ON'
GO
ALTER DATABASE [ITI_new] SET QUERY_STORE = OFF
GO
USE [ITI_new]
GO
/****** Object:  User [koko]    Script Date: 7/16/2023 1:00:45 PM ******/
CREATE USER [koko] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [iti]    Script Date: 7/16/2023 1:00:45 PM ******/
CREATE USER [iti] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Schema [iti]    Script Date: 7/16/2023 1:00:45 PM ******/
CREATE SCHEMA [iti]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 7/16/2023 1:00:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[Crs_Id] [int] NOT NULL,
	[Crs_Name] [nvarchar](50) NULL,
	[Crs_Duration] [int] NULL,
	[Top_Id] [int] NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[Crs_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 7/16/2023 1:00:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[Dept_Id] [int] NOT NULL,
	[Dept_Name] [nvarchar](50) NULL,
	[Dept_Desc] [nvarchar](100) NULL,
	[Dept_Location] [nvarchar](50) NULL,
	[Dept_Manager] [int] NULL,
	[Manager_hiredate] [date] NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Dept_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ins_Course]    Script Date: 7/16/2023 1:00:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ins_Course](
	[Ins_Id] [int] NOT NULL,
	[Crs_Id] [int] NOT NULL,
	[Evaluation] [nvarchar](50) NULL,
 CONSTRAINT [PK_Ins_Course] PRIMARY KEY CLUSTERED 
(
	[Ins_Id] ASC,
	[Crs_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 7/16/2023 1:00:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[Ins_Id] [int] NOT NULL,
	[Ins_Name] [nvarchar](50) NULL,
	[Ins_Degree] [nvarchar](50) NULL,
	[Salary] [money] NULL,
	[Dept_Id] [int] NULL,
 CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED 
(
	[Ins_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stud_Course]    Script Date: 7/16/2023 1:00:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stud_Course](
	[Crs_Id] [int] NOT NULL,
	[St_Id] [int] NOT NULL,
	[Grade] [int] NULL,
 CONSTRAINT [PK_Stud_Course] PRIMARY KEY CLUSTERED 
(
	[Crs_Id] ASC,
	[St_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 7/16/2023 1:00:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[St_Id] [int] NOT NULL,
	[St_Fname] [nvarchar](50) NULL,
	[St_Lname] [nchar](10) NULL,
	[St_Address] [nvarchar](100) NULL,
	[St_Age] [int] NULL,
	[Dept_Id] [int] NULL,
	[St_super] [int] NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[St_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Topic]    Script Date: 7/16/2023 1:00:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topic](
	[Top_Id] [int] NOT NULL,
	[Top_Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Topic] PRIMARY KEY CLUSTERED 
(
	[Top_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Course] ([Crs_Id], [Crs_Name], [Crs_Duration], [Top_Id]) VALUES (100, N'HTML', 20, 3)
INSERT [dbo].[Course] ([Crs_Id], [Crs_Name], [Crs_Duration], [Top_Id]) VALUES (200, N'C Progamming', 60, 1)
INSERT [dbo].[Course] ([Crs_Id], [Crs_Name], [Crs_Duration], [Top_Id]) VALUES (300, N'OOP', 80, 1)
INSERT [dbo].[Course] ([Crs_Id], [Crs_Name], [Crs_Duration], [Top_Id]) VALUES (400, N'Unix', 50, 4)
INSERT [dbo].[Course] ([Crs_Id], [Crs_Name], [Crs_Duration], [Top_Id]) VALUES (500, N'SQL Server', 60, 2)
INSERT [dbo].[Course] ([Crs_Id], [Crs_Name], [Crs_Duration], [Top_Id]) VALUES (600, N'C#', 80, 1)
INSERT [dbo].[Course] ([Crs_Id], [Crs_Name], [Crs_Duration], [Top_Id]) VALUES (700, N'Web Service', 20, 3)
INSERT [dbo].[Course] ([Crs_Id], [Crs_Name], [Crs_Duration], [Top_Id]) VALUES (800, N'Java', 60, 1)
INSERT [dbo].[Course] ([Crs_Id], [Crs_Name], [Crs_Duration], [Top_Id]) VALUES (900, N'Oracle', 50, 2)
INSERT [dbo].[Course] ([Crs_Id], [Crs_Name], [Crs_Duration], [Top_Id]) VALUES (1000, N'ASP.Net', 60, 3)
INSERT [dbo].[Course] ([Crs_Id], [Crs_Name], [Crs_Duration], [Top_Id]) VALUES (1100, N'Win_XP', 20, 4)
INSERT [dbo].[Course] ([Crs_Id], [Crs_Name], [Crs_Duration], [Top_Id]) VALUES (1200, N'Photoshop', 30, 5)
GO
INSERT [dbo].[Department] ([Dept_Id], [Dept_Name], [Dept_Desc], [Dept_Location], [Dept_Manager], [Manager_hiredate]) VALUES (10, N'SD', N'System Development', N'Cairo', 1, CAST(N'2000-01-01' AS Date))
INSERT [dbo].[Department] ([Dept_Id], [Dept_Name], [Dept_Desc], [Dept_Location], [Dept_Manager], [Manager_hiredate]) VALUES (20, N'EL', N'E-Learning', N'Mansoura', 2, CAST(N'2002-10-02' AS Date))
INSERT [dbo].[Department] ([Dept_Id], [Dept_Name], [Dept_Desc], [Dept_Location], [Dept_Manager], [Manager_hiredate]) VALUES (30, N'Java', N'Java', N'Cairo', 6, CAST(N'2008-05-04' AS Date))
INSERT [dbo].[Department] ([Dept_Id], [Dept_Name], [Dept_Desc], [Dept_Location], [Dept_Manager], [Manager_hiredate]) VALUES (40, N'MM', N'Multimedia', N'Alex', 3, CAST(N'2009-01-01' AS Date))
INSERT [dbo].[Department] ([Dept_Id], [Dept_Name], [Dept_Desc], [Dept_Location], [Dept_Manager], [Manager_hiredate]) VALUES (50, N'Unix', N'Unix', N'Alex', 8, CAST(N'2003-01-23' AS Date))
INSERT [dbo].[Department] ([Dept_Id], [Dept_Name], [Dept_Desc], [Dept_Location], [Dept_Manager], [Manager_hiredate]) VALUES (60, N'NC', N'Network', N'Cairo', 4, CAST(N'2005-11-01' AS Date))
INSERT [dbo].[Department] ([Dept_Id], [Dept_Name], [Dept_Desc], [Dept_Location], [Dept_Manager], [Manager_hiredate]) VALUES (70, N'EB', N'E-Business', N'Alex', 7, CAST(N'2009-05-20' AS Date))
GO
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (1, 100, N'Good')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (1, 200, N'Good')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (1, 300, N'Good')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (2, 400, N'VGood')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (2, 500, N'Good')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (3, 100, N'Distinct')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (3, 600, N'VGood')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (3, 700, N'Good')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (4, 200, N'Good')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (4, 300, N'Good')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (5, 800, N'Good')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (5, 900, N'VGood')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (6, 500, NULL)
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (6, 600, NULL)
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (6, 900, NULL)
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (6, 1000, N'Distinct')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (6, 1100, NULL)
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (7, 800, NULL)
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (7, 900, N'Distinct')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (8, 100, N'VGood')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (9, 200, N'Distinct')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (10, 300, N'VGood')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (11, 800, N'VGood')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (11, 900, N'Distinct')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (12, 1000, N'Distinct')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (12, 1100, N'Good')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (13, 300, N'Distinct')
INSERT [dbo].[Ins_Course] ([Ins_Id], [Crs_Id], [Evaluation]) VALUES (13, 400, N'Distinct')
GO
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (1, N'Ahmed', N'Master', 3000.0000, 10)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (2, N'Hany', N'Master', 2000.0000, 10)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (3, N'Reham', N'Master', 10000.0000, 10)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (4, N'Yasmin', N'PHD', 2500.0000, 10)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (5, N'Amany', N'PHD', 4000.0000, 10)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (6, N'Eman', N'Master', 3500.0000, 10)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (7, N'Saly', NULL, 6000.0000, 10)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (8, N'Amr', NULL, 5000.0000, 30)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (9, N'Hussien', NULL, 5000.0000, 50)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (10, N'Khalid', NULL, 4000.0000, 30)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (11, N'Salah', NULL, 3000.0000, 70)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (12, N'Adel', NULL, 2500.0000, 70)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (13, N'Fakry', NULL, 8000.0000, 20)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (14, N'Amena', NULL, 5500.0000, 20)
INSERT [dbo].[Instructor] ([Ins_Id], [Ins_Name], [Ins_Degree], [Salary], [Dept_Id]) VALUES (15, N'Ghada', NULL, 6000.0000, 40)
GO
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (100, 1, 100)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (100, 2, 90)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (100, 3, 80)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (100, 4, 70)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (100, 5, 100)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (100, 6, 90)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (200, 1, 90)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (200, 2, 90)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (200, 3, 80)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (200, 4, 80)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (200, 5, 80)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (200, 7, 60)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (200, 8, 60)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (200, 9, 60)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (300, 5, 70)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (300, 6, 70)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (300, 7, 70)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (300, 10, 100)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (400, 1, 100)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (400, 2, 100)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (400, 3, 100)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (400, 4, 90)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (400, 5, 90)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (500, 6, 80)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (600, 7, 80)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (700, 8, 70)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (800, 1, 70)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (800, 9, 90)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (800, 10, 90)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (900, 2, 80)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (900, 3, 70)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (900, 4, 70)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (900, 5, 60)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (1000, 1, 90)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (1000, 2, 60)
INSERT [dbo].[Stud_Course] ([Crs_Id], [St_Id], [Grade]) VALUES (1000, 3, 60)
GO
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (1, N'Ahmed', N'Hassan    ', N'Cairo', 20, 10, NULL)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (2, N'Amr', N'Magdy     ', N'Cairo', 21, 10, 1)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (3, N'Mona', N'Saleh     ', N'Cairo', 22, 10, 1)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (4, N'Ahmed', N'Mohamed   ', N'Alex', 23, 10, 1)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (5, N'Khalid', N'Moahmed   ', N'Alex', 24, 10, 1)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (6, N'Heba', N'Farouk    ', N'Mansoura', 25, 20, NULL)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (7, N'Ali', N'Hussien   ', N'Cairo', 25, 20, 6)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (8, N'Mohamed', N'Fars      ', N'Alex', 28, 20, 6)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (9, N'Saly', N'Ahmed     ', N'Mansoura', 24, 30, NULL)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (10, N'Fady', N'Ali       ', N'Alex', 24, 30, 9)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (11, N'Marwa', N'Ahmed     ', N'Cairo', 24, 30, 9)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (12, N'Noha', N'Omar      ', N'Cairo', 21, 40, NULL)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (13, N'Said', NULL, NULL, NULL, 40, 12)
INSERT [dbo].[Student] ([St_Id], [St_Fname], [St_Lname], [St_Address], [St_Age], [Dept_Id], [St_super]) VALUES (14, NULL, N'Saleh     ', N'Tanta', 30, NULL, NULL)
GO
INSERT [dbo].[Topic] ([Top_Id], [Top_Name]) VALUES (1, N'Programming')
INSERT [dbo].[Topic] ([Top_Id], [Top_Name]) VALUES (2, N'DB')
INSERT [dbo].[Topic] ([Top_Id], [Top_Name]) VALUES (3, N'Web')
INSERT [dbo].[Topic] ([Top_Id], [Top_Name]) VALUES (4, N'Operating System')
INSERT [dbo].[Topic] ([Top_Id], [Top_Name]) VALUES (5, N'Design')
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Topic] FOREIGN KEY([Top_Id])
REFERENCES [dbo].[Topic] ([Top_Id])
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Topic]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Instructor_manger] FOREIGN KEY([Dept_Manager])
REFERENCES [dbo].[Instructor] ([Ins_Id])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_Instructor_manger]
GO
ALTER TABLE [dbo].[Ins_Course]  WITH CHECK ADD  CONSTRAINT [FK_Ins_Course_Course] FOREIGN KEY([Crs_Id])
REFERENCES [dbo].[Course] ([Crs_Id])
GO
ALTER TABLE [dbo].[Ins_Course] CHECK CONSTRAINT [FK_Ins_Course_Course]
GO
ALTER TABLE [dbo].[Ins_Course]  WITH CHECK ADD  CONSTRAINT [FK_Ins_Course_Instructor] FOREIGN KEY([Ins_Id])
REFERENCES [dbo].[Instructor] ([Ins_Id])
GO
ALTER TABLE [dbo].[Ins_Course] CHECK CONSTRAINT [FK_Ins_Course_Instructor]
GO
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Dempartment] FOREIGN KEY([Dept_Id])
REFERENCES [dbo].[Department] ([Dept_Id])
GO
ALTER TABLE [dbo].[Instructor] CHECK CONSTRAINT [FK_Instructor_Dempartment]
GO
ALTER TABLE [dbo].[Stud_Course]  WITH CHECK ADD  CONSTRAINT [FK_Stud_Course_Course] FOREIGN KEY([Crs_Id])
REFERENCES [dbo].[Course] ([Crs_Id])
GO
ALTER TABLE [dbo].[Stud_Course] CHECK CONSTRAINT [FK_Stud_Course_Course]
GO
ALTER TABLE [dbo].[Stud_Course]  WITH CHECK ADD  CONSTRAINT [FK_Stud_Course_Student] FOREIGN KEY([St_Id])
REFERENCES [dbo].[Student] ([St_Id])
GO
ALTER TABLE [dbo].[Stud_Course] CHECK CONSTRAINT [FK_Stud_Course_Student]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Department] FOREIGN KEY([Dept_Id])
REFERENCES [dbo].[Department] ([Dept_Id])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Department]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Student] FOREIGN KEY([St_super])
REFERENCES [dbo].[Student] ([St_Id])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Student]
GO
USE [master]
GO
ALTER DATABASE [ITI_new] SET  READ_WRITE 
GO
