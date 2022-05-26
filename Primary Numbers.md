
```
DECLARE @inputNumber INT=100
DECLARE @a INT=2,@b INT=2,@count INT=0,@c INT=0,@PrimeNumberList NVARCHAR(MAX);

WHILE @a<=@inputNumber 
BEGIN

SET @count=0; 
SET @b=2;

WHILE @b<1000
BEGIN

IF (@a%@b=0)
BEGIN SET @Count=@count+1
END

SET @b=@b+1;

END

IF(@count=1 and @c<1)

BEGIN

SET @PrimeNumberList=CAST(@a AS NVARCHAR(MAX));
SET @c=@c+1;

END

ELSE

BEGIN

IF(@count=1)

BEGIN

SET @PrimeNumberList=@PrimeNumberList+','+CAST(@a AS NVARCHAR(MAX));

END

END
SET @a=@a+1; 
END

PRINT @PrimeNumberList
```
