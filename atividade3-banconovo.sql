
--ATIVIDADE 3 - BANCO NOVO

--Fa�a uma SP para inserir valores na tabela IES (n�o esque�a que a chave prim�ria � autoincremental). 

create procedure inserindodadosIES(@iesnome as varchar (30))
as
begin
insert into IES values(@iesnome)
end

exec inserindodadosIES 'IF'

SELECT * FROM IES

--Fa�a uma SP para excluir valores da tabela IES. 

create procedure excluirIES (@cog_ies int)
as
begin
delete from IES where IES_codigo = @cog_ies
end

exec excluirIES 12

select * from  IES

--Crie uma SP para atualizar o nome (enviado) de uma IES com base no c�digo passado. 

create Procedure sp3_003 (@cod int, @nome varchar(40))
as begin
Update IES set IES_nome =@nome where IES_codigo = @cod
end
exec sp3_003 11, UNIRP;


select *from IES
--Desenvolva uma SP que receba o c�digo de uma pessoa e mostre todas as informa��es de cliente. 

create procedure mostrarpessoa (@codg_cliente int)
as
begin
select p.Pes_nome,p.Pes_codigo,c.Cli_cpf,c.Cli_email
from Pessoas p, Clientes c
where p.Pes_codigo = @codg_cliente and
		p.Pes_codigo = c.Pes_codigo
end

exec mostrarpessoa 2
	
--Fa�a uma SP que retorne informa��es de todos os estagi�rios: c�digo e nome da pessoa, 
--a data de entrada do estagi�rio, o c�digo e o nome da IES. 

alter procedure estagiariosinfo
as begin
select p.Pes_codigo,p.Pes_nome,e.Est_data,i.IES_codigo,i.IES_nome
from Estagiarios e , IES i,Pessoas p
where p.Pes_codigo = e.Pes_codigo and
	i.IES_codigo =e.IES_codigo
end

exec estagiariosinfo

--Fa�a uma SP que retorne informa��es (c�digo e nome da pessoa, a data de entrada do estagi�rio, o c�digo e o nome da IES) 
--de uma pessoa/estagi�rio cujo c�digo foi passado para a SP. 

create procedure estagiarioscog(@cog_pessoa int)
as begin
select p.Pes_codigo,p.Pes_nome,e.Est_data,i.IES_codigo,i.IES_nome
from Estagiarios e , IES i,Pessoas p
where p.Pes_codigo = @cog_pessoa and
	p.Pes_codigo = e.Pes_codigo and
	i.IES_codigo =e.IES_codigo
end

exec estagiarioscog 10

 