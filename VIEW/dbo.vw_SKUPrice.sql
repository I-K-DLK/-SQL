/*4. Создать представление (на выходе: файл в репозитории dbo.vw_SKUPrice в папке VIEW)
   4.1 Возвращает все атрибуты продуктов из таблицы dbo.SKU и расчетный атрибут со стоимостью одного продукта 
   (используя функцию dbo.udf_GetSKUPrice)
*/
create or alter view dbo.vw_SKUPrice
as
select
   ID
   ,Name
   ,dbo.udf_GetSKUPrice(ID) as Price 
from SKU as s
