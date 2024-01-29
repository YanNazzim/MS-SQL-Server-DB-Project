USE [master]
GO
/****** Object:  Database [WBank]    Script Date: 12/11/2022 5:20:00 PM ******/
CREATE DATABASE [WBank]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WBank', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\WBank.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WBank_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\WBank_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [WBank] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WBank].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WBank] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WBank] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WBank] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WBank] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WBank] SET ARITHABORT OFF 
GO
ALTER DATABASE [WBank] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WBank] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WBank] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WBank] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WBank] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WBank] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WBank] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WBank] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WBank] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WBank] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WBank] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WBank] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WBank] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WBank] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WBank] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WBank] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WBank] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WBank] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WBank] SET  MULTI_USER 
GO
ALTER DATABASE [WBank] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WBank] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WBank] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WBank] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WBank] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WBank] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [WBank] SET QUERY_STORE = OFF
GO
USE [WBank]
GO
/****** Object:  User [CIS435L_User1]    Script Date: 12/11/2022 5:20:01 PM ******/
CREATE USER [CIS435L_User1] FOR LOGIN [CIS435L_User1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [CIS435L_Project]    Script Date: 12/11/2022 5:20:01 PM ******/
CREATE ROLE [CIS435L_Project]
GO
ALTER ROLE [CIS435L_Project] ADD MEMBER [CIS435L_User1]
GO
ALTER ROLE [db_datareader] ADD MEMBER [CIS435L_User1]
GO
ALTER ROLE [db_datareader] ADD MEMBER [CIS435L_Project]
GO
/****** Object:  Table [dbo].[AccountType]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountType](
	[AccountTypeID] [int] NOT NULL,
	[AccountType] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] NOT NULL,
	[DateCreated] [varchar](20) NULL,
	[AccountNumber] [int] NULL,
	[AccountTypeID] [int] NOT NULL,
	[FName] [varchar](15) NULL,
	[LName] [varchar](15) NULL,
	[Gender] [varchar](1) NULL,
	[Address] [varchar](15) NULL,
	[City] [varchar](15) NULL,
	[State] [varchar](15) NULL,
	[PhoneNumber] [varchar](10) NULL,
	[EmailAddress] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Balance]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Name: Yan Gonzalez
--Question 2

CREATE FUNCTION [dbo].[fn_Balance] (@CID int)
RETURNS Table

RETURN
	(SELECT c.CustomerID, a.AccountType, a.AccountTypeID
	, Gender AS Balance FROM Customers c
	JOIN AccountType a ON c.AccountTypeID = a.AccountTypeID
	WHERE c.CustomerID = @CID)

-- had to subsitute balance for another column as i didnt have 
-- a balance column but they probably would have been NULL too
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Balance1]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Name: Yan Gonzalez
--Question 4

CREATE FUNCTION [dbo].[fn_Balance1]()
RETURNS Table

RETURN
	(SELECT c.CustomerID, c.FName + ' ' + c.LName AS [Full Name], c.AccountNumber, a.AccountType
	, Gender AS Balance FROM Customers c
	JOIN AccountType a ON c.AccountTypeID = a.AccountTypeID)

GO
/****** Object:  View [dbo].[vw_customers]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Name: Yan Gonzalez
--Question 4
CREATE VIEW [dbo].[vw_customers] AS
SELECT * FROM fn_balance1()

GO
/****** Object:  Table [dbo].[CheckCashing]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckCashing](
	[CheckCashingID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[CheckCashingDate] [date] NULL,
	[CheckCashingAmount] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[CheckCashingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Deposits]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Deposits](
	[DepositID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[DepositDate] [varchar](15) NOT NULL,
	[DepositAmount] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepositID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] NOT NULL,
	[EmployeeNumber] [int] NULL,
	[FirstName] [varchar](15) NULL,
	[LastName] [varchar](15) NULL,
	[Title] [varchar](10) NULL,
	[CanCreateNewAccount] [varchar](1) NULL,
	[HourlySalary] [money] NULL,
	[Address] [varchar](15) NULL,
	[City] [varchar](15) NULL,
	[State] [varchar](15) NULL,
	[ZipCode] [int] NULL,
	[EmailAddress] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[LocationID] [int] NOT NULL,
	[LocationCode] [int] NULL,
	[Address] [varchar](30) NULL,
	[City] [varchar](20) NULL,
	[State] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Withdrawals]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Withdrawals](
	[WithdrawalID] [int] NOT NULL,
	[LocationID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[WithdrawalDate] [date] NULL,
	[WithdrawalAmount] [money] NULL,
	[WithdrawalSuccesful] [varchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[WithdrawalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CheckCashing]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[CheckCashing]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[CheckCashing]  WITH CHECK ADD FOREIGN KEY([LocationID])
REFERENCES [dbo].[Locations] ([LocationID])
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD FOREIGN KEY([AccountTypeID])
REFERENCES [dbo].[AccountType] ([AccountTypeID])
GO
ALTER TABLE [dbo].[Deposits]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Deposits]  WITH CHECK ADD FOREIGN KEY([LocationID])
REFERENCES [dbo].[Locations] ([LocationID])
GO
ALTER TABLE [dbo].[Withdrawals]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Withdrawals]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employee] ([EmployeeID])
GO
ALTER TABLE [dbo].[Withdrawals]  WITH CHECK ADD FOREIGN KEY([LocationID])
REFERENCES [dbo].[Locations] ([LocationID])
GO
/****** Object:  StoredProcedure [dbo].[sp_all_customers]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Name: Yan Gonzalez
--Question 4
CREATE PROC [dbo].[sp_all_customers] AS
SELECT * FROM vw_customers

GO
/****** Object:  StoredProcedure [dbo].[sp_customer]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Name: Yan Gonzalez
--Question 5
CREATE PROC [dbo].[sp_customer]
@CID int
AS
(SELECT FName + ' ' + LName AS [Customer Full Name]
, e.FirstName + ' ' + e.LastName AS [Employee Full Name], d.LocationID
, 'DEPOSIT' AS [Transaction Type], d.DepositAmount, w.WithdrawalAmount FROM Customers c
JOIN Deposits d ON d.CustomerID = c.CustomerID
JOIN Employee e ON e.EmployeeID = d.EmployeeID
JOIN Withdrawals w ON w.EmployeeID = e.EmployeeID
WHERE c.CustomerID = @CID)

GO
/****** Object:  StoredProcedure [dbo].[sp_customer1]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Name: Yan Gonzalez
--Question 6
CREATE PROC [dbo].[sp_customer1]
@CID int
AS
(SELECT c.CustomerID, FName + ' ' + LName AS [Customer Full Name]
, e.FirstName + ' ' + e.LastName AS [Employee Full Name], d.LocationID
, 'DEPOSIT' AS [Transaction Type], d.DepositAmount, w.WithdrawalAmount FROM Customers c
JOIN Deposits d ON d.CustomerID = c.CustomerID
JOIN Employee e ON e.EmployeeID = d.EmployeeID
JOIN Withdrawals w ON w.EmployeeID = e.EmployeeID
WHERE c.CustomerID = @CID)

--EXEC sp_customer 

GO
/****** Object:  StoredProcedure [dbo].[sp_Employees]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Name: Yan Gonzalez
--Question 7
CREATE PROC [dbo].[sp_Employees]
AS
(SELECT FirstName + ' ' + LastName AS FullName
, EmployeeID FROM Employee)
GO
/****** Object:  StoredProcedure [dbo].[sp_Location]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Name: Yan Gonzalez
--Question 7
create proc [dbo].[sp_Location]
as

SELECT LocationID, LocationCode FROM Locations
GO
/****** Object:  StoredProcedure [dbo].[sp_Locations]    Script Date: 12/11/2022 5:20:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Name: Yan Gonzalez
--Question 7
CREATE PROC [dbo].[sp_Locations]
AS
(SELECT LocationID, LocationCode FROM Locations);

EXEC sp_Locations
GO
USE [master]
GO
ALTER DATABASE [WBank] SET  READ_WRITE 
GO
