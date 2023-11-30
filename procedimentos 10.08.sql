--procedimentos armazenados se comparacm uma função void em c 
--tipo de procedimentp amazenado -- definido pelo usuairo
---- procedimento - cria no bd - vai em programiilit em store procedures , mouse direito new 

--criado na forma mais cheia de etapa- via ambiente
Exec ProcedureName
Exec sp_help 


--criando na consulta o procedimento
Create Procedure sp_projeto as
Select PNome, PCusto from Projeto

--executando
exec sp_projeto


create procedure sp_fornecedores_busca1 as
begin 
	select * from Fornecedor
end

sp_fornecedores_busca1

-- criando com uma variavel
create procedure sp_fornecedores_busca2(@NumForn int)
as 
begin
select * from Fornecedor where FNro = @NumForn
end
exec sp_fornecedores_busca2 3 -- o 3 é o que estou dizendo pra ele buscar que sera colocado na variavel que criei

-- com string

create procedure sp_fornecedores_like(@FornNOme as varchar(20))
as 
begin
select * from Fornecedor where FNome like @FornNOme + '%' -- o like compara a palavr a uma parte dela que corresponde
end									-- se coloca o o porcentagem entre a variavel siginifca que a letra pode estar em qualquer lugar  ex: '%' +@ForNome + '%', qualquer lugar da palavra			
exec sp_fornecedores_like c



 