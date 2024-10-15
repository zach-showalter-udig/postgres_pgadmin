{{ config(materialized='view')}}

select *,
CAST(split_part(substring(vehicle_location, '\((.+)\)'), ' ', 1) AS decimal) as lat,
CAST(split_part(substring(vehicle_location, '\((.+)\)'), ' ', 2)AS decimal) as long
from ev_population