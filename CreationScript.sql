IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'GameDatabase')
BEGIN
    EXEC('CREATE SCHEMA GameDatabase')
END

--Drop all tables if they exist in the database already
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Platforms')
BEGIN
    EXEC('DROP TABLE GameDatabase.Platforms')
END


IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GamesEditions')
BEGIN
    EXEC('DROP TABLE GameDatabase.GamesEditions')
END


IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GamesConsoles')
BEGIN
    EXEC('DROP TABLE GameDatabase.GamesConsoles')
END


IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Consoles')
BEGIN
    EXEC('DROP TABLE GameDatabase.Consoles')
END


IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GameGenres')
BEGIN
    EXEC('DROP TABLE GameDatabase.GameGenres')
END


IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Genres')
BEGIN
    EXEC('DROP TABLE GameDatabase.Genres')
END


IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GamePublishers')
BEGIN
    EXEC('DROP TABLE GameDatabase.GamePublishers')
END


IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Publishers')
BEGIN
    EXEC('DROP TABLE GameDatabase.Publishers')
END


IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GameDevelopers')
BEGIN
    EXEC('DROP TABLE GameDatabase.GameDevelopers')
END


IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Developers')
BEGIN
    EXEC('DROP TABLE GameDatabase.Developers')
END

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Games')
BEGIN
    EXEC('DROP TABLE GameDatabase.Games')
END

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Regions')
BEGIN
    EXEC('DROP TABLE GameDatabase.Regions')
END


--Regions Table Creation
CREATE TABLE GameDatabase.Regions
(
    RegionID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    RegionName nvarchar(20) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)


--Games Table Creation
CREATE TABLE GameDatabase.Games
(
    GameID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    GameName nvarchar(200) NOT NULL,
    isFavorite bit DEFAULT(0) NOT NULL,
    ESRB nvarchar(4) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)


--GamesEditions Table Creation
CREATE TABLE GameDatabase.GamesEditions
(
    GameEditionID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    GameID int NOT NULL,
    GameEdition nvarchar(200) NOT NULL,
    Cost decimal(2) NOT NULL,
    CopiesOwned int NOT NULL,
    RegionID int DEFAULT(NULL), --Region Free if null
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)
ALTER TABLE GameDatabase.GamesEditions
    ADD CONSTRAINT fk_RegionID FOREIGN KEY (RegionID)
        REFERENCES GameDatabase.Regions (RegionID),
    CONSTRAINT fk_GameID FOREIGN KEY (GameID)
        REFERENCES GameDatabase.Games (GameID);


--Platforms Table Creation
CREATE TABLE GameDatabase.Platforms
(
    PlatformID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ConsoleID int NOT NULL,
    ConsoleName nvarchar(200) NOT NULL,
    RegionID int, --Region Free if null
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--Consoles Table Creation
CREATE TABLE GameDatabase.Consoles
(
    ConsoleID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ConsoleEdition nvarchar(200) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--GamesConsoles Table Creation
CREATE TABLE GameDatabase.GamesConsoles
(
    GameEditionID int NOT NULL,
    ConsoleID int NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--Developers Table Creation
CREATE TABLE GameDatabase.Developers
(
    DeveloperID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    DeveloperName nvarchar(100) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--GameDevelopers Table Creation
CREATE TABLE GameDatabase.GameDevelopers
(
    GameID int NOT NULL,
    DeveloperID int NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

----Modify
--Publishers Table Creation
CREATE TABLE GameDatabase.Publishers
(
    PublisherID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    PublisherName nvarchar(100) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--GamePublishers Table Creation
CREATE TABLE GameDatabase.GamePublishers
(
    GameID int NOT NULL,
    PublisherID int NOT NULL,
    PublishingYear date NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--Genres Table Creation
CREATE TABLE GameDatabase.Genres
(
    GenreID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    GenreName nvarchar(100) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--GameGenres Table Creation
CREATE TABLE GameDatabase.GameGenres
(
    GameID int NOT NULL,
    GenreID int NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)