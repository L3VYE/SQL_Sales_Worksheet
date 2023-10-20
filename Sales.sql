create procedure proc_NA (@NA varchar(max),@NA2 varchar(max))
as
select CompanyName, ContactName, City, Country,Phone
from Supplier
where Country =@NA or Country =@NA2
GO
exec proc_NA 'Canada','USA'

create procedure proc_Yıl(@Yıl int)
as 
select OrderDate, OrderNumber, TotalAmount 
from Orders
where YEAR(OrderDate)=@Yıl
go
exec proc_Yıl '2013'

create procedure proc_quan(@quan int)
as
select ProductId,Quantity
from OrderItem where Quantity>@quan
go
exec proc_quan '99'

create table tLogs
(id int identity(1,1) primary key,
logs varchar(max),
process_date date)

create trigger trg_Product
on Product
after update
as
declare @oldPrice int, @newPrice int, @detail varchar(max)
select @oldPrice=UnitPrice from deleted
set @newPrice=(select UnitPrice from inserted)
set @detail=CONCAT(@oldPrice, ' has changed to ',@newPrice)
insert into tLogs(logs,process_date) values (@detail,GETDATE())

create trigger trg_PhoneChange
on Supplier
after update
as
declare @oldPhone nvarchar(max), @newPhone nvarchar(max), @detail varchar(max)
select @oldPhone=Phone from deleted
set @newPhone=(select Phone from inserted)
set @detail=CONCAT(@oldPhone, ' has changed to ',@newPhone)
insert into tLogs(logs,process_date) values (@detail,GETDATE())

create nonclustered index idx_Country
on Supplier
(Country asc);
select Country from Supplier

create index idx_Amount_asc
on Orders(TotalAmount asc);
go
select TotalAmount from Orders

create unique index idx_Name
on Product (ProductName asc);
go
select ProductName FROM Product

create function fn_freq(@freq int)
returns int
begin
	declare @count int
	set @count=(Select COUNT(*) from Orders where CustomerId=@freq)
	return @count
end
select top 1 dbo.fn_freq('87') as Frequency from Orders

create procedure proc_insert
as
insert into Orders(OrderDate,OrderNumber,CustomerId,TotalAmount)
values(GETDATE(),'600001','41',456)
go
exec proc_insert
select * from Orders where OrderNumber='600001'

create procedure proc_update(@Name varchar(max))
as
update Product set UnitPrice=UnitPrice-2 where ProductName=@Name
go
exec proc_update 'Ikura'
select * from Product where ProductName ='Ikura'

create procedure proc_delete(@delete varchar(max))
as
delete from Product where ProductName=@delete
go
exec proc_delete 'Tofu'
