USE vk;

-- Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке.

SELECT DISTINCT firstname FROM users 
	ORDER BY firstname ;


-- Первые пять пользователей пометить как удаленные.

UPDATE users
SET 
	is_deleted = 1
LIMIT 5;


-- Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней).
DELETE FROM messages 
WHERE created_at > now() 


-- Написать название темы курсового проекта.

-- HeadHunter DATABASE 
