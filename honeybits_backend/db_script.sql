USE honeybits;

CREATE TABLE role (
	role_id 		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	description		VARCHAR(255) NOT NULL,
	created_by		INT NOT NULL,
	created_date		TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
	user_id			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	first_name		VARCHAR(255) NOT NULL,
	last_name		VARCHAR(255) NOT NULL,
	birtdate		DATETIME NOT NULL,
	role_id			INT NOT NULL,
	username		VARCHAR(255) NOT NULL,
	passwd			VARCHAR(255) NOT NULL,
	created_date	TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product (
	product_id		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	product_name	VARCHAR(255) NOT NULL,
	product_description	VARCHAR(1000),
	product_price	DECIMAL(6,2),
	created_by		INT NOT NULL,
	created_date	TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- INSERT Statements

-- Role Table
INSERT INTO `honeybits`.`role` (`description`, `created_by`) VALUES ('Administrator', 1);
INSERT INTO `honeybits`.`role` (`description`, `created_by`) VALUES ('Developer', 1);
INSERT INTO `honeybits`.`role` (`description`, `created_by`) VALUES ('Customer', 1);
INSERT INTO `honeybits`.`role` (`description`, `created_by`) VALUES ('Keeper', 1);

-- User Table
INSERT INTO `honeybits`.`users` (`first_name`, `last_name`, `birtdate`, `role_id`, `username`, `passwd`) VALUES ('Admin', 'System', '1990-01-01', 1, 'admin', '123456');
INSERT INTO `honeybits`.`users` (`first_name`, `last_name`, `birtdate`, `role_id`, `username`, `passwd`) VALUES ('Developer', 'System', '1990-01-01', 2, 'developer', '123456');
INSERT INTO `honeybits`.`users` (`first_name`, `last_name`, `birtdate`, `role_id`, `username`, `passwd`) VALUES ('Customer', 'System', '1990-01-01', 3, 'customer', '123456');
INSERT INTO `honeybits`.`users` (`first_name`, `last_name`, `birtdate`, `role_id`, `username`, `passwd`) VALUES ('Keeper', 'System', '1990-01-01', 4, 'keeper', '123456');

-- Product Table
INSERT INTO `honeybits`.`product`(`product_name`, `product_description`, `product_price`, `created_by`) VALUES ('Product 1', 'Product 1 description', 10.99, 1);
INSERT INTO `honeybits`.`product`(`product_name`, `product_description`, `product_price`, `created_by`) VALUES ('Product 2', 'Product 2 description', 12.89, 4);
INSERT INTO `honeybits`.`product`(`product_name`, `product_description`, `product_price`, `created_by`) VALUES ('Product 3', 'Product 3 description', 13.79, 4);
INSERT INTO `honeybits`.`product`(`product_name`, `product_description`, `product_price`, `created_by`) VALUES ('Product 4', 'Product 4 description', 14.69, 4);


