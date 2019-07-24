USE honeybits;
----------------------------------------
-- CREATE Statement
----------------------------------------

CREATE TABLE role (
	role_id 		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	description		VARCHAR(255) NOT NULL,
	created_by		INT NOT NULL,
	created_date	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_deleted		BIT	DEFAULT 0,
	deleted_by		INT,
	deleted_date	TIMESTAMP
);

CREATE TABLE users (
	user_id			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	first_name		VARCHAR(255) NOT NULL,
	last_name		VARCHAR(255) NOT NULL,
	email			VARCHAR(255) NOT NULL UNIQUE,
	birtdate		DATETIME NOT NULL,
	role_id			INT NOT NULL,
	username		VARCHAR(255) NOT NULL,
	passwd			VARCHAR(255) NOT NULL,
	created_date	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_deleted		BIT	DEFAULT 0,
	deleted_by		INT,
	deleted_date	TIMESTAMP
);

CREATE TABLE product_category (
	product_category_id		INT AUTO_INCREMENT PRIMARY KEY,
	product_category_name	VARCHAR(255) NOT NULL,
	product_category_description	VARCHAR(500) NOT NULL,
	created_by			INT NOT NULL,
	created_date		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_deleted		BIT	DEFAULT 0,
	deleted_by		INT,
	deleted_date	TIMESTAMP
);

CREATE TABLE product (
	product_id		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	product_name	VARCHAR(255) NOT NULL,
	product_category_id	INT NOT NULL,
	product_description	VARCHAR(1000),
	product_price	DECIMAL(6,2),
	created_by		INT NOT NULL,
	created_date	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_deleted		BIT	DEFAULT 0,
	deleted_by		INT,
	deleted_date	TIMESTAMP
);

CREATE TABLE shop (
	shop_id			INT AUTO_INCREMENT PRIMARY KEY,
	owner_id		INT NOT NULL,
	shop_name		VARCHAR(255) NOT NULL UNIQUE,
	shop_description	VARCHAR(255) NOT NULL,
	created_by		INT NOT NULL,
	created_date	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_deleted		BIT	DEFAULT 0,
	deleted_by		INT,
	deleted_date	TIMESTAMP
);

CREATE TABLE shop_product (
	shop_product_id		INT AUTO_INCREMENT PRIMARY KEY,
	shop_id				INT NOT NULL,
	product_id			INT NOT NULL,
	created_by		INT NOT NULL,
	created_date	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_deleted		BIT	DEFAULT 0,
	deleted_by		INT,
	deleted_date	TIMESTAMP
);

CREATE TABLE product_image (
	product_image_id		INT AUTO_INCREMENT PRIMARY KEY,
	product_id				INT NOT NULL,
	product_image_name		VARCHAR(255) NOT NULL,
	product_image_description	VARCHAR(500),
	product_image_type	VARCHAR(15) NOT NULL,
	created_by		INT NOT NULL,
	created_date	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_deleted		BIT	DEFAULT 0,
	deleted_by		INT,
	deleted_date	TIMESTAMP
);

CREATE TABLE shop_follower (
	shop_follower_id		INT AUTO_INCREMENT PRIMARY KEY,
	shop_id					INT NOT NULL,
	user_id					INT NOT NULL,
	created_by		INT NOT NULL,
	created_date	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_deleted		BIT	DEFAULT 0,
	deleted_by		INT,
	deleted_date	TIMESTAMP
);

CREATE TABLE product_like (
	product_like_id			INT AUTO_INCREMENT PRIMARY KEY,
	user_id					INT NOT NULL,
	product_id				INT NOT NULL,
	created_by				INT NOT NULL,
	created_date			TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_deleted				BIT	DEFAULT 0,
	deleted_by				INT,
	deleted_date			TIMESTAMP
);

CREATE TABLE transaction_type (
	transaction_type_id		INT AUTO_INCREMENT PRIMARY KEY,
	transaction_type		VARCHAR(250) NOT NULL,
	transaction_type_description	VARCHAR(500),
	created_by				INT NOT NULL,
	created_date			TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_deleted				BIT	DEFAULT 0,
	deleted_by				INT,
	deleted_date			TIMESTAMP
);

CREATE TABLE bee_transaction (
	bee_transaction_id		INT AUTO_INCREMENT PRIMARY KEY,
	user_id					INT NOT NULL,
	transaction_type_id		INT NOT NULL,
	bee_amount				INT NOT NULL,
	created_by				INT NOT NULL,
	created_date			TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	is_deleted				BIT	DEFAULT 0,
	deleted_by				INT,
	deleted_date			TIMESTAMP
);

----------------------------------------
-- Tables Constraints
----------------------------------------

-- User Table
ALTER TABLE users
ADD FOREIGN KEY (role_id) REFERENCES role(role_id)
ADD FOREIGN KEY (deleted_by) REFERENCES users(user_id)

-- Role Table
ALTER TABLE role
ADD FOREIGN KEY (created_by) REFERENCES users(user_id)
ADD FOREIGN KEY (deleted_by) REFERENCES users(user_id)

-- product_category Table
ALTER TABLE product_category
ADD FOREIGN KEY (created_by) REFERENCES users(user_id)
ADD FOREIGN KEY (deleted_by) REFERENCES users(user_id)

-- product Table
ALTER TABLE product
ADD FOREIGN KEY (product_category_id) REFERENCES product_category(product_category_id)
ADD FOREIGN KEY (created_by) REFERENCES users(user_id)
ADD FOREIGN KEY (deleted_by) REFERENCES users(user_id)

-- Shop Table
ALTER TABLE shop
ADD FOREIGN KEY (owner_id) REFERENCES users(user_id)
ADD FOREIGN KEY (created_by) REFERENCES users(user_id)
ADD FOREIGN KEY (deleted_by) REFERENCES users(user_id)



----------------------------------------
-- INSERT Statements
----------------------------------------

-- Role Table
INSERT INTO `honeybits`.`role` (`description`, `created_by`) VALUES ('Administrator', 1);
INSERT INTO `honeybits`.`role` (`description`, `created_by`) VALUES ('Developer', 1);
INSERT INTO `honeybits`.`role` (`description`, `created_by`) VALUES ('Customer', 1);
INSERT INTO `honeybits`.`role` (`description`, `created_by`) VALUES ('Keeper', 1);

-- User Table
INSERT INTO `honeybits`.`users` (`first_name`, `last_name`, `email`, `birtdate`, `role_id`, `username`, `passwd`) VALUES ('Admin', 'System', 'admin@test.com', '1990-01-01', 1, 'admin', '123456');
INSERT INTO `honeybits`.`users` (`first_name`, `last_name`, `email`, `birtdate`, `role_id`, `username`, `passwd`) VALUES ('Developer', 'System', 'developer@test.com', '1990-01-01', 2, 'developer', '123456');
INSERT INTO `honeybits`.`users` (`first_name`, `last_name`, `email`, `birtdate`, `role_id`, `username`, `passwd`) VALUES ('Customer', 'System', 'customer@test.com', '1990-01-01', 3, 'customer', '123456');
INSERT INTO `honeybits`.`users` (`first_name`, `last_name`, `email`, `birtdate`, `role_id`, `username`, `passwd`) VALUES ('Keeper', 'System', 'keeper@test.com', '1990-01-01', 4, 'keeper', '123456');

-- Product Category Table
INSERT INTO `honeybits`.`product_category` (`product_category_name`, `product_category_description`, `created_by`) VALUES ('Food', 'Products that are made to be eated.', 1);
INSERT INTO `honeybits`.`product_category` (`product_category_name`, `product_category_description`, `created_by`) VALUES ('Accesories', 'Products that are accesories.', 1);
INSERT INTO `honeybits`.`product_category` (`product_category_name`, `product_category_description`, `created_by`) VALUES ('Storage', 'Products for storing.', 1);
INSERT INTO `honeybits`.`product_category` (`product_category_name`, `product_category_description`, `created_by`) VALUES ('Clothes', 'Products that are clothes.', 1);

-- Product Table
INSERT INTO `honeybits`.`product`(`product_name`, `product_description`, `product_price`, `created_by`) VALUES ('Product 1', 'Product 1 description', 10.99, 1);
INSERT INTO `honeybits`.`product`(`product_name`, `product_description`, `product_price`, `created_by`) VALUES ('Product 2', 'Product 2 description', 12.89, 4);
INSERT INTO `honeybits`.`product`(`product_name`, `product_description`, `product_price`, `created_by`) VALUES ('Product 3', 'Product 3 description', 13.79, 4);
INSERT INTO `honeybits`.`product`(`product_name`, `product_description`, `product_price`, `created_by`) VALUES ('Product 4', 'Product 4 description', 14.69, 4);

-- Product_image Table
INSERT INTO `honeybits`.`product_image` (`product_id`, `product_image_name`, `product_image_description`, `product_image_type`, `created_by`) VALUES ( 1, 'product_image_1', 'Image for the first product', '.jpeg', 1);
INSERT INTO `honeybits`.`product_image` (`product_id`, `product_image_name`, `product_image_description`, `product_image_type`, `created_by`) VALUES ( 2, 'product_image_2', 'Image for the second product', '.jpeg', 4);
INSERT INTO `honeybits`.`product_image` (`product_id`, `product_image_name`, `product_image_description`, `product_image_type`, `created_by`) VALUES ( 3, 'product_image_3', 'Image for the third product', '.jpeg', 4);
INSERT INTO `honeybits`.`product_image` (`product_id`, `product_image_name`, `product_image_description`, `product_image_type`, `created_by`) VALUES ( 4, 'product_image_4', 'Image for the fourth product', '.jpeg', 4);

-- Shop Table
INSERT INTO `honeybits`.`shop` (`owner_id`, `shop_name`, `shop_description`, `created_by`) VALUES (1, 'First Shop', 'First shop for testing purposes.', 1);
INSERT INTO `honeybits`.`shop` (`owner_id`, `shop_name`, `shop_description`, `created_by`) VALUES (4, 'Second Shop', 'Second shop for testing purposes.', 4);

-- Shop_follower Table
INSERT INTO `honeybits`.`shop_follower` (`shop_id`, `user_id`, `created_by`) VALUES (1, 2, 2);
INSERT INTO `honeybits`.`shop_follower` (`shop_id`, `user_id`, `created_by`) VALUES (2, 2, 2);
INSERT INTO `honeybits`.`shop_follower` (`shop_id`, `user_id`, `created_by`) VALUES (1, 3, 3);
INSERT INTO `honeybits`.`shop_follower` (`shop_id`, `user_id`, `created_by`) VALUES (2, 3, 3);

-- Shop_Product Table
INSERT INTO `honeybits`.`shop_product` (`shop_id`, `product_id`, `created_by`) VALUES (1, 1, 1);
INSERT INTO `honeybits`.`shop_product` (`shop_id`, `product_id`, `created_by`) VALUES (2, 2, 4);
INSERT INTO `honeybits`.`shop_product` (`shop_id`, `product_id`, `created_by`) VALUES (2, 3, 4);
INSERT INTO `honeybits`.`shop_product` (`shop_id`, `product_id`, `created_by`) VALUES (2, 4, 4);

-- Product_like Table
INSERT INTO `honeybits`.`product_like` (`user_id`, `product_id`, `created_by`) VALUES (3, 1, 3);
INSERT INTO `honeybits`.`product_like` (`user_id`, `product_id`, `created_by`) VALUES (3, 2, 3);
INSERT INTO `honeybits`.`product_like` (`user_id`, `product_id`, `created_by`) VALUES (3, 3, 3);
INSERT INTO `honeybits`.`product_like` (`user_id`, `product_id`, `created_by`) VALUES (3, 4, 3);
INSERT INTO `honeybits`.`product_like` (`user_id`, `product_id`, `created_by`) VALUES (1, 1, 1);
INSERT INTO `honeybits`.`product_like` (`user_id`, `product_id`, `created_by`) VALUES (1, 2, 1);
INSERT INTO `honeybits`.`product_like` (`user_id`, `product_id`, `created_by`) VALUES (1, 3, 1);
INSERT INTO `honeybits`.`product_like` (`user_id`, `product_id`, `created_by`) VALUES (1, 4, 1);

