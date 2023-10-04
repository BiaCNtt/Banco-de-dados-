--função inline
use Fabrica2023
--Desenvolva uma função que receba o número do projeto e retorne os nomes e os preços das peças que são fornecidas
-- e que tenham preços inferiores a R$ 20,00. Inclua a chamada à função. 
 
 Create function ex1fun(@proj int)
Returns table 
As 
Return(
Select  p.PeNome, p.Pepreco
From Peca p, projeto pj, fornece_para fp
Where  
pj.Pnro = @proj 
and pj.pnro= fp.pnro 
and Fp.PeNro = p.Penro 
and p.pepreco < 20
)
Select* from dbo.ex1fun(2)

--Crie uma função que receba o código de uma peça e o código de um projeto, retornando os nomes dos projetos e
-- peças e as quantidades fornecidas desse par de parâmetros. Inclua a chamada à função. 

Create function ex2fun(@cog int, @numproj int)
Returns table
As 
Return(
Select  p.PNome as Nomeprojeto, pe.PeNome as Nomepeca, fp.Quant as quantidadePeca 
From  Peca pe , projeto p, Fornece_para fp
Where
Pe.penro = @cog and
p.Pnro=@numproj and
Pe.penro=fp.penro and
p.pnro= fp.pnro
)
select *from dbo.ex2fun(2,3)


 --Elabore uma função que receba o código de um fornecedor e retorne o nome das peças fornecidas que tenham preços 
 --superiores a R$ 20,00 e participam de projetos com períodos de até 4 meses. Inclua a chamada à função. 
 
 
Create function ex3fun(@cogforne int)
Returns table
As return(
Select  pe.PeNome , pe
From Fornecedor f, Peca pe, fornece_para fp , projeto pj
Where F.fnro = @cogforne
and fp.FNro = f.fnro 
and fp.PNro = pj.PNro
and fp.peNro = pe.PeNro
and Pe.PePreco > 20 
and Pj.pduracao <= 4 
)
select *from dbo.ex3fun(5)
 

 
 
 
 
 
 
 
 
 
 
 
 