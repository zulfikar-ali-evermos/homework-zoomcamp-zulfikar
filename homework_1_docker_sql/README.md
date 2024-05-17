This is where to answer the question

QUESTION 3 COUNT RECORDS

How many taxi trips were totally made on September 18th 2019?

Tip: started and finished on 2019-09-18.

Remember that lpep_pickup_datetime and lpep_dropoff_datetime columns are in the format timestamp (date and hour+min+sec) and not in date.

15767
15612
15859
89009

answer: 15612

query:
    `SELECT 
        COUNT(*) AS trip_count    
    FROM 
        public.green_trip_data_2019
    WHERE 
        (lpep_pickup_datetime >= '2019-09-18 00:00:00' 
        AND lpep_pickup_datetime < '2019-09-19 00:00:00')
        AND (lpep_dropoff_datetime >= '2019-09-18 00:00:00' 
        AND lpep_dropoff_datetime < '2019-09-19 00:00:00');`

QUESTION 4 LONGEST TRIP

Which was the pick up day with the longest trip distance? Use the pick up time for your calculations.

Tip: For every trip on a single day, we only care about the trip with the longest distance.

2019-09-18
2019-09-16
2019-09-26
2019-09-21

answer: 2019-09=26

query:
    `SELECT
        DATE(lpep_pickup_datetime) AS trip_date,
        MAX(trip_distance) AS max_trip_distance
    FROM
        public.green_trip_data_2019
    GROUP BY
        DATE(lpep_pickup_datetime)
    ORDER BY
        ax_trip_distance DESC
    LIMIT 1;`

QUESTION 5 Three biggest pick up Boroughs

Consider lpep_pickup_datetime in '2019-09-18' and ignoring Borough has Unknown

Which were the 3 pick up Boroughs that had a sum of total_amount superior to 50000?

"Brooklyn" "Manhattan" "Queens"
"Bronx" "Brooklyn" "Manhattan"
"Bronx" "Manhattan" "Queens"
"Brooklyn" "Queens" "Staten Island"

Answer: "Brooklyn" "Manhattan" "Queens"

query:
    `SELECT
        "Borough",
        SUM(tt.total_amount) AS total_amount_sum
    FROM
        green_trip_data_2019 tt
    JOIN
        taxi_zone_lookup z ON "PULocationID" = "LocationID"
    WHERE
        DATE(tt.lpep_pickup_datetime) = '2019-09-18'
        AND "Borough" != 'Unknown'
    GROUP BY
        "Borough"
    HAVING
        SUM(tt.total_amount) > 50000
    ORDER BY
        total_amount_sum DESC
    LIMIT 3;`

QUESTION 6. Largest tip

For the passengers picked up in September 2019 in the zone name Astoria which was the drop off zone that had the largest tip? We want the name of the zone, not the id.

Note: it's not a typo, it's tip , not trip

Central Park
Jamaica
JFK Airport
Long Island City/Queens Plaza

Answer: JFK Airport

Query: `SELECT
            z_dropoff."Zone" AS dropoff_zone,
            MAX(tt.tip_amount) AS largest_tip
        FROM
            green_trip_data_2019 tt
        JOIN
            taxi_zone_lookup z_pickup ON tt."PULocationID" = z_pickup."LocationID"
        JOIN
            taxi_zone_lookup z_dropoff ON tt."DOLocationID" = z_dropoff."LocationID"
        WHERE
            z_pickup."Zone" = 'Astoria'
            AND tt.lpep_pickup_datetime >= '2019-09-01'
            AND tt.lpep_pickup_datetime < '2019-10-01'
        GROUP BY
            z_dropoff."Zone"
        ORDER BY
            largest_tip DESC
        LIMIT 1;`
