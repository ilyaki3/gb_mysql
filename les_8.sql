USE vk;

/*
 * 1) Пусть задан некоторый пользователь. 
 * Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
 */


SELECT fr.initiator_user_id, count(*) AS count_of_messages
FROM friend_requests fr 
RIGHT JOIN messages m ON fr.initiator_user_id = m.from_user_id 
WHERE fr.target_user_id = 1 AND status = 'approved' AND m.to_user_id = 1

UNION ALL 

SELECT fr.target_user_id, count(*) 
FROM friend_requests fr 
RIGHT JOIN messages m ON fr.target_user_id = m.from_user_id 
WHERE fr.initiator_user_id = 1 AND status = 'approved' AND m.to_user_id = 1

ORDER BY count_of_messages DESC 
LIMIT 1


/*
 * 2) Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.
 */


SELECT count(l.id) AS likes_count
FROM media m 
JOIN likes l ON l.media_id = m.id
JOIN profiles p ON p.user_id = m.user_id 
WHERE timestampdiff(YEAR, p.birthday, now()) < 11


/*
 * 3) Определить кто больше поставил лайков (всего): мужчины или женщины.
 */


SELECT p.gender , count(l.id) AS cnt
FROM profiles p 
JOIN likes l ON p.user_id = l.user_id
GROUP BY gender
ORDER BY cnt DESC 
LIMIT 1








































