create database bancotransaçõeseerros
use bancotransaçõeseerros

create table tbl(
id int identity(1,1) primary key,
val int not null
)

go 
insert into tbl(val) values(1)

-- leitura suja leu um dado que não foi confirmado ainda, ela acessa mesmo que aquela transação nao tenha sido finalida


--teste pra isso 

begin tran logupdate 
update tbl
set val = 1

waitfor delay '00:00:005' -- indica que vai ser um alonga atualização 

rollback tran longupdate

-- teste em seguida simuntaneamente 

set transaction isolation level read uncommitted --da uma leitura suja -- da da um resultado realmente confirmado
begin tran
select val from tbl
commit tran

select *from tbl


set transaction isolation level read committed --read comittedd faz o travamento para outro consulta - 
begin tran	--quando executa o comando 2  ele espera o comand 1 executar inteiro 
select val from tbl -- tem um nover de isolamento maior pois ele espera o primeiro pra depois executar a segunda
commit tran




-----reatread

set transaction isolation level read committed
go
begin tran reapetread
select*from tbl
waitfor delay '00:00:05'
select*from tbl

commit tran reaptread

--comenado 2

begin tran shortupdate
update tbl set val = -1
commit tran shortupdate



--

set transaction isolation repeatable read
go
begin tran reapetread
select*from tbl
waitfor delay '00:00:05'
select*from tbl

commit tran reaptread

--comenado 2

begin tran shortupdate
update tbl set val = 1
commit tran shortupdate


--------------

set transaction isolation repeatable read
go
begin tran reapetread
select*from tbl
waitfor delay '00:00:05'
select*from tbl

commit tran reaptread


--comando 2
begin tran ahortinsert
insert into tbl
values(2)
commit tran shortinsert

----------------------

--serializble
set transation