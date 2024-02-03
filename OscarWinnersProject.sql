
-- Basic Selection where oscar year was in 1970
select
	*
from
	oscar_noms_past_years5
where 
	oscar_year ilike '1970'
	

--Films that streamed within 100 days after release
select
	o.film_name
	, o.original_release_dt
	, o.streaming_release_dt
	, (o.streaming_release_dt - o.original_release_dt) as days_between_streaming 
from
	oscar_noms_past_years5 o
group by
	o.film_name
	, o.original_release_dt
	, o.streaming_release_dt
having
	(o.streaming_release_dt - o.original_release_dt) <= 100
	
	
-- movies with tomatometer scores 
select
	o.film_name
	, o.tomatometer_rating
	, cast(avg(o.tomatometer_count)as decimal(10,2)) as avg_tomatometer_count
from
	oscar_noms_past_years5 o
group by
	o.film_name
	, o.tomatometer_rating
having 
	tomatometer_rating > 65


--Movies with run times less than 2 hours that won an oscar
select
	o.film_name
	, o.film_runtime
	, o.nominated_or_winner
from
	oscar_noms_past_years5 o
where
	film_runtime < 120
	and nominated_or_winner = 'Winner'
	
--total movies that won with runtime under 2 hours
select
	count(*)
from(

	select
			o.film_name
			, o.film_runtime
			, o.nominated_or_winner
		from
			oscar_noms_past_years5 o
		where
			film_runtime < 120
			and nominated_or_winner = 'Winner'
)



--movies that have a high tomatometer rating but still lost
select
	o.film_name
	, o.nominated_or_winner
	, o.tomatometer_rating
from
	oscar_noms_past_years5 o
where
	tomatometer_rating > 90
	and nominated_or_winner = 'Nominee'
order by
	 o.tomatometer_rating desc


--Movie winners that are comedies
select
	o.film_name
	, o.film_genre
	, o.nominated_or_winner
from
	oscar_noms_past_years5 o
where
	o.film_genre ilike '%Comedy%'
	and o.nominated_or_winner ilike 'Winner'




	