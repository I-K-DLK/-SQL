/*
Создать функцию (на выходе: файл в репозитории dbo.udf_GetSKUPrice.sql в папке Function)
   3.1 Входной параметр @ID_SKU
   3.2 Рассчитывает стоимость передаваемого продукта из таблицы dbo.Basket по формуле
      3.1.1 сумма Value по переданному SKU / сумма Quantity по переданному SKU
   3.3 На выходе значение типа decimal(18, 2)
*/
create or alter function dbo.udf_GetSKUPrice(
    @ID_SKU int
)
returns decimal(18,2)
begin
   declare @Price decimal(18,2)
   
   select @Price = sum(s.Value)/sum(s.Quantity)
   from dbo.SKU as s
   where s.ID = @ID_SKU
   group by s.ID
   
   return @Price
end
