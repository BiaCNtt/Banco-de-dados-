 -- fun��o multi-stantment 
 -- exemplo dado em aula
 CREATE FUNCTION fc_QtdPe�asFornecidas (@QtdP� int)
RETURNS @Pe�asFornecidas TABLE
(PeNome varchar(15),
PeCor varchar(15),
Quant int)
AS
BEGIN
INSERT @Pe�asFornecidas
SELECT p.PeNome, p.PeCor, fp.Quant
FROM Peca p, Fornece_Para fp
WHERE p.PeNro = fp.PeNro
AND fp.Quant > @QtdP�
RETURN
END

 
--Crie uma fun��o que retorne os nomes das pe�as, fornecedores e projetos com pe�as de pre�o maior que $ 20 e 
--que s�o fornecidas por empresas de S�o Paulo e utilizadas por projeto com dura��o maior que 2 meses. Inclua a chamada � fun��o.

alter function ex1mult()
returns @Infofabrica table
	(Penome varchar(15),
	FNome varchar(15),
	PNome varchar(15)
	)
as begin
	insert @Infofabrica
	select pe.PeNome NomePeca, f.FNome NomeFornecedor, p.PNome
	from Peca pe, Fornece_Para fp , Projeto p, Fornecedor f
	where 
	p.PNro =fp.PNro and
	f.FNro = fp.FNro and
	pe.PeNro = fp.PeNro and
	pe.PePreco > 20 and
	f.FCidade = 'S�o paulo' and
	p.PDuracao > 2
return
end

select * from dbo.ex1mult()
	
--Obtenha o nome dos projetos e de seus fornecedores que possuem algum fornecimento de fornecedor da cidade de Campinas. 
--Inclua a chamada � fun��o. 

create function ex2multi()
returns @infoproj table
(PNome varchar (15),
 Fnome varchar(15)
)
as begin
insert @infoproj
select p.PNome, f.FNome
from Projeto p, Fornecedor f , Fornece_para fp
where 
fp.FNro = f.FNro and
fp.PNro = p.PNro and
f.FCidade = 'Campinas'
return
end

select * from dbo.ex2multi()


--Desenvolva uma fun��o que retorne o nome dos projetos e das pe�as n�o fornecidas por fornecedores de categoria B. 
--Inclua a chamada � fun��o. 

create function ex3multi()
returns @infoproj table(
PNome varchar(15),
PeNome varchar(15),
FNome varchar (15),
Fcateg varchar (15)
)
as begin
insert @infoproj
select p.PNome NomeProj, pe.PeNome NomedaPeca, f.FNome NomeForncedor , f.FCateg categoria
from Projeto p, Fornecedor f, Fornece_para fp, Peca pe
where 
	fp.PNro = p.PNro and
	fp.FNro = f.FNro and
	fp.PeNro = pe.PeNro and
	f.FCateg != 'B'
return
end

select * from dbo.ex3multi()

--Crie uma fun��o que receba a quantidade de pe�as fornecidas e o c�digo da pe�a e retorne os nomes dos projetos e fornecedores 
--que fornecem tal pe�a em quantidade inferior ao par�metro fornecido. 

create function ex4multi(@qtd int,@cog int)
returns @infoquant table(
PNome varchar(15),
FNome varchar(15),
PQuant int
)
as begin
insert @infoquant
select p.PNome Nomeproj, f.FNome NomeFornecedor, fp.Quant Quantidade
from Fornece_para fp, Projeto p ,Fornecedor f, Peca pe
where 
	p.PNro = @cog and
	fp.FNro= f.FNro and
	fp.PNro =p.PNro and
	fp.PeNro = pe.Penro and
	fp.quant < @qtd

return
end

select * from dbo.ex4multi(2,3)
select*from Fornece_Para