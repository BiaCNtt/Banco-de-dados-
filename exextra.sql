--Crie a função ValorPeça para retornar o preço de uma peça. 
--A função tem um parâmetro de entrada que é o número da peça. Inclua a chamada à função. 

create function Valorpeca(@cog int)
returns table
as return(
select p.PeNome, p.PePreco
from Peca p
where @cog = PeNro
)
SELECT * FROM Valorpeca(4)
select*from Projeto

--Crie uma função que receba o número da peça e retorne quais os nomes e a 
--duração dos projetos com custo maior que R$30.000,00 e que fornecem essa peça. 

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

--Crie uma função que receba a categoria do fornecedor e retorne quais os nomes e a 
--duração dos projetos que tais fornecedores participam. 

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


--Crie uma função que receba um código de peça e retorne o total nos pedidos de fornecimento, 
--agrupados pela peça. A função deve retornar também o nome da peça, do seu fornecedor e do seu projeto. 
--Inclua a chamada à função. 

--Desenvolva uma função que receba o código de um fornecedor e retorne o custo total dos projetos (e seus nomes) 
--em que peças são fornecidas por esse fornecedor. Inclua a chamada à função. 