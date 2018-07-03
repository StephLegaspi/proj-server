DROP USER IF EXISTS 'transactiondb'@'localhost';
CREATE USER 'transactiondb'@'localhost' IDENTIFIED BY 'transactiondb';

DROP DATABASE IF EXISTS transactiondb;
CREATE DATABASE transactiondb;

GRANT ALL PRIVILEGES ON transactiondb.* TO 'transactiondb'@'localhost';
GRANT EXECUTE ON transactiondb.* TO 'transactiondb'@'localhost';

USE transactiondb;

CREATE TABLE booking (
	booking_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	shipper_name VARCHAR(128) NOT NULL,
	contact_number VARCHAR(11) NOT NULL,
	email VARCHAR(128),
	company_name VARCHAR(128),
	pickup_address VARCHAR(128) NOT NULL,
	account_number VARCHAR(50)
);


CREATE TABLE booking_zone (
	pickup_address VARCHAR(128) NOT NULL PRIMARY KEY,
	zone VARCHAR(20) NOT NULL
);

CREATE TABLE item (
	item_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	quantity INT,
	description VARCHAR(128),
	size VARCHAR(128),
	booking_id INT,
	CONSTRAINT FK_bookingid FOREIGN KEY (booking_id)
    REFERENCES booking(booking_id) ON DELETE SET NULL
);

ALTER TABLE item AUTO_INCREMENT = 100;

CREATE TABLE warehouse (
	warehouse_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	warehouse_address VARCHAR(128)
);

CREATE TABLE warehouse_zone (
	warehouse_address VARCHAR(128) NOT NULL PRIMARY KEY,
	warehouse_zone VARCHAR(20)
);

CREATE TABLE courier (
	courier_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	courier_name VARCHAR(128),
	courier_zone VARCHAR(20),
	status VARCHAR(128),
	warehouse_id INT,
	CONSTRAINT FK_warehouseid FOREIGN KEY (warehouse_id)
    REFERENCES warehouse(warehouse_id) ON DELETE SET NULL
);

CREATE TABLE booking_assigned_to_courier (
	item_id INT NOT NULL,
	courier_id INT NOT NULL
);



DELIMITER GO

CREATE PROCEDURE insert_booking(shipper_name VARCHAR(128),
									contact_number VARCHAR(11),
									email VARCHAR(128),
									company_name VARCHAR(128),
									pickup_address VARCHAR(128),
									account_number VARCHAR(50),

									quantity INT,
									description VARCHAR(128),
									size VARCHAR(128))
BEGIN
	INSERT INTO booking(shipper_name, contact_number, email, company_name, pickup_address, account_number) VALUES(shipper_name, contact_number, email, company_name, pickup_address, account_number);

	INSERT INTO item(quantity, description, size, booking_id) VALUES(quantity, description, size, (SELECT LAST_INSERT_ID()));
END;
GO

DELIMITER ;

