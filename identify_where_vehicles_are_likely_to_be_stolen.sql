select * from locations
select * from stolen_vehicles

--1) Find the number of vehicles that were stolen in each region
select l.region, count(sv.vehicle_id) as num_of_vehicles 
from locations l
left join stolen_vehicles sv on sv.location_id = l.location_id
group by l.region
order by num_of_vehicles desc

--2) Combine the previous output with the population and density statistics for each region
select l.region, l.population, l.density, count(sv.vehicle_id) as num_of_vehicles 
from locations l
left join stolen_vehicles sv on sv.location_id = l.location_id
group by l.region, l.population, l.density
order by num_of_vehicles desc

--3) Do the types of vehicles stolen in the three most dense regions differ from the three least dense regions?
select l.region, l.population, l.density, count(sv.vehicle_id) as num_of_vehicles 
from locations l
left join stolen_vehicles sv on sv.location_id = l.location_id
group by l.region, l.population, l.density
order by l.density desc

Auckland	1695200	343.09	1638
Nelson	54500	129.15	92
Wellington	543500	67.52	420

select l.region, l.population, l.density, count(sv.vehicle_id) as num_of_vehicles 
from locations l
left join stolen_vehicles sv on sv.location_id = l.location_id
group by l.region, l.population, l.density
order by l.density

West Coast	32700	1.41	0
Southland	102400	3.28	26
Marlborough	51900	4.94	0

(select 'High_Density' as density, vehicle_type, count(sv.vehicle_id) as num_of_vehicles 
from locations l
left join stolen_vehicles sv on sv.location_id = l.location_id
where l.region in ('Auckland', 'Nelson', 'Wellington')
group by vehicle_type
order by num_of_vehicles desc
limit 5
)
union
(select 'Low_Density' as density, vehicle_type, count(sv.vehicle_id) as num_of_vehicles 
from locations l
left join stolen_vehicles sv on sv.location_id = l.location_id
where l.region in ('West Coast', 'Southland', 'Marlborough')
group by vehicle_type
order by num_of_vehicles desc
limit 5
)


