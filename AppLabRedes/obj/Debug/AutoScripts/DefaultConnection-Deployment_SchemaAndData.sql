SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ContextKey] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Name] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ClaimType] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ClaimValue] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProviderKey] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserId] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RoleId] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Email] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityStamp] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventLogger](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Text] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[class] [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NotSeen] [bit] NULL,
	[datetime] [datetime] NULL,
	[note] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[hasNote] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ping](
	[Id] [int] NOT NULL,
	[routerOn] [bit] NULL,
	[pingTime] [real] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table](
	[Id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VPNUsers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[usr] [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[pwd] [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[email] [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[initDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VPNUsersTemp](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[usr] [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[pwd] [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[email] [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[initDate] [datetime] NULL,
	[endDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'201503261710253_InitialCreate', N'AppLabRedes.Models.ApplicationDbContext', 0x1F8B0800000000000400DD5CDB6EDC36107D2FD07F10F4D416CECA9726488DDD04EEDA6E8DFA86AC13F42DE04ADCB510895225CAB151F4CBFAD04FEA2F742851375E74D99577D74580C022876786C321391C0EF7DFBFFF19BF7FF43DE30147B11B90897930DA370D4CECC071C972622674F1EAADF9FEDDB7DF8CCF1CFFD1F894D31D313A6849E289794F69786C59B17D8F7D148F7CD78E823858D0911DF8167202EB707FFF27EBE0C0C200610296618C3F2484BA3E4E3FE0731A101B873441DE55E0602FE6E550334B518D6BE4E33844369E9827617889E61FB083E351466D1A279E8B409219F616A681080928A220E7F1C718CF681490E52C8402E4DD3D8518E816C88B3197FFB824EFDA95FD43D615AB6C9843D9494C03BF27E0C111D78D25365F49C366A13BD0DE1968993EB15EA71A9C98170E4E8B3E041E284064783CF522463C31AF0A162771788DE9286F38CA20CF2380FB1A445F4655C43DA373BBBDC2960E47FBECDF9E314D3C9A447842704223E4ED19B7C9DC73EDDFF0D35DF00593C9D1C17C71F4F6F51BE41CBDF9111FBDAEF614FA0A74B50228BA8D821047201B5E14FD370DABDECE121B16CD2A6D32AD802DC1B4308D2BF47889C992DEC384397C6B1AE7EE2376F2126E5C1F890BB3081AD12881CFEBC4F3D0DCC345BDD5C893FDDFC0F5F0F59B41B85EA30777990EBDC01F264E04F3EA03F6D2DAF8DE0DB3E9551BEFCF9CEC3C0A7CF65DB7AFACF6F32C48229B7526D092DCA16889695DBAB1551A6F27936650C39B758EBAFBA6CD2495CD5B49CA3AB4CA4CC8596C7A36E4F23E2FDFCE16073B100C5E6A5A4C234D06276F5623A1F59E51A1294DE7A0ABE910E8D2FF79253CF391EB0DB01476E0025EC8C28D7C5CF4F2E7000C0F91DE32DFA2388695C0F915C5F70DA2C39F03883EC376128181CE28F2C367E7767B1F107C9DF87366F79BE335D8D0DC7D0DCE914D83E88CB0566BE35D06F69720A167C43945147FA4760EC83EEF5CBF3BC020E29CD8368EE3733066EC4C0370B273C00B428F0E7BC3B1056ADBAEC8D443AEAFF64584A5F4734E5AFA236A0AC927D190A9FC9226512F83A54BBA899A93EA45CD285A45E5647D456560DD24E5947A415382563933AAC13CBD74848677F552D8DDF7F5D6DBBC756B41458D335821F12F98E0089631E716518A23528E409775631BCE423A7C8CE9B3EF4D29A74FC84B8666B5D26C481781E167430ABBFBB32115138A1F5C8779251D0E403931C077A2579FADDAE79C20D9A6A743AD9B9B66BE993540375D4EE238B0DD741628425F3C7051971F7C38A33D8A91F5468C8440C7C0D05DB6E54109F4CD148DEA869C620F536C9CD85968708A621B39B21AA1434E0FC1F21D5521581911A90BF783C4132C1D47AC116287A01866AA4BA83C2D5C62BB21F25AB524B4ECB885B1BE173CC49A531C62C218B66AA20B737500840950F01106A54D4363AB6271CD86A8F15A7563DEE6C296E32EC5253662932DBEB3C62EB9FFF62C86D9ACB10D1867B34ABA08A00DE66DC340F959A5AB018807975D3350E1C4A43150EE526DC440EB1ADB8281D655F2E20C343BA2761D7FE1BCBA6BE6593F286F7E5B6F54D7166CB3A68F1D33CDCCF78436145AE04836CFD339ABC48F5471380339F9F92CE6AEAE68220C7C86693D6453FABB4A3FD46A06118DA809B034B416507E0D28014913AA8770792CAF513AEE45F480CDE36E8DB07CED17602B36206357AF432B84FA4B53D1383B9D3E8A9E15D6201979A7C34205476110E2E255EF7807A5E8E2B2B262BAF8C27DBCE14AC7F8603428A8C573D52829EFCCE05ACA4DB35D4B2A87AC8F4BB6969604F749A3A5BC33836B89DB68BB92144E410FB7602D15D5B7F081265B1EE928769BA26E6C655952BC606C69D2A9C657280C5DB2ACA457F1126396E5564D5FCDFA271DF9198665C78ADCA342DA82130D22B4C4422DB00649CFDD28A6A788A23962719EA9E34B64CABD55B3FCE72CABDBA73C88F93E9053B3BF0BD3132FEF6B7BADEC8C708C73E8A1CF3C9A348CAE187F757383A5BB210F458AC8FD34F0129FE81D2C7DEBECFEAEDA3E2B9111C69620BFE44049DA92DCDCBAEA3B0D8C3C29061AA4C27F597DA0F4103A75E7DE6755E13A8F548F9207A8AA28BAA0D5D6064EE7C8F41A2CD147EC3F56AD08CF33AF78624A158017F5C4A8E436486095BAEEA8F5F4932A66BDA63BA29063528514AA7A4859CD24A90959AD58094FA3513545770E72EE48155DAEED8EACC822A9422BAA57C056C82CD6754755249A548115D5DDB1CBAC137111DDE19D4B7B725979EBCA0EB7EBED5D1A8CE7591187D9FA2A77F855A04A714F2C7E4B2F81F1F29DB426ED096F656BCA621AEB59930643BFF2D46EBFEB0B4FE395BD1EB376A55D5BDC9BAEF4F578FD6CF6592D433AE0892405F7E2A0271CE8C6FC70D5FE88463A6D6524A691AB1136F6A798627FC40846B33FBCA9E762B68CE7045788B80B1CD32C8DC33CDC3F3814DEE1ECCE9B182B8E1D4F7138D53D8CA98FD90632B2C8038AEC7B14C9F9116BBC1B2941A5D0F30571F0E3C4FC336D759C4631D85F69F19E71117F24EE1F0954DC450936FE92F33D87C9A36F3E64EDE8AB87EE5ABDF8FD73D674CFB88960C61C1BFB822E5719E1FA5B885ED2644DD79066E517122F7742D59E1F28518509B1FA6B83B94B077969904BF99D8F1EBFEF2B9AF235C15A888A170343E10DA242DD8B8055B0B4AF011CF8A4E96B807E9D55BF0E584534EDCB0097F40713DF05745F86F2965BDC6A1467A24D2C49A99E5BF3AAD74AB2DCF6DE24A55FAF35D1E514EB1E706BA451AF60192F2C0379B0DD5191603C18F6364DFBD9B38A772591B84CF1D86EFEF02653861BAE85FE5799C23B90DBA6C8D5D97E3EF0A66D4D17C7DDF1A4CA7E59BF3B666C3C836BFBB9BD9B36365D9877C78DAD5706EF8ED9DAB6F6CF2D5B5AE72D74EBF9B8726A91E63E46150B6ECBB7CD02E770C29F0760049947993D935427783525A7B6302C49F44CF59965226369E2487C258A66B6FDFACA37FCC6CE729A66B69A7CCC26DE7CFD6FE4CD699A796BB21CB79129ACCC3354656FB7AC634D49502F2933B8D6939644F4369FB5F172FD2525020FA294DAECD1DC11BF9CBCDF415432E4D4E991E72B5FF7C2DE59F96545D8BF63775942B0DF5924D8AEED9A05CD055904F9E62D48949308119A2B4C91035BEA4944DD05B22954B31873FACE3B8DDBB19B8E39762EC84D42C3844297B13FF76A012FE60434F14F9399EB328F6FC2F4274B86E80288E9B2D8FC0DF939713DA790FB5C1113D24030EF824774D9585216D95D3E1548D701E908C4D557384577D80F3D008B6FC80C3DE0556403F3BBC44B643F9511401D48FB40D4D53E3E75D132427ECC31CAF6F00936ECF88FEFFE03397F5B8E60540000, N'6.1.1-30610')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'0', N'Administrator')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'1', N'Manager')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'a7101e21-abac-4bf1-9b00-017fb673cac0', N'0')
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'a7101e21-abac-4bf1-9b00-017fb673cac0', N'admin@admin.pt', 0, N'AAOEePe2ia2ew6Mdoz7RkxAWEe6BO2t+oUYJWNinYB49QyVcsXaTHX5fo2gjKaT5sA==', N'0699d907-ff4e-4081-bc3c-980291e73539', NULL, 0, 0, NULL, 1, 0, N'admin@admin.pt')
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'd25fd895-eede-4e1c-a43c-d1a05df79b67', N'pnlferreira@gmail.com', 0, N'AB7N3Kt1pz3JSYhOv5Eg3RknHo9uJfeolwGMyvHKCfciABDN7z3z4YnhMPn/4cuOZA==', N'3cc1d923-2910-4923-a63d-57969d995731', NULL, 0, 0, NULL, 1, 0, N'Pedro')
GO
SET IDENTITY_INSERT [dbo].[EventLogger] ON 

GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (498, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 20:23:46.790' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (499, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 20:24:48.550' AS DateTime), N'dd', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (500, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 20:26:41.273' AS DateTime), N'd', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (501, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 20:39:30.440' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (502, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 20:42:02.330' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (503, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 20:43:39.090' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (504, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 20:44:42.223' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (505, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 20:45:54.140' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (506, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 20:55:47.207' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (507, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 20:57:23.370' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (508, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 20:58:39.350' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (509, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:01:18.420' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (510, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:02:28.557' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (511, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:06:04.327' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (512, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:06:09.377' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (513, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:06:59.293' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (514, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:08:05.167' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (515, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:09:22.277' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (516, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:13:37.533' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (517, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:15:49.133' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (518, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:16:47.217' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (519, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:18:02.457' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (520, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:20:38.330' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (521, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:24:21.893' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (522, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:25:16.147' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (523, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:26:56.503' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (524, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:28:25.640' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (525, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:30:23.650' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (526, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:31:57.200' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (527, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:32:47.977' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (528, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:35:47.843' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (529, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:36:11.007' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
<186>Apr  9 21:34:12 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
XSR-1805(config)#
aaa user ExGroup1                                           
XSR-1805(aaa-user)#
password c604a16b                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
policy vpn 
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
 
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (530, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:37:13.013' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (531, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-09 21:37:34.917' AS DateTime), N'

XSR-1805>en 
XSR-1805#
conf 

Enter configuration commands:
XSR-1805(config)#aaa user ExGro
up1                                           

XSR-1805(aaa-user)#password c604a16b                 <186>Apr  9 21:35:37 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
<186>Apr  9 21:35:37 XSR-1805 CLI: CLI config mode locked by user admin
XSR-1805(aaa-user)#password c604a16b                                           


XSR-1805(aaa-user)#group default 

', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (532, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:04:26.520' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (533, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:07.730' AS DateTime), N'Pipe closed', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (534, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:12.717' AS DateTime), N'Pipe closed', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (535, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:05:21.003' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
XSR-1805(config)#
aaa user ExGroup2                                           
XSR-1805(aaa-user)#
password 46951937                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
policy vpn 
<186>Apr  9 22:03:21 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
<186>Apr  9 22:03:21 XSR-1805 CLI: CLI config mode locked by user admin
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
 
XSR-1805(config)#
aaa user ExGroup2                                           
XSR-1805(aaa-user)#
password 46951937                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
policy vpn 
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
 
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (536, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:22.313' AS DateTime), N'Pipe closed', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (537, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:22.580' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (538, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:27.587' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (539, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:27.673' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (540, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:32.577' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (541, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:32.660' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (542, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:37.590' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (543, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:37.673' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (544, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:42.600' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (545, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:42.683' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (546, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:47.603' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (547, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:47.683' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (548, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:52.603' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (549, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:52.683' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (550, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:57.620' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (551, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:05:57.700' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (552, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:02.617' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (553, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:02.703' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (554, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:07.620' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (555, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:07.700' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (556, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:12.633' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (557, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:12.717' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (558, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:17.637' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (559, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:17.720' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (560, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:22.637' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (561, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:22.730' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (562, N'Error creating users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:27.637' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (563, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:27.713' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (564, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:06:35.630' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
XSR-1805(config)#
aaa user ExGroup2                                           
XSR-1805(aaa-user)#
password 46951937                                 <186>Apr  9 22:04:37 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
<186>Apr  9 22:04:37 XSR-1805 CLI: CLI config mode locked by user admin
XSR-1805(aaa-user)#password 46951937                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
policy vpn 
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
 
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (565, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:35.717' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (566, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:37.650' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (567, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:42.663' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (568, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:47.673' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (569, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:52.667' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (570, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:06:57.680' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (571, N'Error removing users', N'alert alert-danger                                ', 1, CAST(N'2015-04-09 22:07:02.693' AS DateTime), N'SSH_MSG_DISCONNECT: 12 Too many connections. en', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (572, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:07:59.247' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (573, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:08:06.823' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
XSR-1805(config)#
no aaa user ExGroup2                                           
XSR-1805(config)#
no aaa user ExGroup2                                           
The specified user does not exist.
XSR-1805(config)#
no aaa user ExGroup2                                           
The specified user does not exist.
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (574, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:08:52.597' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
XSR-1805(config)#
aaa user ExGroup2                                           
<186>Apr  9 22:06:54 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
<186>Apr  9 22:06:54 XSR-1805 CLI: CLI config mode locked by user admin
XSR-1805(aaa-user)#
password ffa1e402                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
policy vpn 
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
 
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (575, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:08:54.793' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
XSR-1805(config)#
no aaa user ExGroup2                                           
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (576, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:08:56.597' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
<186>Apr  9 22:06:58 XSR-1805 CLI: CLI config mode released by user admin
<186>Apr  9 22:06:58 XSR-1805 CLI: admin exited SSH session from address 2.82.147.19
<186>Apr  9 22:06:59 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
XSR-1805(config)#
no aaa user ExGroup2                                           
The specified user does not exist.
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (577, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:21:42.357' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (578, N'Successfully Scheduled VPN Users', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:22:04.333' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (579, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:22:44.643' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (580, N'Successfully Scheduled VPN Users', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:22:51.340' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (581, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:23:55.133' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (582, N'Successfully Scheduled VPN Users', N'alert alert-success                               ', 0, CAST(N'2015-04-09 22:24:02.260' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (583, N'The Thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-09 22:26:30.583' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (584, N'Successfully Scheduled VPN Users', N'alert alert-success                               ', 0, CAST(N'2015-04-09 22:26:38.413' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (585, N'Successfully created users', N'alert alert-success                               ', 0, CAST(N'2015-04-09 22:26:41.200' AS DateTime), N'
XSR-1805>en 

XSR-1805#conf 
Enter configuration commands:
XSR-1805(config)#
aaa user ExGroup2                                           
XSR-1805(aaa-user)#
password ffa1e402                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
<186>Apr  9 22:24:40 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
<186>Apr  9 22:24:40 XSR-1805 CLI: CLI config mode locked by user admin
XSR-1805(aaa-user)#policy vpn 
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
 
XSR-1805(config)#
aaa user ExGroup2                                           
XSR-1805(aaa-user)#
password ffa1e402                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
policy vpn 
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
 
XSR-1805(config)#
aaa user ExGroup2                                           
XSR-1805(aaa-user)#
password ffa1e402                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
policy vpn 
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
 
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (586, N'Successfully created users', N'alert alert-success                               ', 0, CAST(N'2015-04-09 22:26:43.503' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
XSR-1805(config)#
no aaa user ExGroup2                                           
<186>Apr  9 22:24:45 XSR-1805 CLI: CLI config mode released by user admin
<186>Apr  9 22:24:45 XSR-1805 CLI: admin exited SSH session from address 2.82.147.19
<186>Apr  9 22:24:45 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
<186>Apr  9 22:24:46 XSR-1805 CLI: CLI config mode locked by user admin
<186>Apr  9 22:24:46 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
XSR-1805(config)#
no aaa user ExGroup2                                           
The specified user does not exist.
XSR-1805(config)#
no aaa user ExGroup2                                           
The specified user does not exist.
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (587, N'Successfully created users', N'alert alert-success                               ', 0, CAST(N'2015-04-09 22:26:43.697' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Configuration is currently locked by user admin. Please try later.
XSR-1805#
<186>Apr  9 22:24:45 XSR-1805 CLI: CLI config mode released by user admin
<186>Apr  9 22:24:45 XSR-1805 CLI: admin exited SSH session from address 2.82.147.19
<186>Apr  9 22:24:45 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
<186>Apr  9 22:24:46 XSR-1805 CLI: CLI config mode locked by user admin
<186>Apr  9 22:24:46 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
XSR-1805#no aaa user ExGroup2                                           
            ^
% Invalid input detected at ''^'' marker.
XSR-1805#
no aaa user ExGroup2                                           
            ^
% Invalid input detected at ''^'' marker.
XSR-1805#
no aaa user ExGroup2                                           
            ^
% Invalid input detected at ''^'' marker.
XSR-1805#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (588, N'Successfully created users', N'alert alert-success                               ', 0, CAST(N'2015-04-09 22:26:46.297' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
<186>Apr  9 22:24:47 XSR-1805 CLI: admin exited SSH session from address 2.82.147.19
<186>Apr  9 22:24:48 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
XSR-1805(config)#
no aaa user ExGroup2                                           
The specified user does not exist.
XSR-1805(config)#
no aaa user ExGroup2                                           
The specified user does not exist.
XSR-1805(config)#
no aaa user ExGroup2                                           
The specified user does not exist.
XSR-1805(config)#
no aaa user ExGroup2                                           
The specified user does not exist.
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (589, N'Successfully created users', N'alert alert-success                               ', 0, CAST(N'2015-04-09 22:26:47.687' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
XSR-1805(config)#
no aaa user ExGroup2                                           
The specified user does not exist.
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (590, N'Successfully Scheduled VPN Users', N'alert alert-success                               ', 0, CAST(N'2015-04-09 22:29:15.183' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (591, N'Successfully created users', N'alert alert-success                               ', 0, CAST(N'2015-04-09 22:29:18.880' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
XSR-1805(config)#
aaa user ExGroup2                                          <186>Apr  9 22:27:20 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
<186>Apr  9 22:27:20 XSR-1805 CLI: CLI config mode locked by user admin
XSR-1805(config)#aaa user ExGroup2                                           
XSR-1805(aaa-user)#
password 04d7141a                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
policy vpn 
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
 
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (592, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:31:25.343' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (593, N'Successfully Scheduled VPN Users', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:31:59.570' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (594, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:32:07.683' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
XSR-1805(config)#
aaa user ExGroup2                                           
XSR-1805(aaa-user)#
password 04d7141a                                           
XSR-1805(aaa-user)#
group default 
<186>Apr  9 22:30:09 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
<186>Apr  9 22:30:09 XSR-1805 CLI: CLI config mode locked by user admin
XSR-1805(aaa-user)#
policy vpn 
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
 
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (595, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:32:42.733' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (596, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 22:53:26.940' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (597, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:04:17.330' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (598, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:16:29.670' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (599, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:17:49.840' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (600, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:20:40.813' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (601, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:21:15.047' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (602, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:22:20.250' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (603, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:23:46.280' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (604, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:25:46.117' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (605, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:26:44.760' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (606, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:31:01.090' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (607, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:42:41.793' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (608, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:44:33.627' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (609, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:49:32.073' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (610, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:53:21.540' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (611, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:54:30.230' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (612, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:55:28.100' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (613, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-09 23:59:24.500' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (614, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 00:03:51.130' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (615, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 00:06:28.613' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (616, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 00:14:58.820' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (617, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 00:35:16.720' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (618, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 00:40:05.627' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (619, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 00:51:01.763' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (620, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 01:13:18.733' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (621, N'Successfully Scheduled VPN Users', N'alert alert-success                               ', 1, CAST(N'2015-04-10 01:13:55.390' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (622, N'The emails were sucessfully send', N'alert alert-success                               ', 1, CAST(N'2015-04-10 01:14:06.580' AS DateTime), N'To:pnlferreira@gmail.com                             
Message:
Username: ExGroup4                                          
Password: 23e5efed                                          


', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (623, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-10 01:14:06.580' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
XSR-1805(config)#
aaa user Ex<186>Apr 10 01:12:06 XSR-1805 CLI: User: admin logged in from address 2.82.147.19
<186>Apr 10 01:12:06 XSR-1805 CLI: CLI config mode locked by user admin
XSR-1805(config)#aaa user ExGroup4                                           
XSR-1805(aaa-user)#
password 23e5efed                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
policy vpn 
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
 
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (624, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 01:41:33.150' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (625, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 01:50:03.500' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (626, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 01:50:47.297' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (627, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 01:52:54.900' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (628, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 01:53:10.600' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (629, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:13:03.907' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (630, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:15:11.247' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (631, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:15:18.777' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (632, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:16:36.163' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (633, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:16:43.213' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (634, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:16:48.330' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (635, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:16:54.590' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (636, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:17:54.057' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (637, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:18:00.757' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (638, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:18:09.693' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (639, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:33:54.780' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (640, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:34:35.150' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (641, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:36:36.170' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (642, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:40:08.840' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (643, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:40:12.820' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (644, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:40:19.700' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (645, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:40:22.680' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (646, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:41:27.867' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (647, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:41:29.273' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (648, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:41:35.093' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (649, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:41:38.180' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (650, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:41:41.823' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (651, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:42:16.993' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (652, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:42:48.270' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (653, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:43:24.423' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (654, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:44:23.607' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (655, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:44:42.983' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (656, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:46:21.977' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (657, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:47:00.830' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (658, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:47:10.460' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (659, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:47:18.970' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (660, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:47:25.677' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (661, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:49:22.023' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (662, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:49:25.333' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (663, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:49:30.930' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (664, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:49:34.020' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (665, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:50:05.127' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (666, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:50:07.767' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (667, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:50:13.890' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (668, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:50:31.903' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (669, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:50:33.327' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (670, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:51:01.860' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (671, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:51:24.427' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (672, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:51:32.020' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (673, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:51:43.877' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (674, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:53:29.023' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (675, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:53:32.493' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (676, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:53:38.200' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (677, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:53:41.373' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (678, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:53:44.873' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (679, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:53:50.303' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (680, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 02:53:57.180' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (681, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:06:43.013' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (682, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:06:44.347' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (683, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:06:51.357' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (684, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:06:56.020' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (685, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:13:09.837' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (686, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:13:15.250' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (687, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:13:22.043' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (688, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:13:28.653' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (689, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:18:20.853' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (690, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:18:28.337' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (691, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:18:36.407' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (692, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:18:43.630' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (693, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:37:37.810' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (694, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:37:43.633' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (695, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:52:36.597' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (696, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:52:42.517' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (697, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 14:53:14.847' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (698, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:14:24.323' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (699, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:14:34.170' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (700, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:14:54.673' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (701, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:15:18.747' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (702, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:19:18.377' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (703, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:19:47.437' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (704, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:19:58.577' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (705, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:20:55.063' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (706, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:21:12.187' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (707, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:21:20.867' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (708, N'Successfully Scheduled VPN Users', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:21:22.400' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (709, N'The emails were sucessfully send', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:21:31.780' AS DateTime), N'To:pnlferreira@gmail.com                             
Message:
Username: ExGroup5                                          
Password: 3f5a5058                                          


', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (710, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:21:31.783' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
XSR-1805(config)#
aaa user ExGroup5                                           
XSR-1805(aaa-user)#
password 3f5a5058                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
policy vpn 
XSR-1805(aaa-user)#
<186>Apr 10 16:19:25 XSR-1805 CLI: User: admin logged in from address 193.137.5.232
<186>Apr 10 16:19:25 XSR-1805 CLI: CLI config mode locked by user admin
XSR-1805(aaa-user)#exit 
XSR-1805(config)#
 
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (711, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:22:01.710' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (712, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:22:11.213' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (713, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:22:48.033' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (714, N'Successfully Scheduled VPN Users', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:23:18.620' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (715, N'The emails were sucessfully send', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:23:27.983' AS DateTime), N'To:pnlferreira@gmail.com                             
Message:
Username: ExGroup6                                          
Password: f6708798                                          


', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (716, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-10 16:23:27.983' AS DateTime), N'
XSR-1805>en 

XSR-1805#conf 
Enter configuration commands:
XSR-1805(config)#
<186>Apr 10 16:21:22 XSR-1805 CLI: User: admin logged in from address 193.137.5.232
<186>Apr 10 16:21:22 XSR-1805 CLI: CLI config mode locked by user admin
XSR-1805(config)#aaa user ExGroup6                                           
XSR-1805(aaa-user)#
password f6708798                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
policy vpn 
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
 
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (717, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 17:15:00.880' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (718, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 17:16:29.677' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (719, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 17:24:38.180' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (720, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 17:25:09.157' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (721, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 17:40:09.813' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (722, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 17:54:37.837' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (723, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:09:35.663' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (724, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:36.660' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (725, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:37.760' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (726, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:38.660' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (727, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:39.657' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (728, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:40.660' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (729, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:41.663' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (730, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:42.663' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (731, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:43.663' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (732, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:44.660' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (733, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:45.663' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (734, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:46.673' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (735, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:47.677' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (736, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:48.677' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (737, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:49.677' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (738, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:50.680' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (739, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:51.680' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (740, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:52.680' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (741, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:53.680' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (742, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:54.687' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (743, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:55.687' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (744, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:56.697' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (745, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:57.697' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (746, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:58.700' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (747, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:09:59.700' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (748, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:00.707' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (749, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:01.720' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (750, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:02.723' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (751, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:03.723' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (752, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:04.723' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (753, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:05.723' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (754, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:06.737' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (755, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:07.737' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (756, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:08.737' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (757, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:09.740' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (758, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:10.740' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (759, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:11.740' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (760, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:12.750' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (761, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:13.750' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (762, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:14.753' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (763, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:15.753' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (764, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:16.753' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (765, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:17.763' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (766, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:18.760' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (767, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:10:31.323' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (768, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:32.657' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (769, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:33.650' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (770, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:41.570' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (771, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:41.600' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (772, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:42.583' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (773, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:43.587' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (774, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:44.587' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (775, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:47.837' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (776, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:47.860' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (777, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:48.860' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (778, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:49.860' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (779, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:50.860' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (780, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:10:51.863' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (781, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:11:05.477' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (782, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:06.807' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (783, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:07.907' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (784, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:08.807' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (785, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:09.803' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (786, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:10.807' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (787, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:11.803' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (788, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:12.820' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (789, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:13.823' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (790, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:14.823' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (791, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:15.830' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (792, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:16.833' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (793, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:17.847' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (794, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:18.847' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (795, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:19.850' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (796, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:20.863' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (797, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:21.863' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (798, N'Error Pingging router', N'alert alert-danger                                ', 0, CAST(N'2015-04-11 18:11:22.863' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (799, N'Error Pingging router', N'alert alert-danger                                ', 0, CAST(N'2015-04-11 18:11:23.867' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (800, N'Error Pingging router', N'alert alert-danger                                ', 0, CAST(N'2015-04-11 18:11:24.870' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (801, N'Error Pingging router', N'alert alert-danger                                ', 0, CAST(N'2015-04-11 18:11:25.880' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (802, N'Error Pingging router', N'alert alert-danger                                ', 0, CAST(N'2015-04-11 18:11:26.883' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (803, N'Error Pingging router', N'alert alert-danger                                ', 0, CAST(N'2015-04-11 18:11:27.883' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (804, N'Error Pingging router', N'alert alert-danger                                ', 0, CAST(N'2015-04-11 18:11:28.883' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (805, N'Error Pingging router', N'alert alert-danger                                ', 0, CAST(N'2015-04-11 18:11:29.887' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (806, N'Error Pingging router', N'alert alert-danger                                ', 0, CAST(N'2015-04-11 18:11:30.897' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (807, N'Error Pingging router', N'alert alert-danger                                ', 0, CAST(N'2015-04-11 18:11:31.887' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (808, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:32.897' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (809, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:33.897' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (810, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:34.900' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (811, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:35.910' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (812, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:36.910' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (813, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:37.913' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (814, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:38.913' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (815, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:39.913' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (816, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:40.930' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (817, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:41.930' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (818, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:42.940' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (819, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:44.147' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (820, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:44.940' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (821, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:45.940' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (822, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:46.940' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (823, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:47.957' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (824, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:48.957' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (825, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:49.957' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (826, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:50.957' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (827, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:11:51.960' AS DateTime), N'A referência de objecto não foi definida como uma instância de um objecto.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (828, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:26:19.950' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (829, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:32:31.733' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (830, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:39:25.423' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (831, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:39:28.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (832, N'Router is UP', N'alert alert-successfull                           ', 1, CAST(N'2015-04-11 18:39:32.353' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (833, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:39:32.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (834, N'Router is UP', N'alert alert-successfull                           ', 1, CAST(N'2015-04-11 18:39:33.980' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (835, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:39:34.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (836, N'Router is UP', N'alert alert-successfull                           ', 1, CAST(N'2015-04-11 18:39:35.507' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (837, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:39:35.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (838, N'Router is UP', N'alert alert-successfull                           ', 1, CAST(N'2015-04-11 18:39:37.720' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (839, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:40:31.860' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (840, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:41:18.500' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (841, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:41:18.503' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (842, N'Router is UP', N'alert alert-successfull                           ', 1, CAST(N'2015-04-11 18:41:20.033' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (843, N'The Thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 18:43:32.787' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (844, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:43:32.787' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (845, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:43:59.253' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (846, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:44:00.377' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (847, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:44:23.250' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (848, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:44:28.480' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (849, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 18:46:53.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (850, N'Router is UP', N'alert alert-success                               ', 0, CAST(N'2015-04-11 18:46:58.980' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (851, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:51:01.417' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (852, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 18:51:01.420' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (853, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:57:03.200' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (854, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 18:57:03.200' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (855, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:58:09.847' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (856, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:58:09.850' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (857, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 18:59:17.877' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (858, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 18:59:17.877' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (859, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:00:16.990' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (860, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:00:16.993' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (861, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:02:27.300' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (862, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:02:27.300' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (863, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:03:26.660' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (864, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:03:26.663' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (865, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:04:34.037' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (866, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:04:34.040' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (867, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:06:31.830' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (868, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:06:31.833' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (869, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:08:36.280' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (870, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:08:36.280' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (871, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:10:43.083' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (872, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:10:43.087' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (873, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:11:11.143' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (874, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:11:11.147' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (875, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:11:26.943' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (876, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:11:26.947' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (877, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:11:52.210' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (878, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:11:52.210' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (879, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:12:40.793' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (880, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:12:40.797' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (881, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:18:01.233' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (882, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:18:01.237' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (883, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:19:11.823' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (884, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:19:11.827' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (885, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:19:28.253' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (886, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:19:29.407' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (887, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:19:49.253' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (888, N'The Thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:23:50.300' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (889, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:23:50.303' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (890, N'The Thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:24:38.100' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (891, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:24:38.100' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (892, N'Error Pingging router', N'alert alert-danger                                ', 0, CAST(N'2015-04-11 19:24:48.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (893, N'Router is UP', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:24:53.990' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (894, N'The Thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:27:58.350' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (895, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:27:58.353' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (896, N'The Thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:28:11.447' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (897, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:28:11.450' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (898, N'The Thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:32:15.267' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (899, N'The Ping thread has been startted', N'alert alert-success                               ', 0, CAST(N'2015-04-11 19:32:15.270' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (900, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:32:42.253' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (901, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:32:45.480' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (902, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:34:56.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (903, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:35:01.983' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (904, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:35:52.420' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (905, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:35:52.423' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (906, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:37:22.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (907, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:37:27.980' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (908, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:39:40.253' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (909, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:39:44.487' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (910, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:41:55.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (911, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:42:01.980' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (912, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:43:49.253' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (913, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:43:50.433' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (914, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:43:51.253' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (915, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:43:54.487' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (916, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:46:11.760' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (917, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:46:11.763' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (918, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:46:43.107' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (919, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:48:54.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (920, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:48:59.980' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (921, N'The Thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:51:04.227' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (922, N'The Ping thread has been startted', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:51:04.230' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (923, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:51:05.253' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (924, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:51:09.483' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (925, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:52:49.253' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (926, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:52:53.480' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (927, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:53:45.757' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (928, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:53:46.620' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (929, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:55:14.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (930, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:55:18.980' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (931, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:57:00.357' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (932, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 19:57:16.257' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (933, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 19:57:20.480' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (934, N'The Thread has been started', N'alert alert-success                               ', 1, CAST(N'2015-04-11 20:54:17.707' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (935, N'The Ping thread has been started', N'alert alert-success                               ', 1, CAST(N'2015-04-11 20:54:17.710' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (936, N'Ping not received', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 20:54:37.257' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (937, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 20:54:39.483' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (938, N'Ping not received', N'alert alert-danger                                ', 1, CAST(N'2015-04-11 20:55:34.767' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (939, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-11 20:55:35.983' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (940, N'Ping not received', N'alert alert-danger                                ', 1, CAST(N'2015-04-12 00:42:09.040' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (941, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-12 00:42:09.100' AS DateTime), N'Excepção durante um pedido de Ping.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (942, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-12 00:42:11.653' AS DateTime), N'Excepção durante um pedido de Ping.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (943, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-12 00:42:11.660' AS DateTime), N'Excepção durante um pedido de Ping.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (944, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-12 00:42:12.610' AS DateTime), N'Excepção durante um pedido de Ping.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (945, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-12 00:42:13.600' AS DateTime), N'Excepção durante um pedido de Ping.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (946, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-12 00:42:18.463' AS DateTime), N'Excepção durante um pedido de Ping.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (947, N'The Thread has been started', N'alert alert-success                               ', 1, CAST(N'2015-04-13 14:43:14.627' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (948, N'The Ping thread has been started', N'alert alert-success                               ', 1, CAST(N'2015-04-13 14:43:14.630' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (949, N'Successfully Scheduled VPN Users', N'alert alert-success                               ', 1, CAST(N'2015-04-13 14:46:14.363' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (950, N'The emails were sucessfully send', N'alert alert-success                               ', 1, CAST(N'2015-04-13 14:46:26.820' AS DateTime), N'To:pnlferreira@gmail.com                             
Message:
Username: ExGroup7                                          
Password: 81b3643a                                          


', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (951, N'Successfully created users', N'alert alert-success                               ', 1, CAST(N'2015-04-13 14:46:26.820' AS DateTime), N'
XSR-1805>en 
XSR-1805#
conf 
Enter configuration commands:
XSR-1805(config)#
aaa user ExGroup7                                           
XSR-1805(aaa-user)#
password 81b3643a                                           
XSR-1805(aaa-user)#
group default 
XSR-1805(aaa-user)#
policy vpn 
XSR-1805(aaa-user)#
exit 
XSR-1805(config)#
<186>Apr 13 14:34:49 XSR-1805 CLI: User: admin logged in from address 193.137.5.232
<186>Apr 13 14:34:49 XSR-1805 CLI: CLI config mode locked by user admin
XSR-1805(config)# 
XSR-1805(config)#
', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (952, N'The Thread has been started', N'alert alert-success                               ', 1, CAST(N'2015-04-13 17:29:08.553' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (953, N'The Ping thread has been started', N'alert alert-success                               ', 1, CAST(N'2015-04-13 17:29:08.557' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (954, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-13 18:16:56.057' AS DateTime), N'Excepção durante um pedido de Ping.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (955, N'Error Pingging router', N'alert alert-danger                                ', 1, CAST(N'2015-04-13 18:16:56.063' AS DateTime), N'Excepção durante um pedido de Ping.', 1)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (956, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-13 18:17:51.177' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (957, N'Ping not received', N'alert alert-danger                                ', 1, CAST(N'2015-04-13 18:20:27.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (958, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-13 18:20:28.703' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (959, N'Ping not received', N'alert alert-danger                                ', 1, CAST(N'2015-04-13 18:53:38.753' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (960, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-13 18:53:39.503' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (961, N'Ping not received', N'alert alert-danger                                ', 1, CAST(N'2015-04-13 19:01:44.253' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (962, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-13 19:01:45.177' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (963, N'Ping not received', N'alert alert-danger                                ', 1, CAST(N'2015-04-13 19:02:02.253' AS DateTime), NULL, 0)
GO
INSERT [dbo].[EventLogger] ([Id], [Text], [class], [NotSeen], [datetime], [note], [hasNote]) VALUES (964, N'Router is UP', N'alert alert-success                               ', 1, CAST(N'2015-04-13 19:21:28.463' AS DateTime), NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[EventLogger] OFF
GO
INSERT [dbo].[Ping] ([Id], [routerOn], [pingTime]) VALUES (1, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[VPNUsers] ON 

GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (1, N'w                                                 ', N'w                                                 ', NULL, NULL, NULL, 1)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (2, N'ExGroup1                                          ', N'c604a16b                                          ', NULL, CAST(N'2015-03-26 00:00:00.000' AS DateTime), CAST(N'2019-01-18 00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (3, N'ExGroup4                                          ', N'b346dd47                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2015-11-11 11:11:00.000' AS DateTime), CAST(N'2011-11-11 11:11:00.000' AS DateTime), 0)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (4, N'ExGroup3                                          ', N'5013f399                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2015-11-11 11:11:00.000' AS DateTime), 1)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (5, N'ExGroup2                                          ', N'b346dd47                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2015-01-11 11:11:00.000' AS DateTime), CAST(N'2015-02-11 11:11:00.000' AS DateTime), 0)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (50, N'ExGroup2                                          ', N'46951937                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2011-11-11 11:11:00.000' AS DateTime), 0)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (51, N'ExGroup2                                          ', N'46951937                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2011-11-11 11:11:00.000' AS DateTime), 0)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (52, N'ExGroup2                                          ', N'46951937                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2011-11-11 11:11:00.000' AS DateTime), 0)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (53, N'ExGroup2                                          ', N'ffa1e402                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2011-11-11 11:11:00.000' AS DateTime), 0)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (54, N'ExGroup2                                          ', N'ffa1e402                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2011-11-11 11:11:00.000' AS DateTime), 0)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (55, N'ExGroup2                                          ', N'ffa1e402                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2011-11-11 11:11:00.000' AS DateTime), 0)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (56, N'ExGroup2                                          ', N'ffa1e402                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2011-11-11 11:11:00.000' AS DateTime), 0)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (57, N'ExGroup2                                          ', N'ffa1e402                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2011-11-11 11:11:00.000' AS DateTime), 0)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (58, N'ExGroup2                                          ', N'04d7141a                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2015-11-11 11:11:00.000' AS DateTime), 1)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (59, N'ExGroup2                                          ', N'04d7141a                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2015-11-11 11:11:00.000' AS DateTime), 1)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (60, N'ExGroup4                                          ', N'23e5efed                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2015-11-11 11:11:00.000' AS DateTime), 1)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (61, N'ExGroup5                                          ', N'3f5a5058                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2015-11-11 11:11:00.000' AS DateTime), 1)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (62, N'ExGroup6                                          ', N'f6708798                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2015-11-11 11:11:00.000' AS DateTime), 1)
GO
INSERT [dbo].[VPNUsers] ([Id], [usr], [pwd], [email], [initDate], [endDate], [active]) VALUES (63, N'ExGroup7                                          ', N'81b3643a                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2015-11-11 11:11:00.000' AS DateTime), 1)
GO
SET IDENTITY_INSERT [dbo].[VPNUsers] OFF
GO
SET IDENTITY_INSERT [dbo].[VPNUsersTemp] ON 

GO
INSERT [dbo].[VPNUsersTemp] ([Id], [usr], [pwd], [email], [initDate], [endDate]) VALUES (1, N'ExGroup7                                          ', N'81b3643a                                          ', N'pnlferreira@gmail.com                             ', CAST(N'2011-11-11 11:11:00.000' AS DateTime), CAST(N'2015-11-11 11:11:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[VPNUsersTemp] OFF
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON

GO
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
SET ANSI_PADDING ON

GO
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
