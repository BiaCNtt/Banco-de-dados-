--fun��es --UDF  fun��es definidas pelo usuario(admnsotrador do banco)n�o fazem parte do ocnjunto de fun��es do sql
--se necessita de procedimentos que retornam resultados, pelo simples fato de po der se chamda apartir de uma instru�� sql

---variavel table (similar as tabelas temporaria), pode utiliza-la para armazenar temporariamente um conj.de linhas 
--para futuro processamentos, ou definir uma variavell local que ser� utilizada na fun��o

--escopo
 --area de abrangencia de um objeto , one ela � visivel e pode atuar, bloco onde ela � visivel
 
 -- nao se usa variavel table(insert,selectcom uma lista que ser� tribuida na varivael table
 
 declare @MinhaTabela table (PeNro int primary key,PeNome varchar(30))
 insert into @MinhaTabela
	select distinct PeNro,PeNome
	from Peca where PeNome like 'L%'
	
	select * from @MinhaTabela 
	--where PeNome = 'Lanterna'

--aula 05/09 -continua��es fun��o
--UDF FUN��O DEFINIDA PELO USUARIO 


-- ATIVIDADE FUN��O --

--1 - Crie uma vari�vel do tipo Table com os campos n�mero, nome e dura��o dos projetos. 
--Armazene na vari�vel Table todos os projetos com custo superior a R$ 20 000,00. 
--Em seguida mostre aqueles com dura��o maior ou igual a 2 meses. 

declare @exvariavel1 table(PNro int, PNome varchar(30), PDuracao int)
insert into @exvariavel1
select distinct p.PNro ,p.PNome,p.PDuracao
from Projeto p 
where p.PCusto >20000.00 
select * from @exvariavel1 where PDuracao >= 2

--2 - Crie uma fun��o para calcular o "delta" de uma equa��o do 2� grau (as entradas s�o A, B e C). delta = b� - 4 ac 

create function delta(@A decimal, @B decimal, @c decimal)
returns decimal
as begin
return(@B*@B)-4*@A*@c
end

select dbo.delta(20,30,4)

/*3 - Crie uma stored procedure para calcular a(s) ra�z(es), se houver(em). 
delta < 0 (A = 5, B = 1, C = 5) -> n�o existem ra�zes reais. 
 delta = 0 (A = 2, B = 4, C = 2) -> x = -b / (2 * a) = -1 
 delta > 0 (A = 2, B = 5, C = 2) -> x1 = -0,5 e x2 = -2 
Use a fun��o criada no exerc�cio 2 nesse procedimento. 
Um exemplo de chamada: 
declare @retorno decimal 
set @retorno = dbo.Delta (@A, @B, @C) 
Exemplo de execu��o do procedimento: 
CalcDelta 5, 1, 5 
CalcDelta 2, 4, 2 
CalcDelta 2, 5, 2 */


�
create procedure raiz(@A decimal, @B decimal, @c decimal)
as
begin
��� declare @delta decimal
��� declare @x1 decimal
��� declare @x2 decimal
��� set @delta=dbo.delta(@A, @B, @c)
�
��� if @delta < 0
��� begin
������� print 'N�o existe raiz real'
��� end
��� else if @delta = 0
��� begin
�������� set @x1 = -@B / (2 * @A)
�������� print 'Raiz: ' + cast(@x1 as varchar)
��� end
��� else�
��� begin
������� set @x1 = (-@B + dbo.delta(@A, @B, @c)) / (2 * @A)
������� set @x2 = (-@B - dbo.delta(@A, @B, @c)) / (2 * @A)
������� print 'Raiz 1: ' + cast(@x1 as varchar)
������� print 'Raiz 2: ' + cast(@x2 as varchar)
��� end
�
end
�
raiz '2', '2', '2'
raiz '1', '4', '4'
raiz '1', '-5', '6'
�
�

--4 - Crie uma fun��o scalar que retorne o pre�o de uma pe�a reajustado de acordo com uma porcentagem e um pre�o passados para a fun��o. 
--Na chamada � fun��o voc� deve usar o Select/From/Where para buscar o pre�o de uma pe�a qualquer na tabela Pe�a. 

�
create function ex4reajuste(@preco as decimal, @porcentagem as decimal)
returns decimal 
as
begin
��� declare @novoPreco as decimal
��� set @novoPreco =(@preco*(@preco + (@porcentagem /100)))
���� return @novoPreco
end�� 
select dbo.ex4reajuste(p.PePreco,10) from Peca p where p.PeNro = 1


select * from Peca













