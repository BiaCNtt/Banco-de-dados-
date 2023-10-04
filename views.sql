/*create view PecasNome as 
Select PeNome from Peca*/

alter view PecasNome as 
Select PeNome,PePreco
 from Peca

drop view VisaoForncedores

select * from VisaoQuantPecas

CREATE VIEW VisaoFornecedores as 
select f.FNome NomeFornecedor, f.FCateg Categoria, f.FCidade Cidade
from Fornecedor f
where f.FCidade = 'Campinas'
	and f.FCateg in ('A','B')
	
Create view VisaoProj as 
select p.PNome NomeProjeto,fp.PNro NumeroProjeto
from Projeto p inner join Fornece_Para fp on p.PNro = fp.PNro

alter view VisaoProj as 
select p.PNome NomeProjeto,fp.PNro NumeroProjeto, fp.PeNro Pecas
from Projeto p inner join Fornece_Para fp on p.PNro = fp.PNro
	
alter view VisaoQuantPecas as
select p.PeNome NomePeças, fp.Quant QuantidadePecas
from Peca p inner join Fornece_Para fp on p.PeNro = fp.PeNro
where fp.Quant > 2

create view VisFornecPecas as 
select f.FNome NomeFornecedor, p.PeNome NomePecas
from Fornecedor f inner join Fornece_Para fp on f.FNro = fp.FNro
inner join Peca p on fp.PeNro = p.PeNro

select * from VisFornecPecas