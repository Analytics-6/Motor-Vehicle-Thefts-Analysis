
-- Identify when vehicles are likely to be stolen

--1) Find the number of vehicles stolen each year
select extract(year from date_stolen) as year, count(vehicle_id) as num_of_vehicles
from stolen_vehicles
group by year
order by num_of_vehicles

--2) Find the number of vehicles stolen each month
select month(date_stolen) as month, count(vehicle_id) as num_of_vehicles
from stolen_vehicles
group by month
order by month, num_of_vehicles

select extract(year from date_stolen) as year, extract(month from date_stolen) as month, count(vehicle_id) as num_of_vehicles
from stolen_vehicles
group by year, month
order by year, month, num_of_vehicles

select extract(year from date_stolen) as year, extract(month from date_stolen) as month, 
extract(day from date_stolen) as day, count(vehicle_id) as num_of_vehicles
from stolen_vehicles
where extract(month from date_stolen) = 4
group by year, month, day
order by year, month, day, num_of_vehicles

--3) Find the number of vehicles stolen each week
select DAYOFWEEK(date_stolen) as dow, count(vehicle_id) as num_of_vehicles
from stolen_vehicles
group by dow 
order by dow

--4) Replace the numeric day of week values with the full name of each day of the week (Sunday, Monday, Tuesday, etc.)
select DAYOFWEEK(date_stolen) as dow, 
case when DAYOFWEEK(date_stolen) = 1 then 'Sunday'
     when DAYOFWEEK(date_stolen) = 2 then 'Monday'
     when DAYOFWEEK(date_stolen) = 3 then 'Tuesday'
     when DAYOFWEEK(date_stolen) = 4 then 'Wednesday'
     when DAYOFWEEK(date_stolen) = 5 then 'Thursday'
     when DAYOFWEEK(date_stolen) = 6 then 'Friday'
     else 'Saturday'
     end as day_of_week,
count(vehicle_id) as num_of_vehicles
from stolen_vehicles
group by dow, day_of_week 
order by dow

