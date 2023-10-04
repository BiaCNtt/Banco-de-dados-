create procedure sp_fornecer_inserir(
	@forn_num int,@forn_nome as varchar(20),@forn_cid as varchar (20), @forn_categ as varchar(1))
	as 
	begin  
		insert into Fornecedor (FNro,FNome,FCidade,FCateg)
			values (@forn_num,@forn_nome,@forn_cid,@forn_categ)	
	end
Exec sp_fornecer_inserir 11, 'abracadabra','Barretos','C'
	
	
	
	
create procedure sp_fornecedor_alterar(
	@forn_num as int, @forn_nome as varchar(20))
as 
begin
update Fornecedor
set FNome = @forn_nome
where FNro = @forn_num
end

Exec sp_fornecedor_alterar 4, 'aaa'


--pra deletar

create procedure sp_fornecedor_excluir(@forn_num as int) as
begin
	delete from Fornecedor where FNro = @forn_num
end
Exec sp_fornecedor_excluir 11
select * from Fornecedor

--inserir
create procedure sp_peca_inserir
@p�_num int, @p�_nome as varchar(15),
	@p�_pre�o as float,
@p�_cor as varchar(15)
as
begin
insert into peca values(@p�_num,@p�_nome,@p�_pre�o,@p�_cor)
end



--Crie uma Stored Procedure de nome sp_ex1_proj 
--que receba como par�metro o c�digo do projeto e mostre o nome e a dura��o do mesmo.

create procedure sp_ex1_proj(@NumProj int)
as
begin
select p.PNome,p.PDuracao
from Projeto p
where p.PNro = @NumProj
end
exec sp_ex1_proj 3

select * from Projeto

/*Crie uma Stored Procedure de nome sp_ex2_forn que receba um texto como par�metro, 
indicando um trecho do nome do fornecedor, e mostre o nome e a categoria do fornecedor.*/

alter procedure sp_ex2_forn(@NomForn as varchar (15))
as
begin
select f.FNome,f.FCateg
from Fornecedor f
where f.FNome like '%'+ @NomForn + '%'
end

exec sp_ex2_forn tec
select *from Fornecedor

/*Crie uma Stored Procedure de nome sp_ex3_pe�a que inclua na tabela pe�a 
somente 3 campos: n�mero, nome e pre�o. Inclua uma pe�a.*/


alter procedure sp_ex3_peca(@Pcnum int,@PcNome as varchar(20),@PcPreco as float)
as
begin
insert into Peca (PeNro,PeNome,PePreco) values(@Pcnum,@PcNome,@PcPreco)
end
exec sp_ex3_peca 7, 'Cabide' , 20.5
select *from Peca


/*Crie uma Stored Procedure de nome sp_ex4_pe�a 
que altere a pe�a inclu�da em pelo menos 2 campos.*/

create procedure sp_ex4_pe�a (@PcNome as varchar (15),@Pccor as varchar(15),@PcNum int)
as 
begin
update Peca
set PeNome = @PcNome, PeCor = @Pccor
where PeNro = @PcNum
end

exec sp_ex4_pe�a 'cabideiro', azul,7


--Crie uma Stored Procedure de nome sp_ex5_pe�a 
--que exclua a pe�a anterior, que foi inclu�da e alterada no exerc�cio anterior.

create procedure sp_ex5_pe�a(@Pnum int)
as
begin
delete from Peca where PeNro = @Pnum
end

exec sp_ex5_pe�a 7
