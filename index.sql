--joins
SELECT * FROM invoice as i
join invoice_line as il on il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

SELECT  i.invoice_date, c.first_name,c.last_name,i.total
FROM invoice as i
JOIN customer as c on i.customer_id = c.customer_id

SELECT c.first_name,c.last_name,e.first_name,e.last_name
FROM customer as c
JOIN employee as e on c.support_rep_id = e.employee_id

SELECT al.title,ar.name
FROM album as al
JOIN artist as ar on al.album_id = ar.artist_id

SELECT pt.track_id
FROM playlist_track AS pt
JOIN playlist AS p ON p.playlist_id = pt.playlist_id
WHERE p.name ='Music'

SELECT t.name
FROM track AS t
JOIN playlist_track AS pt ON pt.track_id = t.track_id
WHERE pt.playlist_id =5

SELECT t.name, p.name
FROM track AS t
JOIN playlist_track as pt ON t.track_id = pt.track_id
JOIN playlist as p ON pt.playlist_id = p.playlist_id

SELECT t.name, a.title
FROM track AS t
JOIN album as a ON t.album_id = a.album_id
JOIN genre as g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk'



--nested queries

SELECT * FROM invoice
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99)


SELECT * FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music')

SELECT name FROM track
WHERE track_id IN (SELECT track_id FROM playlist_TRACK WHERE playlist_id = 5)

SELECT * FROM track
WHERE genre_ID IN (SELECT genre_id FROM genre WHERE name = 'Comedy')

SELECT * FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE title = 'Fireball')

SELECT * FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE artist_id in
( SELECT artist_id FROM artist WHERE name = 'Queen'))

-- updating rows

UPDATE customer
SET fax = null
WHERE fax IS NOT NULL

UPDATE customer
SET company = 'self'
WHERE company IS NULL

UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name ='Barnett'

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl' 

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name ='Metal')
And composer IS NULL

--GROUP BY

SELECT COUNT (*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name

SELECT COUNT (*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' or g.name ='Rock'
GROUP BY g.name

SELECT ar.name, COUNT (*)
FROM album al
JOIN artist ar ON al.artist_id = ar.artist_id
GROUP BY ar.name

--USE DISTINCT

SELECT DISTINCT composer
FROM track 

SELECT DISTINCT billing_postal_code
FROM invoice

SELECT DISTINCT company
FROM customer

--DELETE ROWS

DELETE FROM practice_delete WHERE type = 'bronze'

DELETE FROM practice_delete WHERE type = 'silver'

DELETE FROM practice_delete WHERE value = 150

-- eCommerce simulation 

CREATE TABLE users(
  user_id SERIAL PRIMARY KEY,
	name Text,
	email VARCHAR(250)
)

CREATE TABLE products (
  products_id SERIAL PRIMARY KEY,
	name Text,
	price FLOAT
)

CREATE TABLE orders (
    orders_id SERIAL PRIMARY 
    products_id SERIAL PRIMARY
    FORIEGN SERIAL KEY (products_id) REFERENCE products_id(products_id)
)

INSERT INTO products (price,name)
VALUES (0.99,'paper');
INSERT INTO products (price,name)
VALUES (1000,'T.V');
INSERT INTO products (price,name)
VALUES (1200,'Phone');

INSERT INTO users
(email, name)
VALUES
('trey','trey@gmail.com'),
('Madelyn', 'madelyn.arsenault@gmail.com'),
('Kevin', 'KevinIsAFratBoi@gmail.com');

INSERT INTO orders (products_id)
VALUES (1),(2),(3)

SELECT *
FROM products p
join orders o on o.products_id = p.products_id 
WHERE o.products_id =1  

SELECT *
FROM products p
join orders o on o.products_id = p.products_id 
 
SELECT SUM (price)
FROM products p 
JOIN orders o on o.products_id = p.products_id

ALTER TABLE users 
ADD column orders_id INTEGER REFERENCES orders(orders_id)  

UPDATE users 
SET orders_id = users_id;

SELECT * FROM users 
WHERE orders_id = 2

SELECT count(*) FROM users 
WHERE orders_id = 1