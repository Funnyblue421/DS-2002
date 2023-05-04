# DROP database `sakila_dw`;
CREATE DATABASE `sakila_dw` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE sakila_dw;

# DROP TABLE `dim_rentals`;
CREATE TABLE `dim_rentals` (
  `rental_key` int NOT NULL AUTO_INCREMENT,
  `inventory` int DEFAULT NULL,
  `customer` int DEFAULT NULL,
  `rental_date` datetime DEFAULT NULL,
  `return_date` datetime DEFAULT NULL,
  PRIMARY KEY (`rental_key`),
  KEY `inventory` (`inventory`),
  KEY `customer` (`customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

USE sakila;

# Populate dim_rentals
INSERT INTO `sakila_dw`.`dim_rentals`
(`rental_key`,
`inventory`,
`customer`,
`rental_date`,
`return_date`)
SELECT `rental_id`,
`inventory_id`,
`customer_id`,
`rental_date`,
`return_date`
FROM sakila.rental;
