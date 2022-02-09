-- Практическое задание по теме “Оптимизация запросов”

USE shop;


-- 1) Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
-- catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, 
-- идентификатор первичного ключа и содержимое поля name.


DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	`created_at` datetime NOT NULL,
	`table_name` varchar(50),
	`row_id` bigint UNSIGNED NOT NULL,
	`name` varchar(100)
) engine=archive;


DROP PROCEDURE IF EXISTS write_logs;
DROP TRIGGER IF EXISTS users_log;
DROP TRIGGER IF EXISTS catalogs_log;
DROP TRIGGER IF EXISTS products_log;


delimiter //

CREATE PROCEDURE write_logs (
	IN `table_name` varchar(50),
	IN `row_id` bigint,
	IN `name` varchar(100))

BEGIN
	INSERT INTO logs(`table_name`, `row_id`, `name`, `created_at`)
	VALUES (`table_name`, `row_id`, `name`, now());
END//


CREATE TRIGGER users_log AFTER INSERT ON users 
FOR EACH ROW 
BEGIN 
	CALL write_logs ('users', NEW.id, NEW.name);
END//


CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs  
FOR EACH ROW 
BEGIN 
	CALL write_logs ('catalogs', NEW.id, NEW.name);
END//


CREATE TRIGGER products_log AFTER INSERT ON products  
FOR EACH ROW 
BEGIN 
	CALL write_logs ('products', NEW.id, NEW.name);
END//
delimiter ;



INSERT INTO users (`name`) VALUES ('Hello');
INSERT INTO catalogs (`name`) VALUES ('World');
INSERT INTO products (`name`) VALUES ('!');


SELECT * FROM logs 




-- 2) Создайте SQL-запрос, который помещает в таблицу users миллион записей.


DROP PROCEDURE IF EXISTS `multitude_insert`;
delimiter //
CREATE PROCEDURE `multitude_insert`(IN quantity int)
BEGIN
	DECLARE i int DEFAULT 0;
	WHILE i < quantity do
		INSERT INTO users(`name`) values(concat ('test_user_', i));
		SET i = i + 1;
	END WHILE; 
END//
delimiter ;

-- CALL multitude_insert (1000000000)


























