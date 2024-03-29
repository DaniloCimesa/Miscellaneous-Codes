/*Median in SQL

There is no median function in SQL so you will have to create it yourself.
Just find the lowest value of the top 50% of all values and highest value of bottom 50% of all values, then add values together and divide it by 2.*/


Select

((
select max(countryid)
from tblcountry
where countryid in (Select top 50 percent countryid from tblCountry order by CountryId asc ))
+
(
select min(countryid)
from tblcountry
where countryid in (Select top 50 percent countryid from tblCountry order by CountryId desc)
))/2  as median

