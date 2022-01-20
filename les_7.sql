USE shop;

/*
 * 1) Составьте список пользователей users, которые осуществили 
 * 	  хотя бы один заказ orders в интернет магазине.
*/
SELECT 
	o.user_id, 
	u.name 
FROM users AS u
JOIN orders AS o
ON u.id = o.user_id

/*
 * 2) Выведите список товаров products и 
 *    разделов catalogs, который соответствует товару.
 */

SELECT 
	p.id , p.name , p.price , c.name 
FROM products p 
LEFT JOIN catalogs c 
ON p.catalog_id = c.id 



/*
 * (по желанию) 
 * Пусть имеется таблица рейсов flights (id, from, to) 
 * и таблица городов cities (label, name). 
 * Поля from, to и label содержат английские названия городов, поле name — русское. 
 * Выведите список рейсов flights с русскими названиями городов.
*/

DROP TABLE IF EXISTS flights;
CREATE TABLE flights(
	`id` int,
	`from` varchar(255),
	`to` varchar(255)
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities(
	`label` varchar(255),
	`name` varchar(255)
);

INSERT INTO flights 
VALUES (1, 'moscow', 'omsk'), (2, 'novgorod', 'kazan');


INSERT INTO cities 
VALUES 
	('moscow', 'Москва'), 
	('novgorod', 'Новгород'), 
	('omsk', 'Омск'), 
	('kazan', 'Казань');


SELECT 
	cf.name AS "Отправление", 
	ct.name AS "Прибытие" 
FROM flights AS f
JOIN cities AS cf ON cf.label = f.FROM
JOIN cities AS ct ON ct.label = f.TO 















