create procedure fornecimento_totais(@peca_num as int)
as 
begin
select p.PeNome NomePeca,f.FNome NomeFornecedor, SUM(p.PePreco*fp.Quant)total

from Peca p ,Fornecedor f, Fornece_Para fp 

where p.PeNro =@peca_num and
p.PeNro = fp.PeNro and
f.FNro = fp.FNro
group by p.PeNome,f.FNome
end 

exec fornecimento_totais 4


create procedure max_fornecimento 
as begin
select fp.PeNro,p.PeNome,MAX(fp.Quant) Maximo
from Peca p, Fornece_Para fp
where p.PeNro = fp.PeNro
group by fp.PeNro,p.PeNome
having MAX (fp.Quant) > 1
end

exec max_fornecimento

create procedure sp_while 
as
begin
declare @i int --declarações de variaveis
set @i = 1
while (@i < 10)
begin
	print @i
	set @i = @i +1
	end
end

exec sp_while


-- Crie uma StoredProcedure que receba o nº do projeto e liste os 
--nomes dos mesmos e os nomes de peças, bem como as quantidades fornecidas, renomeando as colunas. 

alter procedure exerc1(@proj_num as int)
as 
begin
select proj.PNro NumeroProjeto,proj.PNome NomeProjeto,p.PeNome NomePeca,fp.Quant Quantidade
from Peca p, Projeto proj,Fornece_Para fp 
where proj.PNro = @proj_num and
		fp.PeNro = p.PeNro  and
		proj.PNro = fp.PNro	

end
exec exerc1 2


--Enviar o código do projeto para a stored procedure e 
--listar o nome do projeto e do fornecedor referente a este código do projeto 

alter procedure Listarproj(@cod_proj as int)
as
begin
select
	proj.PNome,f.FNome
from Projeto proj,Fornecedor f, Fornece_Para fp
where 
	 proj.PNro = @cod_proj and
	 f.FNro =fp.FNro and
	 fp.PNro = proj.PNro
	 
end

exec Listarproj 2

--Criar uma Stored Procedure que receba a quantidade de peças fornecidas e 
--verifique quais quantidades estão abaixo desse valor, mostrando o nome do projeto, da peça e do fornecedor. 

create procedure quant_fornece(@peca_quant as int)
as
begin
select proj.PNome NomeProjeto,p.PeNome NomePeca, fp.Quant  quantidade ,f.FNome NomeFornecedor
from Fornece_Para fp,Projeto proj, Peca p, Fornecedor f

where fp.FNro =f.FNro and
	fp.Quant < @peca_quant and
	fp.PeNro = p.PeNro and
	fp.PNro = proj.PNro

end

exec quant_fornece 2

--Crie uma Stored Procedure que receba uma quantidade de peças e mostre os nomes de projetos, 
--peças e fornecedores que possuam quantidades iguais ou inferiores à quantidade passada. 

alter procedure quant_pecas(@quant_pecas as int)
as
begin
select proj.PNome, p.PeNome,fp.Quant,f.FNome
from Projeto proj, Fornecedor f, Fornece_Para fp, Peca p 
where
	fp.Quant <= @quant_pecas and 
	fp.PNro = proj.PNro and
	fp.PeNro = p.PeNro and
	fp.FNro =f.FNro 
	
	
end

exec quant_pecas 2







