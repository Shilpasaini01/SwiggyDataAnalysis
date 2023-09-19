use swiggyda;
select * from orders;
select * from items;
select count(distinct name) from items;
select is_veg, count(name) as items from items
group by is_veg;
select name, is_veg from items where is_veg = 2;
select count(distinct order_id) from orders;
select * from items where name like '%Chicken%';
select count(distinct name)/count(distinct order_id) as averageOrder from items;
select name, count(*) from items group by name 
order by count(*) desc;
select restaurant_name, name from orders
join items on
orders.order_id = items.order_id;
select distinct rain_mode from orders;
select distinct on_time from orders;
select distinct restaurant_name from orders;
select count(*), restaurant_name from orders group by restaurant_name
order by count(*) desc;
-- select date_format("%Y-%m-%d", order_time) from orders; 
select max(order_time) from orders;
select sum(order_total) from orders;
select date_format(order_time, '%y-%m'), count(distinct order_id) from orders
group by  date_format(order_time, '%y-%m')
order by count(distinct order_id) desc;
select date_format(order_time, '%Y-%m'), sum(order_total) as total_revenue from orders
group by date_format(order_time, '%Y-%m')
order by total_revenue desc;
select sum(order_total)/count(distinct order_id) as avrg from orders;

with final as(
select year(order_time) as yearorder, sum(order_total) as revenue from orders
group by year(order_time)
order by sum(order_total))
select yearorder, revenue, lag(revenue) over (order by yearorder) as previousrevenue from final;

with final as(
select year(order_time) as yearorder, sum(order_total) as revenue from orders
group by year(order_time)
order by sum(order_total))
select yearorder, revenue, rank() over (order by revenue desc) as ranking from final;

with final as(
select restaurant_name, sum(order_total) as revenue from orders
group by restaurant_name)
select restaurant_name, revenue, rank() over (order by revenue desc) as ranking from final
order by revenue desc;

select rain_mode, sum(order_total) from orders
group by rain_mode;
select a.order_id,a.name, b.name as name2, concat(a.name,"-",b.name) from items a
join items b
on a.order_id=b.order_id
where a.name!=b.name
and a.name<b.name;
