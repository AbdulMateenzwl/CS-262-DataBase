USE [master]
GO
/****** Object:  Database [lab2_home]    Script Date: 07/02/2023 8:41:47 pm ******/
CREATE DATABASE [lab2_home]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'lab2_home', FILENAME = N'D:\SQL2022\MSSQL16.MSSQLSERVER\MSSQL\DATA\lab2_home.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'lab2_home_log', FILENAME = N'D:\SQL2022\MSSQL16.MSSQLSERVER\MSSQL\DATA\lab2_home_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [lab2_home] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [lab2_home].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [lab2_home] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [lab2_home] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [lab2_home] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [lab2_home] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [lab2_home] SET ARITHABORT OFF 
GO
ALTER DATABASE [lab2_home] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [lab2_home] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [lab2_home] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [lab2_home] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [lab2_home] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [lab2_home] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [lab2_home] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [lab2_home] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [lab2_home] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [lab2_home] SET  ENABLE_BROKER 
GO
ALTER DATABASE [lab2_home] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [lab2_home] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [lab2_home] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [lab2_home] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [lab2_home] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [lab2_home] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [lab2_home] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [lab2_home] SET RECOVERY FULL 
GO
ALTER DATABASE [lab2_home] SET  MULTI_USER 
GO
ALTER DATABASE [lab2_home] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [lab2_home] SET DB_CHAINING OFF 
GO
ALTER DATABASE [lab2_home] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [lab2_home] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [lab2_home] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [lab2_home] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'lab2_home', N'ON'
GO
ALTER DATABASE [lab2_home] SET QUERY_STORE = ON
GO
ALTER DATABASE [lab2_home] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [lab2_home]
GO
/****** Object:  Table [dbo].[Attendence]    Script Date: 07/02/2023 8:41:47 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendence](
	[Student_Registratin_Number] [varchar](50) NULL,
	[Course_Name] [varchar](50) NULL,
	[TimeStamp] [datetime] NULL,
	[Status] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 07/02/2023 8:41:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[Course_Id] [varchar](50) NULL,
	[Course_Name] [varchar](50) NULL,
	[Student_Name] [varchar](50) NULL,
	[Teacher_Name] [varchar](50) NULL,
	[Semester] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollment]    Script Date: 07/02/2023 8:41:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollment](
	[Student_Registration_Number] [varchar](50) NULL,
	[Course_Name] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 07/02/2023 8:41:48 pm ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Registration_Number] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[Department] [varchar](50) NULL,
	[Session] [int] NULL,
	[Address] [varchar](70) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Student] ([Registration_Number], [Name], [Department], [Session], [Address]) VALUES (N'1', N'1', N'1', 1, N'Address')
INSERT [dbo].[Student] ([Registration_Number], [Name], [Department], [Session], [Address]) VALUES (N'4', N'4', N'4', 4, N'Address')
INSERT [dbo].[Student] ([Registration_Number], [Name], [Department], [Session], [Address]) VALUES (N'4', N'4', N'4', 4, N'4')
GO
USE [master]
GO
ALTER DATABASE [lab2_home] SET  READ_WRITE 
GO
