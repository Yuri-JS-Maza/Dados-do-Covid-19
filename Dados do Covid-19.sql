select * 
from covidprojeto..['Covid-mortes$']
where continent is not null


select *
from covidprojeto..['Covid-vacinação$']

--Mostra a probabilidade de morrer se estiveres nesses países
select location,date, total_cases, total_deaths, (CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0))*100 as Percentualdemorte
from covidprojeto..['Covid-mortes$']
where location like '%states%'
order by 1,2

--Essa consulta mostra o percentual de pessoas que contraiu COVID
select location,date,population, total_cases, (CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0))*100 as Populaçãoafetada
from covidprojeto..['Covid-mortes$']
where location like '%states%'
order by 1,2

--Países com o maior número de infectados comparado com a população


select location,population, MAX(total_cases) as Numerodeinfeção, MAX((CONVERT(float, total_cases)) / NULLIF(CONVERT(float, population), 0))*100 as Populaçãoafetadapercentual
from covidprojeto..['Covid-mortes$']
--where location like '%states%'
group by location, population
order by Populaçãoafetadapercentual desc

select location,population, MAX(total_cases) as Numerodeinfeção, MAX((Cast( total_cases as float)) / NULLIF(CONVERT(float, population), 0))*100 as Populaçãoafetadapercentual
from covidprojeto..['Covid-mortes$']
--where location like '%states%'
group by location, population
order by Populaçãoafetadapercentual desc

--Mostra o maior número de mortes por população

select location, MAX(cast(total_deaths as DECIMAL)) as MortesTotal
from covidprojeto..['Covid-mortes$']
--where location like '%states%'
where continent is not null
group by continent
order by MortesTotal desc

--Mortes por continente

select continent, MAX(cast(total_deaths as DECIMAL)) as MortesTotal
from covidprojeto..['Covid-mortes$']
--where location like '%states%'
where continent is not null
group by continent
order by MortesTotal desc

--Números globais
select SUM(cast(new_cases as DECIMAL )) as Casostotais, SUM(cast(total_deaths as float)) as MortesTotal,
SUM(cast(total_deaths as float))/SUM(cast(new_cases as decimal))*100 as Percentualdemorte
from covidprojeto..['Covid-mortes$']
--where location like '%states%'
where continent is not null
--group by continent
order by 1,2

--Números de pessoas que foram vacinadas

SELECT 
    mor.continent, 
    mor.location,
    mor.date, 
    mor.population,
    vac.new_vaccinations
FROM 
    covidprojeto..['Covid-mortes$'] mor 
INNER JOIN 
    covidprojeto..['Covid-vacinação$'] vac
ON 
    mor.location = vac.location 
    AND mor.date = vac.date
WHERE 
    mor.continent IS NOT NULL
ORDER BY 
    1, 2;

