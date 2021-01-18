if object_id('dbo.TestCase1PerfResults ') is not null
	drop table dbo.TestCase1PerfResults 
create table TestCase1PerfResults (
	ID int IDENTITY(1,1),
	[DateTime] datetime,
	DWU int,
	ResourceClass varchar(100),
	Method varchar(100),
	FileType varchar(100),
	Compression varchar(100),
	Files int,
	ScaleFactor int,
	Duration1 time,
	Duration2 time,
	Duration3 time
)with (HEAP, DISTRIBUTION=ROUND_ROBIN)
