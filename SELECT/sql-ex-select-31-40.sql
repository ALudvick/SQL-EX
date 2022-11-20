-- SQL-EX 31
-- Для классов кораблей, калибр орудий которых не менее 16 дюймов, укажите класс и страну.

SELECT cl.class, cl.country FROM classes cl WHERE cl.bore >= 16.0
;