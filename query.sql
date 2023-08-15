--extracting insights using SQL queries
-- How many values are there in the given dataset
select count(*) from patients


-- Count the number of appointments for each day in the given dataset:
SELECT
    COUNT(*),
    AppointmentDay
FROM
    `patients`
GROUP BY
    AppointmentDay


--Calculate the average number of appointments(Set to nearest whole number) per day in the given dataset.
select round(avg(no_of_appointments)) from 
(SELECT
    COUNT(*)'no_of_appointments',
    AppointmentDay
FROM
    `patients`
GROUP BY
    AppointmentDay) as avg_per_day


--Find the day with the highest number of appointments in the given dataset.
SELECT
    COUNT(*) 'No_of_appointment',AppointmentDay
FROM
    patients
GROUP BY
    AppointmentDay
ORDER BY
    No_of_appointment
DESC
LIMIT 1


--Calculate the monthly average number of appointments in the given dataset.
SELECT
    DATE_FORMAT(AppointmentDay, '%Y-%m') AS MONTH,
    COUNT(*) AS no_of_appointment
FROM
    patients
GROUP BY
    MONTH


--Find the month with the highest number of appointments in the given dataset.
SELECT
    DATE_FORMAT(AppointmentDay, '%Y-%m') AS MONTH,
    COUNT(*) AS no_of_appointment
FROM
    patients
GROUP BY
    MONTH
ORDER BY
no_of_appointment DESC
limit 1


--Calculate the weekly average number of appointments in the given dataset.
SELECT
    DATE_FORMAT(AppointmentDay, '%Y-%m') AS MONTH,
    COUNT(*) AS no_of_appointment
FROM
    patients
GROUP BY
    MONTH
ORDER BY
no_of_appointment DESC
limit 1


--Find the week with the highest number of appointments in the given dataset.
select 
year(appointmentday) as year,
week(appointmentday)as week,
count(*) as No_of_appointments
from 
patients 
group by week,year
order by No_of_appointments desc
limit 1


--What is the distribution of appointments based on gender in the dataset?
SELECT
    COUNT(*),
    Gender
FROM
    `patients`
GROUP BY
    Gender


--Calculate the number of appointments per weekday in the given dataset. Order the appointment counts in descending.
--Use 'DAYNAME()' function.
SELECT
    dayname(AppointmentDay) DAY,
    COUNT(*)
FROM
    `patients`
GROUP BY
    DAY
ORDER BY
    COUNT(*)
DESC
    

--Calculate the average time between scheduling and the appointment day in the given dataset. Set to nearest whole number
SELECT
    round(avg(TIMESTAMPDIFF(
        DAY,
        ScheduledDay,
        AppointmentDay
    )))
FROM
    patients