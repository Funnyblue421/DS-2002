USE sakila_dw;

CREATE TABLE `fact_orders` (
	`fact_order_key` int NOT NULL AUTO_INCREMENT,
    `customer` int DEFAULT NULL,
	`store` int DEFAULT NULL,
	`address` int DEFAULT NULL,
    `city` int DEFAULT NULL,
	`customer_last_name` varchar(50) DEFAULT NULL,
	`customer_first_name` varchar(50) DEFAULT NULL,
	`customer_email` varchar(50) DEFAULT NULL,
    `district` varchar(50) DEFAULT NULL,
    `postal_code` varchar(50) DEFAULT NULL,
    `phone_number` varchar(50) DEFAULT NULL,
    PRIMARY KEY (`fact_order_key`),
    KEY `customer` (`customer`),
    KEY `store` (`store`),
    KEY `address` (`address`),
    KEY `city` (`city`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO fact_orders
(`customer`,
`store`,
`address`,
`city`,
`customer_last_name`,
`customer_first_name`,
`customer_email`,
`district`,
`postal_code`,
`phone_number`
)
SELECT c.customer_id,
    c.store_id,
    c.address_id,
    a.city_id,
    c.last_name,
    c.first_name,
    c.email,
    a.district,
    a.postal_code,
    a.phone
FROM sakila.customer AS c
INNER JOIN sakila.address AS a
ON c.address_id = a.address_id;
