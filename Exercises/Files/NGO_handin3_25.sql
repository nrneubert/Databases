-- Start by creating the NGOs database here --
CREATE SCHEMA IF NOT EXISTS `NGOs`;
USE `NGOs`;
DROP TABLE IF EXISTS Donations;
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

-- Create the table for Supporter--
CREATE TABLE `Supporter`(
	`id`		INT				NOT NULL	PRIMARY KEY,
    `name` 		VARCHAR(30)		NOT NULL,
    `email` 	VARCHAR(50) 	NOT NULL 	CHECK(email LIKE '%_@_%._%'),
    `phone` 	CHAR(8) UNIQUE,
    `city`		VARCHAR(20),
    `NGO_name`	VARCHAR(30)		NOT NULL,
    `birthday`	DATE			NOT NULL,
    `volunteer`	BOOLEAN			DEFAULT FALSE,
    UNIQUE(email, NGO_name),
    FOREIGN KEY (NGO_name) REFERENCES NGO(name)			ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE `Donations`(
	`activity` 	VARCHAR(30),
	`amount` 	INT 		NOT NULL,
    `date` 		DATE,
    `s_id` 		INT  		NOT NULL,
    `ngo_name`	VARCHAR(30)	NOT NULL,
    FOREIGN KEY (s_id) REFERENCES Supporter(id) 		ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ngo_name) REFERENCES NGO(name)			ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (s_id, ngo_name, date, amount)
);

-- We provide you with some insert statements to populate the database. If you run this you can test out you solutions for the sql statement and quiries below. --
INSERT INTO NGO VALUES ('MDGA', 'Aarhus', 'Make databases great again', 'Katrine Scheel', '70241207', 0);
INSERT INTO NGO VALUES ('Danish Refugee Council', 'Copenhagen', 'Protect refugees', 'Charlotte Slente', '33735000', 299000);
INSERT INTO NGO VALUES ('SOS Childrens Villages', 'Innsbruck', 'Help children in need', 'Siddhartha Kaul', '33730233', 7600000);
INSERT INTO NGO VALUES ('Amnesty International', 'London', 'Protecting human rights', 'Agnès Callamard', NULL, 1200000);

INSERT INTO Supporter VALUES (32424, 'Ira Assent', 'ira@yahoo.dk', '61591005', 'Aarhus', 'MDGA', '1994-01-04', FALSE);
INSERT INTO Supporter VALUES (34664, 'Fatemeh Zardbani', 'fatemeh@yahoo.dk', '57155444', 'Aarhus C', 'MDGA', '1982-12-17', TRUE);
INSERT INTO Supporter VALUES (21353, 'Ian McKellen', 'ian@yahoo.dk', '62770792', 'Aarhus N', 'MDGA', '1986-11-16', FALSE);
INSERT INTO Supporter VALUES (64876, 'Dwayne Johnson', 'dwayne@yahoo.dk', '48293168', 'Silkeborg', 'MDGA', '2000-09-22', TRUE);
INSERT INTO Supporter VALUES (32464, 'Sofía Vergara', 'sofia@yahoo.dk', '21125181', 'Randers', 'MDGA', '1988-03-31', FALSE);
INSERT INTO Supporter VALUES (73854, 'Nikolaj Coster-Waldau', 'nikolaj@yahoo.dk', '51152078', 'Hinnerup', 'MDGA', '1989-07-23', TRUE);
INSERT INTO Supporter VALUES (32434, 'Mads Mikkelsen', 'mads@yahoo.dk', '52911886', 'København', 'MDGA', '1972-05-29', FALSE);
INSERT INTO Supporter VALUES (65754, 'Lucy Liu', 'lucy@yahoo.dk', '87920919', 'Aarhus C', 'MDGA', '1985-11-04', TRUE);
INSERT INTO Supporter VALUES (54353, 'Hugh Jackman', 'hugh@yahoo.dk', '94899745', 'Tilst', 'MDGA', '1967-12-29', FALSE);

INSERT INTO Supporter VALUES (92365, 'Dorrit Poulsen', 'dorrit@yahoo.dk', '72378491', 'Tilst', 'Danish Refugee Council', '1974-03-02', FALSE);
INSERT INTO Supporter VALUES (98043, 'Inger Abel', 'inger@yahoo.dk', '74920184', 'Aarhus C', 'Danish Refugee Council', '1970-01-24', TRUE);
INSERT INTO Supporter VALUES (84628, 'Bernhard Frederiksen', 'bernhard@yahoo.dk', '81830273', 'Åbyhøj', 'Danish Refugee Council', '2001-06-09', FALSE);
INSERT INTO Supporter VALUES (87349, 'Sander Madsen', 'sander@yahoo.dk', '95927291', 'Skejby', 'Danish Refugee Council', '1992-09-14', FALSE);
INSERT INTO Supporter VALUES (72513, 'Vigga Karlsen', 'vigga@yahoo.dk', '91748291', 'Trøjborg', 'Danish Refugee Council', '1987-04-01', TRUE);
INSERT INTO Supporter VALUES (97534, 'Anja Skovgaard', 'anja@yahoo.dk', '65829104', 'Kolding', 'Danish Refugee Council', '1977-07-31', FALSE);

INSERT INTO Supporter VALUES (74326, 'Julia Lorenzen', 'julia@yahoo.dk', '14083124', 'Gellerup', 'SOS Childrens Villages', '1987-09-21', FALSE);
INSERT INTO Supporter VALUES (39472, 'Gerhard Berg', 'gerhard@yahoo.dk', '16347415', 'Aarhus C', 'SOS Childrens Villages', '1999-11-28', FALSE);
INSERT INTO Supporter VALUES (92683, 'Viola Clemensen', 'viola@yahoo.dk', '23391962', 'Aarhuc N', 'SOS Childrens Villages', '1985-12-08', TRUE);
INSERT INTO Supporter VALUES (12396, 'Katrine Strand', 'katrine@yahoo.dk', '96753028', 'Tilst', 'SOS Childrens Villages', '1969-08-08', TRUE);
INSERT INTO Supporter VALUES (75292, 'Viggo Anker', 'viggo@yahoo.dk', '71569470', 'Vejle', 'SOS Childrens Villages', '1977-04-20', TRUE);
INSERT INTO Supporter VALUES (87343, 'Esben Jensen', 'esben@yahoo.dk', '16642729', 'Aalborg', 'SOS Childrens Villages', '1978-12-26', FALSE);

INSERT INTO Supporter VALUES (83642, 'Ralf Kjær', 'ralf@yahoo.dk', '94961320', 'Vejle', 'Amnesty International', '1988-02-22', TRUE);
INSERT INTO Supporter VALUES (90372, 'Annette Davidsen', 'anette@yahoo.dk', '37956496', 'Aarhus S', 'Amnesty International', '1993-04-04', FALSE);
INSERT INTO Supporter VALUES (83274, 'Bo Falk', 'bo@yahoo.dk', '91395692', 'Åbyhøj', 'Amnesty International', '1999-07-18', TRUE);
INSERT INTO Supporter VALUES (01235, 'Alberte Petersen', 'alberte@yahoo.dk', '83271056', 'Tilst', 'Amnesty International', '1967-10-09', FALSE);
INSERT INTO Supporter VALUES (87342, 'Ivan Vang', 'ivan@yahoo.dk', '54089949', 'Gellerup', 'Amnesty International', '1984-03-18', FALSE);
INSERT INTO Supporter VALUES (90327, 'Ulrik Nelson', 'ulrik@yahoo.dk', '27546200', 'Aalborg', 'Amnesty International', '1986-03-09', TRUE);
INSERT INTO Supporter VALUES (39248, 'Jonas Hjort', 'jonas@yahoo.dk', '42503064', 'Randers', 'Amnesty International', '1978-04-27', FALSE);
INSERT INTO Supporter VALUES (23874, 'Christen Møller', 'christen@yahoo.dk', '92462217', 'Skejby', 'Amnesty International', '1993-10-31', FALSE);
INSERT INTO Supporter VALUES (71273, 'Johannes Nordskov', 'johannes@yahoo.dk', '81620495', '', 'Amnesty International', '1994-09-24', FALSE);

INSERT INTO Donations VALUES ('TA beer', 417, '2022-01-21', 32424, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 611, '2022-02-07', 32424, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 1118, '2022-01-15', 34664, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 22, '2022-01-30', 21353, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 143, '2022-01-06', 32464, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 486, '2022-01-24', 64876, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 330, '2022-01-30', 65754, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 228, '2022-01-11', 54353, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 485, '2022-02-01', 73854, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 240, '2022-01-11', 21353, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 183, '2022-02-07', 65754, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 457, '2022-01-15', 54353, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 58, '2022-02-23', 32464, 'MDGA');
INSERT INTO Donations VALUES ('TA beer', 446, '2022-01-03', 64876, 'MDGA');

INSERT INTO Donations VALUES ('Food to refugee camp', 138, '2022-01-10', 92365, 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 665, '2022-02-11', 98043, 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 968, '2022-02-01', 84628, 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 668, '2022-02-18', 72513, 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 632, '2022-02-17', 87349, 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 214, '2022-01-19', 97534, 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 581, '2022-01-22', 92365, 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 742, '2022-01-09', 97534, 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 369, '2022-01-10', 92365, 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 967, '2022-01-15', 98043, 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 573, '2022-01-16', 72513, 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 648, '2022-02-10', 98043, 'Danish Refugee Council');
INSERT INTO Donations VALUES ('Food to refugee camp', 609, '2022-02-01', 97534, 'Danish Refugee Council');

INSERT INTO Donations VALUES ('New school for kids', 141, '2022-02-11', 74326, 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 557, '2022-02-12', 39472, 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 331, '2022-02-22', 92683, 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 527, '2022-01-19', 12396, 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 748, '2022-02-02', 75292, 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 116, '2022-01-04', 87343, 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 762, '2022-01-25', 92683, 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 986, '2022-02-08', 39472, 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 398, '2022-01-06', 75292, 'SOS Childrens Villages');
INSERT INTO Donations VALUES ('New school for kids', 311, '2022-01-04', 87343, 'SOS Childrens Villages');

INSERT INTO Donations VALUES ('Water is a human right', 317, '2022-02-07', 83642, 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 760, '2022-01-16', 90372, 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 961, '2022-02-06', 83274, 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 572, '2022-01-07', 01235, 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 919, '2022-01-18', 87342, 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 341, '2022-01-09', 90327, 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 848, '2022-02-11', 39248, 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 785, '2022-01-25', 23874, 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 538, '2022-02-14', 23874, 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 344, '2022-01-02', 71273, 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 867, '2022-02-11', 83274, 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 126, '2022-01-05', 90327, 'Amnesty International');
INSERT INTO Donations VALUES ('Water is a human right', 124, '2022-02-17', 83642, 'Amnesty International');

-- Update the name for MDGA to 'KDG' and the cause to 'Keep Databases Great' --
UPDATE NGO SET name = 'KDG', cause = 'Keep Databases Great' WHERE name = 'MDGA';

# 1a
SELECT S.name, SUM(D.amount) FROM Supporter AS S JOIN Donations AS D ON S.id = D.s_id WHERE D.ngo_name = 'KDG' GROUP BY S.id HAVING SUM(D.amount) > 1000;
# 1b
SELECT S.name FROM Supporter AS S JOIN Donations AS D ON S.id = D.s_id WHERE D.ngo_name = 'KDG' GROUP BY S.id 
	HAVING COUNT(*) > FLOOR((SELECT AVG(donation_counts) FROM (SELECT COUNT(*) AS donation_counts FROM Donations WHERE ngo_name='KDG' GROUP BY s_id) AS avg_counts));
# 1c

SELECT DISTINCT n.name AS NGOName, s.name AS SupporterName FROM NGO n 
	JOIN Donations d ON n.name = d.ngo_name
	JOIN Supporter s ON d.s_id = s.id
	WHERE (s.id, n.name) IN 
		(SELECT s_id, ngo_name FROM Donations GROUP BY s_id, ngo_name
			HAVING COUNT(*) > 
            ( SELECT AVG(donation_count) FROM
                    (SELECT COUNT(*) AS donation_count FROM Donations WHERE ngo_name = n.name GROUP BY s_id) AS subquery
            )
		)
	ORDER BY n.name;

SELECT s_id, ngo_name FROM Donations GROUP BY s_id, ngo_name
			HAVING COUNT(*) > 
            ( SELECT AVG(donation_count) FROM
                    (SELECT COUNT(*) AS donation_count FROM Donations WHERE ngo_name = n.name GROUP BY s_id) AS subquery
            );

SELECT AVG(donation_count) FROM
                    (SELECT COUNT(*) AS donation_count FROM Donations WHERE ngo_name = 'KDG' GROUP BY s_id) AS avg_donations;

SELECT COUNT(*) AS donation_count FROM Donations WHERE ngo_name = 'KDG' GROUP BY s_id;

# 2a
ALTER TABLE Supporter 
	ADD COLUMN level 	INT 	NOT NULL 	DEFAULT 0 	CHECK(level >= 0);
# 2b    
UPDATE Supporter AS S1
	SET level = ( SELECT COUNT(*) FROM Donations D WHERE D.s_id = S1.id AND D.ngo_name = 'KDG' )
	WHERE S1.email = 'lucy@yahoo.dk';

# 2c
-- Trivial functional dependency if X -> Y and Y is a subset of X. So for example
-- Supporter: id -> id
-- Suppoerter: name, email -> name

# 2d
-- Supporter: 
-- id -> {name, email, phone, city, NGO_name, birthday, volunteer}
-- {email, NGO_name} -> {id, name, email, phone, city, birthday, volunteer}
-- NGO:
-- name -> {based_in, cause, director, phone, revenue}
-- phone -> {name, based_in, cause, director, revenue}
-- Donations:
-- {s_id, ngo_name, date, amount} -> {activity, s_id, ngo_name, date, amount}

# 2e
-- Our second FD is redundant because it constrains a Supporter to only support a single NGO. 
-- If we were to allow supporting multiple NGOs, we would have redundancy in the form of multiple entries of the SAME Supporter (but for different NGOs). 
-- This opens up for UPDATE anomalies because if we update an attribute, e.g. phone or city, we have to do so for all the entries of that Supporter!

# 2f
ALTER TABLE Supporter DROP COLUMN id;
-- Firstly, because Supporter.id is referenced in Donations it is not allowed to drop that column due to foreign key constraints. 
ALTER TABLE Donations DROP FOREIGN KEY donations_ibfk_1;
ALTER TABLE Supporter DROP COLUMN id;
-- It is a DDL action it does not trigger ON DELETE or ON UPDATE as they are DML triggered actions. 
-- However, we would not be able to distinguish between Donations, althought they keep the s_id's, because we lose information of who made them!

SELECT * FROM Donations;
SELECT * FROM Supporter;

# 3a