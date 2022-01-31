
DROP DATABASE IF EXISTS head_hunter;
CREATE DATABASE head_hunter;
USE head_hunter;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	`id` serial PRIMARY KEY,
	`name` varchar(100),
	`surname` varchar(100),
	`e-mail` varchar(100) UNIQUE,
	`phone_number` varchar(100) UNIQUE,
	`password` varchar(100) NOT NULL,
	`is_deleted` bit DEFAULT 0,
	
	INDEX user_password_idx(`id`, `password`) 
	);
	

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos`(
	`id` serial PRIMARY KEY,
	`user_id` bigint UNSIGNED NOT NULL,
	`filename` varchar(255) UNIQUE,
	`created_at` timestamp DEFAULT now(),
	`is_visible` bit DEFAULT 1,
	
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE `user_profile`(
	`user_id` bigint UNSIGNED NOT NULL,
	`gender` char(1), 
	`country` varchar (100),
	`city` varchar (100),
	`birth_date` datetime,
	`nationality` varchar (100),
	`photo_id` bigint UNSIGNED NOT NULL,
	`created_at` timestamp DEFAULT now(),
	
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (photo_id) REFERENCES photos(id) ON UPDATE CASCADE ON DELETE CASCADE 
);


DROP TABLE IF EXISTS `resume`;
CREATE TABLE `resume`(
	`id` serial PRIMARY KEY,
	`user_id` bigint UNSIGNED NOT NULL,
	`photo_id` bigint UNSIGNED NOT NULL,
	`title` varchar(100),
	`salary` int UNSIGNED,
	`key_skills` varchar(100),
	`about_me` varchar(100),
	`education` varchar(100),
	`languages` varchar(100),
	
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE ON UPDATE CASCADE
);


DROP TABLE IF EXISTS `user_resumes`;
CREATE TABLE `user_resumes`(
	`resume_id` bigint UNSIGNED NOT NULL,
	`user_id` bigint UNSIGNED NOT NULL,
	`created_at` timestamp DEFAULT now(),
	`updated_at` timestamp DEFAULT now() ON UPDATE now(),
	`is_visible` bit DEFAULT 1,
	`is_deteled` bit DEFAULT 0,
	
	FOREIGN KEY (resume_id) REFERENCES resume(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	INDEX user_resume_idx(`user_id`, `resume_id`)
	);


DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies`(
	`id` serial PRIMARY KEY,
	`company_name` varchar(100),
	`photo_id` bigint UNSIGNED NOT NULL,
	`website` varchar(100),
	`e-mail` varchar(100),
	`password` varchar(100) NOT NULL,
	
	FOREIGN KEY (photo_id) REFERENCES photos(id) ON UPDATE CASCADE ON DELETE CASCADE,
	INDEX company_password_idx(`id`, `password`)
);


DROP TABLE IF EXISTS `vacancy`;
CREATE TABLE `vacancy`(
	`id` serial PRIMARY KEY,
	`company_id` bigint UNSIGNED NOT NULL,
	`title` varchar(100),
	`location` varchar(100),
	`salary` int UNSIGNED,
	`key_skills` varchar(255),
	`job_discription` varchar(255),
	
	FOREIGN KEY (company_id) REFERENCES companies(id) ON UPDATE CASCADE ON DELETE CASCADE 
);


DROP TABLE IF EXISTS `vacancies`;
CREATE TABLE `vacancies`(
	`vacancy_id` bigint UNSIGNED NOT NULL,
	`company_id` bigint UNSIGNED NOT NULL,
	`created_at` timestamp DEFAULT now(),
	`updated_at` timestamp ON UPDATE now(),
	`is_visible` bit DEFAULT 1,
	`is_deleted` bit DEFAULT 0,
	
	FOREIGN KEY (vacancy_id) REFERENCES vacancy(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (company_id) REFERENCES companies(id) ON UPDATE CASCADE ON DELETE CASCADE,
	INDEX company_vacancy_idx(`company_id`, `vacancy_id`)
);


DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages`(
	`id` serial PRIMARY KEY,
	`user_id` bigint UNSIGNED NOT NULL,
	`company_id` bigint UNSIGNED NOT NULL,
	`sender` char(1) COMMENT 'c - company or u - user',
	`status` enum('send', 'not send', 'read'),
	`body` varchar(255),
	`created_at` timestamp DEFAULT now(),
	
	FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (company_id) REFERENCES companies(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS `invintations`;
CREATE TABLE `invintations`(
	`resume_id` bigint UNSIGNED NOT NULL,
	`company_id` bigint UNSIGNED NOT NULL,
	`vacancy_id` bigint UNSIGNED NOT NULL,
	`message_id` bigint UNSIGNED NOT NULL,
	`inventation_date` timestamp DEFAULT now(),
	`from` char(1) COMMENT 'c - company or u - user',

	FOREIGN KEY (resume_id) REFERENCES resume(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (company_id) REFERENCES companies(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (vacancy_id) REFERENCES vacancy(id) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (message_id) REFERENCES messages(id) ON UPDATE CASCADE ON DELETE CASCADE
);







-- Представление информации о пользователе
CREATE OR REPLACE VIEW user_info AS 
SELECT  
	u.name AS 'Имя', 
	u.surname AS 'Фамилия', 
	up.country AS 'Страна', 
	up.city AS 'Город', 
	up.nationality AS 'Гражданство',
	up.birth_date AS 'Дата рождения'
FROM users u  
JOIN user_profile up ON u.id = up.user_id 


-- Представление для поиска откликов на резюме пользователя
CREATE OR REPLACE VIEW my_invintations_from_companies AS 
SELECT 
	r.user_id,
	r.title AS 'Вакансия', 
	c.company_name  AS 'Название компании',
	m.body AS 'Сообщение',
	i.inventation_date AS 'Дата отклика'
FROM resume r  
JOIN invintations i ON r.id = i.resume_id  AND i.`from` = 'c'  
JOIN companies c ON c.id = i.company_id 
JOIN messages m ON m.user_id  = r.user_id AND m.company_id = c.id AND m.sender = 'c'
ORDER BY i.inventation_date DESC 

-- SELECT *
-- FROM my_invintations_from_companies 
-- WHERE user_id = 22




-- Триггер для неверной даты рождения (можно работать с 16 лет)
DROP TRIGGER IF EXISTS wrong_birth_date;
delimiter //
CREATE TRIGGER wrong_birth_date BEFORE INSERT ON user_profile  
FOR EACH ROW 
BEGIN 
	IF YEAR(now()) - YEAR ('2022-01-31 19:31:54') < YEAR ('0016-00-00 00:00:00') THEN 
		SIGNAL SQLSTATE '45000' SET message_text = 'wrong date, you must be over 16';
	END IF;
END//
delimiter ;





-- Процедура для установки метки удален для пользователя,
-- сокрытия его резюме и фото
DROP PROCEDURE IF EXISTS set_profile_deleted;
DELIMITER //
//
CREATE PROCEDURE set_profile_deleted (
IN deleting_user_id bigint UNSIGNED)

BEGIN
	DECLARE `_rollback` BIT DEFAULT 0;
	DECLARE code varchar(100);
	DECLARE error_string varchar(100); 
	DECLARE tran_result varchar(100);

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
 		SET `_rollback` = 1;
 		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
		SET tran_result = concat('Ошибка: ', code, ' Текст ошибки: ', error_string);
	END;

	START TRANSACTION;
		UPDATE users 
		SET is_deleted = 1
		WHERE users.id = deleting_user_id; 
	
		UPDATE user_resumes 
		SET is_visible = 0
		WHERE user_id  = deleting_user_id;
	
		UPDATE photos  
		SET is_visible = 0
		WHERE user_id = deleting_user_id;
	
	IF `_rollback` THEN
		SET tran_result = 'ROLLBACK';
		ROLLBACK;
	ELSE
		SET tran_result = 'user marked as deleted';
		COMMIT;
	END IF;
END//
delimiter ;

-- CALL set_profile_deleted (4)




