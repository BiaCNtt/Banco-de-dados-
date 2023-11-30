 -- função multi-stantment 
 -- exemplo dado em aula
 CREATE FUNCTION fc_QtdPeçasFornecidas (@QtdPç int)
RETURNS @PeçasFornecidas TABLE
(PeNome varchar(15),
PeCor varchar(15),
Quant int)
AS
BEGIN
INSERT @PeçasFornecidas
SELECT p.PeNome, p.PeCor, fp.Quant
FROM Peca p, Fornece_Para fp
WHERE p.PeNro = fp.PeNro
AND fp.Quant > @QtdPç
RETURN
END

 
--Crie uma função que retorne os nomes das peças, fornecedores e projetos com peças de preço maior que $ 20 e 
--que são fornecidas por empresas de São Paulo e utilizadas por projeto com duração maior que 2 meses. Inclua a chamada à função.

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
	f.FCidade = 'São paulo' and
	p.PDuracao > 2
return
end

select * from dbo.ex1mult()
	
--Obtenha o nome dos projetos e de seus fornecedores que possuem algum fornecimento de fornecedor da cidade de Campinas. 
--Inclua a chamada à função. 

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


--Desenvolva uma função que retorne o nome dos projetos e das peças não fornecidas por fornecedores de categoria B. 
--Inclua a chamada à função. 

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

--Crie uma função que receba a quantidade de peças fornecidas e o código da peça e retorne os nomes dos projetos e fornecedores 
--que fornecem tal peça em quantidade inferior ao parâmetro fornecido. 

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