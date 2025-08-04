--Macroeconomic Indicator Explorer (SQL Portfolio Project)
--Project Goal
--to explore trends and relationships among key macroeconomic indicators such as GDP, inflation, unemployment, interest rates, and trade balance across multiple countries over time.

--1. GDP Growth Over Time (by Region)

SELECT 
  c.region,
  m.year,
  ROUND(AVG(m.value), 2) AS avg_gdp
FROM macro_data m
JOIN countries c ON m.country_id = c.country_id
JOIN indicators i ON m.indicator_id = i.indicator_id
WHERE i.name = 'GDP'
GROUP BY c.region, m.year
ORDER BY m.year;

--2. Top 5 Countries by GDP in 2022

SELECT 
  c.name AS country,
  m.value AS gdp_usd
FROM macro_data m
JOIN countries c ON m.country_id = c.country_id
JOIN indicators i ON m.indicator_id = i.indicator_id
WHERE i.name = 'GDP' AND m.year = 2022
ORDER BY m.value DESC
LIMIT 5;

--3. Inflation vs Interest Rate (Correlation Table)

SELECT 
  g.name AS country,
  gdp.value AS gdp_2022,
  infl.value AS inflation_2022,
  ir.value AS interest_rate_2022
FROM countries g
JOIN macro_data gdp ON g.country_id = gdp.country_id
JOIN macro_data infl ON g.country_id = infl.country_id
JOIN macro_data ir ON g.country_id = ir.country_id
JOIN indicators i1 ON gdp.indicator_id = i1.indicator_id
JOIN indicators i2 ON infl.indicator_id = i2.indicator_id
JOIN indicators i3 ON ir.indicator_id = i3.indicator_id
WHERE gdp.year = 2022 AND infl.year = 2022 AND ir.year = 2022
  AND i1.name = 'GDP'
  AND i2.name = 'Inflation'
  AND i3.name = 'Interest Rate';


  --4. Country with Most Consistent Inflation (Low Std Dev)

  SELECT 
  c.name,
  ROUND(STDDEV(m.value), 2) AS inflation_std_dev
FROM macro_data m
JOIN countries c ON m.country_id = c.country_id
JOIN indicators i ON m.indicator_id = i.indicator_id
WHERE i.name = 'Inflation'
GROUP BY c.name
ORDER BY inflation_std_dev ASC
LIMIT 5;
