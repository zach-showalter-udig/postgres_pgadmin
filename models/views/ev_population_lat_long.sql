{{ config(materialized='view')}}

with coords as (
	select vin, vehicle_location,
	substring(vehicle_location, '\((.+)\)') as coordinates
	from ev_population
),
lat_long as (
	select vin,
	split_part(coordinates, ' ',1) as lat,
	split_part(coordinates, ' ',2) as long
	from coords
),
ev_population as (
    select * from {{ ref("ev_population") }}
)
select ev_population.*, lat_long.lat, lat_long.long
from ev_population left join lat_long on ev_population.vin = lat_long.vin