-- Project: Auto Sales Customer Acquisition Analysis
-- Purpose: Database schema and table creation
-- Author: Priyam Gupta
-- Date: 22nd June 2025

CREATE DATABASE auto;
USE auto;

-- Orders table - Core transaction data
CREATE TABLE IF NOT EXISTS `orders` (
    `order_id` int  NOT NULL ,
    `order_linenumber` int  NOT NULL ,
    `order_date` datetime  NOT NULL ,
    `order_status` varchar(20)  NOT NULL ,
    `order_quantity` int  NOT NULL ,
    `price_sold` decimal(10,2)  NOT NULL ,
    `client_id` varchar(20)  NOT NULL ,
    `product_code` varchar(30)  NOT NULL ,
    PRIMARY KEY (`order_id`,`order_linenumber`)
);

-- Customer information table
CREATE TABLE IF NOT EXISTS `customers` (
	`client_id` varchar(20) NOT NULL ,
	`client_name` varchar(50)  NOT NULL ,
    `contact_last_name` varchar(50)  NOT NULL ,
    `contact_first_name` varchar(50)  NOT NULL ,
    `city` varchar(50)  NOT NULL ,
    `country` varchar(50)  NOT NULL ,
    `postalcode` varchar(20)  NOT NULL ,
     PRIMARY KEY (`client_id`)
);

-- Product catalog table
CREATE TABLE IF NOT EXISTS `products` (
    `product_code` varchar(30)  NOT NULL ,
    `product_line` varchar(200)  NOT NULL ,
    `MSRP` int  NOT NULL ,
    PRIMARY KEY (`product_code`)
);

-- Foreign key constraints
ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_client_id` 
FOREIGN KEY(`client_id`) REFERENCES `customers` (`client_id`);

ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_product_code` 
FOREIGN KEY(`product_code`) REFERENCES `products` (`product_code`);
