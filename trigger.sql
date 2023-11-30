 triggers

insert into Peca values(30,'porta',30,'verde')

create trigger deletar on Peca for delete as 
print 'um registro foi excluido'

delete from Peca where PeNro = 30
select *from Peca

create trigger atualizar on Peca for Update as
print 'a peça foi atualizada'

update Peca 
set PePreco = PePreco *1.2
where PeNro = 6




-- aula 28/09

alter trigger atualizar on Peca
for update as
print 'uma peça foia atualizada'
Select * from Inserted
Print 'Acabou a execução do Trigger'

update peca 
set PePreco = PePreco*1.2
where PeNro = 6
Select *from Peca
Select * from inserted



----novo usando peca2

alter Trigger InsReplic On Peca For Insert as
Insert into Peca2
Select * from Inserted

Insert Peca values(20,'xxx',30,'verde')
Insert Peca values(21,'xxx',40,'verde')
Insert Peca values(22,'xxx',50,'verde')

select *from Peca
Select *from Peca2

create trigger deletarrep on Peca for delete
as delete from Peca2
where Peca2.PeNro in (select PeNro from deleted)

delete from Peca where PeNro = 21
Select* from Peca


Create Trigger UpdReplic On Peca For Update
As
Update Peca2
Set PePreco = (Select PePreco From Inserted)
Where Peca2.PeNro in (Select PeNro From Inserted)


select *from Peca
Select *from Peca2


--1-Após incluir uma peça com atributo cor 'Amarelo', modifique tal cor para 'Azul'. 

alter trigger modificar on Peca for insert
as update peca 
set PeCor = 'azul'
where peca.penro in (Select PeNro From Inserted)

select * from Peca

insert Peca values (26,'mesa',55,'amarelo') 

--2 - Ao invés de deletar uma peça, crie um trigger para modificar o atributo PePreco dela para 50. 

alter trigger deletar on Peca instead of delete
as
update peca set PePreco = 50
where peca.penro in (select PeNro from deleted)

select * from peca

delete from Peca where PeNro = 98


--3 - Crie um trigger para, ao invés de atualizar o nome de uma peça com um valor qualquer, 
--atualize o campo Pecor dela para 'Amarelo'. 

alter trigger trigerrs on Peca instead of update
as
update peca set PeCor = 'amarelo'
where peca.penro in (select PeNro from inserted)

update peca set PeNome = 'cabideiro'
where PeNro = 6


--4 - Faça um trigger para uma inserção na tabela peça que ao invés de inserir um valor para Pecor, troque-o para 'Roxo'. 

alter trigger mudaroxo on Peca for insert
as update peca 
set PeCor = 'roxo'
where peca.penro in (Select PeNro From Inserted)

select * from Peca

insert Peca values (98,'mesa',55,'amarelo') 


--aula 3/010/2012

create trigger set_cuidade on fornecedor after insert as begin
update fornecedor
set Fcidade ='catanduva'
where FNro =(select FNro from inserted) and FCidade =''
end
insert into fornecedor values(36,'roncal','','A')

--select * from fornecedor



create trigger set_cidade2 on fornecedor instead of delete as begin
select*from deleted
update fornecedor set FCidade ='MonteAzul'
where FNro = (select FNro from deleted)
end
--delete from fornecedor where FNro= 36



create trigger set_status3 on fornecedor instead of update 
as 
begin
update fornecedor set FCidade = null
where FNro = (select FNRo from inseted)
end
--update fornecedor set FNome = 'Madri' where FNro = 35


create trigger
