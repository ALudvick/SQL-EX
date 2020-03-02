

--------------------------------------------
-- sql-ex_22

select speed, avg(price) as Avg_price
from pc
where speed > 600
group by speed
order by speed

--------------------------------------------
-- sql-ex_23

select p1.maker
from pc pc
join product p1 on p1.model = pc.model
where pc.speed >= 750

intersect

select p2.maker
from laptop l
join product p2 on p2.model = l.model
where l.speed >= 750

--------------------------------------------
-- sql-ex_24

with Hight_price as (select model, price
						from pc
					union all
						select model, price
						from laptop
					union all
						select model, price
						from printer)
select distinct model
from Hight_price
where price = (select max(price)
				from Hight_price)
				
--------------------------------------------
-- sql-ex_25 
-- НЕВЕРНО!

select distinct maker
from product
where type = 'printer' 
and maker in (select maker
				from product
				where model in (select model 
								from pc 
								where speed = (select max(speed) 
												from (select speed 
														from pc where ram = (select min(ram) 
																				from pc)
													) as m
												)
								)
			)

--------------------------------------------
-- sql-ex_26

select avg(price)
	from (select pc.price as price
			from pc pc
			join product p1 on p1.model = pc.model
			where p1.maker like 'A'

			union all

			select l.price as price
			from laptop l
			join product p2 on p2.model = l.model
			where p2.maker like 'A') as aa
			
--------------------------------------------
-- sql-ex_27

select p.maker, avg(pc.hd) as avg_hd
from pc pc
join product p on p.model = pc.model
where p.maker in (select maker from product where type = 'printer')
group by p.maker

--------------------------------------------
-- sql-ex_28
-- НЕВЕРНО!

select qty
from (select maker, count(model) as qty
from product
group by maker) as cnt
where qty = 1