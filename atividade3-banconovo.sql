
--ATIVIDADE 3 - BANCO NOVO

--Faça uma SP para inserir valores na tabela IES (não esqueça que a chave primária é autoincremental). 

create procedure inserindodadosIES(@iesnome as varchar (30))
as
begin
insert into IES values(@iesnome)
end

exec inserindodadosIES 'IF'

SELECT * FROM IES

--Faça uma SP para excluir valores da tabela IES. 

create procedure excluirIES (@cog_ies int)
as
begin
delete from IES where IES_codigo = @cog_ies
end

exec excluirIES 12

select * from  IES

--Crie uma SP para atualizar o nome (enviado) de uma IES com base no código passado. 

create Procedure sp3_003 (@cod int, @nome varchar(40))
as begin
Update IES set IES_nome =@nome where IES_codigo = @cod
end
exec sp3_003 11, UNIRP;


select *from IES
--Desenvolva uma SP que receba o código de uma pessoa e mostre todas as informações de cliente. 

create procedure mostrarpessoa (@codg_cliente int)
as
begin
select p.Pes_nome,p.Pes_codigo,c.Cli_cpf,c.Cli_email
from Pessoas p, Clientes c
where p.Pes_codigo = @codg_cliente and
		p.Pes_codigo = c.Pes_codigo
end

exec mostrarpessoa 2
	
--Faça uma SP que retorne informações de todos os estagiários: código e nome da pessoa, 
--a data de entrada do estagiário, o código e o nome da IES. 

alter procedure estagiariosinfo
as begin
select p.Pes_codigo,p.Pes_nome,e.Est_data,i.IES_codigo,i.IES_nome
from Estagiarios e , IES i,Pessoas p
where p.Pes_codigo = e.Pes_codigo and
	i.IES_codigo =e.IES_codigo
end

exec estagiariosinfo

--Faça uma SP que retorne informações (código e nome da pessoa, a data de entrada do estagiário, o código e o nome da IES) 
--de uma pessoa/estagiário cujo código foi passado para a SP. 

create procedure estagiarioscog(@cog_pessoa int)
as begin
select p.Pes_codigo,p.Pes_nome,e.Est_data,i.IES_codigo,i.IES_nome
from Estagiarios e , IES i,Pessoas p
where p.Pes_codigo = @cog_pessoa and
	p.Pes_codigo = e.Pes_codigo and
	i.IES_codigo =e.IES_codigo
end

exec estagiarioscog 10

 