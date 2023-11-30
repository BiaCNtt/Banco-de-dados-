--Crie a fun��o ValorPe�a para retornar o pre�o de uma pe�a. 
--A fun��o tem um par�metro de entrada que � o n�mero da pe�a. Inclua a chamada � fun��o. 

create function Valorpeca(@cog int)
returns table
as return(
select p.PeNome, p.PePreco
from Peca p
where @cog = PeNro
)
SELECT * FROM Valorpeca(4)
select*from Projeto

--Crie uma fun��o que receba o n�mero da pe�a e retorne quais os nomes e a 
--dura��o dos projetos com custo maior que R$30.000,00 e que fornecem essa pe�a. 

create function ex2(@cog int)
returns table
as return(
select p.PNOme,p.PDuracao,p.PCusto
from Projeto p, Peca pe,Fornece_para fp
where @cog = pe.PeNro and
p.PNro = fp.PNro and
pe.PeNro = fp.PeNro and
PCusto > 30.000
)
Select*from ex2(2)

--Crie uma fun��o que receba a categoria do fornecedor e retorne quais os nomes e a 
--dura��o dos projetos que tais fornecedores participam. 

create function ex3(@catf as varchar)
returns table
as return (
select f.FCateg ,p.PNome,p.PDuracao
from Fornece_para fp ,Fornecedor f ,Projeto p
where 
@catf = FCateg and
fp.FNro = f.FNro and
fp.PNro = p.PNro 
)
Select*from ex3 ('b')


--Crie uma fun��o que receba um c�digo de pe�a e retorne o total nos pedidos de fornecimento, 
--agrupados pela pe�a. A fun��o deve retornar tamb�m o nome da pe�a, do seu fornecedor e do seu projeto. 
--Inclua a chamada � fun��o. 

--Desenvolva uma fun��o que receba o c�digo de um fornecedor e retorne o custo total dos projetos (e seus nomes) 
--em que pe�as s�o fornecidas por esse fornecedor. Inclua a chamada � fun��o. 