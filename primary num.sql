

declare @Num int = 2
declare @Interval int = 1000
declare @divider int = 2
declare @TFcorrelation int = 0 --If it is 1 then the number is a primary one, else it is not.
declare @correction int = 0 --Correction for number 2.
declare @List varchar(max)

while @num<@Interval --first while to set the interval from and to which the values are going.
BEGIN
set @TFcorrelation = 0
set @divider = 2

while @divider<1000 --While to limit the max value of the divider, if you don't set it the loop while go to the max value.
begin 
if (@num%@divider=0)
begin set @TFcorrelation=@TFCorrelation+1
end
set @divider=@divider+1 --When the first IF executes then you should increase the divider.
end

if (@tfcorrelation= 1 and @correction<1) --This IF is only for number 2.
begin
set @List= convert(varchar(2), @num)
set @correction=@correction+1 --Increasing the correction variable you are closing the option for SQL to show even numbers in the list. 
end

else
begin
if (@TFcorrelation=1) --This IF is for every other number. If there is no residue when the number is divided with a divider the number is a primary one.
begin
set @List=@List +'&' + convert(varchar(5), @Num) --Add the number to the list. 
end
end


set @Num=@Num+1 --Add an increment to number variable
END

print @list --Print the whole list. 


