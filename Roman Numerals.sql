

ALTER PROCEDURE RomanNumerals (@ID SMALLINT)

AS

BEGIN
    IF @ID>3999
      BEGIN
        PRINT 'THERE'S NO ROMAN NUMBER HIGHER THAN 3999'
      END
    ELSE
      BEGIN

        WITH CTE_A AS (
             SELECT
             @ID AS InputNUM
         ,   CASE WHEN @ID> = 1000 THEN @ID/1000 ELSE 0 END AS HILJADA
         ,   CASE WHEN @ID< 1000 THEN @ID/100 ELSE (@ID -(( @ID / 1000)* 1000))/ 100 END AS STOTINA
         ,   CASE WHEN @ID<100 THEN @ID/10 ELSE (@ID - ((@ID/100)* 100))/ 10 END AS DESETICA
         ,   CASE WHEN @ID>=10 THEN @ID%10 ELSE @ID/1 END AS JEDINICA
                        )

        , RIMSKIBR AS (
            SELECT
            @ID AS BR
            , CASE WHEN DESETICA IN (1,2,3) THEN REPLICATE('X', DESETICA)
                   WHEN DESETICA=4 THEN 'XL'
                   WHEN DESETICA IN (5,6,7,8) THEN REPLICATE('X', DESETICA%5)
                   WHEN DESETICA=9 THEN 'XC'
                   ELSE ''
                   END AS RIMD
            , CASE WHEN JEDINICA IN (1,2,3) THEN PATE('I', JEDINICA)
                   WHEN JEDINICA=4 THEN 'IV' 
                   WHEN JEDINICA IN (5,6,7,8) THEN 'V'+REPLICATE ('I', JEDINICA%5)
                   WHEN JEDINICA=9 THEN 'IX'
                   ELSE ''
                   END AS RIM
            , CASE WHEN STOTINA IN (1,2,3) THEN REPLICATE ('C', STOTINA)
                   WHEN STOTINA=4 THEN 'CO'
                   WHEN STOTINA IN (5,6,7,8) THEN 'D'+REPLICATE ('C', STOTINA%5)
                   WHEN STOTINA=9 THEN 'CM'
                   ELSE ''
                   END AS RIMS
            , CASE WHEN HILJADA IN (1,2,3) THEN REPLICATE ('M', HILJADA)
                   ELSE ''
                   END AS RIMH
                FROM CTE_A)
                
SELECT
    @ID AS BR
,   RIMH+RIMS+RIMD+RIMJ AS ROMAN_NUM
FROM RIMSKIBR
    END
END



                
                
                
