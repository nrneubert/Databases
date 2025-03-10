DROP SCHEMA IF EXISTS `NGOs`;
CREATE SCHEMA IF NOT EXISTS `NGOs`;
USE NGOs;

DROP TABLE IF EXISTS Donations;
DROP TABLE IF EXISTS Supports;
DROP TABLE IF EXISTS Supporter;
DROP TABLE IF EXISTS NGO;


CREATE TABLE `NGO`(
	`name` 		VARCHAR(30) 	NOT NULL	PRIMARY KEY,
    `based_in` 	VARCHAR(30)		NOT NULL,
    `cause` 	VARCHAR(40)		NOT NULL,
    `director` 	VARCHAR(30),
    `phone` 	CHAR(8)						UNIQUE,
    `revenue`	INT
);

-- Create Supporter here
CREATE TABLE `Supporter`(
    `name` 	VARCHAR(30)		NOT NULL,
    `email` 	VARCHAR(50) 		NOT NULL 	CHECK(email LIKE '%_@_%._%') PRIMARY KEY,
    `phone` 	CHAR(8) CHECK(`phone` REGEXP '[0-9]{8,}') UNIQUE,
    `address` VARCHAR(50) CHECK(`address` REGEXP '[0-9]+[ ]+[a-zA-Z ]+' OR `address` REGEXP '[a-zA-Z ]+[ ]+[0-9]+'),
    `zip_code` CHAR(4) CHECK(`zip_code` REGEXP '[0-9]{4,}'),
    `city`		VARCHAR(20),
    `birthday`	DATE	NOT NULL CHECK(`birthday` BETWEEN DATE '1922-01-01' AND '2002-01-01')
);

-- Crreate Supports here
CREATE TABLE `Supports`(
	`ngo_name` 	VARCHAR(30),
    `email` VARCHAR(50),
    `volunteer` BOOLEAN,
    `level` INT DEFAULT 0,
    FOREIGN KEY (ngo_name) REFERENCES NGO(name) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (email) REFERENCES Supporter(email) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(ngo_name, email)
);


CREATE TABLE `Donations`(
	`activity` 	VARCHAR(30),
	`amount` 	INT 		NOT NULL,
    `date` 		DATE,
    `email` 	VARCHAR(50)  NOT NULL,
    `ngo_name`	VARCHAR(30)	NOT NULL,
    FOREIGN KEY (email) REFERENCES Supporter(email) 		ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ngo_name) REFERENCES NGO(name)			ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (email, ngo_name, date, amount)
);

-- Just filling in data --
INSERT INTO NGO VALUES ('KDG', 'Aarhus', 'Make databases great again', 'Katrine Scheel', '70241207', 0);
INSERT INTO NGO VALUES ('Danish Refugee Council', 'Copenhagen', 'Protect refugees', 'Charlotte Slente', '33735000', 299000);
INSERT INTO NGO VALUES ('SOS Childrens Villages', 'Innsbruck', 'Help children in need', 'Siddhartha Kaul', '33730233', 7600000);
INSERT INTO NGO VALUES ('Amnesty International', 'London', 'Protecting human rights', 'Agnès Callamard', '30265910', 1200000);

INSERT INTO Supporter VALUES ('Ira Assent', 'ira@yahoo.dk', '61591005', 'Ådalen 67', '8000', 'Aarhus', '1994-01-04');
INSERT INTO Supporter VALUES ('Fatemeh Zardbani', 'fatemeh@yahoo.dk', '57155444', ' Erhvervsvangen 8', '8000', 'Aarhus C', '1982-12-17');
INSERT INTO Supporter VALUES ('Katrine Scheel Nellemann', 'scheel@cs.au.dk', '62770792', 'Rynkebyvej 51', '8200', 'Aarhus N', '1986-11-16');
INSERT INTO Supporter VALUES ('Dwayne Johnson', 'dwayne@yahoo.dk', '48293168', 'Hindsholmvej 76', '8950', 'Ørsted', '2000-09-22');
INSERT INTO Supporter VALUES ('Sofía Vergara', 'sofia@yahoo.dk', '21125181', 'Mosegårdsvej 51', '1065', 'København K', '1988-03-31');
INSERT INTO Supporter VALUES ('Nikolaj Coster-Waldau', 'nikolaj@yahoo.dk', '51152078', 'Sveltekrogen 79', '8210', 'Hinnerup', '1989-07-23');
INSERT INTO Supporter VALUES ('Mads Mikkelsen', 'mads@yahoo.dk', '52911886', 'Industrivej 95', '6740', 'København', '1972-05-29');
INSERT INTO Supporter VALUES ('Lucy Liu', 'lucy@yahoo.dk', '87920919', 'Strandalléen 84', '4912', 'Aarhus C', '1985-11-04');
INSERT INTO Supporter VALUES ('Hugh Jackman', 'hugh@yahoo.dk', '94899745', 'Brogade 32', '7950', 'Tilst', '1967-12-29');
INSERT INTO Supporter VALUES ('Dorrit Poulsen', 'dorrit@yahoo.dk', '72378491', 'Hovbanken 79', '3080', 'Tilst', '1974-03-02');
INSERT INTO Supporter VALUES ('Inger Abel', 'inger@yahoo.dk', '74920184', 'Svendborg Landevej 23', '8000', 'Aarhus C', '1970-01-24');
INSERT INTO Supporter VALUES ('Bernhard Frederiksen', 'bernhard@yahoo.dk', '81830273', 'Holmevej 58', '1423', 'Åbyhøj', '2001-06-09');
INSERT INTO Supporter VALUES ('Sander Madsen', 'sander@yahoo.dk', '95927291', 'Nordre Ringvej 64', '1732', 'Skejby', '1992-09-14');
INSERT INTO Supporter VALUES ('Vigga Karlsen', 'vigga@yahoo.dk', '91748291', 'Frørup Byvej 82', '1167', 'Trøjborg', '1987-04-01');
INSERT INTO Supporter VALUES ('Anja Skovgaard', 'anja@yahoo.dk', '65829104', 'Clematisvænget 20', '7742', 'Kolding', '1977-07-31');
INSERT INTO Supporter VALUES ('Julia Lorenzen', 'julia@yahoo.dk', '14083124', 'Sandagervej 3', '8210', 'Gellerup', '1987-09-21');
INSERT INTO Supporter VALUES ('Gerhard Berg', 'gerhard@yahoo.dk', '16347415', 'Strandvej 44', '1270', 'Aarhus C', '1999-11-28');
INSERT INTO Supporter VALUES ('Viola Clemensen', 'viola@yahoo.dk', '23391962', 'Espegyden 9', '8200', 'Aarhuc N', '1985-12-08');
INSERT INTO Supporter VALUES ('Katrine Strand', 'katrine@yahoo.dk', '96753028', 'Algade 76', '9560', 'Tilst', '1969-08-08');
INSERT INTO Supporter VALUES ('Viggo Anker', 'viggo@yahoo.dk', '71569470', 'Søndre Havnevej 93', '6852', 'Vejle', '1977-04-20');
INSERT INTO Supporter VALUES ('Esben Jensen', 'esben@yahoo.dk', '16642729', 'Skolegade 85', '9000', 'Aalborg', '1978-12-26');
INSERT INTO Supporter VALUES ('Ralf Kjær', 'ralf@yahoo.dk', '94961320', 'Mølleløkken 24', '5230', 'Vejle', '1988-02-22');
INSERT INTO Supporter VALUES ('Annette Davidsen', 'anette@yahoo.dk', '37956496', 'Vesterskovvej 70', '8860', 'Aarhus S', '1993-04-04');
INSERT INTO Supporter VALUES ('Bo Falk', 'bo@yahoo.dk', '91395692', 'Sludevej 37', '1355', 'Åbyhøj', '1999-07-18');
INSERT INTO Supporter VALUES ('Alberte Petersen', 'alberte@yahoo.dk', '83271056', 'Rynkebyvej 68', '3550', 'Tilst', '1967-10-09');
INSERT INTO Supporter VALUES ('Ivan Vang', 'ivan@yahoo.dk', '54089949', 'Lykkesholmvej 41', '9362', 'Gellerup', '1984-03-18');
INSERT INTO Supporter VALUES ('Ulrik Nelson', 'ulrik@yahoo.dk', '27546200', 'Hersnapvej 65', '9000', 'Aalborg', '1986-03-09');
INSERT INTO Supporter VALUES ('Jonas Hjort', 'jonas@yahoo.dk', '42503064', 'Muusgården 16', '8550', 'Randers', '1978-04-27');
INSERT INTO Supporter VALUES ('Christen Møller', 'christen@yahoo.dk', '92462217', 'Frørupvej 26', '8200', 'Skejby', '1993-10-31');
INSERT INTO Supporter VALUES ('Johannes Nordskov', 'johannes@yahoo.dk', '81620495', 'Gammel Byvej 3', '8000', 'Aarhus', '1994-09-24');

INSERT INTO Supports VALUES ('KDG', 'ira@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('KDG', 'fatemeh@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('KDG', 'scheel@cs.au.dk', TRUE, 0);
INSERT INTO Supports VALUES ('KDG', 'dwayne@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('KDG', 'sofia@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('KDG', 'nikolaj@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('KDG', 'mads@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('KDG', 'lucy@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('KDG', 'hugh@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('KDG', 'sander@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('KDG', 'vigga@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('KDG', 'viola@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('KDG', 'ivan@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('KDG', 'christen@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Danish Refugee Council', 'dorrit@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('Danish Refugee Council', 'inger@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('Danish Refugee Council', 'bernhard@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Danish Refugee Council', 'sander@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('Danish Refugee Council', 'vigga@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Danish Refugee Council', 'anja@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Danish Refugee Council', 'fatemeh@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Danish Refugee Council', 'nikolaj@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Danish Refugee Council', 'viola@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Danish Refugee Council', 'ivan@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('Danish Refugee Council', 'christen@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('SOS Childrens Villages', 'julia@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('SOS Childrens Villages', 'gerhard@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('SOS Childrens Villages', 'viola@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('SOS Childrens Villages', 'katrine@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('SOS Childrens Villages', 'viggo@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('SOS Childrens Villages', 'esben@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('SOS Childrens Villages', 'fatemeh@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('SOS Childrens Villages', 'nikolaj@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('SOS Childrens Villages', 'sander@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('SOS Childrens Villages', 'vigga@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('SOS Childrens Villages', 'ivan@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('SOS Childrens Villages', 'christen@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'ralf@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'anette@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'bo@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'alberte@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'ivan@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'ulrik@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'jonas@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'christen@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'johannes@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'fatemeh@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'nikolaj@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'sander@yahoo.dk', TRUE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'vigga@yahoo.dk', FALSE, 0);
INSERT INTO Supports VALUES ('Amnesty International', 'viola@yahoo.dk', FALSE, 0);

INSERT INTO Donations VALUES ('TA beer', 417, '2022-01-21', 'ira@yahoo.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 11, '2022-02-07', 'ira@yahoo.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 118, '2022-01-15', 'fatemeh@yahoo.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 22, '2022-01-30', 'scheel@cs.au.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 143, '2022-01-06', 'sofia@yahoo.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 486, '2022-01-24', 'dwayne@yahoo.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 330, '2022-01-30', 'lucy@yahoo.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 228, '2022-01-11', 'hugh@yahoo.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 485, '2022-02-01', 'nikolaj@yahoo.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 240, '2022-01-11', 'scheel@cs.au.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 183, '2022-02-07', 'lucy@yahoo.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 457, '2022-01-15', 'hugh@yahoo.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 58, '2022-02-23', 'sofia@yahoo.dk', 'KDG');
INSERT INTO Donations VALUES ('TA beer', 446, '2022-01-03', 'dwayne@yahoo.dk', 'KDG');
INSERT INTO Donations VALUES ('Food to refugee camp', 138, '2022-01-10', 'dorrit@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 665, '2022-02-11', 'inger@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 968, '2022-02-01', 'bernhard@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 668, '2022-02-18', 'vigga@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 632, '2022-02-17', 'sander@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 214, '2022-01-19', 'anja@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 581, '2022-01-22', 'dorrit@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 742, '2022-01-09', 'anja@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 369, '2022-01-10', 'dorrit@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 967, '2022-01-15', 'inger@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 573, '2022-01-16', 'vigga@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 648, '2022-02-10', 'inger@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 609, '2022-02-01', 'anja@yahoo.dk', 'Danish Refugee Council');
INSERT INTO Donations VALUES ('New school for kids', 141, '2022-02-11', 'julia@yahoo.dk', 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 557, '2022-02-12', 'gerhard@yahoo.dk', 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 331, '2022-02-22', 'viola@yahoo.dk', 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 527, '2022-01-19', 'katrine@yahoo.dk', 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 748, '2022-02-02', 'viggo@yahoo.dk', 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 116, '2022-01-04', 'esben@yahoo.dk', 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 762, '2022-01-25', 'viola@yahoo.dk', 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 986, '2022-02-08', 'gerhard@yahoo.dk', 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 398, '2022-01-06', 'viggo@yahoo.dk', 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 311, '2022-01-04', 'esben@yahoo.dk', 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('Water is a human right', 317, '2022-02-07', 'ralf@yahoo.dk', 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 760, '2022-01-16', 'anette@yahoo.dk', 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 961, '2022-02-06', 'bo@yahoo.dk', 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 572, '2022-01-07', 'alberte@yahoo.dk', 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 919, '2022-01-18', 'ivan@yahoo.dk', 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 341, '2022-01-09', 'ulrik@yahoo.dk', 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 848, '2022-02-11', 'jonas@yahoo.dk', 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 785, '2022-01-25', 'christen@yahoo.dk', 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 538, '2022-02-14', 'christen@yahoo.dk', 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 344, '2022-01-02', 'johannes@yahoo.dk', 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 867, '2022-02-11', 'bo@yahoo.dk', 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 126, '2022-01-05', 'ulrik@yahoo.dk', 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 124, '2022-02-17', 'ralf@yahoo.dk', 'Amnesty International');

SET SQL_SAFE_UPDATES = 0;

-- Update level, as the number of donations the supporter made to an NGO, for all entries in Supports using a single update command.

SELECT * FROM Supports;
UPDATE Supports S SET level = (
	SELECT COUNT(*) FROM Donations D
    WHERE D.email = S.email AND D.ngo_name = S.ngo_name
);
SELECT * FROM Supports;

-- Ensure that the 'level' of an NGO supporter is updated correspondingly whenever they make a donation to the NGO. Remember that *level* is defined to be the amount of times a supporter has donated to the NGO. We assume that you cannot undo a donation, and therefore level cannot decre

DELIMITER //
CREATE TRIGGER EnsureLevel
	AFTER INSERT ON Donations
    FOR EACH ROW
    BEGIN 
        DECLARE current_level INT;
        SELECT level into current_level FROM Supports WHERE NEW.email = Supports.email;
		UPDATE Supports S SET level = current_level + 1 WHERE NEW.email = S.email AND NEW.ngo_name = S.ngo_name;
    END//
DELIMITER ;
INSERT INTO Donations VALUES ('Water is a human right', 961, '2022-02-12', 'bo@yahoo.dk', 'Amnesty International');
SELECT * FROM Supports;

-- Create an index on Supports on the attribute ngo_name, so it is faster for an NGO to retrieve its supporters.

CREATE INDEX NGOIndex ON Supports(ngo_name);

-- Suppose KDG has access to the information on their supporters and they would like to be able to share an overview of this data with others. Concretely, they want to show simple statistics of how many supporters they have at each level of support. Create a view that extracts this overview statistics.

DROP VIEW IF EXISTS SupporterStatistics;
CREATE VIEW SupporterStatistics AS
SELECT level, COUNT(*) AS amount FROM Supports WHERE ngo_name = 'KDG' GROUP BY level;

SELECT * FROM SupporterStatistics;

SELECT * FROM Supporter NATURAL JOIN Supports; #GROUP BY email HAVING COUNT(*) = 1;