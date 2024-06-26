USE [master]
GO
/****** Object:  Database [WebAmNhac]    Script Date: 5/7/2024 13:50:12 ******/
CREATE DATABASE [WebAmNhac]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WebAmNhac', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\WebAmNhac.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WebAmNhac_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\WebAmNhac_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [WebAmNhac] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebAmNhac].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebAmNhac] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebAmNhac] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebAmNhac] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebAmNhac] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebAmNhac] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebAmNhac] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WebAmNhac] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebAmNhac] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebAmNhac] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebAmNhac] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebAmNhac] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebAmNhac] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebAmNhac] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebAmNhac] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebAmNhac] SET  ENABLE_BROKER 
GO
ALTER DATABASE [WebAmNhac] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebAmNhac] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebAmNhac] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebAmNhac] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebAmNhac] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebAmNhac] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebAmNhac] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebAmNhac] SET RECOVERY FULL 
GO
ALTER DATABASE [WebAmNhac] SET  MULTI_USER 
GO
ALTER DATABASE [WebAmNhac] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebAmNhac] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebAmNhac] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebAmNhac] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WebAmNhac] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WebAmNhac] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'WebAmNhac', N'ON'
GO
ALTER DATABASE [WebAmNhac] SET QUERY_STORE = ON
GO
ALTER DATABASE [WebAmNhac] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [WebAmNhac]
GO
/****** Object:  Table [dbo].[Artist]    Script Date: 5/7/2024 13:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artist](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Birthday] [nvarchar](30) NULL,
	[Country] [nvarchar](20) NULL,
	[Image] [nvarchar](50) NULL,
 CONSTRAINT [PK__Artist__3214EC2796A88342] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genre]    Script Date: 5/7/2024 13:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK__Genre__3214EC2733428050] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Playlist]    Script Date: 5/7/2024 13:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Playlist](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Detail] [nvarchar](max) NULL,
	[Thumbnail] [nvarchar](50) NULL,
	[UserID] [int] NULL,
	[ViewCount] [int] NULL,
	[GenreID] [int] NULL,
 CONSTRAINT [PK__Playlist__3214EC273D7200BC] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlaylistDetail]    Script Date: 5/7/2024 13:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaylistDetail](
	[PlaylistID] [int] NOT NULL,
	[SongID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Song]    Script Date: 5/7/2024 13:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Song](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ArtistID] [int] NULL,
	[Lyric] [nvarchar](max) NULL,
	[Thumbnail] [nvarchar](50) NULL,
	[Url] [nvarchar](50) NULL,
	[GenreID] [int] NOT NULL,
	[ViewCount] [int] NULL,
 CONSTRAINT [PK_Song] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 5/7/2024 13:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) NULL,
	[Email] [nvarchar](30) NULL,
	[Password] [nvarchar](20) NULL,
	[Age] [int] NULL,
	[Role] [nvarchar](20) NULL,
 CONSTRAINT [PK__User__3214EC2773957CAA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserFavourite]    Script Date: 5/7/2024 13:50:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFavourite](
	[UserID] [int] NULL,
	[PlaylistID] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Artist] ON 

INSERT [dbo].[Artist] ([ID], [Name], [Birthday], [Country], [Image]) VALUES (1, N'Tuấn Hưng', N'1978', N'Việt Nam', N'/image/artist_tuanhung.jpg')
INSERT [dbo].[Artist] ([ID], [Name], [Birthday], [Country], [Image]) VALUES (2, N'Sơn Tùng', N'1994', N'Việt Nam', N'/image/artist_sontung.jpg')
INSERT [dbo].[Artist] ([ID], [Name], [Birthday], [Country], [Image]) VALUES (3, N'Ngô Kiến Huy', N'1988', N'Việt Nam', N'/image/artist_ngokienhuy.jpg')
INSERT [dbo].[Artist] ([ID], [Name], [Birthday], [Country], [Image]) VALUES (4, N'Tăng Duy Tân', N'1995', N'Việt Nam', N'/image/artist_tangduytan.jpg')
INSERT [dbo].[Artist] ([ID], [Name], [Birthday], [Country], [Image]) VALUES (5, N'Keyo', N'1997', N'Việt Nam', N'/image/artist_keyo.jpg')
INSERT [dbo].[Artist] ([ID], [Name], [Birthday], [Country], [Image]) VALUES (6, N'Phong Max', N'1995', N'Việt Nam', N'/image/artist_phongmax.jpg')
INSERT [dbo].[Artist] ([ID], [Name], [Birthday], [Country], [Image]) VALUES (7, N'Nal', N'1997', N'Việt Nam', N'/image/artist_nal.jpg')
INSERT [dbo].[Artist] ([ID], [Name], [Birthday], [Country], [Image]) VALUES (8, N'Taylor Swift', N'1989', N'Mỹ', N'/image/artist_taylor.jpg')
INSERT [dbo].[Artist] ([ID], [Name], [Birthday], [Country], [Image]) VALUES (9, N'Post Malone', N'1995', N'Mỹ', N'/image/artist_postmalone.jpg')
SET IDENTITY_INSERT [dbo].[Artist] OFF
GO
SET IDENTITY_INSERT [dbo].[Genre] ON 

INSERT [dbo].[Genre] ([ID], [Name]) VALUES (1, N'Nhạc Pop')
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (2, N'Nhạc Rock')
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (3, N'Nhạc đồng quê')
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (4, N'Nhạc Ballad')
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (5, N'Nhạc Dance')
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (6, N'Nhạc Acoustic')
INSERT [dbo].[Genre] ([ID], [Name]) VALUES (7, N'Nhạc Rap')
SET IDENTITY_INSERT [dbo].[Genre] OFF
GO
SET IDENTITY_INSERT [dbo].[Playlist] ON 

INSERT [dbo].[Playlist] ([ID], [Name], [Detail], [Thumbnail], [UserID], [ViewCount], [GenreID]) VALUES (1, N'Chill Hits', N'Quay trở lại với những bản hit thư giãn mới và hay', N'album_chill_hits.jpg', 1, 112, 1)
INSERT [dbo].[Playlist] ([ID], [Name], [Detail], [Thumbnail], [UserID], [ViewCount], [GenreID]) VALUES (2, N'Rock Việt', N'Tất cả về cảm xúc và năng lượng đích thực của rock', N'album_rockviet.jpg', 1, 17, 1)
INSERT [dbo].[Playlist] ([ID], [Name], [Detail], [Thumbnail], [UserID], [ViewCount], [GenreID]) VALUES (3, N'Ngày Mới Nhạc Mới', N'Bắt đầu mỗi ngày với tâm trạng lạc quan', N'album_ngaymoinhacmoi.jpg', 1, 13, 2)
INSERT [dbo].[Playlist] ([ID], [Name], [Detail], [Thumbnail], [UserID], [ViewCount], [GenreID]) VALUES (4, N'Tiệc Tùng Thôi', N'Thả mình và thư giãn trong âm nhạc vui nhộn và năng động', N'album_tiectungthoi.jpg', 1, 11, 2)
INSERT [dbo].[Playlist] ([ID], [Name], [Detail], [Thumbnail], [UserID], [ViewCount], [GenreID]) VALUES (5, N'Quốc Tế Thịnh Hành', N'Sự kết hợp độc đáo của các bản nhạc quốc tế đỉnh cao', N'album_quoctethinhhanh.jpg', 2, 11, 3)
SET IDENTITY_INSERT [dbo].[Playlist] OFF
GO
INSERT [dbo].[PlaylistDetail] ([PlaylistID], [SongID]) VALUES (1, 6)
INSERT [dbo].[PlaylistDetail] ([PlaylistID], [SongID]) VALUES (2, 3)
INSERT [dbo].[PlaylistDetail] ([PlaylistID], [SongID]) VALUES (2, 4)
INSERT [dbo].[PlaylistDetail] ([PlaylistID], [SongID]) VALUES (3, 1)
INSERT [dbo].[PlaylistDetail] ([PlaylistID], [SongID]) VALUES (3, 2)
INSERT [dbo].[PlaylistDetail] ([PlaylistID], [SongID]) VALUES (4, 1)
INSERT [dbo].[PlaylistDetail] ([PlaylistID], [SongID]) VALUES (4, 4)
INSERT [dbo].[PlaylistDetail] ([PlaylistID], [SongID]) VALUES (5, 1)
GO
SET IDENTITY_INSERT [dbo].[Song] ON 

INSERT [dbo].[Song] ([ID], [Name], [ArtistID], [Lyric], [Thumbnail], [Url], [GenreID], [ViewCount]) VALUES (1, N'Gấp Đôi Yêu Thương', 1, N'Chưa có', N'/image/gapdoiyeuthuong.jpg', N'/media/gapdoiyeuthuong.mp3', 1, 1)
INSERT [dbo].[Song] ([ID], [Name], [ArtistID], [Lyric], [Thumbnail], [Url], [GenreID], [ViewCount]) VALUES (2, N'Bên Trên Tầng Lầu', 4, N'Chưa có', N'/image/bentrentanglau.jpg', N'/media/bentrentanglau.mp3', 4, 0)
INSERT [dbo].[Song] ([ID], [Name], [ArtistID], [Lyric], [Thumbnail], [Url], [GenreID], [ViewCount]) VALUES (3, N'Blank Space', 8, N'Chưa có', N'/image/blankspace.jpg', N'/media/blankspace.mp3', 1, 0)
INSERT [dbo].[Song] ([ID], [Name], [ArtistID], [Lyric], [Thumbnail], [Url], [GenreID], [ViewCount]) VALUES (4, N'Cắt Đôi Nỗi Sầu', 4, N'Chưa có', N'/image/catdoinoisau.jpg', N'/media/catdoinoisau.mp3', 5, 0)
INSERT [dbo].[Song] ([ID], [Name], [ArtistID], [Lyric], [Thumbnail], [Url], [GenreID], [ViewCount]) VALUES (5, N'Em Là Ai', 5, N'Chưa có', N'/image/emlaai.jpg', N'/media/emlaai.mp3', 5, 0)
INSERT [dbo].[Song] ([ID], [Name], [ArtistID], [Lyric], [Thumbnail], [Url], [GenreID], [ViewCount]) VALUES (6, N'Hoa Cỏ Lau', 6, N'Chưa có', N'/image/hoacolau.jpg', N'/media/hoacolau.mp3', 3, 0)
INSERT [dbo].[Song] ([ID], [Name], [ArtistID], [Lyric], [Thumbnail], [Url], [GenreID], [ViewCount]) VALUES (7, N'Ngây Thơ', 4, N'Chưa có', N'/image/ngaytho.jpg', N'/media/ngaytho.mp3', 6, 0)
INSERT [dbo].[Song] ([ID], [Name], [ArtistID], [Lyric], [Thumbnail], [Url], [GenreID], [ViewCount]) VALUES (8, N'Sunflower', 9, N'Chưa có', N'/image/sunflower.jpg', N'/media/sunflower.mp3', 5, 0)
SET IDENTITY_INSERT [dbo].[Song] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [Name], [Email], [Password], [Age], [Role]) VALUES (1, N'Various Artists', N'admin@gmail.com', N'admin', 23, N'Admin')
INSERT [dbo].[User] ([ID], [Name], [Email], [Password], [Age], [Role]) VALUES (2, N'user', N'user@gmail.com', N'user', 22, N'User')
INSERT [dbo].[User] ([ID], [Name], [Email], [Password], [Age], [Role]) VALUES (3, N'user1', N'user1@gmail.com', N'user1', 20, N'User')
INSERT [dbo].[User] ([ID], [Name], [Email], [Password], [Age], [Role]) VALUES (4, N'User 1', N'1', N'1', 10, N'User')
INSERT [dbo].[User] ([ID], [Name], [Email], [Password], [Age], [Role]) VALUES (5, N'User 2', N'2', N'2', 18, N'User')
INSERT [dbo].[User] ([ID], [Name], [Email], [Password], [Age], [Role]) VALUES (1005, N'User 3', N'3', N'1', 18, N'User')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
INSERT [dbo].[UserFavourite] ([UserID], [PlaylistID]) VALUES (1, 1)
INSERT [dbo].[UserFavourite] ([UserID], [PlaylistID]) VALUES (1, 2)
INSERT [dbo].[UserFavourite] ([UserID], [PlaylistID]) VALUES (4, 4)
GO
ALTER TABLE [dbo].[Playlist] ADD  CONSTRAINT [DF__Playlist__ViewCo__398D8EEE]  DEFAULT ((0)) FOR [ViewCount]
GO
ALTER TABLE [dbo].[Song] ADD  CONSTRAINT [DF__Song__ViewCount__412EB0B6]  DEFAULT ((0)) FOR [ViewCount]
GO
ALTER TABLE [dbo].[Playlist]  WITH CHECK ADD  CONSTRAINT [FK_Playlist_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[Playlist] CHECK CONSTRAINT [FK_Playlist_User]
GO
ALTER TABLE [dbo].[PlaylistDetail]  WITH CHECK ADD  CONSTRAINT [FK_PlaylistDetail_Playlist] FOREIGN KEY([PlaylistID])
REFERENCES [dbo].[Playlist] ([ID])
GO
ALTER TABLE [dbo].[PlaylistDetail] CHECK CONSTRAINT [FK_PlaylistDetail_Playlist]
GO
ALTER TABLE [dbo].[PlaylistDetail]  WITH CHECK ADD  CONSTRAINT [FK_PlaylistDetail_Song] FOREIGN KEY([SongID])
REFERENCES [dbo].[Song] ([ID])
GO
ALTER TABLE [dbo].[PlaylistDetail] CHECK CONSTRAINT [FK_PlaylistDetail_Song]
GO
ALTER TABLE [dbo].[Song]  WITH CHECK ADD  CONSTRAINT [FK_Song_Artist] FOREIGN KEY([ArtistID])
REFERENCES [dbo].[Artist] ([ID])
GO
ALTER TABLE [dbo].[Song] CHECK CONSTRAINT [FK_Song_Artist]
GO
ALTER TABLE [dbo].[Song]  WITH CHECK ADD  CONSTRAINT [FK_Song_Genre] FOREIGN KEY([GenreID])
REFERENCES [dbo].[Genre] ([ID])
GO
ALTER TABLE [dbo].[Song] CHECK CONSTRAINT [FK_Song_Genre]
GO
USE [master]
GO
ALTER DATABASE [WebAmNhac] SET  READ_WRITE 
GO
