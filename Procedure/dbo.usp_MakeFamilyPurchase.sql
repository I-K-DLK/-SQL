/*
5. Создать процедуру (на выходе: файл в репозитории dbo.usp_MakeFamilyPurchase в папке Procedure)
   5.1 Входной параметр (@FamilySurName varchar(255)) одно из значений атрибута SurName таблицы dbo.Family
   5.2 Процедура при вызове обновляет данные в таблицы dbo.Family в поле BudgetValue по логике
      5.2.1 dbo.Family.BudgetValue - sum(dbo.Basket.Value), где dbo.Basket.Value покупки для переданной в процедуру семьи
      5.2.2 При передаче несуществующего dbo.Family.SurName пользователю выдается ошибка, что такой семьи нет
*/
create or alter procedure dbo.usp_MakeFamilyPurchase
    @FamilySurName varchar(255)
as
if @FamilySurName in (select distinct SurName from dbo.Family)  
begin  
    update Family  
    set BudgetValue = BudgetValue - (select sum(Value) as s from dbo.Basket as b inner join dbo.Family as f on f.ID = b.ID_Family where f.SurName = @FamilySurName)
    from Family
    where SurName = @FamilySurName  
end
else
begin
    select 'ошибка, такой семьи нет!'
end
