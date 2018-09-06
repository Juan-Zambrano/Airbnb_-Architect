/* Q1 This query finds out the number of short_term rental in different cities. We assume that less than 30 days 
is considered short term rental since on average more people stay at a certain location for less than a month. Anything stay greater than
30 days would be classify as a long-term rental. From the query, Austin has the largest number of short term rental
Therefore, it illustrates that more airbnb houses are available in Austin, so there is  more demand in Austin because the high supply of short_term rental*/
SELECT 'Austin' as city, count(*) as number_of_short_term_rental 
FROM `juan-chujun.Austin.Summary_listing`
where minimum_nights < 30
UNION ALL
SELECT 'Denver' as city, count(*) as number_of_short_term_rental 
FROM `juan-chujun.Denver.Summary_listing`
where minimum_nights < 30
UNION ALL
SELECT 'Boston' as city, count(*)  as number_of_short_term_rental 
FROM `juan-chujun.Boston.Summary_listing`
where minimum_nights < 30
GROUP BY city;

/*Q2 We want to estimate the maximum revenue in 3 different cities for 3 months(2017-01-01 to 2017-30-31) by assuming all the listings have customers. 
From this query, we can figure out the maximum revenue that generate by Airbnb is each city.
From the query, Austin has the highest maximum revenue among all three the cities. The second one is Boston. Therefore, Airbnb will generate more money
in Austin, and more people tend to stay in an airbnb house when people go to Austin*/
SELECT 'Austin' as city, sum(l.price) as max_revenue 
FROM  `juan-chujun.Austin.Listing`l JOIN `juan-chujun.Austin.Calendar` c on c.listing_id =l.id
where  c.date > '2017-01-01' and c.date < '2017-03-31'
UNION ALL
SELECT 'Denver' as city, sum(l.price) as max_revenue 
FROM  `juan-chujun.Denver.Listing`l JOIN `juan-chujun.Denver.Calendar` c on c.listing_id =l.id
where  c.date > '2017-01-01' and c.date < '2017-03-31'
UNION ALL
SELECT 'Boston' as city, sum(l.price) as max_revenue 
FROM  `juan-chujun.Boston.Listing`  l JOIN `juan-chujun.Boston.Calendar` c on c.listing_id =l.id
where  c.date > '2017-01-01' and c.date < '2017-03-31'
group by city;



/*Q3 compare the average price in the downtown area of different cities, so we can figure out the living standard and the affordability. 
 we choose the prices in the downtown area because those price are more demostrated the differences of living standard between each city.
 From the query, Boston has the higest price among all three cities. The second one is Austin. Therefore, from the view of affordability,
 it is cheaper to live in Denver to Austin, and Austin is cheaper than Boston */
SELECT 'Austin' as city, round(avg(l.price),2) as Average_price
FROM `juan-chujun.Austin.Neighborhood` n join `juan-chujun.Austin.Listing`l on l.zipcode = n.zipcode
where n.zipcode =78705 

UNION ALL
SELECT 'Denver' as city, round(avg(l.price),2) as Average_price
FROM `juan-chujun.Denver.Neighborhood` n join `juan-chujun.Denver.Listing` l on l.zipcode = n.zipcode
where n.zipcode = 80202

UNION ALL
SELECT 'Boston' as city, round(avg(l.price),2) as Average_price
FROM `juan-chujun.Boston.Neighborhood` n join `juan-chujun.Boston.Listing` l on l.zipcode = n.zipcode
where n.zipcode = 2110

group by city;


/*Q4 This query was used to find the approximate occupancy number for different cities by...
#assuming that the number of reviews for a given month as a metric for occupancy.
By comparing that metric for the same month for 3 differet years, we obtained a 
change in amount of reviews for the same month on different years (2015,2016,2017)
This was done for the three cities(Austin,Boston, and Denver) in order to see how occupancy
rate changes amoung locations per year. The month of novemeber was chosen at random
in order to condense the date into a presentable mode 
From the query, we can notice that more reviews are in Boston overall*/

SELECT 'Austin_2015' as city, sum(sl.number_of_reviews) as Total_num_reviews_Nov
FROM `juan-chujun.Austin.Calendar` c JOIN `juan-chujun.Austin.Listing` l on c.listing_id =l.id
JOIN `juan-chujun.Austin.Summary_listing` sl on l.id = sl.id
where sl.number_of_reviews is not Null and c.date > '2015-11-01'and c.date <'2015-11-30'
UNION ALL
SELECT 'Austin_2016' as city, sum(sl.number_of_reviews)
FROM `juan-chujun.Austin.Calendar` c JOIN `juan-chujun.Austin.Listing` l on c.listing_id =l.id
JOIN `juan-chujun.Austin.Summary_listing` sl on l.id = sl.id
where sl.number_of_reviews is not Null and c.date > '2016-11-01'and c.date <'2016-11-30'
UNION ALL
SELECT 'Austin_2017' as city, sum(sl.number_of_reviews)
FROM `juan-chujun.Austin.Calendar` c JOIN `juan-chujun.Austin.Listing` l on c.listing_id =l.id
JOIN `juan-chujun.Austin.Summary_listing` sl on l.id = sl.id
where sl.number_of_reviews is not Null and c.date > '2017-11-01'and c.date <'2017-11-30'

UNION ALL

SELECT 'Boston_2015' as city, sum(sl.number_of_reviews) as Total_num_reviews_Nov
FROM `juan-chujun.Boston.Calendar` c JOIN `juan-chujun.Boston.Listing` l on c.listing_id =l.id
JOIN `juan-chujun.Boston.Summary_listing` sl on l.id = sl.id
where sl.number_of_reviews is not Null and c.date > '2015-11-01'and c.date <'2015-11-30'
UNION ALL
SELECT 'Boston_2016' as city, sum(sl.number_of_reviews)
FROM `juan-chujun.Boston.Calendar` c JOIN `juan-chujun.Boston.Listing` l on c.listing_id =l.id
JOIN `juan-chujun.Boston.Summary_listing` sl on l.id = sl.id
where sl.number_of_reviews is not Null and c.date > '2016-11-01'and c.date <'2016-11-30'
UNION ALL
SELECT 'Boston_2017' as city, sum(sl.number_of_reviews)
FROM `juan-chujun.Boston.Calendar` c JOIN `juan-chujun.Boston.Listing` l on c.listing_id =l.id
JOIN `juan-chujun.Boston.Summary_listing` sl on l.id = sl.id
where sl.number_of_reviews is not Null and c.date > '2017-11-01'and c.date <'2017-11-30'

UNION ALL

SELECT 'Denver_2015' as city, sum(sl.number_of_reviews) as Total_num_reviews_Nov
FROM `juan-chujun.Denver.Calendar` c JOIN `juan-chujun.Denver.Listing` l on c.listing_id =l.id
JOIN `juan-chujun.Denver.Summary_listing` sl on l.id = sl.id
where sl.number_of_reviews is not Null and c.date > '2015-11-01'and c.date <'2015-11-30'
UNION ALL
SELECT 'Denver_2016' as city, sum(sl.number_of_reviews)
FROM `juan-chujun.Denver.Calendar` c JOIN `juan-chujun.Denver.Listing` l on c.listing_id =l.id
JOIN `juan-chujun.Denver.Summary_listing` sl on l.id = sl.id
where sl.number_of_reviews is not Null and c.date > '2016-11-01'and c.date <'2016-11-30'
UNION ALL
SELECT 'Denver_2017' as city, sum(sl.number_of_reviews)
FROM `juan-chujun.Denver.Calendar` c JOIN `juan-chujun.Denver.Listing` l on c.listing_id =l.id
JOIN `juan-chujun.Denver.Summary_listing` sl on l.id = sl.id
where sl.number_of_reviews is not Null and c.date > '2017-11-01'and c.date <'2017-11-30'

GROUP BY city
ORDER BY city; 