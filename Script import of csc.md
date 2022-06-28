How to import csv in SQL Server using Code.

```

BULK INSERT composition
FROM 'D:\GHG_Tables.csv'
WITH 
(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	ROWTERMINATOR='\n',
	TABLOCK
)

SELECT *
FROM composition
```
