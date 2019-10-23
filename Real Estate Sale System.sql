select * from Apartments

select * from Bonus

select * from Cancel

select * from Community

select * from Company

select * from Customers

select * from Employees

select * from Performance

select * from Purchase

select * from Sell


create procedure proc_per_search
(
	@Emp_ID char(20)	--员工ID
)
as
begin
	select *
	from Performance
	where Emp_ID = @Emp_ID
	order by Per_year desc
end

create procedure proc_bon_search
(
	@Emp_ID char(20)	--员工ID
)
as
begin
	select *
	from Bonus
	where Emp_ID = @Emp_ID
	order by Bon_year desc
end

create procedure proc_emp_search
(
	@Emp_ID char(20)	--员工ID
)
as
begin
	select *
	from Employees
	where Emp_ID = @Emp_ID
	order by Emp_rank desc
end

create procedure proc_emp_rank_search
(
	@Emp_rank char(20)	--员工职位
)
as
begin
	select *
	from Employees
	where Emp_rank = @Emp_rank
end

create procedure proc_can_search
(
	@Apa_ID char(20)	--房间ID
)
as
begin
	select *
	from Cancel
	where Apa_ID = @Apa_ID
end

create procedure proc_apa_search
(
	@Apa_ID char(20)	--房间ID
)
as
begin
	select *
	from Apartments
	where Apa_ID = @Apa_ID
end

create procedure proc_com_search
(
	@Com_ID char(20)	--社区ID
)
as
begin
	select *
	from Community
	where Com_ID = @Com_ID
end

create procedure proc_cpn_search
(
	@Cpn_ID char(20)	--公司ID
)
as
begin
	select *
	from Company
	where Cpn_ID = @Cpn_ID
end

create procedure proc_cus_search
(
	@Cus_ID char(20)	--顾客ID
)
as
begin
	select *
	from Customers
	where Cus_ID = @Cus_ID
end

create procedure proc_sel_search
(
	@Emp_ID char(20)	--员工ID
)
as
begin
	select *
	from Sell
	where Emp_ID = @Emp_ID
end

create procedure proc_pur_search
(
	@Cus_ID char(20)	--顾客ID
)
as
begin
	select *
	from Purchase
	where Cus_ID = @Cus_ID
end

create procedure proc_cpn_contain
(
	@Cpn_ID char(20)	--公司ID
)
as
begin
	select *
	from Community
	where Cpn_ID = @Cpn_ID
end

create procedure proc_com_contain
(
	@Com_ID char(20)	--社区ID
)
as
begin
	select *
	from Apartments
	where Com_ID = @Com_ID
end

create procedure proc_emp_add
(
	@Emp_ID			char(20),	--员工ID
	@Emp_name		char(20),	--员工姓名
	@Emp_gender		char(10),	--员工性别
	@Emp_age		int,		--员工年龄
	@Emp_rank		char(20),	--员工职位
	@Emp_contact	char(200)	--员工手机号
)
as
begin
	if not exists (select *
	               from Employees
				   where Emp_ID = @Emp_ID)
		begin
			insert Employees values(@Emp_ID, @Emp_name, @Emp_gender, @Emp_age, @Emp_rank, @Emp_contact)
		end
	else
		print'已存在该员工'
end

create procedure proc_emp_modify
(
	@Emp_ID			char(20),	--员工ID
	@Emp_name		char(20),	--员工姓名
	@Emp_gender		char(10),	--员工性别
	@Emp_age		int,		--员工年龄
	@Emp_rank		char(20),	--员工职位
	@Emp_contact	char(200)	--员工手机号
)
as
begin
	if exists (select *
	           from Employees
			   where Emp_ID = @Emp_ID)
		begin
			delete
			from Employees
			where Emp_ID = @Emp_ID
			insert Employees values(@Emp_ID, @Emp_name, @Emp_gender, @Emp_age, @Emp_rank, @Emp_contact)
		end
	else
		print'不存在该员工'
end

create procedure proc_emp_delete
(
	@Emp_ID char(20)	--员工ID
)
as
begin
	if exists (select *
	           from Employees
			   where Emp_ID = @Emp_ID)
		begin
			delete
			from Employees
			where Emp_ID = @Emp_ID
		end
	else
		print'不存在该员工'
end

create procedure proc_com_bought
(
	@Com_ID	char(20),	--社区ID
	@Cpn_ID char(20)	--公司ID
)
as
begin
	select *
	from Apartments
	where Com_ID = @Com_ID
	and Cpn_ID = @Cpn_ID
	and Apa_ID in (select Apa_ID
	               from Purchase)
end

create procedure proc_com_notBought
(
	@Com_ID	char(20),	--社区ID
	@Cpn_ID char(20)	--公司ID
)
as
begin
	select *
	from Apartments
	where Com_ID in (select Com_ID
	                 from Community
					 where Com_ID = @Com_ID)
	and Cpn_ID in (select Cpn_ID
	               from Company
				   where Cpn_ID = @Cpn_ID)
	except
	select *
	from Apartments
	where Com_ID in (select Com_ID
	                 from Community)
	and Cpn_ID in (select Cpn_ID
	               from Company
				   where Cpn_ID = @Cpn_ID)
	and Apa_ID in (select Apa_ID
	               from Purchase)
end

create procedure proc_cus_add
(
	@Cus_ID			char(20),	--顾客ID
	@Cus_name		char(20),	--顾客姓名
	@Cus_gender		char(10),	--顾客性别
	@Cus_age		int,		--顾客年龄
	@Cus_job		char(20),	--顾客工作
	@Cus_address	char(50),	--顾客住址
	@Cus_contact	char(20)	--顾客电话
)
as
begin
	if not exists (select *
	               from Customers
				   where Cus_ID = @Cus_ID)
		begin
			insert Customers values(@Cus_ID, @Cus_name, @Cus_gender, @Cus_age, @Cus_job, @Cus_address, @Cus_contact)
		end
	else
		print'已存在该顾客'
end

create procedure proc_cus_modify
(
	@Cus_ID			char(20),	--顾客ID
	@Cus_name		char(20),	--顾客姓名
	@Cus_gender		char(10),	--顾客性别
	@Cus_age		int,		--顾客年龄
	@Cus_job		char(20),	--顾客工作
	@Cus_address	char(50),	--顾客住址
	@Cus_contact	char(20)	--顾客电话
)
as
begin
	if exists (select *
	           from Customers
			   where Cus_ID = @Cus_ID)
		begin
			delete
			from Customers
			where Cus_ID = @Cus_ID
			insert Customers values(@Cus_ID, @Cus_name, @Cus_gender, @Cus_age, @Cus_job, @Cus_address, @Cus_contact)
		end
	else
		print'不存在该顾客'
end

create procedure proc_can_add
(
	@Apa_ID		char(20)	--房间ID
)
as
begin
	if exists (select *
	           from Purchase
			   where Apa_ID = @Apa_ID)
		begin
			insert Cancel values(@Apa_ID, getdate())
		end
	else
		print'此房未卖'
end

create procedure proc_apa_add
(
	@Apa_ID			char(20),	--房间ID
	@Com_ID			char(20),	--社区ID
	@Cpn_ID			char(20),	--公司ID
	@Apa_area		float,		--房间面积
	@Apa_totalPrice	float		--房间总价
)
as
begin
	if not exists (select *
	               from Company
				   where Cpn_ID = @Cpn_ID)
		begin
			print '不存在该公司'
		end
	else if not exists (select *
	                    from Community
						where Com_ID = @Com_ID)
		begin
			print '不存在该社区'
		end
	else if not exists (select *
				        from Apartments
				        where Apa_ID = @Apa_ID
				        and Com_ID = @Com_ID
				        and Cpn_ID = @Cpn_ID)
		begin
			insert Apartments values(@Apa_ID, @Com_ID, @Cpn_ID, @Apa_area, @Apa_totalPrice, round(@Apa_totalPrice/@Apa_area, 2))
		end
	else
		print'已存在该房间'
end

create procedure proc_apa_modify
(
	@Apa_ID			char(20),	--房间ID
	@Com_ID			char(20),	--社区ID
	@Cpn_ID			char(20),	--公司ID
	@Apa_area		float,		--房间面积
	@Apa_totalPrice	float		--房间总价
)
as
begin
	if exists (select *
	           from Apartments
			   where Apa_ID = @Apa_ID
			   and Com_ID = @Com_ID
			   and Cpn_ID = @Cpn_ID)
		begin
			update Apartments
			set Apa_area = @Apa_area, Apa_totalPrice = @Apa_totalPrice, Apa_unitPrice = round(@Apa_totalPrice/@Apa_area, 2)
			where Apa_ID = @Apa_ID
			and Com_ID = @Com_ID
			and Cpn_ID = @Cpn_ID
		end
	else
		print'不存在该房间'
end

create procedure proc_apa_delete
(
	@Apa_ID			char(20),	--房间ID
	@Com_ID			char(20),	--社区ID
	@Cpn_ID			char(20)	--公司ID
)
as
begin
	if exists (select *
	           from Apartments
			   where Apa_ID = @Apa_ID
			   and Com_ID = @Com_ID
			   and Cpn_ID = @Cpn_ID)
		begin
			delete
			from Apartments
			where Apa_ID = @Apa_ID
			and Com_ID = @Com_ID
			and Cpn_ID = @Cpn_ID
		end
	else
		print'不存在该房间'
end

create procedure proc_com_add
(
	@Com_ID			char(20),	--社区ID
	@Cpn_ID			char(20),	--公司ID
	@Com_name		char(20),	--社区名称
	@Com_address	char(50)	--社区地址
)
as
begin
	if not exists (select *
	               from Company
				   where Cpn_ID = @Cpn_ID)
		begin
			print'不存在该公司'
		end
	else if not exists (select *
				        from Community
				        where Com_ID = @Com_ID
				        and Cpn_ID = @Cpn_ID)
		begin
			insert Community values(@Com_ID, @Cpn_ID, @Com_name, @Com_address, 0, 0)
		end
	else
		print'已存在该社区'
end

create procedure proc_com_modify
(
	@Com_ID			char(20),	--社区ID
	@Cpn_ID			char(20),	--公司ID
	@Com_name		char(20),	--社区名称
	@Com_address	char(50)	--社区地址
)
as
begin
	if exists (select *
	           from Community
			   where Com_ID = @Com_ID
			   and Cpn_ID = @Cpn_ID)
		begin
			update Community
			set Com_name = @Com_name, Com_address = @Com_address
			where Com_ID = @Com_ID
			and Cpn_ID = @Cpn_ID
		end
	else
		print'不存在该社区'
end

create procedure proc_com_delete
(
	@Com_ID			char(20),	--社区ID
	@Cpn_ID			char(20)	--公司ID
)
as
begin
	if exists (select *
	           from Community
			   where Com_ID = @Com_ID
			   and Cpn_ID = @Cpn_ID)
		begin
			delete
			from Community
			where Com_ID = @Com_ID
			and Cpn_ID = @Cpn_ID
		end
	else
		print'不存在该社区'
end

create procedure proc_cpn_add
(
	@Cpn_ID			char(20),	--公司ID
	@Cpn_name		char(20)	--公司名称
)
as
begin
	if not exists (select *
	               from Company
				   where Cpn_ID = @Cpn_ID)
		begin
			insert Company values(@Cpn_ID, @Cpn_name)
		end
	else
		print'已存在该公司'
end

create procedure proc_cpn_modify
(
	@Cpn_ID			char(20),	--公司ID
	@Cpn_name		char(20)	--公司名称
)
as
begin
	if exists (select *
	           from Company
			   where Cpn_ID = @Cpn_ID)
		begin
			update Company
			set Cpn_name = @Cpn_name
			where Cpn_ID = @Cpn_ID
		end
	else
		print'不存在该公司'
end

create procedure proc_cpn_delete
(
	@Cpn_ID			char(20)	--公司ID
)
as
begin
	if exists (select *
	           from Company
			   where Cpn_ID = @Cpn_ID)
		begin
			delete
			from Company
			where Cpn_ID = @Cpn_ID
		end
	else
		print'不存在该公司'
end

create function fn_apa_boughtOrNot(@Apa_ID	char(20))	--房间ID
returns varchar(10)
as
begin
	declare @result varchar(10)
	select @result = case
					when (@Apa_ID in (select Apa_ID from Purchase))
						then '已卖出'
					else '未卖出'
					end
	return @result
end

create view per_view
as
select *
from Performance

create view bon_view
as
select *
from Bonus

create view emp_view
as
select *
from Employees

create view cus_view
as
select *
from Customers

create view sel_view
as
select *
from Sell

create view pur_view
as
select *
from Purchase

create view can_view
as
select *
from Cancel

create view apa_view
as
select *
from Apartments

create view com_view
as
select *
from Community

create view cpn_view
as
select *
from Company

create view apa_bought_view
as
select *
from Apartments
where Apa_ID in (select Apa_ID
                 from Purchase)

create view apa_notBought_view
as
select *
from Apartments
except
select *
from Apartments
where Apa_ID in (select Apa_ID
                 from Purchase)

create procedure proc_trade
(
	@Cus_ID			char(20),			--顾客ID
	@Emp_ID			char(20),			--员工ID
	@Apa_ID			char(20),			--房间ID
	@Trade_price	double precision	--成交价格
)
as
begin
	begin tran
	if exists (select *
	           from Purchase
			   where Apa_ID = @Apa_ID)
		begin
			print'此房已卖'
		end
	else if not exists (select *
	                    from Employees
						where Emp_ID = @Emp_ID)
		begin
			print'无此员工'
		end
	else if not exists (select *
	                    from Customers
						where Cus_ID = @Cus_ID)
		begin
			print'无此顾客'
		end
	else
		begin
			insert into Purchase values(@Cus_ID, @Apa_ID, getdate(), @Trade_price)
			insert into Sell values(@Emp_ID, @Apa_ID, getdate(), @Trade_price)
			print'交易完成！'
		end
	commit
end

create trigger tri_com
on Purchase
for insert
as
begin
	declare @Com_ID char(20)
	select @Com_ID = Apartments.Com_ID
	from inserted, Apartments
	where inserted.Apa_ID = Apartments.Apa_ID

	update Community
	set Com_leftNum = Com_leftNum - 1
	where Com_ID = @Com_ID
end

create trigger tri_com_add
on Apartments
for insert
as
begin
	declare @Com_ID char(20)
	select @Com_ID = Com_ID from inserted

	update Community
	set Com_totalNum = Com_totalNum + 1, Com_leftNum = Com_leftNum + 1
	where Com_ID = @Com_ID
end

create trigger tri_com_modify
on Apartments
for delete
as
begin
	declare @Com_ID char(20)
	declare @Apa_ID char(20)
	select @Com_ID = Com_ID from deleted
	select @Apa_ID = Apa_ID from deleted

	update Community
	set Com_totalNum = Com_totalNum - 1
	where Com_ID = @Com_ID

	if @Apa_ID not in (select Apa_ID
	                   from Purchase)
		begin
		update Community
		set Com_leftNum = Com_leftNum - 1
		where Com_ID = @Com_ID
		end
end

create trigger tri_com_delete
on Purchase
for delete
as
begin
	declare @Com_ID char(20)
	select @Com_ID = Apartments.Com_ID
	from deleted, Apartments
	where deleted.Apa_ID = Apartments.Apa_ID

	update Community
	set Com_leftNum = Com_leftNum + 1
	where Com_ID = @Com_ID
end

create trigger tri_emp
on Employees
for insert, update, delete
as
begin
	if (datename(weekday, getdate()) in ('星期六','星期日'))
	or (datepart(hh, getdate()) not between 8 and 17)
	begin
		print '不能在非工作时间对员工表信息进行修改！'
		rollback transaction
	end
end

create trigger tri_per
on Sell
for insert
as
begin
	declare @Emp_ID char(20)
	declare @Per_year int
	declare @Per_profit float
	select @Emp_ID = Emp_ID from inserted
	select @Per_year = datepart(year, Sel_date) from inserted
	select @Per_profit = Sel_price from inserted
	
	if not exists (select *
	               from Performance
				   where Per_year = @Per_year
				   and Emp_ID = @Emp_ID)
		begin
			insert into Performance values(@Emp_ID, 1, @Per_year, @Per_profit)
		end
	else
		begin
			update Performance
			set Per_num = Per_num + 1, Per_profit = Per_profit + @Per_profit
			where Emp_ID = @Emp_ID
			and Per_year = @Per_year
		end
end

create trigger tri_per_delete
on Sell
for delete
as
begin
	declare @Emp_ID char(20)
	declare @Per_year int
	declare @Per_profit float
	select @Emp_ID = Emp_ID from deleted
	select @Per_year = datepart(year, Sel_date) from deleted
	select @Per_profit = Sel_price from deleted
	
	update Performance
	set Per_num = Per_num - 1, Per_profit = Per_profit - @Per_profit
	where Emp_ID = @Emp_ID
	and Per_year = @Per_year
end

create trigger tri_bonus
on Sell
for insert
as
begin
	declare @Emp_ID char(20)
	declare @Bon_year int
	declare @Bon_num float
	select @Emp_ID = Emp_ID from inserted
	select @Bon_year = datepart(year, Sel_date) from inserted
	select @Bon_num = 0.01 * Sel_price from inserted
	
	if not exists (select *
	               from Bonus
				   where Bon_year = @Bon_year
				   and Emp_ID = @Emp_ID)
		begin
			insert into Bonus values(@Emp_ID, @Bon_num, @Bon_year)
		end
	else
		begin
			update Bonus
			set Bon_num = Bon_num + @Bon_num
			where Emp_ID = @Emp_ID
			and Bon_year = @Bon_year
		end
end

create trigger tri_bonus_delete
on Sell
for delete
as
begin
	declare @Emp_ID char(20)
	declare @Bon_year int
	declare @Bon_num float
	select @Emp_ID = Emp_ID from deleted
	select @Bon_year = datepart(year, Sel_date) from deleted
	select @Bon_num = 0.01 * Sel_price from deleted
	
	update Bonus
	set Bon_num = Bon_num - @Bon_num
	where Emp_ID = @Emp_ID
	and Bon_year = @Bon_year
end

create trigger tri_pur_sel_delete
on Cancel
for insert
as
begin
	declare @Apa_ID char(20)
	select @Apa_ID = Apa_ID from inserted

	delete
	from Purchase
	where Purchase.Apa_ID = @Apa_ID

	delete
	from Sell
	where Sell.Apa_ID = @Apa_ID
end


create proc proc_backup
(
	@DatabaseName	char(20),	--数据库名
	@Type			char(10)	--备份类型：完全、差异、日志
)
as
begin
declare @name char(30)
declare @sql varchar(255)
set @name = @DatabaseName + '_' + convert(varchar, datepart(year, getdate()))
                          + '_' + convert(varchar, datepart(month, getdate()))
						  + '_' + convert(varchar, datepart(day, getdate())) + '.bak'
set @sql = 'backup database ' + @DatabaseName + ' to disk = ' + '''d:\' + @name + ''''
if @Type = '完整备份'
	set @sql = @sql
else if @Type = '差异备份'
	set @sql = @sql + ' with differential'	--根据类型为语句添加参数
else if @Type = '日志备份'
	set @sql = 'backup log ' + @DatabaseName + ' to disk = ' + '''d:\' + @name + ''''
else
	begin
		print '输入参数不正确，请输入完整备份、差异备份或日志备份'	--输入错误
		return -1
	end
execute (@sql)
end


exec sp_addrole '行政管理'
exec sp_addrole '销售'
exec sp_addrole '房屋管理'

grant select, insert, update, delete on Employees to 行政管理
grant select, insert, update, delete on Performance to 行政管理
grant select, insert, update, delete on Bonus to 行政管理
grant select, insert, update, delete on emp_view to 行政管理
grant select, insert, update, delete on per_view to 行政管理
grant select, insert, update, delete on bon_view to 行政管理
grant execute on proc_emp_search to 行政管理
grant execute on proc_emp_rank_search to 行政管理
grant execute on proc_emp_add to 行政管理
grant execute on proc_emp_modify to 行政管理
grant execute on proc_emp_delete to 行政管理
grant execute on proc_sel_search to 行政管理
grant execute on proc_per_search to 行政管理
grant execute on proc_bon_search to 行政管理
grant execute on proc_backup to 行政管理

grant select, insert, update, delete on Apartments to 房屋管理
grant select, insert, update, delete on Community to 房屋管理
grant select, insert, update, delete on Company to 房屋管理
grant select, insert, update, delete on apa_view to 房屋管理
grant select, insert, update, delete on apa_bought_view to 房屋管理
grant select, insert, update, delete on apa_notBought_view to 房屋管理
grant select, insert, update, delete on com_view to 房屋管理
grant select, insert, update, delete on cpn_view to 房屋管理
grant execute on proc_apa_search to 房屋管理
grant execute on proc_apa_add to 房屋管理
grant execute on proc_apa_modify to 房屋管理
grant execute on proc_apa_delete to 房屋管理
grant execute on dbo.fn_apa_boughtOrNot to 房屋管理
grant execute on proc_com_search to 房屋管理
grant execute on proc_com_contain to 房屋管理
grant execute on proc_com_bought to 房屋管理
grant execute on proc_com_notBought to 房屋管理
grant execute on proc_com_add to 房屋管理
grant execute on proc_cpn_modify to 房屋管理
grant execute on proc_com_delete to 房屋管理
grant execute on proc_cpn_search to 房屋管理
grant execute on proc_cpn_contain to 房屋管理
grant execute on proc_cpn_add to 房屋管理
grant execute on proc_cpn_modify to 房屋管理
grant execute on proc_cpn_delete to 房屋管理
grant execute on proc_backup to 房屋管理

grant select, insert, update, delete on Customers to 销售
grant select, insert, update, delete on Purchase to 销售
grant select, insert, update, delete on Sell to 销售
grant select, insert, update, delete on Cancel to 销售
grant select, insert, update, delete on cus_view to 销售
grant select, insert, update, delete on pur_view to 销售
grant select, insert, update, delete on sel_view to 销售
grant select, insert, update, delete on can_view to 销售
grant execute on proc_cus_search to 销售
grant execute on proc_cus_add to 销售
grant execute on proc_cus_modify to 销售
grant execute on proc_pur_search to 销售
grant execute on proc_can_search to 销售
grant execute on proc_can_add to 销售
grant execute on proc_trade to 销售
grant execute on proc_backup to 销售

create login loginzhu with password = '666666'
create login loginsu with password = '666666'
create login loginlin with password = '666666'

create user dbzhu for login loginzhu
create user dbsu for login loginsu
create user dblin for login loginlin

sp_addrolemember '行政管理', 'dbzhu'
sp_addrolemember '房屋管理', 'dblin'
sp_addrolemember '销售', 'dbsu'





select * from emp_view
select * from per_view
select * from bon_view

select * from cus_view
select * from pur_view
select * from sel_view
select * from can_view

select * from apa_view
select * from apa_bought_view
select * from apa_notBought_view
select * from com_view
select * from cpn_view

exec proc_emp_search 'emp003'
exec proc_emp_rank_search '销售'
exec proc_emp_add 'emp001', '小祝', 'male', '22', '行政管理', '13066667777'
exec proc_emp_modify 'emp001', '小祝', 'male', '23', '行政管理', '13000000000'
exec proc_emp_delete 'emp001'
exec proc_sel_search 'emp003'

exec proc_per_search 'emp003'
exec proc_bon_search 'emp003'

exec proc_apa_search 'apa001'
exec proc_apa_add 'apa002', 'com001', 'cpn001', '30', '800000'
exec proc_apa_modify 'apa003', 'com001', 'cpn001', '45', '400000'
exec proc_apa_delete 'apa002', 'com001', 'cpn001'
select dbo.fn_apa_boughtOrNot('apa001')

exec proc_com_search 'com001'
exec proc_com_contain 'com001'
exec proc_com_bought 'com001', 'cpn001'
exec proc_com_notBought 'com001', 'cpn001'
exec proc_com_add 'com002', 'cpn001', '幸福小d区', '集美区'
exec proc_com_modify 'com001', 'cpn001', '很幸福小区', '集美区'
exec proc_com_delete 'com002', 'cpn001'

exec proc_cpn_search 'cpn001'
exec proc_cpn_contain 'cpn001'
exec proc_cpn_add 'cpn002', '啦啦地产'
exec proc_cpn_modify 'cpn001', '龙帆LF地产'
exec proc_cpn_delete 'cpn002'

exec proc_cus_search 'cus003'
exec proc_cus_add 'cus004', '麦兜', 'na', '30', 'pig', 'pig apartment', 'na'
exec proc_cus_modify 'cus003', '佩奇', 'na', '20', 'pig', 'pig house', 'na'
exec proc_pur_search 'cus003'

exec proc_can_search 'apa001'
exec proc_can_add 'apa001'

exec proc_trade 'cus003', 'emp003', 'apa001', '500000'

exec proc_backup 'Final', '完整备份'
