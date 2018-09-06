	select table1.bedroom, table1.average_bedroom_price_in_zillow, table2.average_bedroom_price_in_airbnb
    FROM
		(select zillow.bedroom, (zillow.average_price/zillow.bedroom) as average_bedroom_price_in_zillow
		from
			(select avg(price) as average_price, 1 as bedroom 
			from `juan-chujun.zillow.Rental_Price_1Bedroom`
			union all 
			select avg(price) as average_price, 2 as bedroom  
			from `juan-chujun.zillow.Rental_Price_2Bedroom`
			union all 
			select avg(price) as average_price, 3 as bedroom  
			from `juan-chujun.zillow.Rental_Price_3Bedroom`
			union all 
			select avg(price) as average_price, 4 as bedroom  
			from `juan-chujun.zillow.Rental_Price_4Bedroom`
			union all 
			select avg(price) as average_price, 5 as bedroom  
			from `juan-chujun.zillow.Rental_Price_5Bedroom`)as zillow) as table1

			join

		(select a.bedrooms, (a.avg_price/a.bedrooms) as average_bedroom_price_in_airbnb
		from
        (select avg(airbnb.price) as avg_price, airbnb.bedrooms
	    FROM 
		(SELECT 
  		case 
		when c.price is null then l.price
		else c.price
		end as price,
		case 
		when l.bedrooms <= 5 then l.bedrooms
		else 5  
        end as bedrooms
  		FROM `juan-chujun.Austin.Calendar` c JOIN `juan-chujun.Austin.Listing` l ON c.listing_id = l.id
  		where l.room_type = 'Entire home/apt' and l.bedrooms > 0 and c.date is not null and l.zipcode is not null and l.bedrooms is not null
	    ) as airbnb

	   group by airbnb.bedrooms) as a
	   ) as table2
	   ON table1.bedroom = table2.bedrooms;