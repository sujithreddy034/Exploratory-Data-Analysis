-- EXPLORATORY DATA ANALYSIS

SELECT *
FROM layoffs_stagging2;


SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_stagging2;

SELECT *
FROM layoffs_stagging2
WHERE percentage_laid_off=1
ORDER BY funds_raised_millions DESC;

SELECT sum(total_laid_off)
FROM layoffs_stagging2
WHERE company='Amazon';

SELECT company,SUM(total_laid_off),country
FROM layoffs_stagging2
GROUP BY company,country
ORDER BY 2 DESC;

SELECT MIN(`date`),MAX(`date`)
FROM layoffs_stagging2;

SELECT industry,SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country,SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`),SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT *
FROM layoffs_stagging2;

SELECT stage,SUM(total_laid_off)
FROM layoffs_stagging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT company,SUM(percentage_laid_off)
FROM layoffs_stagging2
GROUP BY company
ORDER BY 2 DESC;



SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_stagging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;


WITH rolling_cte AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_stagging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`,total_off,sum(total_off) over(order by `MONTH`) as rolling_total
FROM rolling_cte;

SELECT company,SUM(total_laid_off),country
FROM layoffs_stagging2
GROUP BY company,country
ORDER BY 2 DESC;


SELECT company,YEAR(`date`),SUM(total_laid_off) 
FROM layoffs_stagging2
GROUP BY company,YEAR(`date`)
ORDER BY 3 ASC;

WITH COMPANY_YEAR(company,years,total_laid_off) AS
(
SELECT company,Year(`date`),SUM(total_laid_off) 
FROM layoffs_stagging2
GROUP BY company,Year(`date`)
),company_rankings as
(
SELECT *,dense_rank() over(partition by years order by total_laid_off desc) as rankings
FROM COMPANY_YEAR
WHERE years IS NOT NULL

)
Select * from company_rankings
where rankings <=5;

