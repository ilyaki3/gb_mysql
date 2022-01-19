
/* Задача 1
Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, 
задав в нем логин и пароль, который указывался при установке.


C:\Program Files\MySQL\MySQL Server 8.0

[mysql]
user=root
password=*****

*/

/* Задача 2
Создайте базу данных example, разместите в ней таблицу users, 
состоящую из двух столбцов, числового id и строкового name.
*/
-- создание базы данных
create database if not exists example;
use example;

-- создание таблицы
create table users(
	id int auto_increment not null primary key,
	name varchar(100) not null
);


/* Задача 3
Создайте дамп базы данных example из предыдущего задания, 
разверните содержимое дампа в новую базу данных sample.
*/
-- создание дампа
mysqldump.exe -u root -p example > D:\exampledump.sql
-- разворачивание дампа
mysql create database sample
mysqldump.exe -u root -p sample < D:\exampledump.sql

/* Задача 4
(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. 
Создайте дамп единственной таблицы help_keyword базы данных mysql. 
Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
*/
mysqldump.exe -u root -p --where="true limit 100" mysql help_keyword > D:/exampledump.sql


/* горячие клавиши
Ctrl+Space – подсказки (если они есть)
Alt+X – исполнить всё или выделенное
Ctrt+Enter – иcполнить выражение под курсором.
Ctrl+PgUp / Ctrl +PgDn – навигация между вкладками.
*/
