
/* ������ 1
���������� ���� MySQL. �������� � �������� ���������� ���� .my.cnf, 
����� � ��� ����� � ������, ������� ���������� ��� ���������.


C:\Program Files\MySQL\MySQL Server 8.0

[mysql]
user=root
password=*****

*/

/* ������ 2
�������� ���� ������ example, ���������� � ��� ������� users, 
��������� �� ���� ��������, ��������� id � ���������� name.
*/
-- �������� ���� ������
create database if not exists example;
use example;

-- �������� �������
create table users(
	id int auto_increment not null primary key,
	name varchar(100) not null
);


/* ������ 3
�������� ���� ���� ������ example �� ����������� �������, 
���������� ���������� ����� � ����� ���� ������ sample.
*/
-- �������� �����
mysqldump.exe -u root -p example > D:\exampledump.sql
-- �������������� �����
mysql create database sample
mysqldump.exe -u root -p sample < D:\exampledump.sql

/* ������ 4
(�� �������) ������������ ����� �������� � ������������� ������� mysqldump. 
�������� ���� ������������ ������� help_keyword ���� ������ mysql. 
������ ��������� ����, ����� ���� �������� ������ ������ 100 ����� �������.
*/
mysqldump.exe -u root -p --where="true limit 100" mysql help_keyword > D:/exampledump.sql


/* ������� �������
Ctrl+Space � ��������� (���� ��� ����)
Alt+X � ��������� �� ��� ����������
Ctrt+Enter � �c������� ��������� ��� ��������.
Ctrl+PgUp / Ctrl +PgDn � ��������� ����� ���������.
*/
