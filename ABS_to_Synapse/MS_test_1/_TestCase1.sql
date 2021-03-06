--truncate table PerfResults;
--ALTER DATABASE KeboolaPerfDW MODIFY ( SERVICE_OBJECTIVE= 'DW500c' );
--update PerfResults set DWU='500' where DWU is null

--================================================================================================

declare @resourceclass varchar(100) = 'largerc'
declare @DWU int = 2000


--================================================================================================
/*
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=1, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=1, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=1, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=60, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=60, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=60, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=120, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=120, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=120, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=180, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=180, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=180, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=240, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=240, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=240, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=300, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=300, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=300, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=360, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=360, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=360, @folder='CSV', @compression='none'

--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=1, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=1, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=1, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=60, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=60, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=60, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=120, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=120, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=120, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=180, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=180, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=180, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=240, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=240, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=240, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=300, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=300, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=300, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=360, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=360, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=360, @folder='CSV', @compression='none'
/*
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=1, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=1, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=1, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=60, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=60, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=60, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=120, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=120, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=120, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=180, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=180, @folder='CSV', @compression='none'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=180, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=240, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=240, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=240, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=300, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=300, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=300, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=360, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=360, @folder='CSV', @compression='none'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=360, @folder='CSV', @compression='none'
*/
--================================================================================================

--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=1, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=1, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=1, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=360, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=360, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=360, @folder='CSV', @compression='gzip'

--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=1, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=1, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=1, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=360, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=360, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=360, @folder='CSV', @compression='gzip'
/*
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=1, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=1, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=1, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=180, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=240, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=240, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=240, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=300, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=300, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=300, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=360, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=360, @folder='CSV', @compression='gzip'
--exec TestCase1CopyCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=360, @folder='CSV', @compression='gzip'
*/
*/
--================================================================================================

--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=1, @folder='CSV', @compression='none'
--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=1, @folder='CSV', @compression='none'
--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=1, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=60, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=60, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=60, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=120, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=120, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=120, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=180, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=180, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=180, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=240, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=240, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=240, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=300, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=300, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=300, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=360, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=360, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=360, @folder='CSV', @compression='none'

--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=1, @folder='CSV', @compression='none'
--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=1, @folder='CSV', @compression='none'
--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=1, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=60, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=60, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=60, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=120, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=120, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=120, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=180, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=180, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=180, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=240, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=240, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=240, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=300, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=300, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=300, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=360, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=360, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=360, @folder='CSV', @compression='none'

--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=1, @folder='CSV', @compression='none'
--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=1, @folder='CSV', @compression='none'
--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=1, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=60, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=60, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=60, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=120, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=120, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=120, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=180, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=180, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=180, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=240, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=240, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=240, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=300, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=300, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=300, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=360, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=360, @folder='CSV', @compression='none'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=360, @folder='CSV', @compression='none'

--================================================================================================

--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=1, @folder='CSV', @compression='gzip'
--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=1, @folder='CSV', @compression='gzip'
--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=1, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=360, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=360, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=1, @files=360, @folder='CSV', @compression='gzip'

--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=1, @folder='CSV', @compression='gzip'
--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=1, @folder='CSV', @compression='gzip'
--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=1, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=360, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=360, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=10, @files=360, @folder='CSV', @compression='gzip'

--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=1, @folder='CSV', @compression='gzip'
--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=1, @folder='CSV', @compression='gzip'
--exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=1, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=60, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=120, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=180, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=240, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=300, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=360, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=360, @folder='CSV', @compression='gzip'
exec TestCase1PolybaseCSV @DWU=@DWU, @ResourceClass=@resourceclass, @scalefactor=100, @files=360, @folder='CSV', @compression='gzip'

--================================================================================================
