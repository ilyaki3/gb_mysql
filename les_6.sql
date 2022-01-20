USE vk;

/*
 * 1) Пусть задан некоторый пользователь. 
 * Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
 */



SELECT from_user_id, count(*) AS send FROM messages 
WHERE 
	to_user_id = 1	AND from_user_id IN (
		SELECT initiator_user_id AS friends FROM friend_requests
		WHERE status = 'approved' AND target_user_id = 1
		UNION ALL 
		SELECT target_user_id FROM friend_requests
		WHERE status = 'approved' AND initiator_user_id = 1)


GROUP BY from_user_id 
ORDER BY send DESC 
LIMIT 1;



/*
 * 2) Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.
 */

SELECT count(*) AS likes_count FROM likes
WHERE 
	media_id in (SELECT id FROM media 
		WHERE user_id in 
			(SELECT user_id FROM profiles WHERE timestampdiff(YEAR, birthday, now()) < 11)); 
	


/*
 * 3) Определить кто больше поставил лайков (всего): мужчины или женщины.
 */

SELECT 
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender, 
	count(id) AS likes_count 
FROM likes 
GROUP BY gender
ORDER BY likes_count DESC 
LIMIT 1;














