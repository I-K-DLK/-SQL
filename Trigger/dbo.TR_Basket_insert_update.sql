 /* 
6. Создать триггер (на выходе: файл в репозитории dbo.TR_Basket_insert_update в папке Trigger)
   6.1 Если в таблицу dbo.Basket за раз добавляются 2 и более записей одного ID_SKU, то значение 
в поле DiscountValue, для этого ID_SKU рассчитывается по формуле Value * 5%, иначе DiscountValue = 0
*/
create or alter trigger dbo.tr_Basket_insert_update on dbo.Basket
after insert
as
    if (select count(ID_SKU) from inserted group by inserted.ID_SKU having count(ID_SKU)>2)>2
        begin
			select * from Basket
			select count(inserted.ID_SKU) as count, inserted.ID_SKU from inserted group by inserted.ID_SKU having count(inserted.ID_SKU)>2   
            update Basket  
            set Basket.DiscountValue = inserted.Value * 0.05 
            from inserted  
            where Basket.ID_SKU in (select ID_SKU from inserted group by inserted.ID_SKU having count(ID_SKU)>2) 
			select * from Basket
        end
	else  
        begin  
            update Basket  
            set DiscountValue = 0 
            from inserted  
            where Basket.ID_SKU = inserted.ID_SKU 
        end
