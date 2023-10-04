create view VisaoForncedoresPecas as 
select p.PeNome NomePeca
from Peca p
where p.PeNro in (
	select distinct fp.PeNro  /*distinct não traz resultados duplicados*/
	from Fornece_Para fp
	where fp.FNro <> all( /*difeente de todos ou not in(não pertence )*/
	select f.FNro
	from Fornecedor f
	where f.FCateg = 'A'))
	
	

create view VisaoSOmaQuantPecas as 
select fp.Penro NumeroPeça,
	sum(fp.Quant) SomaPecas
from Fornece_Para fp
group by fp.PeNro   -- having é associado ao group by
having SUM(fp.Quant)>1 -- criandom um criterio do agrupamento, fazendo a soma dnv


-- se não usa o cast ele arredonda , com ele faz com o numero quebrado e mostra od etalhe com virgula
-- cast deixa o numero correto e não altera e arredonda
create view VisaoMedQuantPecas as 
select fp.PeNro NumeroPeca , AVG(cast(fp.Quant as float)) MediaPecas
from Fornece_Para fp
group by fp.PeNro
having AVG(cast(fp.Quant as float)) >1

