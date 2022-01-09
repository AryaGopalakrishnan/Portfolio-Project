--Data exploration



select * from coviddeaths$
where continent is not null
order by 3,4;


--Total death  
select location , date ,population, total_cases , total_deaths , (total_deaths / total_cases)*100 as deathpercent 
from coviddeaths$
where location like '%France%'
order by 1,2;


--TOTAL CASES VS POPULATION
select location , date ,population, total_cases , (total_cases/population) *100 as deathpercent
from coviddeaths$
--where location like '%France%'
order by 1,2;


--country with highest infection compare to population
select location ,population,continent,  max(total_cases) as highestinfectioncount , max((total_cases/population)) *100 as populationinfected
from coviddeaths$
where continent like '%Europe%'
group by location, population , continent
order by populationinfected desc;


--countries with highest death count per population
select location,population,  max(cast(total_deaths as int)) as highestdeathcount 
from coviddeaths$
where continent is not null and continent like '%Europe%'
group by location , population
order by highestdeathcount desc;

--Highest death cases in Europe
select location, continent ,max(total_deaths) as highestindeath
from coviddeaths$
where continent like '%Europe%'
group by continent , location
order by highestindeath desc;


--New cases and death across Europe
select sum(new_cases) as sumofnewcases, SUM(cast(new_deaths as int)) as sumofnewdeaths,location,date,continent
--SUM(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from coviddeaths$
where date  between '2021-01-01' AND '2021-12-30' and continent like '%Europe%'
group by location , date,continent
order by 1 desc ,2 desc ;


--Vaccination across Europe
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
from coviddeaths$ dea 
join covidvaccine$ vac
on dea.location = vac.location
and dea.date=vac.date
where dea.continent is not null and dea.continent like '%Europe%'
order by 2,3;


