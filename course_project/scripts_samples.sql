-- Скрипты характерных выборок

-- Поиск вакансий по желаемой зарплате
SELECT 
	v.title, 
	c.company_name,
	v.location, 
	v.key_skills, 
	v.job_discription,
	v.salary 
FROM vacancy v 
JOIN vacancies v2 ON v.id = v2.vacancy_id 
JOIN companies c ON c.id = v2.company_id 
WHERE v2.is_visible = 1 AND v2.is_deleted = 0 
	AND v.salary BETWEEN 1000 AND 5000
ORDER BY v2.updated_at DESC;


-- Подсчитать сколько резюме у пользователя
SELECT u.id , u.name , u.surname, count(ur.resume_id) 
FROM users u 
JOIN user_resumes ur ON u.id = ur.user_id 
WHERE u.id = 1


-- Получить последние отклики за неделю
SELECT `Дата отклика`
FROM my_invintations_from_companies mifc 
WHERE 7 > to_days(now()) - to_days(`Дата отклика`)


-- Собрать все отклики на вакансии от пользователей
SELECT 
	v.title,
	r.user_id,
	m.body,
	i.inventation_date 
FROM vacancy v 
JOIN invintations i ON i.vacancy_id = v.id AND i.`from` = 'u' 
JOIN resume r ON r.id = i.resume_id 
JOIN messages m ON 
	m.user_id = r.user_id AND m.company_id = v.company_id AND m.sender = 'u'
WHERE v.company_id  = 1
ORDER BY i.inventation_date DESC 

