#  compute the Revenue Crossover Point metric of Austin
select airbnb.date, airbnb.zipcode, airbnb.bedrooms,airbnb.a_median as airbnb_price_day, zillow3.z_median as zillow_price_month, ceiling(zillow3.z_median/ airbnb.a_median) as crossover_pt
from
	(select DISTINCT date,airb.zipcode, airb.bedrooms,airb.a_median
	FROM 
		(SELECT 
		PERCENTILE_CONT(l.price,0.5) OVER(PARTITION BY date, l.zipcode,l.bedrooms) AS a_median, DATE_TRUNC(c.date,MONTH) as date,
  		case 
		when c.price is null then l.price
		else c.price
		end as price,
		l.zipcode, l.room_type, 
		case 
		when l.bedrooms <= 5 then l.bedrooms
		else 5  
        end as bedrooms
  		FROM `juan-chujun.Austin.Calendar` c JOIN `juan-chujun.Austin.Listing` l ON c.listing_id = l.id
  		) AS airb

	where airb.room_type = 'Entire home/apt' and airb.bedrooms > 0 and airb.date is not null and airb.zipcode is not null and airb.bedrooms is not null
	) as airbnb

join 
	(SELECT DISTINCT zillow2.date, zillow2.zipcode,zillow2.bedroom,zillow2.z_median
	from 
		(select PERCENTILE_CONT(zillow.price,0.5) over(PARTITION by zillow.date, zillow.zipcode,zillow.bedroom)  as z_median, zillow.zipcode, zillow.date, zillow.bedroom
		from
			(select zipcode, date, price, 1 as bedroom 
			from `juan-chujun.zillow.Rental_Price_1Bedroom`
			where price is not null
			union all 
			select zipcode, date, price, 2 as bedroom  
			from `juan-chujun.zillow.Rental_Price_2Bedroom`
			where price is not null
			union all 
			select zipcode, date, price, 3 as bedroom  
			from `juan-chujun.zillow.Rental_Price_3Bedroom`
			where price is not null
			union all 
			select zipcode, date, price, 4 as bedroom  
			from `juan-chujun.zillow.Rental_Price_4Bedroom`
			where price is not null
			union all 
			select zipcode, date, price, 5 as bedroom  
			from `juan-chujun.zillow.Rental_Price_5Bedroom`
			where price is not null
			) AS zillow 
		)as zillow2
	) as zillow3
    on airbnb.date = zillow3.date and  airbnb.zipcode = zillow3.zipcode and airbnb.bedrooms=zillow3.bedroom;


#  compute the Revenue Crossover Point metric of Denver
select airbnb.date, airbnb.zipcode, airbnb.bedrooms,airbnb.a_median as airbnb_price_day, zillow3.z_median as zillow_price_month, ceiling(zillow3.z_median/ airbnb.a_median) as crossover_pt
from
	(select DISTINCT date,airb.zipcode, airb.bedrooms,airb.a_median
	FROM 
		(SELECT 
		PERCENTILE_CONT(l.price,0.5) OVER(PARTITION BY date, l.zipcode,l.bedrooms) AS a_median, DATE_TRUNC(c.date,MONTH) as date,
  		case 
		when c.price is null then l.price
		else c.price
		end as price,
		l.zipcode, l.room_type, 
		case 
		when l.bedrooms <= 5 then l.bedrooms
		else 5  
        end as bedrooms
  		FROM `juan-chujun.Denver.Calendar` c JOIN `juan-chujun.Denver.Listing` l ON c.listing_id = l.id
  		) AS airb

	where airb.room_type = 'Entire home/apt' and airb.bedrooms > 0 and airb.date is not null and airb.zipcode is not null and airb.bedrooms is not null 
	) as airbnb

join 

	(SELECT DISTINCT zillow2.date, zillow2.zipcode,zillow2.bedroom,zillow2.z_median
	from 
		(select PERCENTILE_CONT(zillow.price,0.5) over(PARTITION by zillow.date, zillow.zipcode,zillow.bedroom)  as z_median, zillow.zipcode, zillow.date, zillow.bedroom
		from
			(select zipcode, date, price, 1 as bedroom 
			from `juan-chujun.zillow.Rental_Price_1Bedroom`
			where price is not null
			union all 
			select zipcode, date, price, 2 as bedroom  
			from `juan-chujun.zillow.Rental_Price_2Bedroom`
			where price is not null
			union all 
			select zipcode, date, price, 3 as bedroom  
			from `juan-chujun.zillow.Rental_Price_3Bedroom`
			where price is not null
			union all 
			select zipcode, date, price, 4 as bedroom  
			from `juan-chujun.zillow.Rental_Price_4Bedroom`
			where price is not null
			union all 
			select zipcode, date, price, 5 as bedroom  
			from `juan-chujun.zillow.Rental_Price_5Bedroom`
			where price is not null
			) AS zillow
		)as zillow2
	) as zillow3
    on airbnb.date = zillow3.date and  airbnb.zipcode = zillow3.zipcode and airbnb.bedrooms=zillow3.bedroom;


#  compute the Revenue Crossover Point metric of Boston
select airbnb.date, airbnb.zipcode, airbnb.bedrooms,airbnb.a_median as airbnb_price_day, zillow3.z_median as zillow_price_month, ceiling(zillow3.z_median/ airbnb.a_median) as crossover_pt
from
	(select DISTINCT date,airb.zipcode, airb.bedrooms,airb.a_median
	FROM 
		(SELECT 
		PERCENTILE_CONT(l.price,0.5) OVER(PARTITION BY date, l.zipcode,l.bedrooms) AS a_median, DATE_TRUNC(c.date,MONTH) as date,
  		case 
		when c.price is null then l.price
		else c.price
		end as price,
		l.zipcode, l.room_type, 
		case 
		when l.bedrooms <= 5 then l.bedrooms
		else 5  
        end as bedrooms
  		FROM `juan-chujun.Boston.Calendar` c JOIN `juan-chujun.Boston.Listing` l ON c.listing_id = l.id
  		) AS airb

	where airb.room_type = 'Entire home/apt' and airb.bedrooms > 0 and airb.date is not null and airb.zipcode is not null and airb.bedrooms is not null and a_median > 0
	) as airbnb

join 

	(SELECT DISTINCT zillow2.date, zillow2.zipcode,zillow2.bedroom,zillow2.z_median
	from 
		(select PERCENTILE_CONT(zillow.price,0.5) over(PARTITION by zillow.date, zillow.zipcode,zillow.bedroom)  as z_median, zillow.zipcode, zillow.date, zillow.bedroom
		from
			(select zipcode, date, price, 1 as bedroom 
			from `juan-chujun.zillow.Rental_Price_1Bedroom`
			where price is not null
			union all 
			select zipcode, date, price, 2 as bedroom  
			from `juan-chujun.zillow.Rental_Price_2Bedroom`
			where price is not null
			union all 
			select zipcode, date, price, 3 as bedroom  
			from `juan-chujun.zillow.Rental_Price_3Bedroom`
			where price is not null
			union all 
			select zipcode, date, price, 4 as bedroom  
			from `juan-chujun.zillow.Rental_Price_4Bedroom`
			where price is not null
			union all 
			select zipcode, date, price, 5 as bedroom  
			from `juan-chujun.zillow.Rental_Price_5Bedroom`
			where price is not null
			) AS zillow
		)as zillow2
	) as zillow3
    on airbnb.date = zillow3.date and  airbnb.zipcode = zillow3.zipcode and airbnb.bedrooms=zillow3.bedroom;
