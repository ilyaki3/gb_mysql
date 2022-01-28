
-- Практическое задание по теме “Транзакции, переменные, представления”
-- 
-- 1) В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
--    Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;
	INSERT INTO sample.users (name, birthday_at) 
	SELECT name, birthday_at 
	FROM shop.users 
	WHERE id = 1;
COMMIT;


-- 2) Создайте представление, которое выводит название name товарной позиции
--    из таблицы products и соответствующее название каталога name из таблицы catalogs.

USE shop;
CREATE OR REPLACE VIEW processors_catalod_id AS 
SELECT p.name AS 'processors', c.name AS 'category'
FROM products p 
JOIN catalogs c ON c.id = p.catalog_id  




-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- 
-- 1) Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
--    в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
--    возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
--    фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;
delimiter //
CREATE FUNCTION hello ()
RETURNS varchar(100) READS SQL DATA 
BEGIN 
	DECLARE time_is time;
	DECLARE greeting varchar(100); 
	SET time_is = curtime();
	
	IF time_is BETWEEN '06:00:00' AND '12:00:00' THEN 
		SET greeting = 'Доброе утро';
	
	ELSEIF time_is BETWEEN '12:00:00' AND '18:00:00' THEN 
		SET greeting = 'Добрый день';
	
	ELSEIF  time_is BETWEEN '18:00:00' AND '23:59:59' THEN 
		SET greeting = 'Добрый вечер';
	ELSE
		SET greeting = 'Доброй ночи';
	END IF;
	
	RETURN greeting;
END//
delimiter ;


SELECT hello() AS 'Приветствие'



-- 2) В таблице products есть два текстовых поля: name с названием товара 
--    и description с его описанием. Допустимо присутствие обоих полей или одно из них. 
--    Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
--    Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
--    При попытке присвоить полям NULL-значение необходимо отменить операцию.

-- Триггер для операции INSERT 
DROP TRIGGER IF EXISTS insert_to_name_and_description_null_value;
delimiter //
CREATE TRIGGER insert_to_name_and_description_null_value BEFORE INSERT ON products 
FOR EACH ROW 
BEGIN 
	IF isnull(NEW.name) OR isnull(NEW.description) THEN 
		SIGNAL SQLSTATE '45000' SET message_text = 'Name and description is null both!';
	END IF;
END//
delimiter ;

-- Проверка INSERT
INSERT INTO products (name, description) VALUES (NULL, NULL);

-- Триггер для операции UPDATE 
DROP TRIGGER IF EXISTS update_to_name_and_description_null_value;
delimiter //
CREATE TRIGGER update_to_name_and_description_null_value BEFORE UPDATE ON products 
FOR EACH ROW 
BEGIN 
	IF isnull(NEW.name) OR isnull(NEW.description) THEN 
		SIGNAL SQLSTATE '45000' SET message_text = 'Name and description is null both!';
	END IF;
END//
delimiter ;

-- Проверка UPDATE
UPDATE products 
	SET name = NULL, description = NULL
WHERE id = 1;











