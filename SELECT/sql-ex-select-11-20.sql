-- SQL-EX 11
-- Найдите среднюю скорость ПК.

SELECT AVG(pc.speed) FROM PC pc
;

-- SQL-EX 12
-- Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.

SELECT AVG(lp.speed)
FROM laptop lp
WHERE lp.price > 1000
;

-- SQL-EX 13
-- Найдите среднюю скорость ПК, выпущенных производителем A.

SELECT AVG(pc.speed)
FROM product pr
JOIN pc pc ON pc.model = pr.model
WHERE pr.maker LIKE 'A'
;

-- SQL-EX 14
-- Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.

SELECT DISTINCT sh.class, sh.name, cl.country
FROM ships sh
JOIN classes cl ON cl.class = sh.class
WHERE cl.numGuns >= 10
;

-- SQL-EX 15
-- Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD

SELECT hd
FROM (SELECT pc.hd, count(*) cnt FROM pc pc GROUP BY pc.hd) tmp
WHERE tmp.cnt >= 2
;

-- SQL-EX 16
-- Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара 
-- указывается только один раз, т.е. (i,j), но не (j,i), 
-- Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.

SELECT DISTINCT pc1.model, pc2.model, pc1.speed, pc1.ram
FROM pc pc1, pc pc2
WHERE pc1.speed = pc2.speed
AND pc1.ram = pc2.ram
AND pc1.model != pc2.model
AND pc1.model > pc2.model
;

-- SQL-EX 17
-- Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
-- Вывести: type, model, speed

SELECT DISTINCT pr.type, lp.model, lp.speed
FROM laptop lp
JOIN product pr ON pr.model = lp.model
WHERE lp.speed < (SELECT min(pc.speed) FROM pc pc)
;

-- SQL-EX 18
-- Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price

SELECT DISTINCT pr.maker, pp.price
FROM printer pp
JOIN product pr ON pr.model = pp.model
WHERE pp.color = 'y'
AND pp.price = (SELECT min(pp1.price) FROM printer pp1 WHERE pp1.color = 'y')
;

-- SQL-EX 19
-- Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
-- Вывести: maker, средний размер экрана.

SELECT pr.maker, avg(lp.screen)
FROM product pr
JOIN laptop lp ON lp.model = pr.model
GROUP BY pr.maker
;

-- SQL-EX 20
-- Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.

SELECT pr.maker, count(pr.type) cnt
FROM product pr
WHERE pr.type = 'PC'
GROUP BY pr.maker
HAVING count(pr.type) >= 3
;
