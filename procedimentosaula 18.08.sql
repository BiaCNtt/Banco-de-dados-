create procedure fornecimento_buscar 
as 
begin 
select p.PeNome,f.FNome,fp.Quant
from Peca p, Fornece_Para fp, Fornecedor f
where 
	f.FNro = fp.FNro and
	p.PeNro = fp.FNro
end

exec fornecimento_buscar

create procedure pecas_fornecidas(@peca_num as int)
as
begin
select p.PeNome NomePeça, fp.Quant quantidade, fp.PNro NumeroProjeto
from Peca p , Fornece_Para fp
where
	p.PeNro =@peca_num and
	p.PeNro =fp.PeNro
end

exec pecas_fornecidas 5


--exemplo 15
create procedure pecas_fornecedores(@peca_num as int)
as 
begin
select p.PeNome NomedaPeca, f.FNome NomeFornecedor, fp.Quant quantidade
from Peca p,Fornece_Para fp, Fornecedor f
	where p.PeNro = @peca_num and
	p.PeNro = fp.PeNro and
	fp.FNro = f.FNro
end

exec pecas_fornecedores 2

--exemplo 16
create procedure quant_fornecidas(@qtd as int)
as begin
select p.PeNome NomePeca,f.FNome NomeFornecedor, fp.Quant quantidade
from Peca p,Fornecedor f,Fornece_Para fp
where
	fp.Quant >= @qtd and
	p.PeNro = fp.PeNro and
	fp.FNro = f.FNro
end

exec quant_fornecidas 5

--exemplo 17
create procedure fornecimentos_pecas_quant(@Penro as int, @qtd as int)
as begin
select p.PeNome,f.FNome,fp.Quant
from Peca p, Fornecedor f, Fornece_Para fp
where p.PeNro =@Penro and
	  fp.Quant = @qtd and
	  p.PeNro = fp.PeNro and
	  fp.FNro =f.FNro
end

exec fornecimentos_pecas_quant 4,2

--exemplo 18
create procedure fornecimento_buscar_cor(@cor_peca as varchar(20), @qtd as int)
as begin
select p.PeNome,fp.Quant
from Peca p, Fornece_Para fp
where
	p.PeCor =@cor_peca and
	fp.Quant <= @qtd and
    p.PeNro = fp.PeNro
end

exec fornecimento_buscar_cor 'vermelho',1

--exemplo 19 

create procedure pecas_totais
as begin
select p.PeNro,p.PeNome NomePeca, SUM(p.PePreco*fp.Quant) total
from Peca p ,Fornece_Para fp
	where p.PeNro =fp.PeNro
	group by p.PeNro,p.PeNome
end

exec pecas_totais

create procedure fornecimento_totais_peca(@peca_num as int)
as begin
select p.PeNome nomePeca, f.FNome NomeFornecedor,SUM(p.PePreco*fp.Quant) total
from Fornece_Para fp , Peca p , Fornecedor f
	where p.PeNro = @peca_num and
	p.PeNro = fp.PeNro and
	f.FNro = fp.FNro
	group by p.PeNome,f.FNome 
end
