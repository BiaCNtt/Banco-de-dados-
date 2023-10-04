--fun��o inline
use Fabrica2023
--Desenvolva uma fun��o que receba o n�mero do projeto e retorne os nomes e os pre�os das pe�as que s�o fornecidas
-- e que tenham pre�os inferiores a R$ 20,00. Inclua a chamada � fun��o. 
 
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

--Crie uma fun��o que receba o c�digo de uma pe�a e o c�digo de um projeto, retornando os nomes dos projetos e
-- pe�as e as quantidades fornecidas desse par de par�metros. Inclua a chamada � fun��o. 

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


 --Elabore uma fun��o que receba o c�digo de um fornecedor e retorne o nome das pe�as fornecidas que tenham pre�os 
 --superiores a R$ 20,00 e participam de projetos com per�odos de at� 4 meses. Inclua a chamada � fun��o. 
 
 
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
 

 
 
 
 
 
 
 
 
 
 
 
 