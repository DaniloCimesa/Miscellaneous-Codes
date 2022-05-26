```
declare @Num int = 2
declare @Divider int = 2
declare @InputNumber int = 10
declare @count int = 0
declare @correction int = 0
declare @List varchar(max)

while @num< @InputNumber
begin
set @count=0
set @Divider=2

while @Divider<@InputNumber
begin 
if (@num%@Divider=0) 
begin set @count=@count+1
end
set @Divider=@Divider+1
end


if (@count=1 and @correction<1)
begin
set @List= cast (@num as varchar(2))
set @correction=@correction+1
end

else 

begin
if (@count=1)
begin 
set @List=@List+','+CAST(@Num AS NVARCHAR(MAX));
end
end

set @Num=@Num+1
end

print @list
```
