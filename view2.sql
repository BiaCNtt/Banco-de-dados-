create view VisaoForncedoresPecas as 
select p.PeNome NomePeca
from Peca p
where p.PeNro in (
	select distinct fp.PeNro  /*distinct n�o traz resultados duplicados*/
	from Fornece_Para fp
	where fp.FNro <> all( /*difeente de todos ou not in(n�o pertence )*/
	select f.FNro
	from Fornecedor f
	where f.FCateg = 'A'))
	
	

create view VisaoSOmaQuantPecas as 
select fp.Penro NumeroPe�a,
	sum(fp.Quant) SomaPecas
from Fornece_Para fp
group by fp.PeNro   -- having � associado ao group by
having SUM(fp.Quant)>1 -- criandom um criterio do agrupamento, fazendo a soma dnv


-- se n�o usa o cast ele arredonda , com ele faz com o numero quebrado e mostra od etalhe com virgula
-- cast deixa o numero correto e n�o altera e arredonda
create view VisaoMedQuantPecas as 
select fp.PeNro NumeroPeca , AVG(cast(fp.Quant as float)) MediaPecas
from Fornece_Para fp
group by fp.PeNro
having AVG(cast(fp.Quant as float)) >1

