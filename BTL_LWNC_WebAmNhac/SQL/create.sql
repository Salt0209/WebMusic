USE [master]
GO
/****** Object:  Database [WebAmNhac]    Script Date: 4/27/2024 00:32:39 ******/
CREATE DATABASE [WebAmNhac]
GO
USE [WebAmNhac]
GO
/****** Object:  Table [dbo].[Artist]    Script Date: 4/27/2024 00:32:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artist](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](30) NULL,
	[Birthday] [nchar](10) NULL,
	[Country] [nchar](20) NULL,
	[Image] [nchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genre]    Script Date: 4/27/2024 00:32:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Playlist]    Script Date: 4/27/2024 00:32:39 ******/
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
/****** Object:  Table [dbo].[PlaylistDetail]    Script Date: 4/27/2024 00:32:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaylistDetail](
	[PlaylistID] [int] NOT NULL,
	[SongID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Song]    Script Date: 4/27/2024 00:32:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Song](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](30) NULL,
	[ArtistID] [int] NULL,
	[Lyric] [nchar](500) NULL,
	[Thumbnail] [nchar](50) NULL,
	[Url] [nchar](50) NULL,
	[GenreID] [int] NOT NULL,
	[ViewCount] [int] NULL,
 CONSTRAINT [PK_Song] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 4/27/2024 00:32:39 ******/
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
	[Role] [nvarchar](50) NULL,
 CONSTRAINT [PK__User__3214EC2773957CAA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserFavourite]    Script Date: 4/27/2024 00:32:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFavourite](
	[UserID] [int] NULL,
	[PlaylistID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Playlist] ADD  CONSTRAINT [DF__Playlist__ViewCo__398D8EEE]  DEFAULT ((0)) FOR [ViewCount]
GO
ALTER TABLE [dbo].[Song] ADD  DEFAULT ((0)) FOR [ViewCount]
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
