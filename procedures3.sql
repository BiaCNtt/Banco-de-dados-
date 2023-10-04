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
@pç_num int, @pç_nome as varchar(15),
	@pç_preço as float,
@pç_cor as varchar(15)
as
begin
insert into peca values(@pç_num,@pç_nome,@pç_preço,@pç_cor)
end



--Crie uma Stored Procedure de nome sp_ex1_proj 
--que receba como parâmetro o código do projeto e mostre o nome e a duração do mesmo.

create procedure sp_ex1_proj(@NumProj int)
as
begin
select p.PNome,p.PDuracao
from Projeto p
where p.PNro = @NumProj
end
exec sp_ex1_proj 3

select * from Projeto

/*Crie uma Stored Procedure de nome sp_ex2_forn que receba um texto como parâmetro, 
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

/*Crie uma Stored Procedure de nome sp_ex3_peça que inclua na tabela peça 
somente 3 campos: número, nome e preço. Inclua uma peça.*/


alter procedure sp_ex3_peca(@Pcnum int,@PcNome as varchar(20),@PcPreco as float)
as
begin
insert into Peca (PeNro,PeNome,PePreco) values(@Pcnum,@PcNome,@PcPreco)
end
exec sp_ex3_peca 7, 'Cabide' , 20.5
select *from Peca


/*Crie uma Stored Procedure de nome sp_ex4_peça 
que altere a peça incluída em pelo menos 2 campos.*/

create procedure sp_ex4_peça (@PcNome as varchar (15),@Pccor as varchar(15),@PcNum int)
as 
begin
update Peca
set PeNome = @PcNome, PeCor = @Pccor
where PeNro = @PcNum
end

exec sp_ex4_peça 'cabideiro', azul,7


--Crie uma Stored Procedure de nome sp_ex5_peça 
--que exclua a peça anterior, que foi incluída e alterada no exercício anterior.

create procedure sp_ex5_peça(@Pnum int)
as
begin
delete from Peca where PeNro = @Pnum
end

exec sp_ex5_peça 7
