CREATE DATABASE Ernesto;

USE Ernesto;

DESCRIBE customer_address;

SELECT * FROM Ernesto.customer_address;

USE Ernesto;

DESCRIBE customer_demographic;

SELECT * FROM customer_demographic;

SELECT * FROM customer_demographic;

DESCRIBE transactions;

SELECT * FROM transactions;

#Agregar la edad de los clientes como age

SELECT 
    DATE_FORMAT(
        FROM_DAYS(
            DATEDIFF(CURRENT_DATE, DOB)
        ),
        '%y Years %m Months %d Days'
    ) AS age 
FROM 
    Ernesto.customer_demographic;
    
SHOW DATABASES;

USE Ernesto;

SHOW TABLES;

DESCRIBE transactions;

#Demograficos de clientes

SELECT * FROM customer_demographic 
ORDER BY tenure DESC;

#Clientes con mayor Antiguedad

SELECT customer_id, first_name, last_name, tenure FROM customer_demographic
ORDER BY tenure DESC;

#Clientes con mayor número de compras en los ultimos tres años

SELECT customer_id, first_name, last_name, past_3_years_bike_related_purchases FROM customer_demographic 
ORDER BY past_3_years_bike_related_purchases DESC;

#Clientes con mayor valor de propiedad

SELECT customer_id, property_valuation FROM customer_address
ORDER BY property_valuation DESC;

SELECT * FROM transactions; 

#Transacciones con order status approved

SELECT transaction_id, customer_id, order_status, brand, product_line, product_class, product_size FROM transactions
WHERE order_status = "Approved"; 

#Transacciones con order status approved con mayor precio de lista

SELECT transaction_id, customer_id, order_status, product_id, brand, product_line, product_class, product_size, list_price FROM transactions
WHERE order_status = "Approved"
ORDER BY list_price DESC;

#Transacciones con order status cancelled

SELECT transaction_id, customer_id, order_status, brand, product_line, product_class, product_size FROM transactions
WHERE order_status = "Cancelled"; 

#Transacciones con order status cancelled con mayor precio de lista

SELECT transaction_id, customer_id, order_status, product_id, brand, product_line, product_class, product_size, list_price FROM transactions
WHERE order_status = "Cancelled"
ORDER BY list_price DESC;

#Precio promedio 

SELECT AVG(list_price) FROM transactions;

#Costo promedio

SELECT AVG(standard_cost) FROM transactions;

#Número de transacciones 

SELECT COUNT(*) FROM transactions;

#Número de transacciones con estatus approved; 

SELECT COUNT(*) FROM transactions WHERE order_status = "Approved";

#Precio máximo

SELECT MAX(list_price) FROM transactions;

#Costo maximo

SELECT MAX(standard_cost) FROM transactions;

#Margen por producto 

SELECT (list_price - standard_cost) AS margin FROM transactions;
 
#Suma transacciones con estatus approved
 
SELECT sum(list_price) FROM transactions WHERE order_status = "Approved";
 
# Clientes con auto
 
SELECT customer_id, first_name, last_name, owns_car FROM customer_demographic WHERE owns_car = "yes"; 

# Clientes sin auto
 
SELECT customer_id, first_name, last_name, owns_car FROM customer_demographic WHERE owns_car = "no"; 

#Cantidad de transacciones por marca

SELECT brand, count(*) AS qty 
FROM transactions
GROUP BY brand
ORDER BY qty DESC;

#Cantidad de transacciones por cliente 

SELECT customer_id, count(*) AS qty
FROM transactions
GROUP BY customer_id
ORDER BY qty DESC;

#Join datos demograficos con datos de residencia

SELECT *
FROM customer_demographic AS cd
JOIN customer_address AS ca
ON cd.customer_id = ca.customer_id;

#Join datos demograficos con transacciones

SELECT *
FROM customer_demographic AS cd
JOIN transactions AS t
ON cd.customer_id = t.customer_id;

#Clientes con mayor numero de ordenes con estatus approved

SELECT customer_demographic.first_name, customer_demographic.last_name, customer_demographic.customer_id, count(*) AS count FROM Ernesto.customer_demographic
JOIN Ernesto.transactions
ON customer_demographic.customer_id = transactions.customer_id
WHERE order_status = "Approved"
GROUP BY customer_demographic.customer_id
ORDER BY count DESC;

#Clientes con menor número de ordenes con estatus approved

SELECT customer_demographic.first_name, customer_demographic.last_name, customer_demographic.customer_id, count(*) AS count FROM Ernesto.customer_demographic
JOIN Ernesto.transactions
ON customer_demographic.customer_id = transactions.customer_id
WHERE order_status = "Approved"
GROUP BY customer_demographic.customer_id
ORDER BY count ASC;

#Clientes con mayor numero de ordenes con estatus cancelled

SELECT customer_demographic.first_name, customer_demographic.last_name, customer_demographic.customer_id, count(*) AS count FROM Ernesto.customer_demographic
JOIN Ernesto.transactions
ON customer_demographic.customer_id = transactions.customer_id
WHERE order_status = "Cancelled"
GROUP BY customer_demographic.customer_id
ORDER BY count DESC;

# Crea una vista llamada monthly_sales que muestre el histórico de montos de venta por mes.
 
CREATE VIEW Ernesto.monthly_sales AS
SELECT 
  YEAR(transaction_date) AS year,
  MONTH(transaction_date) AS month,
  SUM(list_price) AS total
FROM Ernesto.transactions
WHERE order_status = "Approved"
GROUP BY year, month
ORDER BY year, month;

SELECT * FROM Ernesto.monthly_sales;















