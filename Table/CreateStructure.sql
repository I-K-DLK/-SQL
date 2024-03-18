/*dbo.SKU (ID identity, Code, Name)
      2.1.1 Ограничение на уникальность поля Code
      2.1.2 Поле Code вычисляемое: "s" + ID
   2.2 dbo.Family (ID identity, SurName, BudgetValue)
   2.3 dbo.Basket (ID identity, ID_SKU (внешний ключ на таблицу dbo.SKU), ID_Family (Внешний ключ на таблицу dbo.Family) Quantity, Value, PurchaseDate, DiscountValue)
      2.3.1 Ограничение, что поле Quantity и Value не могут быть меньше 0
      2.3.2 Добавить значение по умолчанию для поля PurchaseDate: дата добавления записи (текущая дата)*/
if object_id('dbo.SKU') is null
begin
    create table dbo.SKU (
        ID int not null identity
        ,Code as (concat('s',ID)) persisted
        ,Name varchar(255) not null,
    );
    alter table dbo.SKU add constraint UK_SKU_Code unique (Code)
end

if object_id('dbo.Family') is null
begin
    create table dbo.Family (
        ID int not null identity,
        SurName varchar(255) not null,
        BudgetValue int not null
    );
end

if object_id('dbo.Basket') is null
begin
    create table dbo.Basket (
        ID int not null identity,
        ID_SKU int not null,
        ID_Family int not null,
        Quantity int not null, 
        Value int not null, 
        PurchaseDate datetime not null, 
        DiscountValue int not null     
    );
    alter table dbo.Basket add constraint FK_Basket_ID_SKU foreign key (FK_Basket_ID_SKU ) references dbo.SKU(ID)
    alter table dbo.Basket add constraint FK_Basket_ID_Family foreign key (FK_Basket_ID_Family) references dbo.Family(ID)
    alter table dbo.Basket add constraint CK_Basket_QuantityValue check (Quantity >= 0 and Value >= 0)
    alter table dbo.Basket add constraint DF_Basket_PurchaseDate default getdate() for PurchaseDate
end
