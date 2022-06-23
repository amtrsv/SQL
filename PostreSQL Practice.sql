
create table employees(
id serial primary key,
employee_name varchar(50) not null
);

insert into employees (employee_name)
values 
('Andrey'),
('Igor'),
('Pavel'),
('Vadim'),
('Artem'),
('Aleksei'),
('Eduard'),('Ivan'),('Petr'),
('Alexandra'),('Aline'),('Alla'),('Albina'),('Anastasia'),('Angelina'),('Valentina'),('Valeria'),
('Vera'),('Victoria'),('Daria'),('Diana'),('Eugenia'),('Elena'),('Joanna'),('Zena'),('Ina'),('Irene'),
('Camilla'),('Carina'),('Clara'),('Kristina'),('Lara'),('Lydia'),('Lilian'),('Lia'),('Mia'),
('Margarita'),('Marianna'),('Marina'),('Natalia'),('Nina'),('Anatole'),('Anton'),('Artemus'),
('Arthur'),('Boris'),('Basil'),('Gregory'),('Daniel'),('Demetrius'),('John'),('Joseph'),('Cyril'),
('Constantine'),('Leo'),('Leonidas'),('Max'),('Matthew'),('Michael'),('Moses'),('Nicolas'),('Paul'),('Peter'),
('Roman'),('Simon'),('Stanislaus'),('Timothy'),('Theodore'),('Erik'),('Jacob');



select * from employees;

create table salary
(id serial primary key,
monthly_salary int not null 
);

insert into salary (monthly_salary)
values 
(1000),(1100),(1200),(1300),(1400),(1500),(1600),(1700),
(1800),(1900),(2000),(2100),(2200),(2300),(2400),(2500);

select * from salary;

create table employees_salary(
id serial primary key,
employee_id int not null unique,
salary_id int not null
);

select * from employees_salary;

insert into employees_salary
(employee_id, salary_id)
values
(3,7),(1,4),(5,9),(40,13),(23,4),(11,2),(52,10),(15,13),(26,4),(16,1),
(33,16),(71,3),(72,4),(73,6),(74,7),(75,8),(76,9),(77,10),(78,12),(79,13),
(80,14),(20,3),(21,4),(25,5),(27,6),(44,7),(28,8),(29,9),(30,10),(31,11),
(32,12),(37,13),(34,14),(35,15),(36,16),(38,1),(39,2),(41,3),(42,4),(43,5);


select * from employees_salary;

create table roles (
id serial primary key,
role_name VARCHAR(30) not null unique
);


select column_name, data_type
FROM  information_schema.columns
WHERE table_name = 'roles';

select * from roles;

INSERT into roles (role_name) 
values ('Junior Python developer'),
		('Middle Python developer'),
		('Senior Python developer'),
		('Junior Java developer'),
		('Middle Java developer'),
		('Senior Java developer'),
		('Junior JavaScript developer'),
		('Middle JavaScript developer'),
		('Senior JavaScript developer'),
		('Junior Manual QA engineer'),
		('Middle Manual QA engineer'),
		('Senior Manual QA engineer'),
		('Project Manager'),
		('Designer'),
		('HR'),
		('CEO'),
		('Sales manager'),
		('Junior Automation QA engineer'),
		('Middle Automation QA engineer'),
		('Senior Automation QA engineer');
	
	select * from roles;

create table roles_employee
(id serial primary key,
employee_id int not null unique,
role_id int not null,
foreign key (employee_id)
	references employees(id),
	foreign key (role_id)
	references roles(id)
);

select * from roles_employee;


insert into roles_employee (employee_id, role_id)
values 
	(7,2),
	(20,4),
	(3,9),
	(5,13),
	(23,4),
	(11,2),
	(10,9),
	(22,13),
	(21,3),
	(34,4),
	(6,7),
	(1,1),
	(2,14),
	(4,15),
	(51,16),
	(52,17),
	(53,18),
	(54,19),
	(55,20),
	(56,3),
	(57,4),
	(58,5),
	(59,6),
	(60,7),
	(61,8),
	(62,9),
	(63,10),
	(64,11),
	(65,12),
	(66,13),
	(67,14),
	(68,15),
	(69,16),
	(70,17),
	(50,1),
	(49,2),
	(48,3),
	(47,4),
	(46,5),
	(45,6);
	
select * from roles_employee;


     -- 1. Вывести всех работников чьи зарплаты есть в базе, вместе с зарплатами.
select employee_name as "ФИО работника",
	   monthly_salary as "З/П работника"
	   from employees_salary 
	   join employees on employees_salary.employee_id = employees.id 
	   join salary on employees_salary.salary_id = salary.id;
	  
	  -- 2. Вывести всех работников у которых ЗП меньше 2000.
select employee_name as "ФИО работника",
       monthly_salary as "З/П работника"
       from employees_salary 
       join employees on employees_salary.employee_id = employees.id 
       join salary on employees_salary.salary_id = salary.id
       where monthly_salary < 2000;
      
      
 	   -- 3. Вывести все зарплатные позиции, но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select monthly_salary as "З/П работника", 
	   employee_name as "ФИО работника"
		from salary
		join employees_salary on employees_salary.salary_id = salary.id
		left join employees on employees_salary.employee_id = employees.id
		where employee_name is null;


		-- 4. Вывести все зарплатные позиции  меньше 2000 но работник по ним не назначен. (ЗП есть, но не понятно кто её получает.)
select employee_name as "ФИО работника",
		monthly_salary as "З/П работника"
		from salary
		join employees_salary on employees_salary.salary_id = salary.id
		left join employees on employees_salary.employee_id = employees.id
		where monthly_salary <= 2000 and employee_name notnull;


		-- 5. Найти всех работников кому не начислена ЗП.
select employee_name as "ФИО работника",
		monthly_salary as "отсутствует З/П работника"
		from salary 
		join employees_salary on employees_salary.salary_id = salary.id 
		right join employees on employees_salary.employee_id = employees.id
		where monthly_salary is null;
		
--  6. Вывести всех работников с названиями их должности.

select employee_name as "ФИО работника",
			role_name as "Должность"
			from roles_employee
			join employees on roles_employee.employee_id = employees.id 
			join roles on roles_employee.role_id = roles.id;
			
		
		-- 7. Вывести имена и должность только Java разработчиков.
select employee_name as "ФИО работника",
			role_name as "Должность"
			from roles_employee
			join employees on roles_employee.employee_id = employees.id 
			join roles on roles_employee.role_id = roles.id
			where role_name like '%Java developer%';
		
		-- 8. Вывести имена и должность только Python разработчиков.
select employee_name as "ФИО работника",
		role_name as "Должность"
		from roles_employee
		join roles on roles_employee.role_id = roles.id 
		join employees on roles_employee.employee_id = employees.id 
		where role_name like '%Python developer%';
	
	-- 9. Вывести имена и должность всех QA инженеров.
select employee_name as "ФИО работника",
		role_name as "Должность"
		from roles_employee 
		join roles on roles_employee.role_id = roles.id 
		join employees on roles_employee.role_id = employees.id
		where role_name like '%QA%';
	
	--10. Вывести имена и должность ручных QA инженеров.
select employee_name as "ФИО работника",
		role_name as "Должность"
		from roles_employee
		join roles on roles_employee.role_id = roles.id 
		join employees on roles_employee.employee_id = employees.id 
		where role_name like '%Manual%';
	
	-- 11. Вывести имена и должность автоматизаторов QA
select employee_name as "ФИО работника", 
		role_name as "Должность"
		from roles_employee
		join employees on roles_employee.employee_id = employees.id 
		join roles on roles_employee.role_id = roles.id 
		where role_name like '%Auto%';
	
	-- 12. Вывести имена и зарплаты Junior специалистов
select employee_name as "ФИО работника",
		monthly_salary as "З/П работника",
		role_name as "Должность"
		from salary
		join employees_salary on employees_salary.salary_id = salary.id 
		join employees on employees_salary.employee_id = employees.id 
		join roles_employee on employees.id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id
		where role_name like '%Junior%';
	
   -- 13. Вывести имена и зарплаты Middle специалистов
 select employee_name as "ФИО работника",
		monthly_salary as "З/П работника",
		role_name as "Должность"
		from salary 
		join employees_salary on salary.id = employees_salary.salary_id 
		join employees on employees_salary.employee_id = employees.id
		join roles_employee on employees.id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id 
		where role_name like '%Middle%';
	
	-- 14. Вывести имена и зарплаты Senior специалистов
select employee_name as "ФИО работника",
		monthly_salary as "З/П работника",
		role_name as "Должность"
		from salary
		join employees_salary on salary.id = employees_salary.salary_id 
		join employees on employees_salary.employee_id = employees.id 
		join roles_employee on employees.id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id 
		where role_name like '%Senior%';
	
	-- 15. Вывести зарплаты Java разработчиков
select monthly_salary as "З/П работника",
		role_name as "Должность"
		from salary
		join employees_salary on salary.id = employees_salary.salary_id 
		join roles_employee on employees_salary.employee_id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id 
		where role_name Like '%Java developer%';
	
	-- 16. Вывести зарплаты Python разработчиков
select monthly_salary as "З/П работника",
		role_name as "Должность"
		from salary 
		join employees_salary on salary.id = employees_salary.salary_id 
		join roles_employee on employees_salary.employee_id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id 
		where role_name like '%Python%';
	
	-- 17. Вывести имена и зарплаты Junior Python разработчиков
select monthly_salary as "З/П работника",
		employee_name as "ФИО"
		from salary
		join employees_salary on salary.id = employees_salary.salary_id 
		join employees on employees_salary.employee_id = employees.id
		join roles_employee on employees_salary.employee_id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id 
		where role_name like '%Junior Python%';
	
	-- 18. Вывести имена и зарплаты Middle(мидлов нет - вывожу сеньеров) JS разработчиков
select monthly_salary as "З/П работника",
		role_name as "Должность"
		from salary
		join employees_salary on salary.id = employees_salary.salary_id
		join employees on employees_salary.employee_id = employees.id 
		join roles_employee on employees.id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id
		where role_name like '%Senior JavaS%';
	
	-- 19. Вывести имена и зарплаты Senior Java разработчиков
select employee_name as "ФИО работника",
		monthly_salary as "З/П работника",
		role_name as "Должность"
		from salary 
		join employees_salary on salary.id = employees_salary.salary_id 
		join employees on employees_salary.employee_id = employees.id 
		join roles_employee on employees.id = roles_employee.employee_id
		join roles on roles_employee.role_id = roles.id 
		where role_name like '%Senior%';
	
	-- 20. Вывести зарплаты Junior QA инженеров
	select role_name as "Должность",
			monthly_salary as "З/П работника"
			from salary
			join employees_salary on salary.id = employees_salary.salary_id 
			join roles_employee on employees_salary.employee_id = roles_employee.employee_id 
			join roles on roles_employee.role_id = roles.id
			where role_name like '%QA%';
		
	-- 21. Вывести среднюю зарплату всех Junior специалистов
select avg(monthly_salary) as "Средняя З/П работника"
   		from salary
		join employees_salary on salary.id = employees_salary.salary_id 
		join roles_employee on employees_salary.employee_id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id
		where role_name like '%Junior%';
	
	--22. Вывести сумму зарплат JS разработчиков
select sum(monthly_salary) as "Сумма З/П работников"
		from salary 
		join employees_salary on salary.id = employees_salary.salary_id 
		join roles_employee on employees_salary.employee_id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id 
		where role_name like '%JavaScript%';
	
	-- 23. Вывести минимальную ЗП QA инженеров - (QA инженеров -нет буду выводить разработчиков)
select min(monthly_salary) as "Минимальная З/П работника"
		from salary
		join employees_salary on salary.id = employees_salary.salary_id 
		join roles_employee on employees_salary.employee_id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id
		where role_name like '%developer%';
	
	-- 24. Вывести максимальную разработчиков - (QA инженеров -нет буду выводить разработчиков)
select max(monthly_salary) as "Максимальная З/П работника"
		from salary
		join employees_salary on salary.id = employees_salary.salary_id 
		join roles_employee on employees_salary.employee_id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id
		where role_name like '%developer%';
	
	-- 25. Вывести количество QA инженеров - (QA инженеров -нет буду выводить разработчиков)
	
select count(role_name) as "Количество Разработчиков"
		from roles_employee
		join roles on roles_employee.role_id = roles.id
		where role_name like '%developer%';
	
	-- 26. Вывести количество Middle специалистов.
select count(role_name) as "Количество специалистов уровня Middle"
		from roles_employee
		join roles on roles_employee.role_id = roles.id
		where role_name like '%Middle%';
	
	-- 27. Вывести количество разработчиков (так как разработчики уже были выведены, выводим всех специалистов, которые не разработчики)
select count(role_name) as "Остальные должности, не разработчики"	
		from roles_employee
		join roles on roles_employee.role_id = roles.id 
		where role_name not like '%developer%';
	
	-- 28. Вывести фонд (сумму) зарплаты разработчиков.
select sum(monthly_salary) as "Суммы(фонд) зарплат разработчиков"
		from salary
		join employees_salary on salary.id = employees_salary.salary_id 
		join roles_employee on employees_salary.employee_id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id 
		where role_name like '%developer%';
	
    -- 29. Вывести имена, должности и ЗП всех специалистов по возрастанию
select employee_name as "ФИО работника",
		role_name as "Должность",
		monthly_salary as "З/П работника"
		from salary 
		join employees_salary on salary.id = employees_salary.salary_id
		join employees on employees_salary.employee_id = employees.id 
		join roles_employee on employees.id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id
		order by monthly_salary;
	
	-- 30. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП от 1700 до 2300
select employee_name as "ФИО работника",
		role_name as "Должность",
		monthly_salary as "З/П работника"
		from salary 
		join employees_salary on salary.id = employees_salary.salary_id
		join employees on employees_salary.employee_id = employees.id 
		join roles_employee on employees.id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id
		where monthly_salary between 1700 and 2300
		order by monthly_salary;
	
	--  31. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП меньше 2300
 
select employee_name as "ФИО работника",
		role_name as "Должность",
		monthly_salary as "З/П работника"
		from salary 
		join employees_salary on salary.id = employees_salary.salary_id
		join employees on employees_salary.employee_id = employees.id 
		join roles_employee on employees.id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id
		where monthly_salary < 2300
		order by monthly_salary;		
	
	-- 32. Вывести имена, должности и ЗП всех специалистов по возрастанию у специалистов у которых ЗП равна 1100, 1500, 2000
select employee_name as "ФИО работника",
		role_name as "Должность",
		monthly_salary as "З/П работника"
		from salary 
		join employees_salary on salary.id = employees_salary.salary_id
		join employees on employees_salary.employee_id = employees.id 
		join roles_employee on employees.id = roles_employee.employee_id 
		join roles on roles_employee.role_id = roles.id
		where monthly_salary in (1100, 1500, 2000)
		order by monthly_salary;
		

--Команды для проверки наполнения таблиц	  
select * from salary;
select * from employees_salary;
select * from employees;
select * from roles;
select * from roles_employee;



     
select * from salary;



























--Cоздание таблицы:
create table storage_goods (
id serial primary key,
title varchar(100),
articl varchar(10) not null,
image text null,
price dec(10,2) not null,
date_on date,
amount int null
);


--select * from storage_goods;

--drop table storage_goods;

--Наполнение таблицы данными:
insert into storage_goods (title, articl, image, price, date_on, amount)
values ('Детская игрушка', '2321231234', null, 100.89, '2021.11.17', 5),
	   ('Машина на пульте управления', '4238947239', null, 2341.65, '2021.12.29', 15),
	   ('Кукла', '2343243212', null, 500.00, '2021.12.21', 105),
	   ('Жевательная резинка','3854773847', null, 11.99, '2022.05.17', 55),
	   ('Детский рюкзак', '9383743893', null, 3454.50, '2022.05.11', 34);
	   
-- 
--Попытка ввода некорректных данных: 
--1) Ввод пустого артикула:
insert into storage_goods (title, articl, image, price, date_on, amount)
values ('Детская игрушка',null, null, 100.89, '2021.11.17', 5);
--SQL Error [23502]: ERROR: null value in column "articl" violates not-null constraint
  Подробности: Failing row contains (8, Детская игрушка, null, null, 100.89, 2021-11-17, 5).

--2) Ввод отрицательной цены товара: 
insert into storage_goods (title, articl, image, price, date_on, amount)
values ('Детская игрушка','1321412132', null, -100.89, '2021.11.17', 5);
--Данные записываются в таблицу

--3) Ввод отрицательного количества товаров:
insert into storage_goods (title, articl, image, price, date_on, amount)
values ('Детская игрушка','1321412132', null, -100.89, '2021.11.17', -50);
--Данные записываются в таблицу









create table online_shop (
id serial primary key,
articl char(10) unique,
name varchar(100) not null,
new_price dec(10,2) not null,
old_price dec(10,2) null,
image text null,
date_on_warehouse date,
amount_warehouse int not null,
categories_id int not null,
brand_id int not null
);


drop table online_shop;
select * from online_shop;

INSERT INTO online_shop  (articl , name , new_price, old_price, image, date_on_warehouse, amount_warehouse, categories_id, brand_id)
VALUES ('1231243478', 'Ручка гелевая', 34.99, null, null, '2022-05-21', 101, 1, 5),
       ('0081342200', 'Ручка шариковая', 101.79, 111.89, null, '2022-01-01', 31, 1, 5),
       ('3223412216', 'Ластик', 22.99, null, null, '2020-10-31', 21, 1, 5),
       ('test982193', 'Пенал', 210.99, 240.99, null, '2020-03-23', 78, 1, 5),
       ('test239480', 'Детский ранец', 134.99, null, 'https://images.app.goo.gl/IUK9Bt9Tgg5Rfh&d8Uew75GA', '2022-05-21', 10, 1, 5),
       ('4350490454', 'Разноцветные фломастеры', 141.79, 178.89, 'https://images.app.goo.gl/IUK9Bt9Tgg36Yfdhfs65GA', '2022-01-01', 131, 1, 5 ),
       ('9983543381', 'Тетрадь', 12.99, null, null, '2020-10-31', 521, 1, 5),
       ('test121623', 'Карандаш', 20.99, 20.99, 'https://images.app.goo.gl/IUK9Bt9TgdfhhJekUrhIIJ8', '2020-03-23', 378, 1, 5),
       ('2389754467', 'Глобус', 799.99, 1000.99, 'https://images.app.goo.gl/IUTu48YHf84hYuXNio5GA', '2022-05-21', 1101, 1, 5 ),
       ('3987981101', 'Линейка', 78.79, 101.89, 'https://images.app.goo.gl/IusdfjUiern7hR7Ghf7FgHG36', '2022-01-01', 319, 1, 5 ),
       ('test859834', 'Циркуль', 122.99, null, null, '2020-10-31', 320, 1, 5),
       ('9999234200', 'Корректор', 210.99, 340.99, 'https://images.app.goo.gl/IUK9Bt9TggkYuXNio5GA', '2020-03-23', 678, 1, 5),
       ('test213892', 'Мобильный телефон', 10134.99, 105678.93, 'https://www.labirint.ru/office/537944/', '2022-08-01', 1101, 2, 1 ),
       ('test943889', 'Телевизор', 50081.49, 51111.89, null, '2021-12-10', 231, 2, 3 ),
       ('7847948371', 'Компьютер', 34522.89, 67899.22, 'https://images.app.goo.gl/cGrLQt9aYzfXNv3YA', '2021-11-17', 545, 2, 2),
       ('test079010', 'Принтер', 12210.99, 12240.99, null, '2021-08-24', 23, 2, 2),
       ('4829323389', 'Факс', 22134.99, null, 'https://images.app.goo.gl/IUK9Bt9Tgg5Rfh&d8Uew75GA', '2022-04-07', 54, 2, 2),
       ('test900340', 'Сканер', 22141.79, 22178.89, 'https://images.app.goo.gl/IUK9Bt9Tgg36Yfdhfs65GA', '2022-05-01', 341, 2, 2),
       ('0348832156', 'Картриджи для принтера', 9012.99, null, null, '2022-04-30', 111, 2, 5),
       ('test883342', 'Папка', 500.99, 520.99, 'https://images.app.goo.gl/IUK9Bt9TgdfhhJekUrhIIJ8', '2022-04-23', 236, 3, 5),
       ('4378913878', 'Настольная лампа', 1799.99, 1900.99, 'https://images.app.goo.gl/IUTu48YHf84hYuXNio5GA', '2022-03-21', 9, 3, 4),
       ('test992348', 'Стол', 5578.79, 5591.89, null, '2022-02-24', 82, 3, 4),
       ('7288232381', 'Стул', 1122.99, null, 'https://images.app.goo.gl/IUK9Bt9TggkYuXNio5GA', '2022-05-23', 190, 3, 4),
       ('test799328', 'Диван', 45210.99, 47340.99, 'https://images.app.goo.gl/IUK9Bt9TggkYuXNio5GA', '2022-03-23', 1678, 3, 4);
       
      CREATE INDEX  online_shop_order_number ON online_shop (articl);
     CREATE INDEX  online_shop_date_on ON online_shop (date_on_warehouse);
      
     -- Добавить EXPLAIN
-- Запрос на выборку 10 самых новых товаров
explain SELECT * FROM online_shop 
ORDER BY date_on_warehouse desc
LIMIT 10;

-- Запрос на выборку 10 самых дешевых товаров
explain SELECT * FROM online_shop 
ORDER BY new_price
LIMIT 10;

explain SELECT articl, name , new_price, old_price, online_shop.old_price - online_shop.new_price as Price_diff
from online_shop 
ORDER BY Price_diff desc
LIMIT 10;

-- Запрос на выборку  10 товаров, цена на которых была максимально снижена (в абсолютном или относительном смысле)
explain SELECT articl, name , new_price, old_price, online_shop.old_price - online_shop.new_price as Price_diff
from online_shop 
ORDER BY Price_diff desc
LIMIT 10;
-- 4. Замечание относительно алиесов полей и таблиц русскими буквами понял, буду использовать латиницу.

-- Запрос на выборку Выбирают те товары, чей артикул начинается с символов "TEST" (такие товары должны быть в таблице!), используя оператор LIKE
explain SELECT * FROM online_shop 
WHERE articl  LIKE 'test%'; 
— 5. Для выборки данных, которые начинаются на «test» необходимо использовать выборку типа -  ‘test%’

4
-- Создайте таблицу Категорий товаров (например "Еда", "Посуда", "Обувь") и таблицу производителей (брендов)
CREATE TABLE categories (
 id serial primary key,
 name varchar(50) not null
);
CREATE TABLE brands (
    id serial primary key,
    name varchar(50) not null,
    class char(1)
   );
-- Добавьте в таблицу Товаров поля для связи с Категориями и Брендами
   
ALTER TABLE online_shop ADD COLUMN categories_id int;

ALTER TABLE online_shop ADD COLUMN brand_id; 

-- ALTER TABLE online_shop DROP COLUMN brand_id;

-- ALTER TABLE online_shop DROP COLUMN categories_id;

select * from online_shop;
select * from brands;
select * from categories;


--  Наполняем таблицы (Бренды и Категории) данными
INSERT INTO brands (name, class)
VALUES ('APPLE','A'),
       ('HP', 'A'),
       ('SONY', 'B'),
       ('IKEA', 'B'),
       ('МИР КАНЦЕЛЯРСКИХ ТОВАРОВ', 'C');
      
         drop table brands cascade;
      
      
      
INSERT INTO categories (name)
VALUES ('Кацелярские товары'),
       ('Электронника'),
       ('Мебель');
 
      
 -- Создать внешние ключи для связей
ALTER TABLE online_shop 
add foreign key (categories_id)
references categories (id);    

ALTER TABLE online_shop 
add foreign key (brand_id)
references brands (id);  

-- Выберут все товары с указанием их категории и бренда
SELECT * FROM online_shop 
JOIN categories ON online_shop.categories_id = categories.id
JOIN brands ON online_shop.brand_id = brands.id;

-- Выберут все товары, бренд которых начинается на букву "А"
SELECT * FROM online_shop 
JOIN categories ON online_shop.categories_id = categories.id
JOIN brands ON online_shop.brand_id = brands.id
WHERE brands.name like 'A%';

-- Выведут список категорий и число товаров в каждой (используйте подзапросы и функцию COUNT(), использовать группировку нельзя)
SELECT name,
(SELECT count(name) from online_shop where online_shop.categories_id = categories.id) as Quantity
FROM categories;

-- * Выберут для каждой категории список брендов товаров, входящих в нее
SELECT brands.name as Brands, online_shop.name as Goods FROM online_shop 
JOIN categories ON online_shop.categories_id = categories.id
JOIN brands ON online_shop.brand_id = brands.id
order by Brands;


-- Запрос, который выберет категории и среднюю цену товаров в каждой категории, при условии, что эта средняя цена менее 1000 рублей (выбираем "бюджетные" категории товаров)
SELECT categories.name, AVG(online_shop.new_price) as AVG_PRICE from online_shop
JOIN categories on categories.id = online_shop.categories_id
-- WHERE avg(online_shop.new_price) <= 1000
group by categories.name 
where avg_price  < 1000;

select * from online_shop;

-- Улучшите предыдущий запрос таким образом, чтобы в расчет средней цены включались только товары, имеющиеся на складе.
SELECT categories.name, AVG(online_shop.new_price) as AVG_PRICE from online_shop
JOIN categories on categories.id = online_shop.categories_id
WHERE online_shop.new_price <= 1000 AND online_shop.amount_warehouse > 0
GROUP BY categories.name;


5
-- Запрос, который выберет категории и среднюю цену товаров в каждой категории, при условии, что эта средняя цена менее 1000 рублей (выбираем "бюджетные" категории товаров)
SELECT categories.name, AVG(online_shop.new_price) as AVG_PRICE from online_shop 
JOIN categories on categories.id = online_shop.categories_id
WHERE online_shop.new_price <= 1000
GROUP BY categories.name;

-- Улучшите предыдущий запрос таким образом, чтобы в расчет средней цены включались только товары, имеющиеся на складе.
SELECT categories.name, AVG(online_shop.new_price) as AVG_PRICE from online_shop
JOIN categories on categories.id = online_shop.categories_id
WHERE online_shop.new_price <= 1000 AND online_shop.amount_warehouse > 0
GROUP BY categories.name;

-- Добавьте к таблице брендов класс бренда (A, B, C). Например, A - Apple, B - Samsung, C - Xiaomi. Напишите запрос, который для каждой категории и класса брендов, представленных в категории выберет среднюю цену товаров.
ALTER TABLE brands ADD column class Char(1);

SELECT categories.name, brands.class, AVG(online_shop.new_price) as AVG_PRICE from online_shop
JOIN categories on online_shop.categories_id = categories.id
JOIN brands on online_shop.brand_id = brands.id
GROUP BY (brands.class, categories.name);


-- Добавьте к своей базе данных таблицу заказов. Простейший вариант - номер заказа, дата и время, ID товара. Можете и сложнее, если у вас есть время.
CREATE TABLE Orders (
    id serial primary key,
    order_number char(10) not null,
    order_date date,
    online_shop_id int not null
);

ALTER TABLE Orders ADD FOREIGN KEY (goods_id) REFERENCES online_shop(id)
ON UPDATE CASCADE
ON DELETE restrict;

select*from orders;

-- Напишите запрос, который выведет таблицу с полями "дата", "число заказов за дату", "сумма заказов за дату". Для этого вам придется самостоятельно найти информацию о функциях работы с датой и временем.
SELECT order_date, COUNT(order_date) as Quan_Order_date, SUM(online_shop.new_price) as Sum_Order_date
FROM Orders
JOIN online_shop on online_shop.id = orders.goods_id
WHERE order_date = '2022-05-01'
group by orders.order_date;


-- * Улучшите этот запрос, введя группировку по признаку "дешевый товар", "средняя цена", "дорогой товар". Критерии отнесения товара к той или иной группе определите самостоятельно. В итоге должно получиться "дата", "группа по цене", "число заказов", "сумма заказов"
SELECT order_date,
       min(price) AS min_price,
       AVG(price) AS avg_price,
       max(price) as max_price,
       COUNT(order_date) as Quan_Order_date,
       SUM(goods.price) as Sum_Order_date
FROM Orders
JOIN goods on orders.goods_id = goods.id
WHERE order_date = '2022-05-01';


DROP TABLE Orders;

select * from online_shop;

-- Установите ограничения на таблицу товаров:
-- На цены товаров
ALTER TABLE online_shop ADD CHECK (new_price > 0 and old_price > 0);

-- На артикул
ALTER TABLE online_shop ADD  CHECK (length(article) = 10);

-- На поле "есть на складе"
ALTER TABLE online_shop ADD CHECK (amount_warehouse >= 0);

-- Придумайте еще не менее двух ограничений в других таблицах 
-- будущего интернет-магазина и реализуйте их
ALTER TABLE online_shop ADD check (brand_id <> 0);
ALTER TABLE online_shop ADD check (categories_id <> 0);

-- Допустим, что поступило требование: каждый товар может отныне находится в нескольких категориях сразу. 
-- Перепроектируйте таблицу товаров, используя поле categories bigint[] и напишите запросы:


-- Удаление связи
 ALTER TABLE online_shop DROP constraint online_shop_categories_id_fkey;

-- Замена типа поля
ALTER TABLE online_shop ALTER COLUMN categories_id TYPE bigint[] USING array[categories_id]::bigint[];

-- -- Выбирающий все товары из заданной категории
select * from online_shop where 1 = any (categories_id);

-- Выбирающий все товары из заданной категории
    select  * from online_shop
    where 2 = any(categories_id);
   
-- Выбирающий все категории и количество товаров в каждой из них
    select *,
    (
    select count(*)
     from online_shop
     where  categories.id = ANY(online_shop.categories_id)
     )
    FROM categories;
   
 -- Добавляющий определенный товар в определенную категорию (вам придется найти нужную функцию для работы с массивами)
    INSERT INTO online_shop (articl , name , new_price, old_price, image, date_on_warehouse, amount_warehouse, categories_id, brand_id) VALUES (
      '0007688821',
      'Стиральная машина',
      67896,
      70000,
      'http://www.yandex.ru/image',
      '2022-06-15',
      156,
      array[3],
      1);
     
    
     

