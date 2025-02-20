CREATE SCHEMA IF NOT EXISTS exercise612;

USE exercise612;

CREATE TABLE STUDENT (
	Name			VARCHAR(100),
	Student_number	INT,
	Class			INT,
	Major			VARCHAR(4)
);

CREATE TABLE COURSE (
	Course_name		VARCHAR(100),
	Course_number	VARCHAR(50),
	Credit_hours	INT,
	Department		VARCHAR(4)
);

CREATE TABLE SECTION (
	Section_identifier	INT,
	Course_number		VARCHAR(50),
	Semester			VARCHAR(10),
	Year 				YEAR,
	Instructor			VARCHAR(50)
);

CREATE TABLE GRADE_REPORT (
	Student_number		INT,
	Section_identifier	INT,
	Grade				CHAR(1)
);

CREATE TABLE PREREQUISITE (
	Course_number		VARCHAR(50),
	Prerequisite_number	VARCHAR(50)
);

INSERT INTO COURSE
VALUES
	('Intro to Computer Science', 'CS1310', 4, 'CS'),
	('Data Structures', 'CS3320', 4, 'CS'),
	('Discrete Mathematics', 'MATH2410', 3, 'MATH'),
	('Database', 'CS3380', 3, 'CS');

INSERT INTO SECTION
VALUES
	(85, 'MATH2410', 'Fall', '2007', 'King'),
	(92, 'CS1310', 'Fall', '2007', 'Anderson'),
	(102, 'CS3320', 'Spring', '2008', 'Knuth'),
	(112, 'MATH2410', 'Fall', '2008', 'Chang'),
	(119, 'CS1310', 'Fall', '2008', 'Anderson'),
	(135, 'CS3380', 'Fall', '2008', 'Stone');

INSERT INTO GRADE_REPORT
VALUES
	(17, 112, 'B'),
	(17, 119, 'C'),
	(8, 85, 'A'),
	(8, 92, 'A'),
	(8, 102, 'B'),
	(8, 135, 'A');

INSERT INTO PREREQUISITE
VALUES
	('CS3380', 'CS3320'),
	('CS3380', 'MATH2410'),
	('CS3320', 'CS1310');
