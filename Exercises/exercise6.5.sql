CREATE SCHEMA IF NOT EXISTS exercise65;

CREATE TABLE IF NOT EXISTS Customer(
	cust INT PRIMARY KEY,
    cname VARCHAR(30),
    city VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Rental(
	rental INT,
    rdate DATE,
    cust INT REFERENCES Customer(cust),
    -- date DATE,
    -- time TIME,
    hourly_rate INT,
    PRIMARY KEY (rental, cust)
);

CREATE TABLE IF NOT EXISTS Rental_car(
	rental INT REFERENCES Rental(rental),
    car VARCHAR(30) REFERENCES Car(car),
    driver VARCHAR(30),
    start_time TIME,
    end_time TIME,
    amount_recevied INT,
    PRIMARY KEY (rental, car, driver)
);

CREATE TABLE IF NOT EXISTS Car(
	car VARCHAR(30) PRIMARY KEY,
    car_year INT,
    price INT,
    depreciation VARCHAR(30),
    last_service DATE
);

CREATE TABLE IF NOT EXISTS Servicing(
	garager VARCHAR(30),
    car VARCHAR(30) REFERENCES Car(car),
    service_date DATE,
    PRIMARY KEY (garager, car)
);

CREATE TABLE IF NOT EXISTS Garage(
	garage VARCHAR(30) PRIMARY KEY,
    gaddress VARCHAR(30),
    owner_name VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Driver(
	driver VARCHAR(30) PRIMARY KEY,
    dname VARCHAR(30),
    daddress VARCHAR(30)
);
