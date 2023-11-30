-- aula cursores Exercícios

-- exemplo
CREATE PROCEDURE Atualiza_preço (@NumForn as int) AS
Begin
--Declarando cursor
DECLARE CursorPreço CURSOR FOR
--Nome do cursor
-- Select utilizado para o cursor
SELECT Distinct PeNro FROM fornece_para WHERE FNro = @NumForn
--Declarando variáveis
DECLARE @NumPeca as int
--Abrindo cursor
OPEN CursorPreço
--Atribuindo valores do SELECT na variável
FETCH NEXT FROM CursorPreço INTO @NumPeca
--Iniciando laço
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE Peca
Set PePreco = PePreco*1.1
WHERE PeNro = @NumPeca
--Próxima linha do cursor
FETCH NEXT FROM CursorPreço INTO @NumPeca
END
--Fechando e desalocando cursor
CLOSE CursorPreço
DEALLOCATE CursorPreço
END

select*from Projeto

--1 – Faça uma Stored Procedure com um cursor que receba todos os projetos que têm custo superior a R$ 25.000,00 e 
--selecione todos os nomes e categorias de fornecedores que fornecem para estes projetos.

CREATE TABLE FornecedoresParaProjetos (
    ProjetoNr INT,
    NomeProjeto VARCHAR(100),
    CustoProjeto DECIMAL(18, 2),
    NFornecedor VARCHAR(100),
    CatFornecedor VARCHAR(50)
);

select *from FornecedoresParaProjetos

CREATE PROCEDURE ObterFornecedores
AS
BEGIN
    DECLARE @ProjetoNr INT
    DECLARE @NomeProjeto NVARCHAR(100)
    DECLARE @CustoProjeto DECIMAL(18, 2)
    
    DECLARE ProjetosCursor CURSOR FOR
    SELECT PNro,PNome, PCusto
    FROM Projeto
    WHERE PCusto > 25000.00
  
    DECLARE @NFornecedor VARCHAR(100)
    DECLARE @CatFornecedor VARCHAR(50)
  
    OPEN ProjetosCursor
    
    FETCH NEXT FROM ProjetosCursor INTO @ProjetoNr, @NomeProjeto, @CustoProjeto
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO FornecedoresParaProjetos values (@ProjetoNr, @NomeProjeto, @CustoProjeto, @NFornecedor,@CatFornecedor)
        SELECT @ProjetoNr, @NomeProjeto, @CustoProjeto, @NFornecedor, @CatFornecedor
        FROM Fornecedor
        WHERE FNro = @NFornecedor
        FETCH NEXT FROM ProjetosCursor INTO @ProjetoNr, @NomeProjeto, @CustoProjeto
    END
    
    CLOSE ProjetosCursor
    DEALLOCATE ProjetosCursor  -- liberar os recursos , se não da erro na proxima
END

exec ObterFornecedores

--2 – Crie um Trigger que é disparado quando se atualiza uma categoria qualquer de Fornecedor, 
--com um cursor que armazene os fornecedores que não são das categorias ‘A’, ‘B’ e ‘C’, e atualize suas categorias para ‘C’.
CREATE TABLE historicforne (
Fnro int,
FNome varchar,
Fcateg varchar
);

create trigger ex2cursor on Fornecedor for update
as
begin
declare @Fnro int
declare @FNome varchar
declare @Fcateg varchar

DECLARE cursorfornece CURSOR FOR
SELECT FNro,Fome, FCateg
FROM Fornecedor
WHERE FCateg = 'D'

open cursorfornece
FETCH NEXT FROM cursorfornece INTO @FNro, @FNome, @FCateg
WHILE @@FETCH_STATUS = 0
 IF UPDATE(FCateg)
    BEGIN
		UPDATE Forecedor SET FCateg = 'C' 
        INSERT INTO historicforcedor values(@Fnro,@FNome,@Fcateg)
        end
    CLOSE cursorfornece
    DEALLOCATE cursorfornece  -- liberar os recursos , se não da erro na proxima
END

UPDATE Fornecedor SET FCateg = 'D' WHERE FNro = 11
exec ex2cursor

--3 – Faça uma Stored Procedure que armazene em um cursor todos os códigos de projetos que 
--têm fornecedores que são da categoria A ou B. Atualize todos os custos desses projetos de tais fornecedores em 10%.

--4 – Faça uma Stored Procedure com um cursor que receba o código do fornecedor,
-- selecionando todos os projetos nos quais este fornecedor possui fornecimento e aumente em 15% o custo de tais projetos.