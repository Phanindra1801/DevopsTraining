CREATE DATABASE WaterManagementDB;
USE watermanagementdb;

CREATE TABLE Water_Zones (
    zone_id INT PRIMARY KEY,
    zone_name VARCHAR(50),
    city VARCHAR(50),
    population INT,
    water_source VARCHAR(50)
);

INSERT INTO Water_Zones VALUES
(1, 'Green Valley', 'Chennai', 12000, 'Reservoir'),
(2, 'Lake View', 'Hyderabad', 8500, 'Lake'),
(3, 'Sunrise Colony', 'Bengaluru', 15000, 'Groundwater'),
(4, 'River Side', 'Vijayawada', 10000, 'River'),
(5, 'Hill Town', 'Pune', 6500, 'Reservoir'),
(6, 'Metro Park', 'Chennai', 18000, 'River'),
(7, 'Garden City', 'Hyderabad', 9500, 'Groundwater');

CREATE TABLE Water_Usage (
    usage_id INT PRIMARY KEY,
    zone_id INT,
    daily_usage_liters INT,
    leakage_percent DECIMAL(5,2),
    water_quality_score DECIMAL(5,2),
    monthly_bill DECIMAL(10,2),
    FOREIGN KEY (zone_id)
        REFERENCES Water_Zones(zone_id)
);

INSERT INTO Water_Usage VALUES
(101, 1, 850000, 4.50, 92.00, 45000.00),
(102, 2, 620000, 7.20, 85.00, 32000.00),
(103, 3, 1100000, 3.00, 96.00, 58000.00),
(104, 4, 780000, 6.50, 88.00, 39000.00),
(105, 5, 450000, 2.50, 94.00, 24000.00),
(106, 6, 1350000, 8.00, 82.00, 72000.00),
(107, 7, 690000, 5.50, 90.00, 35000.00);


SELECT * FROM Water_Zones;
SELECT * FROM Water_Usage;


SELECT zone_id, daily_usage_liters, leakage_percent
FROM Water_Usage
WHERE daily_usage_liters > 700000
ORDER BY daily_usage_liters DESC;

SELECT
    MAX(daily_usage_liters) AS maximum_usage,
    MIN(daily_usage_liters) AS minimum_usage,
    ROUND(AVG(daily_usage_liters), 2) AS average_usage
FROM Water_Usage;

SELECT city, COUNT(*) AS total_zones
FROM Water_Zones
GROUP BY city;

SELECT
    z.zone_name,
    z.city,
    w.daily_usage_liters,
    w.leakage_percent
FROM Water_Zones z
INNER JOIN Water_Usage w
    ON z.zone_id = w.zone_id;

SELECT
    z.water_source,
    SUM(w.daily_usage_liters) AS total_daily_usage
FROM Water_Zones z
JOIN Water_Usage w
    ON z.zone_id = w.zone_id
GROUP BY z.water_source;


SELECT
    z.water_source,
    ROUND(AVG(w.water_quality_score), 2) AS average_quality
FROM Water_Zones z
JOIN Water_Usage w
    ON z.zone_id = w.zone_id
GROUP BY z.water_source
HAVING AVG(w.water_quality_score) > 90;

SELECT
    z.city,
    COUNT(*) AS total_zones,
    SUM(w.daily_usage_liters) AS total_daily_usage,
    ROUND(AVG(w.daily_usage_liters), 2) AS average_daily_usage
FROM Water_Zones z
JOIN Water_Usage w
    ON z.zone_id = w.zone_id
WHERE w.leakage_percent > 3
GROUP BY z.city
HAVING AVG(w.daily_usage_liters) > 700000
   AND SUM(w.daily_usage_liters) > 1000000
ORDER BY total_daily_usage DESC;
