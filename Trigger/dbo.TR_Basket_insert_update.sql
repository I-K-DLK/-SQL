 /* 
6. Создать триггер (на выходе: файл в репозитории dbo.TR_Basket_insert_update в папке Trigger)
   6.1 Если в таблицу dbo.Basket за раз добавляются 2 и более записей одного ID_SKU, то значение 
в поле DiscountValue, для этого ID_SKU рассчитывается по формуле Value * 5%, иначе DiscountValue = 0
*/
create or alter trigger dbo.tr_Basket_insert_update on dbo.Basket
after insert
as
	if (select count(ID_SKU) as c from inserted as i group by i.ID_SKU having count(ID_SKU)>2)>2
	begin
		update dbo.Basket as b 
	        set b.DiscountValue = i.Value * 0.05 
	        from inserted as i 
	        where b.ID_SKU in (select ID_SKU from i group by i.ID_SKU having count(ID_SKU)>2) 
	end
    	else  
        begin  
	        update dbo.Basket as b
	        set b.DiscountValue = 0 
	        from inserted as i  
	        where b.ID_SKU = i.ID_SKU 
        end
