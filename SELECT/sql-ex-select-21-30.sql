-- SQL-EX 21
-- Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
-- Вывести: maker, максимальная цена.

SELECT pr.maker, MAX(pc.price)
FROM pc pc
JOIN product pr ON pr.model = pc.model
GROUP BY pr.maker
;

-- SQL-EX 22
--  Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. 
-- Вывести: speed, средняя цена.

SELECT pc.speed, avg(pc.price) as avg_price
FROM pc pc
WHERE pc.speed > 600
GROUP BY pc.speed
ORDER BY pc.speed
;

-- SQL-EX 23
-- Найдите производителей, которые производили бы как ПК
-- со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
-- Вывести: Maker

SELECT pr1.maker
FROM pc pc
JOIN product pr1 ON pr1.model = pc.model
WHERE pc.speed >= 750

INTERSECT

SELECT pr2.maker
FROM laptop lp
JOIN product pr2 ON pr2.model = lp.model
WHERE lp.speed >= 750
;

-- SQL-EX 24
-- Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.

WITH hight_price as (SELECT pc.model, pc.price FROM pc pc
					 UNION ALL
					 SELECT lp.model, lp.price FROM laptop lp
					 UNION ALL
					 SELECT pp.model, pp.price FROM printer pp
					)
SELECT DISTINCT model
FROM hight_price
WHERE price = (SELECT max(price) FROM hight_price)
;

-- SQL-EX 25 
-- Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым 
-- процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker

SELECT DISTINCT pr.maker
FROM product pr
WHERE 1=1
AND pr.type = 'Printer'
AND pr.maker in (SELECT pr2.maker
                 FROM pc pc1
		         JOIN product pr2 ON pr2.model = pc1.model
		     	 WHERE 1=1
				 AND pc1.ram = (SELECT min(pc2.ram) FROM pc pc2)
				 AND pc1.speed = (SELECT max(pc3.speed) FROM pc pc3 WHERE pc3.ram = (SELECT min(pc4.ram) FROM pc pc4))
                )
;

-- SQL-EX 26
-- Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.

SELECT avg(price)
FROM (SELECT pc.price
	  FROM pc pc
	  JOIN product pr1 ON pr1.model = pc.model
	  WHERE pr1.maker LIKE 'A'

	  UNION ALL

	  SELECT lp.price
	  FROM laptop lp
	  JOIN product pr2 ON pr2.model = lp.model
	  WHERE pr2.maker LIKE 'A') AS tmp
;
			
-- SQL-EX 27
-- Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. 
-- Вывести: maker, средний размер HD.

SELECT pr.maker, avg(pc.hd) as avg_hd
FROM pc pc
JOIN product pr ON pr.model = pc.model
WHERE pr.maker IN (SELECT pr1.maker FROM product pr1 WHERE pr1.type = 'Printer')
GROUP BY pr.maker
;

-- SQL-EX 28
-- Используя таблицу Product, определить количество производителей, выпускающих по одной модели.

SELECT count(*)
FROM (SELECT pr.maker, count(*) as cnt
	  FROM product pr
	  GROUP BY pr.maker) as tmp
WHERE tmp.cnt = 1
;

-- SQL-EX 29
-- В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще 
-- одного раза в день [т.е. первичный ключ (пункт, дата)], написать запрос с выходными 
-- данными (пункт, дата, приход, расход). Использовать таблицы Income_o и Outcome_o.

SELECT i.point, i.date, i.inc, o.out
FROM income_o i
LEFT JOIN outcome_o o ON i.point = o.point AND i.date = o.date

UNION

SELECT o.point, o.date, i.inc, o.out
FROM outcome_o o
LEFT JOIN income_o i ON o.point = i.point AND o.date = i.date
;

-- SQL-EX 30
-- В предположении, что приход и расход денег на каждом пункте приема фиксируется произвольное число 
-- раз (первичным ключом в таблицах является столбец code), требуется получить таблицу, в которой каждому 
-- пункту за каждую дату выполнения операций будет соответствовать одна строка.
-- Вывод: point, date, суммарный расход пункта за день (out), суммарный приход пункта за день (inc). 
-- Отсутствующие значения считать неопределенными (NULL).

SELECT tmp.point, tmp.date, SUM(tmp.sum_out), SUM(tmp.sum_inc)
FROM (SELECT i.point, i.date, SUM(i.inc) AS sum_inc, NULL AS sum_out 
      FROM income i 
      GROUP BY i.point, i.date

      UNION

      SELECT o.point, o.date, NULL AS sum_inc, SUM(o.out) AS sum_out 
      FROM outcome o 
      GROUP BY o.point, o.date) AS tmp
GROUP BY tmp.point, tmp.date
;