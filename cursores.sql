-- aula cursores Exerc�cios

-- exemplo
CREATE PROCEDURE Atualiza_pre�o (@NumForn as int) AS
Begin
--Declarando cursor
DECLARE CursorPre�o CURSOR FOR
--Nome do cursor
-- Select utilizado para o cursor
SELECT Distinct PeNro FROM fornece_para WHERE FNro = @NumForn
--Declarando vari�veis
DECLARE @NumPeca as int
--Abrindo cursor
OPEN CursorPre�o
--Atribuindo valores do SELECT na vari�vel
FETCH NEXT FROM CursorPre�o INTO @NumPeca
--Iniciando la�o
WHILE @@FETCH_STATUS = 0
BEGIN
UPDATE Peca
Set PePreco = PePreco*1.1
WHERE PeNro = @NumPeca
--Pr�xima linha do cursor
FETCH NEXT FROM CursorPre�o INTO @NumPeca
END
--Fechando e desalocando cursor
CLOSE CursorPre�o
DEALLOCATE CursorPre�o
END

select*from Projeto

--1 � Fa�a uma Stored Procedure com um cursor que receba todos os projetos que t�m custo superior a R$ 25.000,00 e 
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
    DEALLOCATE ProjetosCursor  -- liberar os recursos , se n�o da erro na proxima
END

exec ObterFornecedores

--2 � Crie um Trigger que � disparado quando se atualiza uma categoria qualquer de Fornecedor, 
--com um cursor que armazene os fornecedores que n�o s�o das categorias �A�, �B� e �C�, e atualize suas categorias para �C�.
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
    DEALLOCATE cursorfornece  -- liberar os recursos , se n�o da erro na proxima
END

UPDATE Fornecedor SET FCateg = 'D' WHERE FNro = 11
exec ex2cursor

--3 � Fa�a uma Stored Procedure que armazene em um cursor todos os c�digos de projetos que 
--t�m fornecedores que s�o da categoria A ou B. Atualize todos os custos desses projetos de tais fornecedores em 10%.

--4 � Fa�a uma Stored Procedure com um cursor que receba o c�digo do fornecedor,
-- selecionando todos os projetos nos quais este fornecedor possui fornecimento e aumente em 15% o custo de tais projetos.