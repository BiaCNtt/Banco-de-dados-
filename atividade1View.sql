--exercicio 1 aula 03/08
/*Com os projetos de duração entre 3 e 5 meses inclusive, 
e que possuem um preço menor que $ 30.000. Mostre os nomes, a duração e o custo, todos com apelidos*/
 
alter view Ex1ProjPeriodo as
 select p.PNome nome ,p.PDuracao duracao ,p.PCusto custo
 from Projeto p
 where p.PDuracao between '3' and '5' 
 and p.PCusto < 30000
 
 
--exercicio2 Com os projetos que tenham custo inferior a R$ 30.000,00 e 
--apenas 1 peça fornecida. Mostrar nome e custo do projeto. 
 
alter view ProjectInferi1Peca as 
select distinct p.PNome,p.PCusto
from Projeto p inner join Fornece_Para fp on (fp.PNro = p.PNro)
where  p.PCusto < 30000  and fp.Quant = 1 --o mais correto em um grande bd seria somae as quantdades e depois mostrar se realmente é um só


-- exercicio 2 - forma correta somando prmeiro e apos mostrando se realmente o projeto tem custo inferiror
create view CustoInferior as 
select distinct p.PNome,sum(Pcusto)
from Projeto p inner join Fornece_Para fp on (fp.PNro = p.PNro)
where p.Pcusto < 30000 
group by p.PNome 
having sum(fp.Quant) =1



--exercicio3
/*Criar uma visão com os nomes e os códigos das peças que são fornecidas. */
alter view PecasFornecida AS 
select  distinct pe.PeNome Nome_Peça, pe.PeNro Codigo_Peça
FROM Fornece_Para fp
	INNER JOIN Peca pe ON pe.PeNro = fp.PeNro -- inner join funciona relacionando os selects da antiga forma
	INNER JOIN Fornecedor f ON f.FNro = fp.FNro
	
--exercicio4- Criar uma visão com o nome de fornecedor relacionado com as peças fornecidas/
alter view Fornecedores_Pecas AS
select distinct f.FNome Nome_Fornecedor, p.PeNome Nome_Pecas  
from Fornece_Para fp
	INNER JOIN Fornecedor f ON fp.FNro = f.FNro
	INNER JOIN Peca p ON fp.PeNro = p.PeNro
GROUP BY f.FNome, p.PeNome 

--exercicio5 - criar uma visão nome de projetos e as peças + filtrar pela cor vermelha/

alter view ProjetoNomePeca AS 
select distinct p.PNome Nome_Projeto, pe.PeNome Nome_Pecas
from Fornece_Para fp
	INNER JOIN Projeto p ON p.PNro = fp.PNro
	INNER JOIN Peca pe ON pe.PeNro = fp.PeNro
where pe.PeCor = 'Vermelho' -- condição do exercicio



