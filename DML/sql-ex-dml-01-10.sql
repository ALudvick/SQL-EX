-- SQL-EX 1
-- Добавить в таблицу PC следующую модель:
-- code: 20, model: 2111, speed: 950, ram: 512, hd: 60, cd: 52x, price: 1100

INSERT INTO pc(code, model, speed, ram, hd, cd, price)
VALUES (20, 2111, 950, 512, 60, '52x', 1100)
;

-- SQL-EX 2
-- Добавить в таблицу Product следующие продукты производителя Z:
-- принтер модели 4003, ПК модели 4001 и блокнот модели 4002

INSERT INTO product(maker, model, type)
VALUES ('Z', 4003, 'Printer'), 
       ('Z', 4001, 'PC'),
       ('Z', 4002, 'Laptop')
;

-- SQL-EX 3
-- Добавить в таблицу PC модель 4444 с кодом 22, имеющую скорость процессора 1200 и цену 1350.
-- Отсутствующие характеристики должны быть восполнены значениями по умолчанию, принятыми для соответствующих столбцов.

INSERT INTO pc(code, model, speed, price)
VALUES (22, 4444, 1200, 1350)
;

-- SQL-EX 4
-- Для каждой группы блокнотов с одинаковым номером модели добавить запись в таблицу PC со следующими характеристиками:
-- код: минимальный код блокнота в группе +20;
-- модель: номер модели блокнота +1000;
-- скорость: максимальная скорость блокнота в группе;
-- ram: максимальный объем ram блокнота в группе *2;
-- hd: максимальный объем hd блокнота в группе *2;
-- cd: значение по умолчанию;
-- цена: максимальная цена блокнота в группе, уменьшенная в 1,5 раза.
-- Замечание. Считать номер модели числом.

INSERT INTO pc(code, model, speed, ram, hd, price)
SELECT min(code)+20 as code, 
       model+1000 as model,
       max(speed) as speed,
       max(ram)*2 as ram,
       max(hd)*2 as hd,
       max(price)/1.5 as price
FROM laptop
GROUP BY model
;

-- SQL-EX 5
-- Удалить из таблицы PC компьютеры, имеющие минимальный объем диска или памяти.

DELETE FROM pc
WHERE 1=1
   AND hd = (SELECT min(hd) FROM pc)
   OR ram = (SELECT min(ram) FROM pc)
;

-- SQL-EX 6
-- Удалить все блокноты, выпускаемые производителями, которые не выпускают принтеры.

DELETE FROM laptop
WHERE model IN (SELECT l.model
                FROM laptop l, product p
                WHERE 1=1
                AND l.model = p.model
                AND p.maker NOT IN (SELECT pr.maker FROM product pr WHERE pr.type = 'Printer')
               )
;

-- SQL-EX 7
-- Производство принтеров производитель A передал производителю Z. Выполнить соответствующее изменение.

UPDATE product
SET maker = 'Z' 
WHERE 1=1
AND maker = 'A'
AND type = 'Printer'
;

-- SQL-EX 8
-- Удалите из таблицы Ships все корабли, потопленные в сражениях.

DELETE FROM ships
WHERE name IN (SELECT s.name
               FROM ships s, outcomes o
               WHERE 1=1
               AND s.name = o.ship
               AND o.result = 'sunk'
              )
;

-- SQL-EX 9
-- Измените данные в таблице Classes так, чтобы калибры орудий измерялись в
-- сантиметрах (1 дюйм=2,5см), а водоизмещение в метрических тоннах (1 метрическая тонна = 1,1 тонны). 
-- Водоизмещение вычислить с точностью до целых.

UPDATE classes
SET bore = round(bore*2.5, 2), displacement = round(displacement/1.1, 0)
;



