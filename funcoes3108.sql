--funções --UDF  funções definidas pelo usuario(admnsotrador do banco)não fazem parte do ocnjunto de funções do sql
--se necessita de procedimentos que retornam resultados, pelo simples fato de po der se chamda apartir de uma instruçã sql

---variavel table (similar as tabelas temporaria), pode utiliza-la para armazenar temporariamente um conj.de linhas 
--para futuro processamentos, ou definir uma variavell local que será utilizada na função

--escopo
 --area de abrangencia de um objeto , one ela é visivel e pode atuar, bloco onde ela é visivel
 
 -- nao se usa variavel table(insert,selectcom uma lista que será tribuida na varivael table
 
 declare @MinhaTabela table (PeNro int primary key,PeNome varchar(30))
 insert into @MinhaTabela
	select distinct PeNro,PeNome
	from Peca where PeNome like 'L%'
	
	select * from @MinhaTabela 
	--where PeNome = 'Lanterna'

--aula 05/09 -continuações função
--UDF FUNÇÃO DEFINIDA PELO USUARIO 


-- ATIVIDADE FUNÇÃO --

--1 - Crie uma variável do tipo Table com os campos número, nome e duração dos projetos. 
--Armazene na variável Table todos os projetos com custo superior a R$ 20 000,00. 
--Em seguida mostre aqueles com duração maior ou igual a 2 meses. 

declare @exvariavel1 table(PNro int, PNome varchar(30), PDuracao int)
insert into @exvariavel1
select distinct p.PNro ,p.PNome,p.PDuracao
from Projeto p 
where p.PCusto >20000.00 
select * from @exvariavel1 where PDuracao >= 2

--2 - Crie uma função para calcular o "delta" de uma equação do 2º grau (as entradas são A, B e C). delta = b² - 4 ac 

create function delta(@A decimal, @B decimal, @c decimal)
returns decimal
as begin
return(@B*@B)-4*@A*@c
end

select dbo.delta(20,30,4)

/*3 - Crie uma stored procedure para calcular a(s) raíz(es), se houver(em). 
delta < 0 (A = 5, B = 1, C = 5) -> não existem raízes reais. 
 delta = 0 (A = 2, B = 4, C = 2) -> x = -b / (2 * a) = -1 
 delta > 0 (A = 2, B = 5, C = 2) -> x1 = -0,5 e x2 = -2 
Use a função criada no exercício 2 nesse procedimento. 
Um exemplo de chamada: 
declare @retorno decimal 
set @retorno = dbo.Delta (@A, @B, @C) 
Exemplo de execução do procedimento: 
CalcDelta 5, 1, 5 
CalcDelta 2, 4, 2 
CalcDelta 2, 5, 2 */


 
create procedure raiz(@A decimal, @B decimal, @c decimal)
as
begin
    declare @delta decimal
    declare @x1 decimal
    declare @x2 decimal
    set @delta=dbo.delta(@A, @B, @c)
 
    if @delta < 0
    begin
        print 'Não existe raiz real'
    end
    else if @delta = 0
    begin
         set @x1 = -@B / (2 * @A)
         print 'Raiz: ' + cast(@x1 as varchar)
    end
    else 
    begin
        set @x1 = (-@B + dbo.delta(@A, @B, @c)) / (2 * @A)
        set @x2 = (-@B - dbo.delta(@A, @B, @c)) / (2 * @A)
        print 'Raiz 1: ' + cast(@x1 as varchar)
        print 'Raiz 2: ' + cast(@x2 as varchar)
    end
 
end
 
raiz '2', '2', '2'
raiz '1', '4', '4'
raiz '1', '-5', '6'
 
 

--4 - Crie uma função scalar que retorne o preço de uma peça reajustado de acordo com uma porcentagem e um preço passados para a função. 
--Na chamada à função você deve usar o Select/From/Where para buscar o preço de uma peça qualquer na tabela Peça. 

 
create function ex4reajuste(@preco as decimal, @porcentagem as decimal)
returns decimal 
as
begin
    declare @novoPreco as decimal
    set @novoPreco =(@preco*(@preco + (@porcentagem /100)))
     return @novoPreco
end   
select dbo.ex4reajuste(p.PePreco,10) from Peca p where p.PeNro = 1


select * from Peca













