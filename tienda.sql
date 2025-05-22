

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

roducto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- 1. List the name of all products in the product table.
SELECT nombre FROM producto;

-- 2. List the names and prices of all products in the product table.
SELECT nombre, precio FROM producto;

-- 3. List all columns of the product table.
SELECT * FROM producto;

-- 4. List product names, prices in euros, and prices in USD (1 EUR = 1.08 USD).
SELECT nombre, precio, precio * 1.08 AS precio_usd FROM producto;

-- 5. Same as above, with column aliases.
SELECT nombre AS 'nombre de producto', precio AS euros, precio * 1.08 AS dólares FROM producto;

-- 6. List product names in uppercase along with their prices.
SELECT UPPER(nombre), precio FROM producto;

-- 7. List product names in lowercase along with their prices.
SELECT LOWER(nombre), precio FROM producto;

-- 8. List manufacturer names and the first two characters in uppercase.
SELECT nombre, UPPER(LEFT(nombre, 2)) FROM fabricante;

-- 9. List product names and their prices rounded to the nearest integer.
SELECT nombre, ROUND(precio) FROM producto;

-- 10. List product names and their prices truncated to whole numbers.
SELECT nombre, TRUNCATE(precio, 0) FROM producto;

-- 11. List manufacturer codes of products in the product table.
SELECT codigo_fabricante FROM producto;

-- 12. List unique manufacturer codes of products in the product table.
SELECT DISTINCT codigo_fabricante FROM producto;

-- 13. List manufacturer names in ascending order.
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- 14. List manufacturer names in descending order.
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- 15. List product names ordered by name ascending, then price descending.
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- 16. List the first 5 rows from the manufacturer table.
SELECT * FROM fabricante LIMIT 5;

-- 17. List 2 rows starting from the 4th row (inclusive) from the manufacturer table.
SELECT * FROM fabricante LIMIT 3 OFFSET 3;

-- 18. List the name and price of the cheapest product.
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- 19. List the name and price of the most expensive product.
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 20. List names of all products from manufacturer with code 2.
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- 21. List product name, price, and manufacturer name for all products.
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- 22. Same as above, but sorted by manufacturer name.
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre ASC;

-- 23. List product code, name, manufacturer code, and manufacturer name for all products.
SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- 24. List name, price, and manufacturer name of the cheapest product.
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.precio ASC LIMIT 1;

-- 25. List name, price, and manufacturer name of the most expensive product.
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.precio DESC LIMIT 1;

-- 26. List all products from the manufacturer Lenovo.
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

-- 27. List all products from manufacturer Crucial with price greater than 200.
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Crucial') AND precio > 200;

-- 28. List all products from manufacturers Asus, Hewlett-Packard, and Seagate without using IN.
SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';

-- 29. List all products from manufacturers Asus, Hewlett-Packard, and Seagate using IN.
SELECT * FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 30. List product names and prices from manufacturers whose name ends with 'e'.
SELECT producto.nombre, producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%e';

-- 31. List product names and prices where manufacturer name contains 'w'.
SELECT producto.nombre, producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%w%';

-- 32. List product name, price, and manufacturer for products priced >= 180, ordered by price DESC, then name ASC.
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 ORDER BY producto.precio DESC, producto.nombre ASC;

-- 33. List manufacturer code and name for manufacturers with associated products.
SELECT DISTINCT fabricante.codigo, fabricante.nombre FROM fabricante JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

-- 34. List all manufacturers and their products, including those with no products.
SELECT fabricante.nombre, producto.nombre FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

-- 35. List manufacturers with no associated products.
SELECT fabricante.nombre FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante WHERE producto.codigo IS NULL;

-- 36. List all products from manufacturer Lenovo without using INNER JOIN.
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

-- 37. List all products with the same price as the most expensive product from Lenovo.
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- 38. List the name of the most expensive product from Lenovo.
SELECT nombre FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- 39. List the name of the cheapest product from Hewlett-Packard.
SELECT nombre FROM producto WHERE precio = (SELECT MIN(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard'));

-- 40. List all products with price greater than or equal to the most expensive Lenovo product.
SELECT * FROM producto WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- 41. List all products from Asus that have a price above the average price of Asus products.
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus') AND precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus'));
