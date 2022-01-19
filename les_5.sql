USE vk;

/*
 * Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»
 */






/*  1) Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
		Заполните их текущими датой и временем. 
*/

ALTER TABLE users DROP COLUMN created_at;
ALTER TABLE users DROP COLUMN updated_at;
ALTER TABLE users ADD COLUMN created_at datetime; 
ALTER TABLE users ADD COLUMN updated_at datetime; 


UPDATE users 
SET 
	created_at = now(),
	updated_at = now();

select created_at, updated_at from users;






/*  2) Таблица users была неудачно спроектирована. 
	   Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время 
	   помещались значения в формате 20.10.2017 8:10. 
	   Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
*/

-- Создание столбцов с неверным типом данных

ALTER TABLE users DROP COLUMN created_at;
ALTER TABLE users DROP COLUMN updated_at;
ALTER TABLE users ADD COLUMN created_at VARCHAR(255); 
ALTER TABLE users ADD COLUMN updated_at VARCHAR(255); 


UPDATE users 
SET 
	created_at = '20.10.2017 8:10',
	updated_at = '20.10.2017 8:10';


-- Создание дополнительных столбцов

-- ALTER TABLE users DROP COLUMN created_at_dt;
-- ALTER TABLE users DROP COLUMN updated_at_td;

ALTER TABLE users ADD COLUMN created_at_dt datetime;
ALTER TABLE users ADD COLUMN updated_at_td datetime; 

UPDATE users
SET 
	created_at_dt = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
	updated_at_td = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i');

-- Удаление старых  и переименование новых столбцов

ALTER TABLE users DROP created_at, DROP updated_at;

ALTER TABLE users RENAME COLUMN created_at_dt TO created_at;
ALTER TABLE users RENAME COLUMN updated_at_td TO updated_at;





/* 3) В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0,
 	  если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
	  чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей.

*/

DROP TABLE IF EXISTS `storehouses_products`;
CREATE TABLE `storehouses_products` (
	`id` serial,
	`product` varchar(255),
	`value` bigint UNSIGNED NOT NULL
);

INSERT INTO `storehouses_products` VALUES (1,'a280ff4af10e8338a3ae6cb56e4c1499',0),(2,'39b5365ea5f317e60ea90367c546a41c',125),(3,'1c61f6822087c9ee16141f52604b7095',0),(4,'87d2136c29d0155f84f4813828ad1be1',65),(5,'af2adaa7c0c0a98afdc6ebf8751727c4',29),(6,'35a58335d6a52975284876caff622b5d',79),(7,'ce0801cda23e2eab14feac1362c5a48d',161),(8,'f578f8939ff7037dc4dde7b0a2a75019',135),(9,'b8051eee846107428fe022287583fee6',58),(10,'ec95382d1c6ab5f859a8ee39ab3009f9',112);


SELECT * FROM storehouses_products 
ORDER BY CASE 
WHEN VALUE != 0 THEN 0 ELSE 1 END, value;





/* 4) (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
 	  Месяцы заданы в виде списка английских названий (may, august)
*/

ALTER TABLE users ADD COLUMN birthday_at varchar(255);
UPDATE users SET birthday_at = 'May' WHERE 2 < id < 4;
UPDATE users SET birthday_at = 'August' WHERE id > 5;
	
SELECT id, firstname, lastname, birthday_at FROM users 
WHERE birthday_at IN ('May', 'August');




/* 5) (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. 
	SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
*/

SELECT id, email FROM users WHERE id IN (5, 1, 2) ORDER BY field(id, 5, 1, 2);









/*
 * Практическое задание теме «Агрегация данных»
 */

/* 
 * 1) Подсчитайте средний возраст пользователей в таблице users.
 */

-- Создание и заполнение столбца birthday_at с помощью дополнительной таблицы
DROP TABLE IF EXISTS birth;
CREATE TABLE birth (
	id serial,
	birthday_at date);
INSERT INTO birth VALUES (1,'1972-06-21'), (2,'1975-07-22'), (3,'1975-12-18'), (4,'1982-10-03'), (5,'1988-03-12'), (6,'1990-05-02'), (7,'1991-07-08'), (8,'1997-03-15'), (9,'2001-01-01'), (10,'2003-04-20');


-- Не получилось сделать update таблицы users birthday_at через другую таблицу, только вывести вместе(

-- SELECT users.id, users.firstname, birth.birthday_at FROM users 
-- INNER JOIN birth 
-- 	ON users.id = birth.id;


SELECT sum(timestampdiff(YEAR, birthday_at, now())) / count(birthday_at) AS average_age FROM birth



/*
 * 2) Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
 * Следует учесть, что необходимы дни недели текущего года, а не года рождения.
 */

SELECT 
	dayname(concat(YEAR(now()), '-', substring(birthday_at, 6, 10))) AS weekday,
	count(*) AS count_weekday
FROM birth
GROUP BY weekday
ORDER BY count_weekday;




/*
 * 3) (по желанию) Подсчитайте произведение чисел в столбце таблицы.
 */

SELECT floor(exp(sum(LN(id)))) AS product_of_numbers FROM users






















