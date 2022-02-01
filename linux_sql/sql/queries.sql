/*Question 1)*/
select distinct hi.cpu_number,hu.host_id,hi.total_mem 
from host_usage hu 
join host_info hi
on hi.id = hu.host_id
order by cpu_number asc,total_mem desc

/*Question 2)*/

select hu.host_id,hi.hostname,(date_trunc('hour', hu.timestamp) + 
							date_part('minute', hu.timestamp):: int / 5 * 
							interval '5 min') as rounded_timestamp,
							avg(((hi.total_mem/1024) - hu.memory_free)/(hi.total_mem/1024):: float) * 100
							as avg_used_mem_percentage
from host_usage hu 
join host_info hi
on hi.id = hu.host_id
group by rounded_timestamp,hu.host_id,hi.hostname
order by hu.host_id,rounded_timestamp

/*Question 3)*/

select hu.host_id,hi.hostname,(date_trunc('hour', hu.timestamp) + 
							date_part('minute', hu.timestamp):: int / 5 * 
							interval '5 min') as rounded_timestamp,
							count(*)
from host_usage hu 
join host_info hi
on hi.id = hu.host_id
group by 1,2,3
having count(*) < 3
order by rounded_timestamp





