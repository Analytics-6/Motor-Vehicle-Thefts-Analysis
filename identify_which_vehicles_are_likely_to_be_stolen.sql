select * from stolen_vehicles

-- Identify which vehicles are likely to be stolen

--1) Find the vehicle types that are most often and least often stolen

select vehicle_type, count(vehicle_id) as num_of_vehicles
from stolen_vehicles 
group by vehicle_type
order by num_of_vehicles desc
limit 5

select vehicle_type, count(vehicle_id) as num_of_vehicles
from stolen_vehicles 
group by vehicle_type
order by num_of_vehicles 
limit 5

--2) For each vehicle type, find the average age of the cars that are stolen
select vehicle_type, round(avg(year(date_stolen) - model_year),2) as avg_age
from stolen_vehicles 
group by vehicle_type
order by avg_age desc

--3) For each vehicle type, find the percent of vehicles stolen that are luxury versus standard
with luxury as
(select vehicle_type,
case when make_type = 'Luxury' then 1 else 0 end as luxury_type
from stolen_vehicles sv
left join make_details md on md.make_id = sv.make_id)
select vehicle_type, sum(luxury_type)/count(luxury_type) * 100 as pct_stolen_vehicles
from luxury
group by vehicle_type
order by pct_stolen_vehicles desc

with luxury as
(select vehicle_type,
case when make_type = 'Luxury' then 1 else 0 end as luxury_type, 1 as all_cars
from stolen_vehicles sv
left join make_details md on md.make_id = sv.make_id)
select vehicle_type, sum(luxury_type)/sum(all_cars) * 100 as pct_stolen_vehicles
from luxury
group by vehicle_type
order by pct_stolen_vehicles desc

select vehicle_type, count(vehicle_id) as num_of_vehicles
from stolen_vehicles
group by vehicle_type
order by num_of_vehicles desc
limit 10

select color, count(vehicle_id) as num_of_vehicles
from stolen_vehicles
group by color
order by num_of_vehicles desc


--4) Create a table where the rows represent the top 10 vehicle types, the columns represent the top 7 vehicle colors (plus 1 column for all other colors) and the values are the number of vehicles stolen
select vehicle_type, count(vehicle_id) as num_of_vehicles,
sum(case when color = 'Silver' then 1 else 0 end) as Silver,
sum(case when color = 'White' then 1 else 0 end) as White,
sum(case when color = 'Black' then 1 else 0 end) as Black,
sum(case when color = 'Blue' then 1 else 0 end) as Blue,
sum(case when color = 'Red' then 1 else 0 end) as Red,
sum(case when color = 'Grey' then 1 else 0 end) as Grey,
sum(case when color = 'Green' then 1 else 0 end) as Green,
sum(case when color in ('Gold','Brown','Yellow','Orange','Purple','Cream','Pink') then 1 else 0 end )as Other
from stolen_vehicles
group by vehicle_type
order by num_of_vehicles desc
limit 10



