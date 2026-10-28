
CREATE DATABASE SpaceMissionDB;
USE SpaceMissionDB;

CREATE TABLE Missions (
    mission_id INT PRIMARY KEY,
    mission_name VARCHAR(50),
    destination VARCHAR(50),
    agency VARCHAR(30),
    launch_year INT
);

INSERT INTO Missions VALUES
(1, 'Chandrayaan-3', 'Moon', 'ISRO', 2023),
(2, 'Mangalyaan', 'Mars', 'ISRO', 2013),
(3, 'Artemis-I', 'Moon', 'NASA', 2022),
(4, 'Perseverance', 'Mars', 'NASA', 2020),
(5, 'JUICE', 'Jupiter', 'ESA', 2023),
(6, 'Aditya-L1', 'Sun', 'ISRO', 2023),
(7, 'Voyager-1', 'Deep Space', 'NASA', 1977);

CREATE TABLE Mission_Stats (
    stat_id INT PRIMARY KEY,
    mission_id INT,
    budget_millions DECIMAL(10,2),
    duration_days INT,
    scientists INT,
    success_rate DECIMAL(5,2),
    FOREIGN KEY (mission_id)
        REFERENCES Missions(mission_id)
);

INSERT INTO Mission_Stats VALUES
(101, 1, 75.00, 40, 150, 95.00),
(102, 2, 74.00, 300, 200, 85.00),
(103, 3, 930.00, 25, 250, 98.00),
(104, 4, 2700.00, 500, 300, 97.00),
(105, 5, 1600.00, 2920, 350, 90.00),
(106, 6, 45.00, 180, 100, 92.00),
(107, 7, 250.00, 15000, 80, 99.00);

SELECT * FROM Missions;
SELECT * FROM Mission_Stats;

SELECT mission_name, destination, launch_year
FROM Missions
WHERE launch_year > 2020
ORDER BY launch_year DESC;

SELECT
    MAX(budget_millions) AS highest_budget,
    MIN(budget_millions) AS lowest_budget,
    ROUND(AVG(budget_millions), 2) AS average_budget
FROM Mission_Stats;

SELECT agency, COUNT(*) AS total_missions
FROM Missions
GROUP BY agency;

SELECT
    m.mission_name,
    m.destination,
    s.budget_millions,
    s.success_rate
FROM Missions m
INNER JOIN Mission_Stats s
    ON m.mission_id = s.mission_id;

SELECT
    m.agency,
    SUM(s.budget_millions) AS total_budget
FROM Missions m
JOIN Mission_Stats s
    ON m.mission_id = s.mission_id
GROUP BY m.agency;

SELECT
    m.agency,
    ROUND(AVG(s.success_rate), 2) AS avg_success_rate
FROM Missions m
JOIN Mission_Stats s
    ON m.mission_id = s.mission_id
GROUP BY m.agency
HAVING AVG(s.success_rate) > 93;

SELECT
    m.destination,
    COUNT(*) AS total_missions,
    SUM(s.budget_millions) AS total_budget
FROM Missions m
JOIN Mission_Stats s
    ON m.mission_id = s.mission_id
WHERE m.launch_year >= 2020
GROUP BY m.destination
HAVING SUM(s.budget_millions) > 1000
ORDER BY total_budget DESC;
