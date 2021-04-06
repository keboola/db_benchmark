SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42019' order by name;
DROP TABLE [WORKSPACE_42019].[tableLoaded];
SELECT name FROM sys.views WHERE schema_name(schema_id) = 'WORKSPACE_42019' order by name;
DROP SCHEMA [WORKSPACE_42019];
EXEC sp_droprolemember 'KEBOOLA_ZAJCA_XWORKSPACE_42019_ROLE', 'KEBOOLA_ZAJCA_XWORKSPACE_42019_USER';
DROP ROLE [KEBOOLA_ZAJCA_XWORKSPACE_42019_ROLE];
DROP USER [KEBOOLA_ZAJCA_XWORKSPACE_42019_USER];
DROP LOGIN [KEBOOLA_ZAJCA_XWORKSPACE_42019_USER];

-- HERE WE GO!!!
--
-- START CASE: SPK_NO_PK
--
--
-- OPERATION: Table from CSV
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK] (
    [id]         NVARCHAR(4000) NOT NULL,
    [name]       NVARCHAR(4000) NOT NULL,
    [_timestamp] DATETIME2
)
    WITH (DISTRIBUTION = ROUND_ROBIN);
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK]');
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '181224046' ORDER BY [column_id];
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '181224046';
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '181224046' AND c.object_id = '181224046';
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57024d3408_21659086] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN) COPY INTO [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57024d3408_21659086] FROM 'https://kbcfsznsajl4ssv6zw.blob.core.windows.net/exp-15-files-384-42107-2021-04-06/languages.csv.gz'
WITH
    (FILE_TYPE='CSV', CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2021-04-06T12:41:38Z&se=2021-04-07T00:41:38Z&sp=rl&sig=Ze%2BWVMNiLfGMC2t%2FT04bwFcAGLDv7RBm3sFJim1n098%3D'), FIELDQUOTE='"', FIELDTERMINATOR =',', ENCODING = 'UTF8', ROWTERMINATOR ='0x0A', IDENTITY_INSERT = 'OFF' , FIRSTROW =2);

SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57024d3408_21659086];

BEGIN TRANSACTION;
DELETE FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK];
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK] ([id], [name], [_timestamp]) (SELECT
                                                                                                                                    CAST(COALESCE([id], '') as nvarchar(4000))   AS [id]
                                                                                                                                  , CAST(COALESCE([name], '') as nvarchar(4000)) AS [name]
                                                                                                                                  , '2021-04-06 12:41:43'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57024d3408_21659086] AS [src]);
COMMIT;
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57024d3408_21659086];
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK_tmp];
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK_tmp_rename];
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK]';

-- OPERATION: Load table to WS
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT name FROM sys.views WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
CREATE TABLE [WORKSPACE_42106].[tableLoaded] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (DISTRIBUTION = ROUND_ROBIN);
INSERT INTO
    [WORKSPACE_42106].[tableLoaded] ([id], [name])
SELECT
    [id]
  , [name]
FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK];
SELECT COUNT(*) AS [count] FROM [WORKSPACE_42106].[tableLoaded];
EXEC sp_spaceused '[WORKSPACE_42106].[tableLoaded]';

-- OPERATION: Load table from WS
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]');
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '197224103'
ORDER BY
    c.column_id;

SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK]');
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '181224046' ORDER BY [column_id];
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '181224046';
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '181224046' AND c.object_id = '181224046';
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57194c7020_67293465] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN);
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57194c7020_67293465] ([id], [name])
SELECT
    [id]
  , [name]
FROM [WORKSPACE_42106].[tableLoaded];
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57194c7020_67293465];
BEGIN TRANSACTION;
DELETE FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK];
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK] ([id], [name], [_timestamp]) (SELECT
                                                                                                                                    CAST(COALESCE([id], '') as nvarchar(4000))   AS [id]
                                                                                                                                  , CAST(COALESCE([name], '') as nvarchar(4000)) AS [name]
                                                                                                                                  , '2021-04-06 12:42:05'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57194c7020_67293465] AS [src]);
COMMIT;
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57194c7020_67293465];
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK_tmp];
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK_tmp_rename];
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK]';

-- OPERATION: Table from CSV inc
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_NO_PK] (
    [id]         NVARCHAR(4000) NOT NULL,
    [name]       NVARCHAR(4000) NOT NULL,
    [_timestamp] DATETIME2
)
    WITH (DISTRIBUTION = ROUND_ROBIN);
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_NO_PK]');
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '213224160' ORDER BY [column_id];
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '213224160';
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '213224160' AND c.object_id = '213224160';
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c572658fc59_92965709] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN) ;

COPY INTO [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c572658fc59_92965709]
    FROM 'https://kbcfsznsajl4ssv6zw.blob.core.windows.net/exp-15-files-384-42114-2021-04-06/languages.increment.csv.gz'
WITH
    (FILE_TYPE='CSV', CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2021-04-06T12:42:14Z&se=2021-04-07T00:42:14Z&sp=rl&sig=ZlMP7T2Wb03%2FSI4zkXaDsgxxfIvYuoc1CNJCmXtn38o%3D'), FIELDQUOTE='"', FIELDTERMINATOR =',', ENCODING = 'UTF8', ROWTERMINATOR ='0x0A', IDENTITY_INSERT = 'OFF' , FIRSTROW =2);

SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c572658fc59_92965709];
BEGIN TRANSACTION;
DELETE FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_NO_PK];
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_NO_PK] ([id], [name], [_timestamp]) (SELECT
                                                                                                                                       CAST(COALESCE([id], '') as nvarchar(4000))   AS [id]
                                                                                                                                     , CAST(COALESCE([name], '') as nvarchar(4000)) AS [name]
                                                                                                                                     , '2021-04-06 12:42:19'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c572658fc59_92965709] AS [src]);
COMMIT;
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c572658fc59_92965709];
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_NO_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_NO_PK_tmp];
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_NO_PK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_NO_PK_tmp_rename];
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_NO_PK]';

-- OPERATION: Load table to WS inc
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]');
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '197224103'
ORDER BY
    c.column_id;
CREATE TABLE [WORKSPACE_42106].[__temp_validation606c57317ef293_78666151] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (DISTRIBUTION = ROUND_ROBIN);
SELECT OBJECT_ID(N'[WORKSPACE_42106].[__temp_validation606c57317ef293_78666151]');
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '229224217'
ORDER BY
    c.column_id;
DROP TABLE [WORKSPACE_42106].[__temp_validation606c57317ef293_78666151];
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]', N'U') IS NULL
CREATE TABLE [WORKSPACE_42106].[tableLoaded] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (DISTRIBUTION = ROUND_ROBIN);
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]');
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '197224103' ORDER BY [column_id];
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '197224103';
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '197224103' AND c.object_id = '197224103';
CREATE TABLE [WORKSPACE_42106].[#__temp_csvimport606c57332fdf36_99677486] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN);
INSERT INTO
    [WORKSPACE_42106].[#__temp_csvimport606c57332fdf36_99677486] ([id], [name])
SELECT
    [id]
  , [name]
FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_NO_PK];
SELECT COUNT(*) AS [count] FROM [WORKSPACE_42106].[#__temp_csvimport606c57332fdf36_99677486];
CREATE TABLE [WORKSPACE_42106].[#__temp_csvimport606c57365ef2a4_41858722] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN);
BEGIN TRANSACTION;
INSERT INTO
    [WORKSPACE_42106].[tableLoaded] ([id], [name]) (SELECT
                                                        CAST(COALESCE([id], '') as nvarchar(4000))   AS [id]
                                                      , CAST(COALESCE([name], '') as nvarchar(4000)) AS [name]
FROM [WORKSPACE_42106].[#__temp_csvimport606c57332fdf36_99677486] AS [src]);
COMMIT;
DROP TABLE [WORKSPACE_42106].[#__temp_csvimport606c57332fdf36_99677486];
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded_tmp]', N'U') IS NOT NULL DROP TABLE [WORKSPACE_42106].[tableLoaded_tmp];
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded_tmp_rename]', N'U') IS NOT NULL
    DROP TABLE [WORKSPACE_42106].[tableLoaded_tmp_rename];
EXEC sp_spaceused '[WORKSPACE_42106].[tableLoaded]';

-- OPERATION: Load table from WS inc
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]');
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '197224103'
ORDER BY
    c.column_id;
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK]');
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '181224046' ORDER BY [column_id];
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '181224046';
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '181224046' AND c.object_id = '181224046';
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c573cc54275_05771337] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN);
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c573cc54275_05771337] ([id], [name])
SELECT
    [id]
  , [name]
FROM [WORKSPACE_42106].[tableLoaded];
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c573cc54275_05771337];
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c574068d2e6_64512019] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN);
BEGIN TRANSACTION;
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK] ([id], [name], [_timestamp]) (SELECT
                                                                                                                                    CAST(COALESCE([id], '') as nvarchar(4000))   AS [id]
                                                                                                                                  , CAST(COALESCE([name], '') as nvarchar(4000)) AS [name]
                                                                                                                                  , '2021-04-06 12:42:40'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c573cc54275_05771337] AS [src]);
COMMIT;
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c573cc54275_05771337];
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK_tmp];
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK_tmp_rename];
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_NO_PK]';
-- END CASE: SPK_NO_PK

-- START CASE: SPK_PK
--
--
-- OPERATION: Table from CSV
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK] (
    [id]         NVARCHAR(4000) NOT NULL,
    [name]       NVARCHAR(4000) NOT NULL,
    [_timestamp] DATETIME2,
    PRIMARY KEY NONCLUSTERED ([id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([id]))
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '245224274' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '245224274'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '245224274' AND c.object_id = '245224274'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c574bcd3c26_35476471] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id])) COPY INTO [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c574bcd3c26_35476471] FROM 'https://kbcfsznsajl4ssv6zw.blob.core.windows.net/exp-15-files-384-42121-2021-04-06/languages.csv.gz'
WITH
    (FILE_TYPE='CSV', CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2021-04-06T12:42:51Z&se=2021-04-07T00:42:51Z&sp=rl&sig=68MmiSvJtKLQ9Xe1KyBtVN4pyIScTiRZG2X0KMprsdg%3D'), FIELDQUOTE='"', FIELDTERMINATOR =',', ENCODING = 'UTF8', ROWTERMINATOR ='0x0A', IDENTITY_INSERT = 'OFF' , FIRSTROW =2)
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c574bcd3c26_35476471]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp]
    WITH (DISTRIBUTION = HASH ([id])) AS
SELECT
    a.[id]
  , a.[name]
  , '2021-04-06 12:42:56' AS [_timestamp]
FROM
    (SELECT
         COALESCE([id], '')                                  AS [id]
       , COALESCE([name], '')                                AS [name]
       , ROW_NUMBER() OVER (PARTITION BY [id] ORDER BY [id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c574bcd3c26_35476471]) AS a
WHERE
    a."_row_number_" = 1 RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK] TO [tableSPK_PK_tmp_rename]
RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp] TO [tableSPK_PK]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp_rename]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c574bcd3c26_35476471]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp_rename]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK]'
-- OPERATION: Load table to WS
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
DROP TABLE [WORKSPACE_42106].[tableLoaded]
SELECT name FROM sys.views WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
CREATE TABLE [WORKSPACE_42106].[tableLoaded] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000),
    PRIMARY KEY NONCLUSTERED ([id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([id]))
INSERT INTO
    [WORKSPACE_42106].[tableLoaded] ([id], [name])
SELECT
    [id]
  , [name]
FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK];
SELECT COUNT(*) AS [count] FROM [WORKSPACE_42106].[tableLoaded]
EXEC sp_spaceused '[WORKSPACE_42106].[tableLoaded]'
-- OPERATION: Load table from WS
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '293224445'
ORDER BY
    c.column_id;
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '277224388' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '277224388'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '277224388' AND c.object_id = '277224388'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c575d8d5023_08299304] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id]))
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c575d8d5023_08299304] ([id], [name])
SELECT
    [id]
  , [name]
FROM [WORKSPACE_42106].[tableLoaded]
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c575d8d5023_08299304]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp]
    WITH (DISTRIBUTION = HASH ([id])) AS
SELECT
    a.[id]
  , a.[name]
  , '2021-04-06 12:43:11' AS [_timestamp]
FROM
    (SELECT
         CAST(COALESCE([id], '') as nvarchar(4000))          AS [id]
       , CAST(COALESCE([name], '') as nvarchar(4000))        AS [name]
       , ROW_NUMBER() OVER (PARTITION BY [id] ORDER BY [id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c575d8d5023_08299304]) AS a
WHERE
    a."_row_number_" = 1 RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK] TO [tableSPK_PK_tmp_rename]
RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp] TO [tableSPK_PK]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp_rename]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c575d8d5023_08299304]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp_rename]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK]'
-- OPERATION: Table from CSV inc
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK] (
    [id]         NVARCHAR(4000) NOT NULL,
    [name]       NVARCHAR(4000) NOT NULL,
    [_timestamp] DATETIME2,
    PRIMARY KEY NONCLUSTERED ([id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([id]))
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '341224616' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '341224616'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '341224616' AND c.object_id = '341224616'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c576a885b62_54787887] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id])) COPY INTO [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c576a885b62_54787887] FROM 'https://kbcfsznsajl4ssv6zw.blob.core.windows.net/exp-15-files-384-42128-2021-04-06/languages.increment.csv.gz'
WITH
    (FILE_TYPE='CSV', CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2021-04-06T12:43:22Z&se=2021-04-07T00:43:22Z&sp=rl&sig=oGszF4V%2FeykwoDCpdGWY%2B9dxEBApFc9ZD0O0C8%2FKaWw%3D'), FIELDQUOTE='"', FIELDTERMINATOR =',', ENCODING = 'UTF8', ROWTERMINATOR ='0x0A', IDENTITY_INSERT = 'OFF' , FIRSTROW =2)
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c576a885b62_54787887]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_tmp]
    WITH (DISTRIBUTION = HASH ([id])) AS
SELECT
    a.[id]
  , a.[name]
  , '2021-04-06 12:43:27' AS [_timestamp]
FROM
    (SELECT
         COALESCE([id], '')                                  AS [id]
       , COALESCE([name], '')                                AS [name]
       , ROW_NUMBER() OVER (PARTITION BY [id] ORDER BY [id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c576a885b62_54787887]) AS a
WHERE
    a."_row_number_" = 1 RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK] TO [tableIncSPK_PK_tmp_rename]
RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_tmp] TO [tableIncSPK_PK]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_tmp_rename]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c576a885b62_54787887]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK]'
-- OPERATION: Load table to WS inc
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '293224445'
ORDER BY
    c.column_id;
CREATE TABLE [WORKSPACE_42106].[__temp_validation606c5775620360_88248908] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000),
    PRIMARY KEY NONCLUSTERED ([id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([id]));
SELECT OBJECT_ID(N'[WORKSPACE_42106].[__temp_validation606c5775620360_88248908]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '389224787'
ORDER BY
    c.column_id;
DROP TABLE [WORKSPACE_42106].[__temp_validation606c5775620360_88248908]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]', N'U') IS NULL
CREATE TABLE [WORKSPACE_42106].[tableLoaded] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000),
    PRIMARY KEY NONCLUSTERED ([id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([id]))
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '293224445' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '293224445'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '293224445' AND c.object_id = '293224445'
CREATE TABLE [WORKSPACE_42106].[#__temp_csvimport606c57771c1792_49064937] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id]))
INSERT INTO
    [WORKSPACE_42106].[#__temp_csvimport606c57771c1792_49064937] ([id], [name])
SELECT
    [id]
  , [name]
FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK]
SELECT COUNT(*) AS [count] FROM [WORKSPACE_42106].[#__temp_csvimport606c57771c1792_49064937]
CREATE TABLE [WORKSPACE_42106].[#__temp_csvimport606c57798a4664_37883588] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id]))
BEGIN TRANSACTION
UPDATE [WORKSPACE_42106].[tableLoaded]
SET
    [name] = COALESCE([src].[name], '')
FROM [WORKSPACE_42106].[#__temp_csvimport606c57771c1792_49064937] AS [src]
WHERE
    [WORKSPACE_42106].[tableLoaded].[id] = COALESCE([src].[id], '') AND
    (COALESCE(CAST([WORKSPACE_42106].[tableLoaded].[id] AS varchar(4000)), '') != COALESCE([src].[id], '') OR
     COALESCE(CAST([WORKSPACE_42106].[tableLoaded].[name] AS varchar(4000)), '') != COALESCE([src].[name], ''))
DELETE [WORKSPACE_42106].[#__temp_csvimport606c57771c1792_49064937]
WHERE
    EXISTS(SELECT *
    FROM [WORKSPACE_42106].[tableLoaded]
    WHERE
            [WORKSPACE_42106].[tableLoaded].[id] =
            COALESCE([WORKSPACE_42106].[#__temp_csvimport606c57771c1792_49064937].[id], ''))
INSERT INTO
    [WORKSPACE_42106].[#__temp_csvimport606c57798a4664_37883588] ([id], [name])
SELECT
    a.[id]
  , a.[name]
FROM
    (SELECT
         [id]
       , [name]
       , ROW_NUMBER() OVER (PARTITION BY [id] ORDER BY [id]) AS "_row_number_"
    FROM [WORKSPACE_42106].[#__temp_csvimport606c57771c1792_49064937]) AS a
WHERE
    a."_row_number_" = 1
DELETE FROM [WORKSPACE_42106].[#__temp_csvimport606c57771c1792_49064937]
INSERT INTO
    [WORKSPACE_42106].[tableLoaded] ([id], [name]) (SELECT
                                                        CAST(COALESCE([id], '') as nvarchar(4000))   AS [id]
                                                      , CAST(COALESCE([name], '') as nvarchar(4000)) AS [name]
FROM [WORKSPACE_42106].[#__temp_csvimport606c57798a4664_37883588] AS [src])
COMMIT
DROP TABLE [WORKSPACE_42106].[#__temp_csvimport606c57798a4664_37883588]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded_tmp]', N'U') IS NOT NULL DROP TABLE [WORKSPACE_42106].[tableLoaded_tmp]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded_tmp_rename]', N'U') IS NOT NULL
    DROP TABLE [WORKSPACE_42106].[tableLoaded_tmp_rename]
EXEC sp_spaceused '[WORKSPACE_42106].[tableLoaded]'
-- OPERATION: Load table from WS inc
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '293224445'
ORDER BY
    c.column_id;
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '325224559' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '325224559'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '325224559' AND c.object_id = '325224559'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57832cc7f0_97841948] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id]))
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57832cc7f0_97841948] ([id], [name])
SELECT
    [id]
  , [name]
FROM [WORKSPACE_42106].[tableLoaded]
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57832cc7f0_97841948]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5784d1b597_15980394] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id]))
BEGIN TRANSACTION
UPDATE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK]
SET
    [name] = COALESCE([src].[name], ''), [_timestamp] = '2021-04-06 12:43:48'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57832cc7f0_97841948] AS [src]
WHERE
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK].[id] =
        COALESCE([src].[id], '') AND
        (COALESCE(CAST(
                     [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK].[id] AS varchar(4000)),
                  '') != COALESCE([src].[id], '') OR COALESCE(CAST(
                                                                 [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK].[name] AS varchar(4000)),
                                                              '') != COALESCE([src].[name], ''))
DELETE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57832cc7f0_97841948]
WHERE
    EXISTS(SELECT *
    FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK]
    WHERE
            [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK].[id] = COALESCE(
           [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57832cc7f0_97841948].[id],
           ''))
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5784d1b597_15980394] ([id], [name])
SELECT
    a.[id]
  , a.[name]
FROM
    (SELECT
         [id]
       , [name]
       , ROW_NUMBER() OVER (PARTITION BY [id] ORDER BY [id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57832cc7f0_97841948]) AS a
WHERE
    a."_row_number_" = 1
DELETE
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57832cc7f0_97841948]
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK] ([id], [name], [_timestamp]) (SELECT
                                                                                                                                 CAST(COALESCE([id], '') as nvarchar(4000))   AS [id]
                                                                                                                               , CAST(COALESCE([name], '') as nvarchar(4000)) AS [name]
                                                                                                                               , '2021-04-06 12:43:48'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5784d1b597_15980394] AS [src])
COMMIT
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5784d1b597_15980394]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp_rename]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK]'
-- END CASE: SPK_PK
-- START CASE: SPK_PK_DK
--
--
-- OPERATION: Table from CSV
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK] (
    [id]         NVARCHAR(4000) NOT NULL,
    [name]       NVARCHAR(4000) NOT NULL,
    [_timestamp] DATETIME2,
    PRIMARY KEY NONCLUSTERED ([id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([name]))
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '421224901' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '421224901'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '421224901' AND c.object_id = '421224901'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5792225715_45550630] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([name])) COPY INTO [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5792225715_45550630] FROM 'https://kbcfsznsajl4ssv6zw.blob.core.windows.net/exp-15-files-384-42135-2021-04-06/languages.csv.gz'
WITH
    (FILE_TYPE='CSV', CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2021-04-06T12:44:02Z&se=2021-04-07T00:44:02Z&sp=rl&sig=XHTTXhbaPutq6s4BHag7jDahsZ7sbSg7ORW90ol8ZdA%3D'), FIELDQUOTE='"', FIELDTERMINATOR =',', ENCODING = 'UTF8', ROWTERMINATOR ='0x0A', IDENTITY_INSERT = 'OFF' , FIRSTROW =2)
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5792225715_45550630]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp]
    WITH (DISTRIBUTION = HASH ([name])) AS
SELECT
    a.[id]
  , a.[name]
  , '2021-04-06 12:44:10' AS [_timestamp]
FROM
    (SELECT
         COALESCE([id], '')                                  AS [id]
       , COALESCE([name], '')                                AS [name]
       , ROW_NUMBER() OVER (PARTITION BY [id] ORDER BY [id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5792225715_45550630]) AS a
WHERE
    a."_row_number_" = 1 RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK] TO [tableSPK_PK_DK_tmp_rename]
RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp] TO [tableSPK_PK_DK]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp_rename]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5792225715_45550630]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK]'
-- OPERATION: Load table to WS
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
DROP TABLE [WORKSPACE_42106].[tableLoaded]
SELECT name FROM sys.views WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
CREATE TABLE [WORKSPACE_42106].[tableLoaded] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000),
    PRIMARY KEY NONCLUSTERED ([id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([name]))
INSERT INTO
    [WORKSPACE_42106].[tableLoaded] ([id], [name])
SELECT
    [id]
  , [name]
FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK];
SELECT COUNT(*) AS [count] FROM [WORKSPACE_42106].[tableLoaded]
EXEC sp_spaceused '[WORKSPACE_42106].[tableLoaded]'
-- OPERATION: Load table from WS
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '469225072'
ORDER BY
    c.column_id;
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '453225015' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '453225015'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '453225015' AND c.object_id = '453225015'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57a7cea656_27942215] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([name]))
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57a7cea656_27942215] ([id], [name])
SELECT
    [id]
  , [name]
FROM [WORKSPACE_42106].[tableLoaded]
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57a7cea656_27942215]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp]
    WITH (DISTRIBUTION = HASH ([name])) AS
SELECT
    a.[id]
  , a.[name]
  , '2021-04-06 12:44:26' AS [_timestamp]
FROM
    (SELECT
         CAST(COALESCE([id], '') as nvarchar(4000))          AS [id]
       , CAST(COALESCE([name], '') as nvarchar(4000))        AS [name]
       , ROW_NUMBER() OVER (PARTITION BY [id] ORDER BY [id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57a7cea656_27942215]) AS a
WHERE
    a."_row_number_" = 1 RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK] TO [tableSPK_PK_DK_tmp_rename]
RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp] TO [tableSPK_PK_DK]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp_rename]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57a7cea656_27942215]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK]'
-- OPERATION: Table from CSV inc
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_DK] (
    [id]         NVARCHAR(4000) NOT NULL,
    [name]       NVARCHAR(4000) NOT NULL,
    [_timestamp] DATETIME2,
    PRIMARY KEY NONCLUSTERED ([id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([name]))
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_DK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '517225243' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '517225243'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '517225243' AND c.object_id = '517225243'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57b5b609e4_66274800] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([name])) COPY INTO [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57b5b609e4_66274800] FROM 'https://kbcfsznsajl4ssv6zw.blob.core.windows.net/exp-15-files-384-42142-2021-04-06/languages.increment.csv.gz'
WITH
    (FILE_TYPE='CSV', CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2021-04-06T12:44:37Z&se=2021-04-07T00:44:37Z&sp=rl&sig=3l6kV89Ax0rxQNlqM2YwXgwBVh%2FMsQzSUqo1Q6EWO%2BE%3D'), FIELDQUOTE='"', FIELDTERMINATOR =',', ENCODING = 'UTF8', ROWTERMINATOR ='0x0A', IDENTITY_INSERT = 'OFF' , FIRSTROW =2)
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57b5b609e4_66274800]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_DK_tmp]
    WITH (DISTRIBUTION = HASH ([name])) AS
SELECT
    a.[id]
  , a.[name]
  , '2021-04-06 12:44:41' AS [_timestamp]
FROM
    (SELECT
         COALESCE([id], '')                                  AS [id]
       , COALESCE([name], '')                                AS [name]
       , ROW_NUMBER() OVER (PARTITION BY [id] ORDER BY [id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57b5b609e4_66274800]) AS a
WHERE
    a."_row_number_" = 1 RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_DK] TO [tableIncSPK_PK_DK_tmp_rename]
RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_DK_tmp] TO [tableIncSPK_PK_DK]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_DK_tmp_rename]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57b5b609e4_66274800]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_DK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_DK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_DK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_DK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_DK]'
-- OPERATION: Load table to WS inc
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '469225072'
ORDER BY
    c.column_id;
CREATE TABLE [WORKSPACE_42106].[__temp_validation606c57c12ed330_05457933] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000),
    PRIMARY KEY NONCLUSTERED ([id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([name]));
SELECT OBJECT_ID(N'[WORKSPACE_42106].[__temp_validation606c57c12ed330_05457933]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '565225414'
ORDER BY
    c.column_id;
DROP TABLE [WORKSPACE_42106].[__temp_validation606c57c12ed330_05457933]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]', N'U') IS NULL
CREATE TABLE [WORKSPACE_42106].[tableLoaded] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000),
    PRIMARY KEY NONCLUSTERED ([id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([name]))
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '469225072' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '469225072'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '469225072' AND c.object_id = '469225072'
CREATE TABLE [WORKSPACE_42106].[#__temp_csvimport606c57c340bd42_04853102] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([name]))
INSERT INTO
    [WORKSPACE_42106].[#__temp_csvimport606c57c340bd42_04853102] ([id], [name])
SELECT
    [id]
  , [name]
FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncSPK_PK_DK]
SELECT COUNT(*) AS [count] FROM [WORKSPACE_42106].[#__temp_csvimport606c57c340bd42_04853102]
CREATE TABLE [WORKSPACE_42106].[#__temp_csvimport606c57c5ce4c03_04976925] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([name]))
BEGIN TRANSACTION
UPDATE [WORKSPACE_42106].[tableLoaded]
SET
    [name] = COALESCE([src].[name], '')
FROM [WORKSPACE_42106].[#__temp_csvimport606c57c340bd42_04853102] AS [src]
WHERE
    [WORKSPACE_42106].[tableLoaded].[id] = COALESCE([src].[id], '') AND
    (COALESCE(CAST([WORKSPACE_42106].[tableLoaded].[id] AS varchar(4000)), '') != COALESCE([src].[id], '') OR
     COALESCE(CAST([WORKSPACE_42106].[tableLoaded].[name] AS varchar(4000)), '') != COALESCE([src].[name], ''))
DELETE [WORKSPACE_42106].[#__temp_csvimport606c57c340bd42_04853102]
WHERE
    EXISTS(SELECT *
    FROM [WORKSPACE_42106].[tableLoaded]
    WHERE
            [WORKSPACE_42106].[tableLoaded].[id] =
            COALESCE([WORKSPACE_42106].[#__temp_csvimport606c57c340bd42_04853102].[id], ''))
INSERT INTO
    [WORKSPACE_42106].[#__temp_csvimport606c57c5ce4c03_04976925] ([id], [name])
SELECT
    a.[id]
  , a.[name]
FROM
    (SELECT
         [id]
       , [name]
       , ROW_NUMBER() OVER (PARTITION BY [id] ORDER BY [id]) AS "_row_number_"
    FROM [WORKSPACE_42106].[#__temp_csvimport606c57c340bd42_04853102]) AS a
WHERE
    a."_row_number_" = 1
DELETE FROM [WORKSPACE_42106].[#__temp_csvimport606c57c340bd42_04853102]
INSERT INTO
    [WORKSPACE_42106].[tableLoaded] ([id], [name]) (SELECT
                                                        CAST(COALESCE([id], '') as nvarchar(4000))   AS [id]
                                                      , CAST(COALESCE([name], '') as nvarchar(4000)) AS [name]
FROM [WORKSPACE_42106].[#__temp_csvimport606c57c5ce4c03_04976925] AS [src])
COMMIT
DROP TABLE [WORKSPACE_42106].[#__temp_csvimport606c57c5ce4c03_04976925]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded_tmp]', N'U') IS NOT NULL DROP TABLE [WORKSPACE_42106].[tableLoaded_tmp]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded_tmp_rename]', N'U') IS NOT NULL
    DROP TABLE [WORKSPACE_42106].[tableLoaded_tmp_rename]
EXEC sp_spaceused '[WORKSPACE_42106].[tableLoaded]'
-- OPERATION: Load table from WS inc
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '469225072'
ORDER BY
    c.column_id;
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '501225186' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '501225186'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '501225186' AND c.object_id = '501225186'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57d25d5806_82996578] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([name]))
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57d25d5806_82996578] ([id], [name])
SELECT
    [id]
  , [name]
FROM [WORKSPACE_42106].[tableLoaded]
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57d25d5806_82996578]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57d464f1a7_72470961] (
    [id]   nvarchar(4000),
    [name] nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([name]))
BEGIN TRANSACTION
UPDATE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK]
SET
    [name] = COALESCE([src].[name], ''), [_timestamp] = '2021-04-06 12:45:08'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57d25d5806_82996578] AS [src]
WHERE
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK].[id] =
        COALESCE([src].[id], '') AND
        (COALESCE(CAST(
                     [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK].[id] AS varchar(4000)),
                  '') != COALESCE([src].[id], '') OR COALESCE(CAST(
                                                                 [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK].[name] AS varchar(4000)),
                                                              '') != COALESCE([src].[name], ''))
DELETE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57d25d5806_82996578]
WHERE
    EXISTS(SELECT *
    FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK]
    WHERE
            [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK].[id] =
            COALESCE(
               [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57d25d5806_82996578].[id],
               ''))
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57d464f1a7_72470961] ([id], [name])
SELECT
    a.[id]
  , a.[name]
FROM
    (SELECT
         [id]
       , [name]
       , ROW_NUMBER() OVER (PARTITION BY [id] ORDER BY [id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57d25d5806_82996578]) AS a
WHERE
    a."_row_number_" = 1
DELETE
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57d25d5806_82996578]
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK] ([id], [name], [_timestamp]) (SELECT
                                                                                                                                    CAST(COALESCE([id], '') as nvarchar(4000))   AS [id]
                                                                                                                                  , CAST(COALESCE([name], '') as nvarchar(4000)) AS [name]
                                                                                                                                  , '2021-04-06 12:45:08'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57d464f1a7_72470961] AS [src])
COMMIT
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57d464f1a7_72470961]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableSPK_PK_DK]'
-- END CASE: SPK_PK_DK
-- START CASE: MPK_NO_PK
--
--
-- OPERATION: Table from CSV
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK] (
    [id]         NVARCHAR(4000) NOT NULL,
    [sub_id]     NVARCHAR(4000) NOT NULL,
    [name]       NVARCHAR(4000) NOT NULL,
    [_timestamp] DATETIME2
)
    WITH (DISTRIBUTION = ROUND_ROBIN)
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '597225528' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '597225528'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '597225528' AND c.object_id = '597225528'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57e1e4deb3_66530979] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN) COPY INTO [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57e1e4deb3_66530979] FROM 'https://kbcfsznsajl4ssv6zw.blob.core.windows.net/exp-15-files-384-42149-2021-04-06/pk.multiple.csv.gz'
WITH
    (FILE_TYPE='CSV', CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2021-04-06T12:45:21Z&se=2021-04-07T00:45:21Z&sp=rl&sig=B1nVsTmafkOZl9KHSBHGtqtSC6IYmOE1jZ%2BzhfvjF8c%3D'), FIELDQUOTE='"', FIELDTERMINATOR =',', ENCODING = 'UTF8', ROWTERMINATOR ='0x0A', IDENTITY_INSERT = 'OFF' , FIRSTROW =2)
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57e1e4deb3_66530979]
BEGIN TRANSACTION
DELETE FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK]
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK] ([id], [sub_id], [name], [_timestamp]) (SELECT
                                                                                                                                              CAST(COALESCE([id], '') as nvarchar(4000))     AS [id]
                                                                                                                                            , CAST(COALESCE([sub_id], '') as nvarchar(4000)) AS [sub_id]
                                                                                                                                            , CAST(COALESCE([name], '') as nvarchar(4000))   AS [name]
                                                                                                                                            , '2021-04-06 12:45:25'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57e1e4deb3_66530979] AS [src])
COMMIT
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57e1e4deb3_66530979]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK]'
-- OPERATION: Load table to WS
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
DROP TABLE [WORKSPACE_42106].[tableLoaded]
SELECT name FROM sys.views WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
CREATE TABLE [WORKSPACE_42106].[tableLoaded] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (DISTRIBUTION = ROUND_ROBIN)
INSERT INTO
    [WORKSPACE_42106].[tableLoaded] ([id], [sub_id], [name])
SELECT
    [id]
  , [sub_id]
  , [name]
FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK];
SELECT COUNT(*) AS [count] FROM [WORKSPACE_42106].[tableLoaded]
EXEC sp_spaceused '[WORKSPACE_42106].[tableLoaded]'
-- OPERATION: Load table from WS
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '613225585'
ORDER BY
    c.column_id;
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '597225528' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '597225528'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '597225528' AND c.object_id = '597225528'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57f117b7b7_06616514] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN)
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57f117b7b7_06616514] ([id], [sub_id], [name])
SELECT
    [id]
  , [sub_id]
  , [name]
FROM [WORKSPACE_42106].[tableLoaded]
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57f117b7b7_06616514]
BEGIN TRANSACTION
DELETE FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK]
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK] ([id], [sub_id], [name], [_timestamp]) (SELECT
                                                                                                                                              CAST(COALESCE([id], '') as nvarchar(4000))     AS [id]
                                                                                                                                            , CAST(COALESCE([sub_id], '') as nvarchar(4000)) AS [sub_id]
                                                                                                                                            , CAST(COALESCE([name], '') as nvarchar(4000))   AS [name]
                                                                                                                                            , '2021-04-06 12:45:39'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57f117b7b7_06616514] AS [src])
COMMIT
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57f117b7b7_06616514]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK]'
-- OPERATION: Table from CSV inc
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_NO_PK] (
    [id]         NVARCHAR(4000) NOT NULL,
    [sub_id]     NVARCHAR(4000) NOT NULL,
    [name]       NVARCHAR(4000) NOT NULL,
    [_timestamp] DATETIME2
)
    WITH (DISTRIBUTION = ROUND_ROBIN)
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_NO_PK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '629225642' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '629225642'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '629225642' AND c.object_id = '629225642'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57fd4f6cf1_72835444] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN) COPY INTO [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57fd4f6cf1_72835444] FROM 'https://kbcfsznsajl4ssv6zw.blob.core.windows.net/exp-15-files-384-42156-2021-04-06/pk.multiple.increment.csv.gz'
WITH
    (FILE_TYPE='CSV', CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2021-04-06T12:45:49Z&se=2021-04-07T00:45:49Z&sp=rl&sig=NGGfZQnAdSTDTCN8%2F368MdJncPJ0Y3MVrcdUHQkcrMI%3D'), FIELDQUOTE='"', FIELDTERMINATOR =',', ENCODING = 'UTF8', ROWTERMINATOR ='0x0A', IDENTITY_INSERT = 'OFF' , FIRSTROW =2)
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57fd4f6cf1_72835444]
BEGIN TRANSACTION
DELETE FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_NO_PK]
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_NO_PK] ([id], [sub_id], [name], [_timestamp]) (SELECT
                                                                                                                                                 CAST(COALESCE([id], '') as nvarchar(4000))     AS [id]
                                                                                                                                               , CAST(COALESCE([sub_id], '') as nvarchar(4000)) AS [sub_id]
                                                                                                                                               , CAST(COALESCE([name], '') as nvarchar(4000))   AS [name]
                                                                                                                                               , '2021-04-06 12:45:54'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57fd4f6cf1_72835444] AS [src])
COMMIT
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c57fd4f6cf1_72835444]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_NO_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_NO_PK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_NO_PK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_NO_PK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_NO_PK]'
-- OPERATION: Load table to WS inc
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '613225585'
ORDER BY
    c.column_id;
CREATE TABLE [WORKSPACE_42106].[__temp_validation606c5807def3a6_83973531] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (DISTRIBUTION = ROUND_ROBIN);
SELECT OBJECT_ID(N'[WORKSPACE_42106].[__temp_validation606c5807def3a6_83973531]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '645225699'
ORDER BY
    c.column_id;
DROP TABLE [WORKSPACE_42106].[__temp_validation606c5807def3a6_83973531]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]', N'U') IS NULL
CREATE TABLE [WORKSPACE_42106].[tableLoaded] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (DISTRIBUTION = ROUND_ROBIN)
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '613225585' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '613225585'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '613225585' AND c.object_id = '613225585'
CREATE TABLE [WORKSPACE_42106].[#__temp_csvimport606c580961b839_21484225] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN)
INSERT INTO
    [WORKSPACE_42106].[#__temp_csvimport606c580961b839_21484225] ([id], [sub_id], [name])
SELECT
    [id]
  , [sub_id]
  , [name]
FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_NO_PK]
SELECT COUNT(*) AS [count] FROM [WORKSPACE_42106].[#__temp_csvimport606c580961b839_21484225]
CREATE TABLE [WORKSPACE_42106].[#__temp_csvimport606c580bcecd15_02963950] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN)
BEGIN TRANSACTION
INSERT INTO
    [WORKSPACE_42106].[tableLoaded] ([id], [sub_id], [name]) (SELECT
                                                                  CAST(COALESCE([id], '') as nvarchar(4000))     AS [id]
                                                                , CAST(COALESCE([sub_id], '') as nvarchar(4000)) AS [sub_id]
                                                                , CAST(COALESCE([name], '') as nvarchar(4000))   AS [name]
FROM [WORKSPACE_42106].[#__temp_csvimport606c580961b839_21484225] AS [src])
COMMIT
DROP TABLE [WORKSPACE_42106].[#__temp_csvimport606c580961b839_21484225]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded_tmp]', N'U') IS NOT NULL DROP TABLE [WORKSPACE_42106].[tableLoaded_tmp]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded_tmp_rename]', N'U') IS NOT NULL
    DROP TABLE [WORKSPACE_42106].[tableLoaded_tmp_rename]
EXEC sp_spaceused '[WORKSPACE_42106].[tableLoaded]'
-- OPERATION: Load table from WS inc
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '613225585'
ORDER BY
    c.column_id;
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '597225528' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '597225528'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '597225528' AND c.object_id = '597225528'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5810598e75_16168142] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN)
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5810598e75_16168142] ([id], [sub_id], [name])
SELECT
    [id]
  , [sub_id]
  , [name]
FROM [WORKSPACE_42106].[tableLoaded]
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5810598e75_16168142]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58138160a6_12094328] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN)
BEGIN TRANSACTION
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK] ([id], [sub_id], [name], [_timestamp]) (SELECT
                                                                                                                                              CAST(COALESCE([id], '') as nvarchar(4000))     AS [id]
                                                                                                                                            , CAST(COALESCE([sub_id], '') as nvarchar(4000)) AS [sub_id]
                                                                                                                                            , CAST(COALESCE([name], '') as nvarchar(4000))   AS [name]
                                                                                                                                            , '2021-04-06 12:46:11'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5810598e75_16168142] AS [src])
COMMIT
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5810598e75_16168142]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_NO_PK]'
-- END CASE: MPK_NO_PK
-- START CASE: MPK_PK
--
--
-- OPERATION: Table from CSV
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK] (
    [id]         NVARCHAR(4000) NOT NULL,
    [sub_id]     NVARCHAR(4000) NOT NULL,
    [name]       NVARCHAR(4000) NOT NULL,
    [_timestamp] DATETIME2,
    PRIMARY KEY NONCLUSTERED ([id], [sub_id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = ROUND_ROBIN)
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '661225756' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '661225756'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '661225756' AND c.object_id = '661225756'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c581bc96463_00187265] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN) COPY INTO [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c581bc96463_00187265] FROM 'https://kbcfsznsajl4ssv6zw.blob.core.windows.net/exp-15-files-384-42163-2021-04-06/pk.multiple.csv.gz'
WITH
    (FILE_TYPE='CSV', CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2021-04-06T12:46:19Z&se=2021-04-07T00:46:19Z&sp=rl&sig=AaheHZEG5Br3IcMQ81vq3yK%2FnDXIu9ti4PUXITY1sv8%3D'), FIELDQUOTE='"', FIELDTERMINATOR =',', ENCODING = 'UTF8', ROWTERMINATOR ='0x0A', IDENTITY_INSERT = 'OFF' , FIRSTROW =2)
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c581bc96463_00187265]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp]
    WITH (DISTRIBUTION = ROUND_ROBIN) AS
SELECT
    a.[id]
  , a.[sub_id]
  , a.[name]
  , '2021-04-06 12:46:23' AS [_timestamp]
FROM
    (SELECT
         COALESCE([id], '')                                                    AS [id]
       , COALESCE([sub_id], '')                                                AS [sub_id]
       , COALESCE([name], '')                                                  AS [name]
       , ROW_NUMBER() OVER (PARTITION BY [id],[sub_id] ORDER BY [id],[sub_id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c581bc96463_00187265]) AS a
WHERE
    a."_row_number_" = 1 RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK] TO [tableMPK_PK_tmp_rename]
RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp] TO [tableMPK_PK]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp_rename]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c581bc96463_00187265]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp_rename]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK]'
-- OPERATION: Load table to WS
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
DROP TABLE [WORKSPACE_42106].[tableLoaded]
SELECT name FROM sys.views WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
CREATE TABLE [WORKSPACE_42106].[tableLoaded] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000),
    PRIMARY KEY NONCLUSTERED ([id], [sub_id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = ROUND_ROBIN)
INSERT INTO
    [WORKSPACE_42106].[tableLoaded] ([id], [sub_id], [name])
SELECT
    [id]
  , [sub_id]
  , [name]
FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK];
SELECT COUNT(*) AS [count] FROM [WORKSPACE_42106].[tableLoaded]
EXEC sp_spaceused '[WORKSPACE_42106].[tableLoaded]'
-- OPERATION: Load table from WS
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '709225927'
ORDER BY
    c.column_id;
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '693225870' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '693225870'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '693225870' AND c.object_id = '693225870'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c582b3d4f37_54469636] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN)
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c582b3d4f37_54469636] ([id], [sub_id], [name])
SELECT
    [id]
  , [sub_id]
  , [name]
FROM [WORKSPACE_42106].[tableLoaded]
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c582b3d4f37_54469636]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp]
    WITH (DISTRIBUTION = ROUND_ROBIN) AS
SELECT
    a.[id]
  , a.[sub_id]
  , a.[name]
  , '2021-04-06 12:46:37' AS [_timestamp]
FROM
    (SELECT
         CAST(COALESCE([id], '') as nvarchar(4000))                            AS [id]
       , CAST(COALESCE([sub_id], '') as nvarchar(4000))                        AS [sub_id]
       , CAST(COALESCE([name], '') as nvarchar(4000))                          AS [name]
       , ROW_NUMBER() OVER (PARTITION BY [id],[sub_id] ORDER BY [id],[sub_id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c582b3d4f37_54469636]) AS a
WHERE
    a."_row_number_" = 1 RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK] TO [tableMPK_PK_tmp_rename]
RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp] TO [tableMPK_PK]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp_rename]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c582b3d4f37_54469636]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp_rename]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK]'
-- OPERATION: Table from CSV inc
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK] (
    [id]         NVARCHAR(4000) NOT NULL,
    [sub_id]     NVARCHAR(4000) NOT NULL,
    [name]       NVARCHAR(4000) NOT NULL,
    [_timestamp] DATETIME2,
    PRIMARY KEY NONCLUSTERED ([id], [sub_id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = ROUND_ROBIN)
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '757226098' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '757226098'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '757226098' AND c.object_id = '757226098'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5837629cc7_06627730] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN) COPY INTO [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5837629cc7_06627730] FROM 'https://kbcfsznsajl4ssv6zw.blob.core.windows.net/exp-15-files-384-42170-2021-04-06/pk.multiple.increment.csv.gz'
WITH
    (FILE_TYPE='CSV', CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2021-04-06T12:46:47Z&se=2021-04-07T00:46:47Z&sp=rl&sig=%2FxpjDYTWN749SC41kPsivmXSBnI51Xte0lVLwGBGZw4%3D'), FIELDQUOTE='"', FIELDTERMINATOR =',', ENCODING = 'UTF8', ROWTERMINATOR ='0x0A', IDENTITY_INSERT = 'OFF' , FIRSTROW =2)
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5837629cc7_06627730]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_tmp]
    WITH (DISTRIBUTION = ROUND_ROBIN) AS
SELECT
    a.[id]
  , a.[sub_id]
  , a.[name]
  , '2021-04-06 12:46:51' AS [_timestamp]
FROM
    (SELECT
         COALESCE([id], '')                                                    AS [id]
       , COALESCE([sub_id], '')                                                AS [sub_id]
       , COALESCE([name], '')                                                  AS [name]
       , ROW_NUMBER() OVER (PARTITION BY [id],[sub_id] ORDER BY [id],[sub_id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5837629cc7_06627730]) AS a
WHERE
    a."_row_number_" = 1 RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK] TO [tableIncMPK_PK_tmp_rename]
RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_tmp] TO [tableIncMPK_PK]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_tmp_rename]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5837629cc7_06627730]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK]'
-- OPERATION: Load table to WS inc
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '709225927'
ORDER BY
    c.column_id;
CREATE TABLE [WORKSPACE_42106].[__temp_validation606c5844cff391_88958211] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000),
    PRIMARY KEY NONCLUSTERED ([id], [sub_id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = ROUND_ROBIN);
SELECT OBJECT_ID(N'[WORKSPACE_42106].[__temp_validation606c5844cff391_88958211]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '805226269'
ORDER BY
    c.column_id;
DROP TABLE [WORKSPACE_42106].[__temp_validation606c5844cff391_88958211]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]', N'U') IS NULL
CREATE TABLE [WORKSPACE_42106].[tableLoaded] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000),
    PRIMARY KEY NONCLUSTERED ([id], [sub_id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = ROUND_ROBIN)
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '709225927' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '709225927'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '709225927' AND c.object_id = '709225927'
CREATE TABLE [WORKSPACE_42106].[#__temp_csvimport606c5847336a52_59090335] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN)
INSERT INTO
    [WORKSPACE_42106].[#__temp_csvimport606c5847336a52_59090335] ([id], [sub_id], [name])
SELECT
    [id]
  , [sub_id]
  , [name]
FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK]
SELECT COUNT(*) AS [count] FROM [WORKSPACE_42106].[#__temp_csvimport606c5847336a52_59090335]
CREATE TABLE [WORKSPACE_42106].[#__temp_csvimport606c584b00b851_72191537] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN)
BEGIN TRANSACTION
UPDATE [WORKSPACE_42106].[tableLoaded]
SET
    [name] = COALESCE([src].[name], '')
FROM [WORKSPACE_42106].[#__temp_csvimport606c5847336a52_59090335] AS [src]
WHERE
    [WORKSPACE_42106].[tableLoaded].[id] = COALESCE([src].[id], '') AND
    [WORKSPACE_42106].[tableLoaded].[sub_id] = COALESCE([src].[sub_id], '') AND
    (COALESCE(CAST([WORKSPACE_42106].[tableLoaded].[id] AS varchar(4000)), '') != COALESCE([src].[id], '') OR
     COALESCE(CAST([WORKSPACE_42106].[tableLoaded].[sub_id] AS varchar(4000)), '') != COALESCE([src].[sub_id], '') OR
     COALESCE(CAST([WORKSPACE_42106].[tableLoaded].[name] AS varchar(4000)), '') != COALESCE([src].[name], ''))
DELETE [WORKSPACE_42106].[#__temp_csvimport606c5847336a52_59090335]
WHERE
    EXISTS(SELECT *
    FROM [WORKSPACE_42106].[tableLoaded]
    WHERE
            [WORKSPACE_42106].[tableLoaded].[id] =
            COALESCE([WORKSPACE_42106].[#__temp_csvimport606c5847336a52_59090335].[id], '') AND
            [WORKSPACE_42106].[tableLoaded].[sub_id] =
            COALESCE([WORKSPACE_42106].[#__temp_csvimport606c5847336a52_59090335].[sub_id], ''))
INSERT INTO
    [WORKSPACE_42106].[#__temp_csvimport606c584b00b851_72191537] ([id], [sub_id], [name])
SELECT
    a.[id]
  , a.[sub_id]
  , a.[name]
FROM
    (SELECT
         [id]
       , [sub_id]
       , [name]
       , ROW_NUMBER() OVER (PARTITION BY [id],[sub_id] ORDER BY [id],[sub_id]) AS "_row_number_"
    FROM [WORKSPACE_42106].[#__temp_csvimport606c5847336a52_59090335]) AS a
WHERE
    a."_row_number_" = 1
DELETE FROM [WORKSPACE_42106].[#__temp_csvimport606c5847336a52_59090335]
INSERT INTO
    [WORKSPACE_42106].[tableLoaded] ([id], [sub_id], [name]) (SELECT
                                                                  CAST(COALESCE([id], '') as nvarchar(4000))     AS [id]
                                                                , CAST(COALESCE([sub_id], '') as nvarchar(4000)) AS [sub_id]
                                                                , CAST(COALESCE([name], '') as nvarchar(4000))   AS [name]
FROM [WORKSPACE_42106].[#__temp_csvimport606c584b00b851_72191537] AS [src])
COMMIT
DROP TABLE [WORKSPACE_42106].[#__temp_csvimport606c584b00b851_72191537]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded_tmp]', N'U') IS NOT NULL DROP TABLE [WORKSPACE_42106].[tableLoaded_tmp]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded_tmp_rename]', N'U') IS NOT NULL
    DROP TABLE [WORKSPACE_42106].[tableLoaded_tmp_rename]
EXEC sp_spaceused '[WORKSPACE_42106].[tableLoaded]'
-- OPERATION: Load table from WS inc
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '709225927'
ORDER BY
    c.column_id;
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '741226041' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '741226041'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '741226041' AND c.object_id = '741226041'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c585c1f2232_98471504] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN)
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c585c1f2232_98471504] ([id], [sub_id], [name])
SELECT
    [id]
  , [sub_id]
  , [name]
FROM [WORKSPACE_42106].[tableLoaded]
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c585c1f2232_98471504]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5860a3a785_11240844] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = ROUND_ROBIN)
BEGIN TRANSACTION
UPDATE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK]
SET
    [name] = COALESCE([src].[name], ''), [_timestamp] = '2021-04-06 12:47:28'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c585c1f2232_98471504] AS [src]
WHERE
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK].[id] =
        COALESCE([src].[id], '') AND
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK].[sub_id] =
        COALESCE([src].[sub_id], '') AND
        (COALESCE(CAST(
                     [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK].[id] AS varchar(4000)),
                  '') != COALESCE([src].[id], '') OR COALESCE(CAST(
                                                                 [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK].[sub_id] AS varchar(4000)),
                                                              '') != COALESCE([src].[sub_id], '') OR COALESCE(CAST(
                                                                                                                 [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK].[name] AS varchar(4000)),
                                                                                                              '') !=
                                                                                                     COALESCE([src].[name], ''))
DELETE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c585c1f2232_98471504]
WHERE
    EXISTS(SELECT *
    FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK]
    WHERE
            [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK].[id] = COALESCE(
           [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c585c1f2232_98471504].[id],
           '') AND
            [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK].[sub_id] =
            COALESCE(
               [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c585c1f2232_98471504].[sub_id],
               ''))
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5860a3a785_11240844] ([id], [sub_id], [name])
SELECT
    a.[id]
  , a.[sub_id]
  , a.[name]
FROM
    (SELECT
         [id]
       , [sub_id]
       , [name]
       , ROW_NUMBER() OVER (PARTITION BY [id],[sub_id] ORDER BY [id],[sub_id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c585c1f2232_98471504]) AS a
WHERE
    a."_row_number_" = 1
DELETE
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c585c1f2232_98471504]
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK] ([id], [sub_id], [name], [_timestamp]) (SELECT
                                                                                                                                           CAST(COALESCE([id], '') as nvarchar(4000))     AS [id]
                                                                                                                                         , CAST(COALESCE([sub_id], '') as nvarchar(4000)) AS [sub_id]
                                                                                                                                         , CAST(COALESCE([name], '') as nvarchar(4000))   AS [name]
                                                                                                                                         , '2021-04-06 12:47:28'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5860a3a785_11240844] AS [src])
COMMIT
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c5860a3a785_11240844]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp_rename]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK]'
-- END CASE: MPK_PK
-- START CASE: MPK_PK_DK
--
--
-- OPERATION: Table from CSV
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK] (
    [id]         NVARCHAR(4000) NOT NULL,
    [sub_id]     NVARCHAR(4000) NOT NULL,
    [name]       NVARCHAR(4000) NOT NULL,
    [_timestamp] DATETIME2,
    PRIMARY KEY NONCLUSTERED ([id], [sub_id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([id]))
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '837226383' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '837226383'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '837226383' AND c.object_id = '837226383'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c586c5c41d2_81238560] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id])) COPY INTO [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c586c5c41d2_81238560] FROM 'https://kbcfsznsajl4ssv6zw.blob.core.windows.net/exp-15-files-384-42177-2021-04-06/pk.multiple.csv.gz'
WITH
    (FILE_TYPE='CSV', CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2021-04-06T12:47:40Z&se=2021-04-07T00:47:40Z&sp=rl&sig=6MOM%2FUMhGwImghKql8md4BSKp%2BCIApcTket7dO6LH0c%3D'), FIELDQUOTE='"', FIELDTERMINATOR =',', ENCODING = 'UTF8', ROWTERMINATOR ='0x0A', IDENTITY_INSERT = 'OFF' , FIRSTROW =2)
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c586c5c41d2_81238560]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp]
    WITH (DISTRIBUTION = HASH ([id])) AS
SELECT
    a.[id]
  , a.[sub_id]
  , a.[name]
  , '2021-04-06 12:47:43' AS [_timestamp]
FROM
    (SELECT
         COALESCE([id], '')                                                    AS [id]
       , COALESCE([sub_id], '')                                                AS [sub_id]
       , COALESCE([name], '')                                                  AS [name]
       , ROW_NUMBER() OVER (PARTITION BY [id],[sub_id] ORDER BY [id],[sub_id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c586c5c41d2_81238560]) AS a
WHERE
    a."_row_number_" = 1 RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK] TO [tableMPK_PK_DK_tmp_rename]
RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp] TO [tableMPK_PK_DK]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp_rename]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c586c5c41d2_81238560]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK]'
-- OPERATION: Load table to WS
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
DROP TABLE [WORKSPACE_42106].[tableLoaded]
SELECT name FROM sys.views WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
CREATE TABLE [WORKSPACE_42106].[tableLoaded] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000),
    PRIMARY KEY NONCLUSTERED ([id], [sub_id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([id]))
INSERT INTO
    [WORKSPACE_42106].[tableLoaded] ([id], [sub_id], [name])
SELECT
    [id]
  , [sub_id]
  , [name]
FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK];
SELECT COUNT(*) AS [count] FROM [WORKSPACE_42106].[tableLoaded]
EXEC sp_spaceused '[WORKSPACE_42106].[tableLoaded]'
-- OPERATION: Load table from WS
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '885226554'
ORDER BY
    c.column_id;
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '869226497' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '869226497'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '869226497' AND c.object_id = '869226497'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c587cd83579_92414416] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id]))
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c587cd83579_92414416] ([id], [sub_id], [name])
SELECT
    [id]
  , [sub_id]
  , [name]
FROM [WORKSPACE_42106].[tableLoaded]
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c587cd83579_92414416]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp]
    WITH (DISTRIBUTION = HASH ([id])) AS
SELECT
    a.[id]
  , a.[sub_id]
  , a.[name]
  , '2021-04-06 12:47:58' AS [_timestamp]
FROM
    (SELECT
         CAST(COALESCE([id], '') as nvarchar(4000))                            AS [id]
       , CAST(COALESCE([sub_id], '') as nvarchar(4000))                        AS [sub_id]
       , CAST(COALESCE([name], '') as nvarchar(4000))                          AS [name]
       , ROW_NUMBER() OVER (PARTITION BY [id],[sub_id] ORDER BY [id],[sub_id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c587cd83579_92414416]) AS a
WHERE
    a."_row_number_" = 1 RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK] TO [tableMPK_PK_DK_tmp_rename]
RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp] TO [tableMPK_PK_DK]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp_rename]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c587cd83579_92414416]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK]'
-- OPERATION: Table from CSV inc
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_DK] (
    [id]         NVARCHAR(4000) NOT NULL,
    [sub_id]     NVARCHAR(4000) NOT NULL,
    [name]       NVARCHAR(4000) NOT NULL,
    [_timestamp] DATETIME2,
    PRIMARY KEY NONCLUSTERED ([id], [sub_id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([id]))
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_DK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '933226725' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '933226725'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '933226725' AND c.object_id = '933226725'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c588e164b41_40254602] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id])) COPY INTO [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c588e164b41_40254602] FROM 'https://kbcfsznsajl4ssv6zw.blob.core.windows.net/exp-15-files-384-42184-2021-04-06/pk.multiple.increment.csv.gz'
WITH
    (FILE_TYPE='CSV', CREDENTIAL =(IDENTITY ='Shared Access Signature', SECRET ='?sv=2017-11-09&sr=c&st=2021-04-06T12:48:14Z&se=2021-04-07T00:48:14Z&sp=rl&sig=Xfco7NSzO97QEXjuEER0%2Bx%2BD1Pt%2FxrJvd4MWMhZYrxo%3D'), FIELDQUOTE='"', FIELDTERMINATOR =',', ENCODING = 'UTF8', ROWTERMINATOR ='0x0A', IDENTITY_INSERT = 'OFF' , FIRSTROW =2)
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c588e164b41_40254602]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_DK_tmp]
    WITH (DISTRIBUTION = HASH ([id])) AS
SELECT
    a.[id]
  , a.[sub_id]
  , a.[name]
  , '2021-04-06 12:48:18' AS [_timestamp]
FROM
    (SELECT
         COALESCE([id], '')                                                    AS [id]
       , COALESCE([sub_id], '')                                                AS [sub_id]
       , COALESCE([name], '')                                                  AS [name]
       , ROW_NUMBER() OVER (PARTITION BY [id],[sub_id] ORDER BY [id],[sub_id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c588e164b41_40254602]) AS a
WHERE
    a."_row_number_" = 1 RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_DK] TO [tableIncMPK_PK_DK_tmp_rename]
RENAME OBJECT [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_DK_tmp] TO [tableIncMPK_PK_DK]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_DK_tmp_rename]
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c588e164b41_40254602]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_DK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_DK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_DK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_DK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_DK]'
-- OPERATION: Load table to WS inc
SELECT name FROM sys.tables WHERE schema_name(schema_id) = 'WORKSPACE_42106' order by name;
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '885226554'
ORDER BY
    c.column_id;
CREATE TABLE [WORKSPACE_42106].[__temp_validation606c5899794763_09391676] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000),
    PRIMARY KEY NONCLUSTERED ([id], [sub_id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([id]));
SELECT OBJECT_ID(N'[WORKSPACE_42106].[__temp_validation606c5899794763_09391676]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '981226896'
ORDER BY
    c.column_id;
DROP TABLE [WORKSPACE_42106].[__temp_validation606c5899794763_09391676]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]', N'U') IS NULL
CREATE TABLE [WORKSPACE_42106].[tableLoaded] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000),
    PRIMARY KEY NONCLUSTERED ([id], [sub_id]) NOT ENFORCED
)
    WITH (DISTRIBUTION = HASH ([id]))
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '885226554' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '885226554'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '885226554' AND c.object_id = '885226554'
CREATE TABLE [WORKSPACE_42106].[#__temp_csvimport606c589bb6ba23_03140453] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id]))
INSERT INTO
    [WORKSPACE_42106].[#__temp_csvimport606c589bb6ba23_03140453] ([id], [sub_id], [name])
SELECT
    [id]
  , [sub_id]
  , [name]
FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableIncMPK_PK_DK]
SELECT COUNT(*) AS [count] FROM [WORKSPACE_42106].[#__temp_csvimport606c589bb6ba23_03140453]
CREATE TABLE [WORKSPACE_42106].[#__temp_csvimport606c589e762921_23326565] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id]))
BEGIN TRANSACTION
UPDATE [WORKSPACE_42106].[tableLoaded]
SET
    [name] = COALESCE([src].[name], '')
FROM [WORKSPACE_42106].[#__temp_csvimport606c589bb6ba23_03140453] AS [src]
WHERE
    [WORKSPACE_42106].[tableLoaded].[id] = COALESCE([src].[id], '') AND
    [WORKSPACE_42106].[tableLoaded].[sub_id] = COALESCE([src].[sub_id], '') AND
    (COALESCE(CAST([WORKSPACE_42106].[tableLoaded].[id] AS varchar(4000)), '') != COALESCE([src].[id], '') OR
     COALESCE(CAST([WORKSPACE_42106].[tableLoaded].[sub_id] AS varchar(4000)), '') != COALESCE([src].[sub_id], '') OR
     COALESCE(CAST([WORKSPACE_42106].[tableLoaded].[name] AS varchar(4000)), '') != COALESCE([src].[name], ''))
DELETE [WORKSPACE_42106].[#__temp_csvimport606c589bb6ba23_03140453]
WHERE
    EXISTS(SELECT *
    FROM [WORKSPACE_42106].[tableLoaded]
    WHERE
            [WORKSPACE_42106].[tableLoaded].[id] =
            COALESCE([WORKSPACE_42106].[#__temp_csvimport606c589bb6ba23_03140453].[id], '') AND
            [WORKSPACE_42106].[tableLoaded].[sub_id] =
            COALESCE([WORKSPACE_42106].[#__temp_csvimport606c589bb6ba23_03140453].[sub_id], ''))
INSERT INTO
    [WORKSPACE_42106].[#__temp_csvimport606c589e762921_23326565] ([id], [sub_id], [name])
SELECT
    a.[id]
  , a.[sub_id]
  , a.[name]
FROM
    (SELECT
         [id]
       , [sub_id]
       , [name]
       , ROW_NUMBER() OVER (PARTITION BY [id],[sub_id] ORDER BY [id],[sub_id]) AS "_row_number_"
    FROM [WORKSPACE_42106].[#__temp_csvimport606c589bb6ba23_03140453]) AS a
WHERE
    a."_row_number_" = 1
DELETE FROM [WORKSPACE_42106].[#__temp_csvimport606c589bb6ba23_03140453]
INSERT INTO
    [WORKSPACE_42106].[tableLoaded] ([id], [sub_id], [name]) (SELECT
                                                                  CAST(COALESCE([id], '') as nvarchar(4000))     AS [id]
                                                                , CAST(COALESCE([sub_id], '') as nvarchar(4000)) AS [sub_id]
                                                                , CAST(COALESCE([name], '') as nvarchar(4000))   AS [name]
FROM [WORKSPACE_42106].[#__temp_csvimport606c589e762921_23326565] AS [src])
COMMIT
DROP TABLE [WORKSPACE_42106].[#__temp_csvimport606c589e762921_23326565]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded_tmp]', N'U') IS NOT NULL DROP TABLE [WORKSPACE_42106].[tableLoaded_tmp]
IF OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded_tmp_rename]', N'U') IS NOT NULL
    DROP TABLE [WORKSPACE_42106].[tableLoaded_tmp_rename]
EXEC sp_spaceused '[WORKSPACE_42106].[tableLoaded]'
-- OPERATION: Load table from WS inc
SELECT OBJECT_ID(N'[WORKSPACE_42106].[tableLoaded]')
SELECT
    c.name        AS column_name
  , c.precision   AS column_precision
  , c.scale       AS column_scale
  , c.max_length  AS column_length
  , c.is_nullable AS column_is_nullable
  , d.definition  AS column_default
  , t.name        AS column_type
FROM
    sys.columns AS c
        JOIN sys.types AS t ON t.user_type_id = c.user_type_id
        LEFT JOIN sys.default_constraints AS d ON c.default_object_id = d.object_id
WHERE
    c.object_id = '885226554'
ORDER BY
    c.column_id;
SELECT OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK]')
SELECT [name] FROM [sys].[columns] WHERE [object_id] = '917226668' ORDER BY [column_id]
SELECT distribution_policy_desc FROM sys.pdw_table_distribution_properties AS dp WHERE dp.OBJECT_ID = '917226668'
SELECT
    c.name
FROM
    sys.pdw_column_distribution_properties AS dp
        INNER JOIN sys.columns AS c ON dp.column_id = c.column_id
WHERE
    dp.distribution_ordinal = 1 AND dp.OBJECT_ID = '917226668' AND c.object_id = '917226668'
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a5e09a87_39587193] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id]))
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a5e09a87_39587193] ([id], [sub_id], [name])
SELECT
    [id]
  , [sub_id]
  , [name]
FROM [WORKSPACE_42106].[tableLoaded]
SELECT
    COUNT(*) AS [count]
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a5e09a87_39587193]
CREATE TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a816bbc2_32722934] (
    [id]     nvarchar(4000),
    [sub_id] nvarchar(4000),
    [name]   nvarchar(4000)
)
    WITH (HEAP, LOCATION = USER_DB, DISTRIBUTION = HASH ([id]))
BEGIN TRANSACTION
UPDATE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK]
SET
    [name] = COALESCE([src].[name], ''), [_timestamp] = '2021-04-06 12:48:40'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a5e09a87_39587193] AS [src]
WHERE
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK].[id] =
        COALESCE([src].[id], '') AND
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK].[sub_id] =
        COALESCE([src].[sub_id], '') AND
        (COALESCE(CAST(
                     [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK].[id] AS varchar(4000)),
                  '') != COALESCE([src].[id], '') OR COALESCE(CAST(
                                                                 [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK].[sub_id] AS varchar(4000)),
                                                              '') != COALESCE([src].[sub_id], '') OR COALESCE(CAST(
                                                                                                                 [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK].[name] AS varchar(4000)),
                                                                                                              '') !=
                                                                                                     COALESCE([src].[name], ''))
DELETE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a5e09a87_39587193]
WHERE
    EXISTS(SELECT *
    FROM [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK]
    WHERE
            [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK].[id] =
            COALESCE(
               [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a5e09a87_39587193].[id],
               '') AND
            [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK].[sub_id] =
            COALESCE(
               [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a5e09a87_39587193].[sub_id],
               ''))
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a816bbc2_32722934] ([id], [sub_id], [name])
SELECT
    a.[id]
  , a.[sub_id]
  , a.[name]
FROM
    (SELECT
         [id]
       , [sub_id]
       , [name]
       , ROW_NUMBER() OVER (PARTITION BY [id],[sub_id] ORDER BY [id],[sub_id]) AS "_row_number_"
    FROM
        [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a5e09a87_39587193]) AS a
WHERE
    a."_row_number_" = 1
DELETE
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a5e09a87_39587193]
INSERT INTO
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK] ([id], [sub_id], [name], [_timestamp]) (SELECT
                                                                                                                                              CAST(COALESCE([id], '') as nvarchar(4000))     AS [id]
                                                                                                                                            , CAST(COALESCE([sub_id], '') as nvarchar(4000)) AS [sub_id]
                                                                                                                                            , CAST(COALESCE([name], '') as nvarchar(4000))   AS [name]
                                                                                                                                            , '2021-04-06 12:48:40'
FROM
    [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a816bbc2_32722934] AS [src])
COMMIT
DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[#__temp_csvimport606c58a816bbc2_32722934]
IF OBJECT_ID(N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp]',
             N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp]
IF OBJECT_ID(
   N'[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp_rename]',
   N'U') IS NOT NULL
    DROP TABLE [KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK_tmp_rename]
EXEC sp_spaceused '[KEBOOLA_ZAJCA_X384-in_c-API-tests-9c0ef4e0850f1b365af1c3655957cb98c8d73590].[tableMPK_PK_DK]'
-- END CASE: MPK_PK_DK