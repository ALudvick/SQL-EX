-- SQL-EX 1
-- Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. 
-- Вывести: model, speed и hd

SELECT model, speed, hd
FROM pc
WHERE price < 500
;

-- SQL-EX 2
-- Найдите производителей принтеров. Вывести: maker

SELECT DISTINCT pr.maker
FROM product pr
WHERE pr.type = 'Printer'
;

-- SQL-EX 3
-- Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.

SELECT lp.model, lp.ram, lp.screen
FROM laptop lp
WHERE lp.price > 1000
;

-- SQL-EX 4
-- Найдите все записи таблицы Printer для цветных принтеров.

SELECT *
FROM printer pp
WHERE pp.color = 'y'
;

-- SQL-EX 5
-- Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.

SELECT pc.model, pc.speed, pc.hd
FROM PC pc
WHERE (pc.cd = '12x' OR pc.cd ='24x')
AND pc.price < 600
;

-- SQL-EX 6
-- Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, 
-- найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.

SELECT DISTINCT pr.maker, lp.speed
FROM product pr
JOIN laptop lp ON lp.model = pr.model
WHERE 1 = 1
AND lp.hd >= 10
;

-- SQL-EX 7
-- Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).

SELECT pc.model, pc.price
FROM pc pc
JOIN Product pr ON pr.model = pc.model
WHERE pr.maker LIKE 'B'

UNION ALL 

SELECT lp.model, lp.price
FROM laptop lp
JOIN product pr ON pr.model = lp.model
WHERE pr.maker LIKE 'B'

UNION ALL 

SELECT pp.model, pp.price
FROM printer pp
JOIN product pr ON pr.model = pp.model
WHERE pr.maker LIKE 'B'
;

-- SQL-EX 8
-- Найдите производителя, выпускающего ПК, но не ПК-блокноты.

SELECT pr.maker
FROM product pr
WHERE pr.type = 'PC'
EXCEPT (SELECT pr1.maker FROM product pr1 WHERE pr1.type = 'Laptop')
;

-- SQL-EX 9
-- Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker

SELECT DISTINCT pr.maker
FROM product pr
JOIN pc pc ON pc.model = pr.model
WHERE pc.speed >= 450
;

-- SQL-EX 10
-- Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price

SELECT pp.model, pp.price
FROM printer pp
WHERE pp.price = (SELECT MAX(pp1.price) FROM pp1.printer)
;
