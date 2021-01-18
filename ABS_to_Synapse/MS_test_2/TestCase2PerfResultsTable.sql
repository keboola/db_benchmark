/****** Object:  Table [dbo].[TestCase2PerfResults]    Script Date: 12.01.2021 16:27:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TestCase2PerfResults]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DateTime] [datetime] NULL,
	[DWU] [int] NULL,
	[ResourceClass] [varchar](100) NULL,
	[Duration1] [time](7) NULL,
	[Duration2] [time](7) NULL,
	[Duration3] [time](7) NULL,
	[Duration4] [time](7) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	HEAP
)
GO


