USE [master]
GO
/****** Object:  Database [MultiTenancy]    Script Date: 11/09/2014 23:23:48 ******/
CREATE DATABASE [MultiTenancy] ON  PRIMARY 
( NAME = N'MultiTenancy', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLSERVER2K8R2\MSSQL\DATA\MultiTenancy.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MultiTenancy_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLSERVER2K8R2\MSSQL\DATA\MultiTenancy_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MultiTenancy] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MultiTenancy].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MultiTenancy] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [MultiTenancy] SET ANSI_NULLS OFF
GO
ALTER DATABASE [MultiTenancy] SET ANSI_PADDING OFF
GO
ALTER DATABASE [MultiTenancy] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [MultiTenancy] SET ARITHABORT OFF
GO
ALTER DATABASE [MultiTenancy] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [MultiTenancy] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [MultiTenancy] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [MultiTenancy] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [MultiTenancy] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [MultiTenancy] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [MultiTenancy] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [MultiTenancy] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [MultiTenancy] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [MultiTenancy] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [MultiTenancy] SET  DISABLE_BROKER
GO
ALTER DATABASE [MultiTenancy] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [MultiTenancy] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [MultiTenancy] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [MultiTenancy] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [MultiTenancy] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [MultiTenancy] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [MultiTenancy] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [MultiTenancy] SET  READ_WRITE
GO
ALTER DATABASE [MultiTenancy] SET RECOVERY FULL
GO
ALTER DATABASE [MultiTenancy] SET  MULTI_USER
GO
ALTER DATABASE [MultiTenancy] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [MultiTenancy] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'MultiTenancy', N'ON'
GO
USE [MultiTenancy]
GO
/****** Object:  User [ort]    Script Date: 11/09/2014 23:23:48 ******/
CREATE USER [ort] FOR LOGIN [ort] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Schema [User]    Script Date: 11/09/2014 23:23:48 ******/
CREATE SCHEMA [User] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [superman]    Script Date: 11/09/2014 23:23:48 ******/
CREATE SCHEMA [superman] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [Ronaldo]    Script Date: 11/09/2014 23:23:48 ******/
CREATE SCHEMA [Ronaldo] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [dunglp]    Script Date: 11/09/2014 23:23:48 ******/
CREATE SCHEMA [dunglp] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [bipro13389]    Script Date: 11/09/2014 23:23:48 ******/
CREATE SCHEMA [bipro13389] AUTHORIZATION [dbo]
GO
/****** Object:  Schema [billgates]    Script Date: 11/09/2014 23:23:48 ******/
CREATE SCHEMA [billgates] AUTHORIZATION [dbo]
GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 11/09/2014 23:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 11/09/2014 23:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_OAuthMembership](
	[Provider] [nvarchar](30) NOT NULL,
	[ProviderUserId] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Provider] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 11/09/2014 23:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL,
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (3, CAST(0x0000A3DD00C0E3C7 AS DateTime), NULL, 1, NULL, 0, N'AHw8n8oNkiwhEMXF8iz3IYRyEKQhHIhdzwC1QhrhUUYVOaA7kAWtDgqHKOcuGaoM/g==', CAST(0x0000A3DD00C0E3C7 AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (4, CAST(0x0000A3DD011FAE6B AS DateTime), NULL, 1, NULL, 0, N'ADsvOVDdIVJoLfZJnpB2Un/H8Uf8MmQ0DveV95DBQNidD+KKFZu8MV+/1OfsS74eaw==', CAST(0x0000A3DD011FAE6B AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (5, CAST(0x0000A3DD01451526 AS DateTime), NULL, 1, NULL, 0, N'AM3zHgn7Bq8CD0hd8VoT6TTAZWTGByFpbAJnMefxJid33d4Wa2/wndSye0HD0Gwb2g==', CAST(0x0000A3DD01451526 AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (6, CAST(0x0000A3DD014AC618 AS DateTime), NULL, 1, NULL, 0, N'APVodnDu7K6lcXNuhviuqPWhQjAZez3lGSIkdOy2oDuQFuCeKbn8kjFJ/5qCxOeOMA==', CAST(0x0000A3DD014AC618 AS DateTime), N'', NULL, NULL)
INSERT [dbo].[webpages_Membership] ([UserId], [CreateDate], [ConfirmationToken], [IsConfirmed], [LastPasswordFailureDate], [PasswordFailuresSinceLastSuccess], [Password], [PasswordChangedDate], [PasswordSalt], [PasswordVerificationToken], [PasswordVerificationTokenExpirationDate]) VALUES (7, CAST(0x0000A3DE000B3FA8 AS DateTime), NULL, 1, NULL, 0, N'APpdBsHTmWI27h+NjlZ8bNkT9rq3G6tVPvR0fXHLg/gs5XdwNJ137MCDlIPqDbiW2g==', CAST(0x0000A3DE000B3FA8 AS DateTime), N'', NULL, NULL)
/****** Object:  Table [dbo].[Users]    Script Date: 11/09/2014 23:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[TenantID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[DisplayName] [nvarchar](50) NOT NULL,
	[Country] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[TenantID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Users] ON
INSERT [dbo].[Users] ([TenantID], [UserName], [DisplayName], [Country]) VALUES (3, N'dunglp', N'Dung Le', N'Philipines')
INSERT [dbo].[Users] ([TenantID], [UserName], [DisplayName], [Country]) VALUES (4, N'ronaldo', N'Ronaldo', N'Ronaldo')
INSERT [dbo].[Users] ([TenantID], [UserName], [DisplayName], [Country]) VALUES (5, N'Beckham', N'David Beckham', N'United Kingdom')
INSERT [dbo].[Users] ([TenantID], [UserName], [DisplayName], [Country]) VALUES (6, N'rooney', N'Wayne Rooney', N'Great Britain')
INSERT [dbo].[Users] ([TenantID], [UserName], [DisplayName], [Country]) VALUES (7, N'bipro13389', N'Bi Pro', N'cuba')
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  Table [superman].[User]    Script Date: 11/09/2014 23:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [superman].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[UserName] [nvarchar](max) NULL,
	[DisplayName] [nvarchar](max) NULL,
	[Country] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [superman].[User] ON
INSERT [superman].[User] ([UserID], [Password], [UserName], [DisplayName], [Country]) VALUES (1, N'dunglp', N'superman', N'Clark Kent', N'United Kingdom')
SET IDENTITY_INSERT [superman].[User] OFF
/****** Object:  Table [Ronaldo].[User]    Script Date: 11/09/2014 23:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Ronaldo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[UserName] [nvarchar](max) NULL,
	[DisplayName] [nvarchar](max) NULL,
	[Country] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [Ronaldo].[User] ON
INSERT [Ronaldo].[User] ([UserID], [Password], [UserName], [DisplayName], [Country]) VALUES (1, N'dunglp', N'Ronaldo', N'Ronaldo', N'Portugal')
SET IDENTITY_INSERT [Ronaldo].[User] OFF
/****** Object:  Table [dunglp].[User]    Script Date: 11/09/2014 23:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dunglp].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[UserName] [nvarchar](max) NULL,
	[DisplayName] [nvarchar](max) NULL,
	[Country] [nvarchar](max) NULL,
 CONSTRAINT [PK_dunglp.User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dunglp].[User] ON
INSERT [dunglp].[User] ([UserID], [Password], [UserName], [DisplayName], [Country]) VALUES (1, N'dunglp', N'dunglp', N'Dung Le', N'Vietnam')
SET IDENTITY_INSERT [dunglp].[User] OFF
/****** Object:  Table [bipro13389].[User]    Script Date: 11/09/2014 23:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bipro13389].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[UserName] [nvarchar](max) NULL,
	[DisplayName] [nvarchar](max) NULL,
	[Country] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [bipro13389].[User] ON
INSERT [bipro13389].[User] ([UserID], [Password], [UserName], [DisplayName], [Country]) VALUES (1, N'dunglp', N'bipro13389', N'Bi Pro', N'vietnam')
SET IDENTITY_INSERT [bipro13389].[User] OFF
/****** Object:  Table [billgates].[User]    Script Date: 11/09/2014 23:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [billgates].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Password] [nvarchar](max) NULL,
	[UserName] [nvarchar](max) NULL,
	[DisplayName] [nvarchar](max) NULL,
	[Country] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [billgates].[User] ON
INSERT [billgates].[User] ([UserID], [Password], [UserName], [DisplayName], [Country]) VALUES (1, N'dunglp', N'billgates', N'Bill Gates', N'USA')
SET IDENTITY_INSERT [billgates].[User] OFF
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 11/09/2014 23:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_UsersInRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Default [DF__webpages___IsCon__04E4BC85]    Script Date: 11/09/2014 23:23:48 ******/
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
/****** Object:  Default [DF__webpages___Passw__05D8E0BE]    Script Date: 11/09/2014 23:23:48 ******/
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
/****** Object:  ForeignKey [fk_RoleId]    Script Date: 11/09/2014 23:23:48 ******/
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
/****** Object:  ForeignKey [fk_UserId]    Script Date: 11/09/2014 23:23:48 ******/
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([TenantID])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
